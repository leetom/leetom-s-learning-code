#!/usr/bin/php
<?php

$fd = fopen('./ls.txt', 'r+');

while($line = fgets($fd)){
	echo $line;
}
