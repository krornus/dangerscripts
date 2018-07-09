import re
import struct

from binascii import unhexlify

class Construct:

    def __init__(self, name, fields, userpack=[], userunpack=[]):

        VAR_RE = re.compile("^[a-zA-Z_][0-9a-zA-Z_]*$")

        self.st_name = name
        types = {
            'pad': 'x',
            'char': 'c',
            'signed char': 'b',
            'unsigned char': 'B',
            'bool': '?',
            'short': 'h',
            'unsigned short': 'H',
            'int': 'i',
            'unsigned int': 'I',
            'long': 'l',
            'unsigned long': 'L',
            'long long': 'q',
            'unsigned long long': 'Q',
            'ssize_t': 'n',
            'size_t': 'N',
            'float': 'f',
            'double': 'd',
            'char[]': 's',
            'char[]': 'p',
            'void *': 'P',
            'void*': 'P',
        }

        self.names = []
        self.types = []
        self.custom = []
        self.user = []
        self.fields = fields
        self.structs = []
        self.values = []

        self.userpack = userpack
        self.userunpack = userunpack

        if not isinstance(self.userpack,list):
            self.userpack = [self.userpack]
        if not isinstance(self.userunpack,list):
            self.userunpack = [self.userunpack]

        assert(len(self.userpack) == len(self.userunpack))

        fmt = ""
        i = 0
        upctr = 0
        while i < len(fields):

            dtype,name = fields[i]

            if not VAR_RE.match(name):
                raise ValueError("Invalid variable name: '{}'".format(name))

            self.names.append(name)
            self.types.append(dtype)

            if dtype in types:
                fmt += types[dtype]
                upctr += 1
            else:
                # upack can return another Construct
                upack = self.pack_user(dtype)
                if upack:
                    # add current index to list
                    self.user.append(i)

                    if isinstance(upack, Construct):
                        if fmt:
                            self.structs.append(struct.Struct(fmt))
                        self.structs.append(upack)
                        upctr += 1
                        fmt = ""
                    else:
                        fmt += upack
                        upctr += len(upack)

                else:
                    cpack = self.pack_custom(dtype)
                    if cpack:
                        # add current index to list
                        self.custom.append(i)
                        fmt += cpack

                        upctr += len(cpack)
                    else:
                        raise ValueError("Unsupported data type: {}".format(dtype))
            i += 1

        if fmt:
            self.structs.append(struct.Struct(fmt))

        self.format = str([x.format for x in self.structs])
        self.size = sum(x.size for x in self.structs)

        self.__call__ = self.load


    def factory(self, name, fields):
        class Factory:
            def __init__(self,name,fields):
                self.values = []
                self.st_name = name
                self.fields = fields

            def __str__(self):

                ptr_re = re.compile("(?:struct\s+)?[a-zA-Z_][a-zA-Z0-9_]*\s*\*+")

                struct =  "struct {} {{\n".format(self.st_name)
                values = self.values if self.values != None else []

                for ((dtype,name),value) in zip(self.fields, values):

                    if dtype == "P" or ptr_re.match(dtype):
                        value = hex(value)

                    value = "\n    ".join(str(value).split("\n"))
                    struct += "    {} {} = {},\n".format(dtype,name,value)

                struct +=  "}"

                return struct

        Factory.__name__ = self.st_name
        factory = Factory(name, fields)

        return factory


    def unpack(self, buf):
        return (self.load(buf),)

    def load(self, buf):

        values = []

        for s in self.structs:
            data = buf[:s.size]
            buf = buf[s.size:]
            values.extend(list(s.unpack(data)))

        self.values = []

        factory = self.factory(self.st_name, self.fields)

        i = 0
        fidx = 0
        while i < len(values):
            name = self.names[fidx]

            if i in self.user:
                i,value = self.unpack_user(self.types[i], i, values)
                factory.__dict__[name] = value
                factory.values.append(value)
            elif i in self.custom:
                i,value = self.unpack_custom(self.types[i], i, values)
                factory.__dict__[name] = value
                factory.values.append(value)
            else:
                factory.__dict__[name] = values[i]
                factory.values.append(values[i])
                i += 1
            fidx += 1

        return factory

    def store(self, buf):

        values = [self.__dict__[name] for name in self.names]
        self.pack(*values)

    def pack_custom(self, t):

        types = [self.pack_sized_str, self.pack_sized_buf, self.pack_typed_ptr, self.pack_enum]

        for custom in types:
            pack = custom(t)

            if pack:
                return pack
                break

    def unpack_custom(self, t, index, values):

        types = [self.unpack_sized_str, self.unpack_sized_buf, self.unpack_typed_ptr, self.unpack_enum]

        for custom in types:
            unpack = custom(t,index,values)

            if unpack:
                return unpack
                break

    # helper function for making packing constructs
    @staticmethod
    def pack_construct(name, cons):

        def pack(t):
            if t == name:
                return cons

        def unpack(t, i, v):
            if t == name:
                return i+1, v[i]

        return pack,unpack

    def pack_user(self, t):

        types = self.userpack

        for user in types:
            pack = user(t)

            if pack:
                return pack
                break

    def unpack_user(self, t, index, values):

        types = self.userunpack

        for user in types:
            unpack = user(t,index,values)

            if unpack:
                return unpack
                break

    # TODO: account for padding
    def pack_sized_buf(self, t):

        sized_buf = re.match("unsigned char\[([0-9]+)\]",t)

        if sized_buf:
            length = int(sized_buf.group(1))
            return "B"*length

    # TODO: account for padding
    def unpack_sized_buf(self, t, index, values):

        sized_buf = re.match("unsigned char\[([0-9]+)\]",t)

        if sized_buf:
            length = int(sized_buf.group(1))
            buf = []

            for i in range(length):
                buf.append(values[i+index])

            return index+length, s

    # TODO: account for padding
    def pack_sized_str(self, t):

        sized_str = re.match("char\[([0-9]+)\]",t)

        if sized_str:
            length = int(sized_str.group(1))
            return "b"*length

    # TODO: account for padding
    def unpack_sized_str(self, t, index, values):

        sized_str = re.match("char\[([0-9]+)\]",t)

        if sized_str:
            length = int(sized_str.group(1))
            s = ""

            for i in range(length):
                if values[index+i] == 0:
                    return index+length, s

                s += chr(values[index+i])

            return index+length, s

    def pack_enum(self, t):

        enum = re.match("enum\s+[a-zA-Z_][a-zA-Z0-9_]*",t)

        if enum:
            return "I"

    def unpack_enum(self, t, i, values):

        enum = re.match("enum\s+[a-zA-Z_][a-zA-Z0-9_]*",t)

        if enum:
            return i+1, values[i]

    def pack_typed_ptr(self, t):

        typed_ptr = re.match("(?:struct\s+)?[a-zA-Z_][a-zA-Z0-9_]*\s*\*+",t)

        if typed_ptr:
            return "P"

    def unpack_typed_ptr(self, t, i, values):

        typed_ptr = re.match("(?:struct\s+)?[a-zA-Z_][a-zA-Z0-9_]*\s*\*+",t)

        if typed_ptr:
            return i+1, values[i]


Entry = Construct("entry", [
    ("struct directory_entry*", "parent_directory"),
    ("enum entry_type", "type"),
    ("char[20]", "name"),
])
ep,eup = Construct.pack_construct("struct entry", Entry)

FileEntry = Construct("file_entry", [
    ("struct entry", "entry"),
    ("long long", "size"),
    ("char*", "data"),
], userpack=ep, userunpack=eup)

DirectoryEntry = Construct("directory_entry", [
    ("struct entry", "entry"),
    ("long long", "size"),
    ("struct entry*", "child"),
], userpack=ep, userunpack=eup)


if __name__ == "__main__":
    buf = unhexlify("1ea831420000000002000000696f00"
                    "616161616161616161616161616161"
                    "61616400000000000000736a4d4600"
                    "000000616161616161616161616161"
                    "616161616161616161616161616161"
                    "616161616161616161616161616161"
                    "61616161616161616161")

    file_entry = FileEntry(buf)
    print file_entry
