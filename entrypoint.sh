#/bin/bash

usage() {
  echo "ERROR: $1"
  echo " - puppet"
  echo " - facter"
  exit 1
}

if [ "$1" == '/bin/sh' ] || [ "$1" == '/bin/bash' ]
then
  exec $1
else
  . /etc/profile.d/rvm.sh

  mount -o bind /var/tmp /mnt/root/var/tmp/ 2>/dev/null
  exit=$?
  [ $exit != 0 ] && usage "Mount failed. Did you run docker with '--privileged -v /:/mnt/root:rw' ? "
  hostname $(cat /mnt/root/etc/hostname)
  exec chroot /mnt/root/ /bin/bash -c "$(echo $@)"
fi
