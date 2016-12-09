echo "$1        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

(echo d; echo n; echo p; echo 1; echo; echo; echo a; echo w) | fdisk /dev/sda > /dev/null 

(echo n; echo p; echo 1; echo; echo; echo w) | fdisk /dev/sdc > /dev/null 
mkfs -t ext4 /dev/sdc1 > /dev/null 
sleep 5

if [ -e "/dev/sdc1" ]  
then
  mkdir /datadisk0 
  echo "/dev/sdc1    /datadisk0/    ext4    defaults 0 0" >> /etc/fstab
  sleep 2
  mount /dev/sdc1 /datadisk0
fi
chmod go+w /datadisk0

