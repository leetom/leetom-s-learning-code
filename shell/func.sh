
tarview(){
	echo -n "display contents of $1 "
	if [ ${1##*.} = tar ]
	then
		echo "(uncompressed tar)"
		tar tvf $1
	elif [ ${1##*.} = gz ]
	then
		echo "(Gzip-compressed tar)"
		tar tzvf $1
	elif [ ${1##*.} = bz2 ]
	then
		echo "(bzip2-compressed tar"
		cat $1 | bzip2 -d | tar tvf -
	fi
}

tarview $1
