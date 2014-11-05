import pyprocessing
import application


# An application must be built outside the setup and draw
# functions. That way, it can be accessed from each.
app = application.new()


# Generates recursive lattices without opening a processing 
# window. Finished products are stored in ./output unless an
# alternative path is specified.
def dump(args):
	app.prepare(args)
	app.dump()


# Starts a Processing application in which users click through
# generated lattices, choosing to save them when they so 
# desire.
def open(args):
	app.prepare(args)
	pyprocessing.run()
	

# Updates application each frame. Worker threads continue unless
# the memory cap is reached. User is given the options: 'save'
# and 'next' indefinitely.
def draw():
	app.draw()