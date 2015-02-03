# Puppet agent docker image

## Description

Run puppet over the parent host from a container

Running puppet into a container is easy, but having it to make changes over the
parent host is another story.

This image allows you to run puppet and modify the parent host instead of
modifying the files inside the own container.

Some changes had to be done to allow it:
1. Puppet and all its dependencies are installed in /var/tmp
2. When the container is executed, you need to pass as volume the full
   filesystem of the parent host as read-write to /mnt/root
3. When the container starts, it will bind mount /var/tmp to /mnt/root/var/tmp
   and it will chroot to /mnt/tmp so Puppet can be executed over the parent
   filesystem

## How to use this image

Run puppet agent:

```
docker run \
  --privileged \
  -v /:/mnt/root:rw \
  -t \
  fr3nd/puppet \
  puppet agent -t --noop
```

Run facter:

```
docker run \
  --privileged \
  -v /:/mnt/root:rw \
  -t \
  fr3nd/puppet \
  facter -p
```

## FAQ

### Do you need to run the container as privileged?

Yes. Otherwise there is no way to bind mount the root filesystem in read-write


### Does it work?

Yes... and no. I could not compile ruby fully statically, so if you run it in
a Debian based distro it will work. Otherwise, it will probably crash because
it can't found some linked libraries.
