echo "$1        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

(echo d; echo n; echo p; echo 1; echo; echo; echo a; echo w) | fdisk /dev/sda > /dev/null 

(echo n; echo p; echo 1; echo; echo; echo w) | fdisk /dev/sdc > /dev/null 
mkfs -t ext4 /dev/sdc1 > /dev/null 
mkdir /datadisk0 
mount /dev/sdc1 /datadisk0

echo "UUID=$(blkid | grep -oP '/dev/sdc1: UUID="*"\K[^"]*')   /datadisk0   ext4   defaults   1   2" >> /etc/fstab
chmod go+w /datadisk0


