from pyprocessing import *
import Queue


# Represents a lattice-generating Processing app, either
# dumping or displaying images, depending on command line
# input.
class Application:

	def __init__(self, args=None):
		self.queue = Queue.Queue()
		if args is not None:
			self.prepare(args)

	# Stores application arguments in self, spawns worker
	# threads, and begins generating images (assuming
	# at least one worker is permitted).
	def prepare(self, args):
		self.args = args


	# To be called on each frame update. Prompts user to
	# either 'save' or 'skip' the current lattice.
	def draw(self):
		print 'drawing...'

	# Generates requested lattices, saving each to the dump
	# directory. Prints updates to console so it doesn't 
	# look frozen.
	def dump(self):
		print 'dumping... (TODO)'


# Creates a new application without opening windows or 
# spawning
def new():
	return Application()