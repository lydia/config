#!/usr/bin/python

import os
import sys

def main():
    files = os.listdir(os.curdir)
    home = os.path.expanduser('~')
    print home
    print files
    print sys.argv[0]
    for f in files:       
        if f != 'links.py' and f != '.' and f != '..':
            print f
            path = os.path.abspath(os.path.join(os.curdir, f))
            print path
            os.symlink(path, os.path.join(home, '.' + f))


if __name__ == '__main__':
    main()
