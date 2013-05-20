#!/bin/bash
hello="AB C D"

echo $hello
echo "Second:"
echo "$hello"   
#hello=
unset hello
echo "\$hello (null value) = $hello"

