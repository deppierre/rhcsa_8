#!/bin/bash
#VM1
sudo virt-install --name=centos8_1-vm \
--ram=1024 --vcpus=1 \
--cdrom=/home/ingenico/Documents/centos_iso/centos8_mini.iso --os-type=linux \
--network bridge=virbr1 \
--noreboot\
--disk path=/home/ingenico/Documents/centos_iso/centos8_1.dsk,size=20

#Image creation
sudo qemu-img create -f qcow2 centos8.img 100M

#Network
##LIST IP DU DHCP
sudo virsh net-dhcp-leases centos_bridge

#Manage VMs
# https://computingforgeeks.com/virsh-commands-cheatsheet/
##LIST
sudo virsh list --all
##START
sudo virsh start centos8_1
##STOP
sudo virsh shutdown centos8_1
##EDIT CONF
sudo virsh edit centos8_1
##DISABLE AUTOSTART
sudo virsh autostart --disable centos8_1-vm

#Snapshot
##LIST
sudo virsh snapshot-list --domain centos8_1-vm 
##INFO
sudo virsh snapshot-info --domain centos8_1-vm  --snapshotname "centos8_1-snap"
##CREATION
sudo virsh snapshot-create-as --domain centos8_1-vm --name "centos8_1-snap"
##DELETE
sudo virsh snapshot-delete --domain centos8_1-vm centos8_1-snap
##ROLLBACK (apres shutdown)
virsh snapshot-revert --domain centos8_1-vm --snapshotname centos8_1-snap --running 

#Clone VM
virt-clone \
--original=centos8_1 \
--name=centos8_1-vm \
--file=/home/ingenico/Documents/centos_iso/centos8_1_clone.dsk