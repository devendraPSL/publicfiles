echo "$1        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
 
 
# Partitions all data disks attached to the VM and creates
# a RAID-0 volume with them.
#  https://raw.githubusercontent.com/Azure/azure-quickstart-templates/875d139c16c9c023dce519e6dd48c707e3473346/slurm-on-sles12-hpc/azuredeploy.sh
#setup_data_disks()
#{
    mountPoint="$2"
	createdPartitions=""

    # Loop through and partition disks until not found
    for disk in sda; do
        fdisk -l /dev/$disk || break
        fdisk /dev/$disk << EOF
d
n
p
1


a
w
EOF
        createdPartitions="$createdPartitions /dev/${disk}1"
	done

#}
