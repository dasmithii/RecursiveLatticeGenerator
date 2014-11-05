"""Recursive Lattice Generator

Usage:
  main.py [--dimension=<d>] ([--output=<f>] | [--count=<c>] [--threads=<ts>])
  main.py (-h | --help)
  main.py --version

Options:
  -h --help         Show this screen.
  --version         Show version.
  --dimension=<d>   Specify lattice dimension.   [default: 3]
  --output=<file>   Specify output directory.    [default: ./dump]
  --count=<c>       Specify lattice count.       [default: 1]
  --threads=<ts>    Limit number of threads.     [default: 1]


"""
from docopt import docopt
from pyprocessing import *

# Parse command line arguments via docopt and start the
# lattice generator.
if __name__ == '__main__':
    arguments = docopt(__doc__, version='2.0')
    print(arguments)