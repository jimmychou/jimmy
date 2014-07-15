#服务器最小化安装后的优化脚本，此脚本在CentOS[5.5-5.8] x86_64系统下测试均顺利通过， 由于现在Linux服务器系统都是采用Kickstart批量安装的方式，此脚本可以由Puppet服务器推送执行，脚本内容如下所示：

#!/bin/bash
#添加epel和rpmforge的外部yum扩展源
cd /usr/local/src
wget http://mirrors.ustc.edu.cn/fedora/epel//5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivh epel-release-5-4.noarch.rpm
wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
rpm -ivh rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
#安装gcc基础库文件以及sysstat工具
yum -y install gcc gcc-c++ vim-enhanced unzip unrar sysstat
#配置ntpdate自动对时
yum -y install ntp
echo "01 01 * * * /usr/sbin/ntpdate ntp.api.bz    >> /dev/null 2>&1" >> /etc/crontab
ntpdate ntp.api.bz
service crond restart
#配置文件的ulimit值
ulimit -SHn 65535
echo "ulimit -SHn 65535" >> /etc/rc.local
cat >> /etc/security/limits.conf << EOF
*                     soft     nofile             60000
*                     hard     nofile             65535
EOF
#tune kernel parametres(基础系统内核优化)
cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 1024 65535
EOF
/sbin/sysctl -p
#禁用control-alt-delete组合键以防止误操作
sed -i 's@ca::ctrlaltdel:/sbin/shutdown -t3 -r now@#ca::ctrlaltdel:/sbin/shutdown -t3 -r now@' /etc/inittab
#关闭SElinux
sed -i 's@SELINUX=enforcing@SELINUX=disabled@' /etc/selinux/config
#ssh服务配置优化
sed -i -e '74 s/^/#/' -i -e '76 s/^/#/' /etc/ssh/sshd_config
sed -i 's@#UseDNS yes@UseDNS no@' /etc/ssh/sshd_config
service sshd restart
#禁用ipv6地址
echo "alias net-pf-10 off" >> /etc/modprobe.conf
echo "alias ipv6 off" >> /etc/modprobe.conf
echo "install ipv6 /bin/true" >> /etc/modprobe.conf
echo "IPV6INIT=no" >> /etc/sysconfig/network
sed -i 's@NETWORKING_IPV6=yes@NETWORKING_IPV6=no@'    /etc/sysconfig/network
chkconfig ip6tables off
#vim基础语法优化
echo "syntax on" >> /root/.vimrc
echo "set nohlsearch" >> /root/.vimrc
#停用系统中不必要的服务
chkconfig bluetooth off
chkconfig sendmail off
chkconfig kudzu off
chkconfig nfslock off
chkconfig portmap off
chkconfig iptables off
chkconfig autofs off
chkconfig yum-updatesd off
#重启服务器
reboot
#脚本重点部分说明：tune kernel parametres为系统内核优化部分，在这里我只做了基础处理，大家有需求可以自行修改，记住：一切以系统稳定为原则。vim优化部分为vim的个性化配置，如果想vim语法高亮，则必须安装vim-enhanced包，另外，vim在使用搜索功能，搜索选中内容为高亮，感觉不是特别舒服，所以我这里用了set nohlsearch选项，如果大家不介意此项功能，则不需要添加此语句；disable ipv6选项我在测试时发现，在CentOS5.8 x86_64系统下，如果不添加install ipv6 /bin/true此语句到/etc/modprobe.conf文件里，是关闭不了ipv6选项的，而测试的CentOS{5.5,5,6} x86_64系统不添加此句均可以顺利关闭ipv6，这点请大家注意下。
