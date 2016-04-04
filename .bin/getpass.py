import sys
import re
import hashlib
import argparse

def get_pass(raw_passwd, url):
    pattern = "^https?://(?:www\.)?([^.]+).+$"
    
    regex = re.compile(pattern)
    match = regex.search(url)
    
    salt = hashlib.sha256(match.groups()[0]).hexdigest()[:2]
    
    passwd = hashlib.md5(salt + raw_passwd).hexdigest()

    return passwd

if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('password', help="Input string")
    parser.add_argument('url', help="Website url")

    args = parser.parse_args()
    sys.stdout.write(get_pass(args.password, args.url))
