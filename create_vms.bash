#!/bin/bash
#VM1 - hostname: server1
sudo virt-install --name=centos8_1-vm \
--ram=2048 --vcpus=1 \
--cdrom=/home/ingenico/Documents/centos_iso/centos8_full.iso --os-type=linux \
--network bridge=virbr1 \
--disk path=/home/ingenico/Documents/centos_iso/centos8_1.dsk,size=20

#Clone VM
virt-clone \
--original=centos8_1-vm \
--name=centos8_2-vm \
--file=/home/ingenico/Documents/centos_iso/centos8_2.dsk

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
