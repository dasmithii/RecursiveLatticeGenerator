"""Recursive Lattice Generator

Usage:
  main.py [--size=<>] [--prongs=<>] ([--output=<>] | [--count=<>] [--threads=<>])
  main.py (-h | --help)
  main.py --version

Options:
  -h --help          Show this screen.
  --version          Show version.
  --count=<n>        Specify lattice count.
  --size=<pixels>    Specify image side length.   [default: 500]
  --prongs=<n>       Specify lattice dimension.   [default: 3]
  --output=<file>    Specify output directory.    [default: ./dump]
  --threads=<n>      Limit number of threads.     [default: 1]


"""
import pyprocessing
from docopt import docopt
import application


# An application must be built outside the setup and draw
# functions. That way, it can be accessed from each.
app = application.new()


# Spawns worker threads and begins generating lattices.
def setup():
	pyprocessing.size(500, 500)
	app.setup()


# Updates application each frame. Worker threads continue unless
# the memory cap is reached. User is given the options: 'save'
# and 'next' indefinitely.
def draw():
	app.draw()


# Parse command line arguments via docopt and start the
# lattice generator.
if __name__ == '__main__':
	args = docopt(__doc__, version='2.0')
	app.prepare(args)
	if args["--count"] is None:
		pyprocessing.run()
	else:
		app.dump()
