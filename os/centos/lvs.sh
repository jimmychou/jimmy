#!/bin/bash
# 2015-04-23 by jimmychou

VIP=192.168.4.243
RIP1=192.168.4.241
RIP2=192.168.4.254

/etc/rc.d/init.d/functions

logger $0 called with $1
case "$1" in

start)
echo " start LVS of DirectorServer"
/sbin/ifconfig eth0:0 $VIP broadcast $VIP netmask 255.255.255.255 up
/sbin/route add -host $VIP dev eth0:0
echo "1" >/proc/sys/net/ipv4/ip_forward

#Clear IPVS table
/sbin/ipvsadm -C
#set LVS
/sbin/ipvsadm -A -t $VIP:80 -s rr
/sbin/ipvsadm -a -t $VIP:80 -r $RIP1:80 -g
/sbin/ipvsadm -a -t $VIP:80 -r $RIP2:80 -g

#Run LVS
/sbin/ipvsadm
;;
stop)
echo "close LVS Directorserver"
echo "0" >/proc/sys/net/ipv4/ip_forward
/sbin/ipvsadm -C
/sbin/ifconfig eth0:0 down
;;
*)

echo "Usage: $0 {start|stop}"
exit 1
esac
