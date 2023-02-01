import os, sys

def process_file(fn):
    print(fn)
    lines = open(fn).readlines()
    print(f"{len(lines)} lines in file")
    for i,l in enumerate(lines): print(i+1, l.strip())

def main(args):
    print('start')
    print("Inside python")
    
    print(args)
    process_file(args[0])
    print('end')

if __name__ == '__main__':
    args = sys.argv[1:]
    main(args)
