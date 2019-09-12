
Use it like this:

```
docker run --rm -it --name img \
    --volume $(pwd):/home/user/src:ro \ # for the build context and dockerfile, can be read-only since we won't modify it
    --volume "${HOME}/.docker:/root/.docker:ro" \ # for credentials to push to docker hub or a registry.
    --volume $(pwd)/.state:/home/user/state:rw \ # If you want to keep between docker run.
    --privileged \ # Mandatory for now. see : [source](https://github.com/genuinetools/img#goals)
    gitlab.kariba.fr:4567/docker/img-bash:latest build -t test -s /home/user/state
```
