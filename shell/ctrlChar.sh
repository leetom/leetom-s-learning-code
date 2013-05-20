#!/bin/bash
# Thank you, Lee Maschmeyer, for this example.

read -n 1 -s -p $'Control-M leaves cursor at beginning of this line. Press Enter. \x0d'

#当然,'0d'就是二进制的回车.
echo >&2
# '-s'参数使得任何输入都不将回显出来
#+ 所以,明确的重起一行是必要的.
read -n 1 -s -p $'Control-J leaves cursor on next line. \x0a'
echo >&2
# Control-J 是换行.

###

read -n 1 -s -p $'And Control-K\x0bgoes straight down.'
echo >&2
# Control-K 是垂直制表符.

# 关于垂直制表符效果的一个更好的例子见下边:

var=$'\x0aThis is the bottom line\x0bThis is the top line\x0a'
echo "$var"
# 这句与上边的例子使用的是同样的办法,然而:




echo "$var" | col
# 这将造成垂直制表符右边的部分在左边部分的上边.
# 这也解释了为什么我们要在行首和行尾加上一个换行符--
#+ 来避免一个混乱的屏幕输出.

# Lee Maschmeyer 的解释:
# ---------------------
# In the [first vertical tab example] . . . the vertical tab
# 在这里[第一个垂直制表符的例子中] . . . 这个垂直制表符







#+ makes the printing go straight down without a carriage return.
# This is true only on devices, such as the Linux console,
#+ that can't go "backward."
# The real purpose of VT is to go straight UP, not down.
# It can be used to print superscripts on a printer.
# 它可以用来在一个打印机上打印上标.
# col 的作用,可以用来模仿 VT 的合适的行为.
exit 0

