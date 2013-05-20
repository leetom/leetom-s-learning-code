#!/usr/bin/env php
<?php
$fd = fopen('./ls.txt', 'r+');


while($line = fread($fd, 10)){
	echo $line;
}
