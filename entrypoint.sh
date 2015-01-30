#/bin/bash

usage() {
  echo "You need to specify a puppet command:"
  echo " - puppet"
  echo " - facter"
  exit 1
}

# Exit if no parameter is passed
# for some reason docker passes the /bin/sh as $1 when no parameter is added
# from the commandline
[ "$1" == '/bin/sh' ] && usage

. /etc/profile.d/rvm.sh

mount -o bind /var/tmp /mnt/root/var/tmp/
hostname $(cat /mnt/root/etc/hostname)
exec chroot /mnt/root/ /bin/bash -c "$(echo $@)"
