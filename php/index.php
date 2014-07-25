<?php
$hostname = gethostname();
$IP = gethostbyname($hostname);
echo "Hostname is $hostname and IP is $IP\n";
