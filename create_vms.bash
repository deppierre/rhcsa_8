#!/bin/bash
#SSHI l
#CONNECTION HYPERVISOR
virt-manager -c qemu:///system
#VM CONNECTIONS
ssh student@$(sudo virsh -q net-dhcp-leases centos_bridge | grep server1 | awk '{print $5}' | cut -c 1-14)
ssh student@$(sudo virsh -q net-dhcp-leases centos_bridge | grep server2 | awk '{print $5}' | cut -c 1-14)

#VM1 - hostname: server1
sudo virt-install --name=centos8_1-vm \
--ram=2048 --vcpus=1 \
--cdrom=/home/ingenico/Documents/centos_iso/centos8_full.iso --os-type=linux \
--network bridge=virbr1 \
--disk path=/home/ingenico/Documents/centos_iso/centos8_1.dsk,size=20

#VM2 - hostname: server2
sudo virt-install --name=centos8_2-vm \
--ram=2048 --vcpus=1 \
--cdrom=/home/ingenico/Documents/centos_iso/centos8_full.iso --os-type=linux \
--network bridge=virbr1 \
--disk path=/home/ingenico/Documents/centos_iso/centos8_2.dsk,size=20

#Snapshot
##LIST
sudo virsh snapshot-list --domain centos8_1-vm 
##INFO
sudo virsh snapshot-info --domain centos8_1-vm  --snapshotname "centos8_1-snap"
##CREATION
sudo virsh snapshot-create-as --domain centos8_1-vm --name "centos8_1-snap"
sudo virsh snapshot-create-as --domain centos8_2-vm --name "centos8_2-snap"
##DELETE
sudo virsh snapshot-delete --domain centos8_1-vm centos8_1-snap
##ROLLBACK (apres shutdown)
virsh snapshot-revert --domain centos8_1-vm --snapshotname centos8_1-snap --running 

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

