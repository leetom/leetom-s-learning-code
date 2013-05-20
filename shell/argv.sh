#!/bin/bash

echo $#
echo "The argvs are:"
echo $@ "and " $*
#shift
echo "after shift"
echo $@ "and " $*
echo "The execurate uid is $UID"

echo arguments:0,1,2;
echo $0
echo $1
echo $2
