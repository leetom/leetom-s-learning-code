#!/usr/bash

#i=1;
for((i=1;$i<255;i++))
do
	ping -c 1 `echo 222.199.202.$i` >> pingRESULT
done

