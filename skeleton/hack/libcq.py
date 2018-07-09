import requests
from bs4 import BeautifulSoup
from collections import namedtuple

Library = namedtuple("Library", "name,symbols")

# assume string is hex
def trailing_hex(n):

    try:
        n = n.strip()

        base10 = all(c.isdigit() for c in n)
        save = n

        n = int(n,16)

        if base10:
            print "[*] WARNING: assuming '{}' is base 16".format(save)
    except:
        try:
            n = int(n)
        except:
            raise ValueError("Cannot convert '{}' to an integer".format(n))

    n = n & 0xfff
    return hex(n)[2:]

def find_libc(query):

    q = []
    for k,v in query.items():
        q.append("{}:{}".format(k, trailing_hex(v)))
    q = ",".join(q)

    r = requests.get("https://libc.blukat.me/", params={"q": q})

    if r.status_code != 200:
        return

    html  = r.text
    soup  = BeautifulSoup(html, "lxml")
    items = soup.find_all("a", {"class":"lib-item"})

    libs = []

    for item in items:

        lib=item.string.strip()

        url="https://libc.blukat.me/d/{}.symbols".format(lib)

        r = requests.get(url)
        if r.status_code != 200:
            continue

        symbols = {}
        entries = r.text.split("\n")

        for entry in entries:

            if not entry:
                continue

            sym,off = tuple(entry.split(" "))

            off = int(off, 16)
            symbols[sym] = off

        libs.append(Library(lib, symbols))

    return libs

if __name__ == "__main__":
    libc = find_libc({"puts": "690"})[0]
    print "{}::puts @ 0x{:x}".format(libc.name, libc.symbols['puts'])
