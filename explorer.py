from pyprocessing import *


class Explorer:


	def __init__(self, d=3, p=3):
		self.prepared = False
		self.set_dimension(d)
		self.set_precision(p)


	def set_dimension(self, n):
		self.dimension = n


	def set_precision(self, p):
		self.precision = p


	def prepare(self):
		self.lattices = []
		self.prepared = True


	def ensure_ready(self):
		if not self.prepared:
			self.prepare()


	def draw(self):
		self.ensure_ready()
