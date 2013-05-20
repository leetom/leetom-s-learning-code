#!/usr/bin/python

class Polygon:
	def getArea(self):
		print "Method to get Area of polygon"
	def setArea(self, area):
		self.area = area

	def __init__(self, bian, jiao):
		self.bian = bian
		self.jiao = jiao

	PI = 3.14

class Triangle(Polygon):
	def getArea(self):
		print "Method to get Area of Triangle"

	def __init__(self, bianchang):
		self.bian = bianchang

	Neijiaohe = 180

poly = Polygon(20, 20)
poly.setArea(100)
poly.getArea()

print poly.PI
print Polygon.PI

print poly.area
print dir(Polygon)
print dir(poly)
print "create triangle:"
tri = Triangle(30)
tri.getArea()
print tri.Neijiaohe
print dir(Triangle)
