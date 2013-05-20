#!/usr/bin/env python

ex01 = open('ex1.py', 'r')

for line in ex01.readlines():
	print line.rstrip()

