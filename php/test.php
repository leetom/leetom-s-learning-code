#!/usr/bin/env php
<?php
#This is a php file
#
print_r($_SERVER);
$fd = file_get_contents('/etc/passwd');
echo $fd;
