#!/bin/bash

#read -p "please input an ip address: " ip
echo "$ip is an ip?"
if echo $ip | egrep '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' #>> /dev/null
then
	echo $ip " is a valid ip"
else
	echo -e "invalid ip address\n"
fi
for i in ok and this is enum struct
do
  echo "the word is $i"
done

#select i in se lec ct ; do
#  echo "$i is in select"
#  break
#done
select var_in_case in first_var second_var
do
	case var_in_case in
	"first_var") ls . ;;
	second_var) ls / ;;
	*)	ls /etc/ ;;
	esac

	break
done



