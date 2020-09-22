#!/bin/bash
## Author: Tyr4n7
### Storage utility to reformat an entire disk to a vfat or alternatively really anything (mkfs.$Type, I guess)

if [ $# -eq 0 ]
  then
    echo -ne "No arguments supplied.\nUsage: $0 /dev/sdX\n"
    exit;
fi


sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk -w always -W always $1
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1, as well as try to maintain the two newlines below to ensure it starts at the beginning of disk (vice versa for ending), if you copy-paste this, then just add two newlines down here


  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

###### Make into a vfat
mkfs.vfat $11; #/dev/sdb1
echo "Done!"

