#cloud-config

packages:
 - htop
 - ntp
 - tcpdump
 - tree
 - epel-release
 - mariadb-server
 - mysql-server

package_upgrade: true
