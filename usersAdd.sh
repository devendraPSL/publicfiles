 echo "edtuser        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
# echo "si-install        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
 
 
# Partitions all data disks attached to the VM and creates
# a RAID-0 volume with them.
#  https://raw.githubusercontent.com/Azure/azure-quickstart-templates/875d139c16c9c023dce519e6dd48c707e3473346/slurm-on-sles12-hpc/azuredeploy.sh
setup_data_disks()
{
    mountPoint="$1"
	createdPartitions=""

    # Loop through and partition disks until not found
    for disk in sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr; do
        fdisk -l /dev/$disk || break
        fdisk /dev/$disk << EOF
n
p
1


t
fd
w
EOF
        createdPartitions="$createdPartitions /dev/${disk}1"
	done

    # Create RAID-0 volume
    if [ -n "$createdPartitions" ]; then
        devices=`echo $createdPartitions | wc -w`
        mdadm --create /dev/md10 --level 0 --raid-devices $devices $createdPartitions
	    mkfs -t ext4 /dev/md10
	    echo "/dev/md10 $mountPoint ext4 defaults,nofail 0 2" >> /etc/fstab
	    mount /dev/md10
    fi
}
