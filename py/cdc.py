# -*- coding: utf-8 -*-
#
import os

def cdWalker(path, cdcfile):
	export = ""
	for root, dirs, files in os.walk(path):
		export += "\n %s; %s; %s" % (root, dirs, files)
	open (cdcfile, 'w').write(export)

cdWalker('/media/xp/software', './cd1.cdc')

