#!/bin/bash

if [ "${1##*.}" = "tar" ]
then
	echo This appears to be a tarball.
else
	echo At first glance, this does not appear to be a tarball.
fi
