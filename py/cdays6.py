import time

year = time.localtime()[0]
print year
if(year % 400 == 0 or year % 4 == 0 and year %100 <> 0):
	print "This year %s is a leap year" % year
else:
	print "This year %s is not a leap year" % year
