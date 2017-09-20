#cloud-config

packages:
 - htop
 - ntp
 - tcpdump
 - tree
 - epel-release
 - nginx

package_upgrade: true
