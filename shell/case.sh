echo $*
case "${1##*.}" in 
	gz)
		echo gz file
		;;
	bz2)
		echo bz2 file
		;;
	*)
		echo "any thing"
		;;
esac
