# Puppet agent docker image

Docker image to run puppet agent and act over the parent host instead of the
container

Run it like:

```
docker run --privileged -v /:/mnt/root:rw -i -t --rm fr3nd/puppet puppet agent -t --noop
```
