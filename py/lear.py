#!/usr/bin/env python

import math
for i in [20:80]:
	for j in [20:i]:
		avg = (i + j)/2.0
		avgln = (i - j)/math.ln(i/j)
		print avg - avgln

