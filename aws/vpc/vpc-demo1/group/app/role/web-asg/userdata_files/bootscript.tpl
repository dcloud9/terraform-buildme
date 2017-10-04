#! /bin/bash -x

# Set hostname
[ $(rpm -q --queryformat '%{VERSION}' centos-release) == '7' ] && hostnamectl set-hostname ${hostname}.${domainname} || hostname ${hostname}.${domainname}
sed -i "s/.*HOSTNAME.*/HOSTNAME=${hostname}.${domainname}/" /etc/sysconfig/network
# Set cloud-config to persist hostname on reboot
echo "hostname: ${hostname}" > /etc/cloud/cloud.cfg.d/99_hostname.cfg
echo "fqdn: ${hostname}.${domainname}" >> /etc/cloud/cloud.cfg.d/99_hostname.cfg

# Enable services for any CentOS version, including AMZN AMI
[ $(rpm -q --queryformat '%{VERSION}' centos-release) == '7' ] && systemctl enable ntpd || chkconfig ntpd on
[ $(rpm -q --queryformat '%{VERSION}' centos-release) == '7' ] && systemctl enable nginx || chkconfig nginx on

# Reboot to ensure change persistence
reboot

