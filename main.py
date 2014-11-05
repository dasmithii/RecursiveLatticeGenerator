"""Recursive Lattice Generator

Usage:
  main.py [--size=<>] [--prongs=<>] ([--output=<>] | [--count=<>] [--threads=<>])
  main.py (-h | --help)
  main.py --version

Options:
  -h --help          Show this screen.
  --version          Show version.
  --count=<n>        Specify lattice count.
  --size=<pixels>    Specify image widths.
  --prongs=<n>       Specify lattice dimension.   [default: 3]
  --output=<file>    Specify output directory.    [default: ./dump]
  --threads=<n>      Limit number of threads.     [default: 1]


"""
from docopt import docopt
import generator


# Parse command line arguments via docopt and start the
# lattice generator.
if __name__ == '__main__':
	args = docopt(__doc__, version='2.0')
	if args["--count"] is None:
		generator.open(args)
	else:
		generator.dump(args)
