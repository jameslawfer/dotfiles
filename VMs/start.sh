#!/bin/bash
echo "virt-viewer --connect=qemu:///system --domain-name win10 &"
sudo virsh start win10
virt-viewer --connect=qemu:///system --domain-name win10 -f &
