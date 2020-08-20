# Know How to
- How to setup CIFS and NFS from scratch
- How to reset root password from single mode
- How to configure Logical Volume from scratch
- How to create partitions and filesystems
- How to extend LVMs and VDOs
- How to change NTP servers


# Essential Tools
## Basic Commands
- touch
- cp
- mv
- rm
- su
- sudo
- ls
- mkdir
- cat
- less
- more
- head
- tail
- ln
- w
- uptime

## Additional Basic Commands
- sort
- wc
- diff
- file
- awk
- sed

## File Editors (Pick 1 and learn it)
- vi
- nano
- ed

## IO Redirect
- \>
- \>>
- |
- 2>

## File Archive
- tar
- gzip
- bzip2
- zip
- unzip

## Search
- grep
- pgrep
- fgrep
- which
- find
- locate
    - updatedb
- System Documentation
    - man
    - apropos
- Packages
    - mlocate

# Permissions
- chown
- chmod
- umask
- setfacl
- getfacl

# User Management 
- id
- getent
- useradd
- usermod
- chage
- groupadd
- groupmod
- Important Locations
    - /etc/skel
    - /etc/passwd
    - /etc/group
    - /etc/default/useradd
    - /etc/login.defs

# Operating System
## Systemd (systemctl)
- Targets (runlevel)
- Services

## Boot
- grub
    - rd.break
    - emergency
    - rescue
- Kernel
    - grubby
    - grub2-set-default

## Processes
- top
- nice
    - [-20 to 20] (Lower has higher priority)
- renice
- ps aux
- pgrep
- kill
    - SIGHUP  (Stop)
    - SIGINT  (Ctrl+C)
    - SIGKILL (Kill, No Clean-up)
    - SIGTERM (Kill, Clean exit)
    - SIGSTOP (Stop and background)
    - SIGCONT (Start a Stopped process)
    - SIGTSTP (Ctrl+Z)
- Schedulers
    - chrt
    - Policy
        - SCHED_FIFO
        - SCHED_RR
        - SCHED_NORMAL
        - SCHED_DEADLINE

## Journal
- journalctl
- Persistent
    - mkdir -p /var/log/journal
    - systemctl restart systemd-journald

# Package Management
- rpm
- yum
- dnf
- Modules (AppStream)
    - dnf module enable module-name:stream
    - dnf module list

# Storage
- LVM
    - pvcreate
    - vgcreate
    - lvcreate
    - lvdisplay
    - vgextend
    - lvextend
- Filesystem
    - mkfs
    - mount
    - fdisk
    - gdisk
    - /etc/fstab
    - lsblk -l
- Compression (VDO)
    - vdo
        - vdo growPhysical --name=nameofvdo
    - vdostats
    - Create
        - mkfs.xfs -K
        - mkfs.ext4 -E nodiscard
        - udevdm settle
        - mount
        - fstab
            - /device /mount FSTYPE defaults,_netdev, x-systemd.device-timeout=0,x-systemd.requires=vdo.service 0 0
    - Packages
        - vdo
        - kmod-kvdo
    - Guidance
        - 10x vdoLogicalSize (VM/Container)
        - 3x vdoLogicalSize (Other)

# Scheduling
- cron
- /etc/cron.d
- at

# Networking
## Interfaces
- nmcli
- ip
- ping
- curl
- dig
- Packages
    - bash-completion
    - iproute2
    - bind-utils
    - NetworkManager
- Important Locations
    - /sys/class/net
    - /etc/sysconfig/network-scripts
    - /etc/resolv.conf
    - /etc/hosts
    - /etc/nsswitch.conf
## Firewall
- firewall-cmd
- iptables
- Packages
    - firewalld
    - firewall-config
## Time
- timedatactl
- tzselect
- chronyc
    - /etc/chronyc.conf
## Storage
- NFS
    - /etc/exports
    - exportfs
    - showmount
    - Packages
        - nfs-utils
    - Services
        - rpcbind
        - nfs-server (Server)
        - rpcstatd   (Server)
        - nfs-idmapd (Server)
- SMB/CIFS
    - /etc/samba/smb.conf
    - smbpasswd
    - Packages
        - samba
        - cifs-utils
- AutoFS
    - Location
        - /etc/auto.master
    - Package
        - autofs

# Logging
- journalctl
- Important Locations
    - /etc/rsyslog.conf
    - /etc/logrotate.conf
    - /var/log

# Directory Services
- authconfig-gtk
- authconfig-tui
- authconfig
- realmd
- Packages
    - nss-pam-ldapd
    - pam_krb5
    - autofs
    - nfs-utils
    - openldap-clients

# SELinux
- getenforce
- setenforce
- getsebool
- setsebool
- sealert
- Locations
    - /var/log/audit/audit.log
- Packages
    - setroubleshoot-server
- Modes
    - Permissive
    - Enforcing
    - Disabled
- Context
    - semanage fcontext -l
    - restorecon
    - ps auxZ
    - chcon
    - ls -ldZ
    - /.autorelabel





