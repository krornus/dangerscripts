# helper scripts
from hack import *
from hack.pwnable import LogLevel

# useful imports
from collections import namedtuple
from pwn import *
from time import sleep,time
from ctypes import CDLL
from uuid import uuid4
from copy import copy
from binascii import unhexlify,hexlify
from bs4 import BeautifulSoup
from argparse import ArgumentParser

import numpy as np

import subprocess
import requests
import urllib
import string
import struct
import sys
import re
import os

def main(remote):

    target = ""
    pwd    = ""
    fn     = pwd+target
    server = ("", 0)
    path   = fn if not remote else server
    m      = pwnable.Pwnable(path, terminal=['sakura', '-x'], using=Interactive)

    # gdb default PIE address
    m.pie = 0x555555554000

    libc = m.libc()
    elf = m.elf()

    # exploit

    m.interact()

# place interaction functions here
# auto add methods to the pwnable instantiation using
#     m = pwnable.Pwnable(path)
#     m.using(Interactive)
# OR
#     m = pwnable.Pwnable(path, using=Interactive)
class Interactive:
    pass

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--remote", "-r", action="store_true")
    args = parser.parse_args()
    main(args.remote)
