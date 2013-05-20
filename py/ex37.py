#!/usr/bin/env python

from random import randint
from sys import argv

number = randint(1,100)
if len(argv) == 2 and argv[1] == 'debug':
	print number
guess_count = 0

while True:
	guess_count += 1
	guess = int(raw_input('Please guess a number:'))
	if guess > number:
		print "Too Large."
	elif guess < number:
		print "Too Little"
	else:
		print "Bingo! "
		print "You have guessed %d times" % guess_count
		break


