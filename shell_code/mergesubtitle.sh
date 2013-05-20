#!/bin/bash
#
#
for file in *.en.srt
do
	cn_file=`echo $file | sed "s/.en/.gb/"`
	if [ ! -f $cn_file ]
	then
		cn_file=`echo $file | sed "s/.en/.ch/"`
	fi
	new_file=`echo $file | sed "s/.en.srt/.srt/"`
	cat $file $cn_file > $new_file
done
	
