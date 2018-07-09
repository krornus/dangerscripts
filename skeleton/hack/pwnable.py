from enum import IntEnum
from pwn import *
from pwnlib import timeout

import inspect
import subprocess
import re
import os


RE_GETSTR = re.compile("([0-9]+\n)?((:?.*\n)+.*)(:?sftp>\s*)?")

default = timeout.Timeout.default
forever = timeout.Timeout.forever

def upad64(x):
    x=x[:8].ljust(8,'\x00')
    return u64(x)

def upad32(x):
    x=x[:4].ljust(4,'\x00')
    return u32(x)

def logger(log, level):
    def log_decorator(f):
        def log_call(*args, **kwargs):
            data = f(*args, **kwargs)
            log(data, level)
            return data

        return log_call
    return log_decorator


class LogLevel(IntEnum):
    NONE  = 0x0
    SEND  = 0x1
    RECV  = 0x2
    DEBUG = 0x4
    WARN  = 0x8
    ERROR = 0x10
    USER  = 0x20


class Pwnable(object):

    def __init__(self, fn, argv=[], env=[], terminal=None, using=None):
        if not env:
            env = os.environ

        if using != None:
            self.using(using)

        if terminal:
            context(terminal=terminal)

        self.remote = False

        try:
            fn, port = fn

            self.remote = True
            self.proc = remote(fn, port)
            self.file = None
        except:
            self.proc = process(executable=fn, argv=argv, aslr=False, env=env)
            self.file = fn

        self.init_io_wrappers()
        self.level  = LogLevel.NONE

        self.breakpoints = []
        self.commands = []
        self._libc = None
        self._elf = None
        self.libc_dll = None
        self.pie = 0
        self.allocations = 0

    # wrap send/recv functions with a logger
    def init_io_wrappers(self):

        self.recv = logger(self.log, LogLevel.RECV)(self.proc.recv)
        self.recv_raw = logger(self.log, LogLevel.RECV)(self.proc.recv_raw)
        self.recvall = logger(self.log, LogLevel.RECV)(self.proc.recvall)
        self.recvline = logger(self.log, LogLevel.RECV)(self.proc.recvline)
        self.recvline_contains = logger(self.log, LogLevel.RECV)(self.proc.recvline_contains)
        self.recvline_endswith = logger(self.log, LogLevel.RECV)(self.proc.recvline_endswith)
        self.recvline_pred = logger(self.log, LogLevel.RECV)(self.proc.recvline_pred)
        self.recvline_regex = logger(self.log, LogLevel.RECV)(self.proc.recvline_regex)
        self.recvline_startswith = logger(self.log, LogLevel.RECV)(self.proc.recvline_startswith)
        self.recvlines = logger(self.log, LogLevel.RECV)(self.proc.recvlines)
        self.recvn = logger(self.log, LogLevel.RECV)(self.proc.recvn)
        self.recvpred = logger(self.log, LogLevel.RECV)(self.proc.recvpred)
        self.recvregex = logger(self.log, LogLevel.RECV)(self.proc.recvregex)
        self.recvrepeat = logger(self.log, LogLevel.RECV)(self.proc.recvrepeat)
        self.recvuntil = logger(self.log, LogLevel.RECV)(self.proc.recvuntil)

        self.send = logger(self.log, LogLevel.SEND)(self.proc.send)
        self.send_raw = logger(self.log, LogLevel.SEND)(self.proc.send_raw)
        self.sendafter = logger(self.log, LogLevel.SEND)(self.proc.sendafter)
        self.sendline = logger(self.log, LogLevel.SEND)(self.proc.sendline)
        self.sendlineafter = logger(self.log, LogLevel.SEND)(self.proc.sendlineafter)
        self.sendlinethen = logger(self.log, LogLevel.SEND)(self.proc.sendlinethen)
        self.sendthen = logger(self.log, LogLevel.SEND)(self.proc.sendthen)

    def interact(self):
        self.proc.interactive()

    def breakpoint(self, b, c=None):

        if c:
            b = self.format_bp(b)
            self.commands.append("b " + b)
            self.commands.append("commands")
            self.commands.append("\n".join(c))
            self.commands.append("end")
        else:
            self.breakpoints.append(b)

    bp = breakpoint

    def gdb(self):

        self.gdbinit = """
            {bp}
            {commands}
        """.format(
            bp="\n".join(
                ["b "+self.format_bp(x) for x in self.breakpoints]
            ),
            commands="\n".join(self.commands),
        )

        gdb.attach(self.proc, self.gdbinit)

    def format_bp(self, x):

        if isinstance(x, int):
            return "*"+hex(x+self.pie)
        else:
            try:
                return int(x+self.pie)
            except:
                return str(x)

    def log(self, s, t=LogLevel.DEBUG):
        if int(t) & self.level != 0:
            print s

    def ldd(self):

        if not self.file:
            print "[-] No local file, cannot check libraries"
            return []

        libs = []
        p = subprocess.Popen(["ldd", self.file],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)

        result = p.stdout.readlines()

        for x in result:
            s = x.split()
            if "=>" in x:
                if len(s) == 3: # virtual library
                    pass
                else:
                    libs.append(s[2])
            else:
                if len(s) == 2:
                    libs.append(s[0])

        return libs

    def libc_path(self):

        libs = [x for x in self.ldd() if "libc" in x]
        if not libs or len(libs) > 1:
            return
        else:
            return libs[0]

    def libc(self, path=None):

        if self._libc:
            return self._libc
        elif (not path) and self.remote:
            print "[-] libc not available on remote connection, please provide filename"
            return
        elif not path:
            path = self.libc_path()

        print "[+] loading libc"
        self._libc = ELF(path)
        print "[+] done"

        return self._libc


    def elf(self):
        if not self.file:
            print '[-] no local file found, skipping'
            return
        if self._elf:
            return self._elf
        else:
            self._elf = ELF(self.file)
            return self._elf


    # LOLOLOLOLOLOL
    def using(self,cls):
        merge = inspect.getmembers(cls, predicate=inspect.ismethod)
        for name,meth in merge:
            self.__dict__[name] = meth.__get__(self)

