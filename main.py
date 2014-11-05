from pyprocessing import *
from explorer import Explorer
import sys


# Command line help.
usage = ''' - usage:
       =>  program [lattice-dimension]'''


# Global explorer.
explorer = Explorer()


# Prepares drawing window.
def setup():
	size(screen.width, screen.height)
	rectMode(CENTER)
	explorer.prepare()



# Update for next frame.
def draw():
	background(0)
	explorer.draw()


# Helper for input errors.
def invalid(message):
	print ' - ERROR: ' + message + '.'
	print usage
	exit(1)


# React to command line arguments and start the lattice
# explorer.
if __name__ == "__main__":
	args = sys.argv[1:]
	if len(args) > 1:
		invalid('too many arguments')
	elif len(args) == 1:
		if args[0] == 'help':
			print usage
			exit(0)
		try:
			prongs = int(args[0])
		except:
			invalid('dimension not parsable')
		if prongs <= 1:
			invalid('dimension <= 1')
		explorer.set_dimension(prongs)
	run()




