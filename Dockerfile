FROM alpine:3.6
CMD ["echo", "-e", "# eval \"$(docker run lalyos/nsenter)\"\n# screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty\n# docker run --pid=host --privileged -it --rm debian nsenter -t 1 -m -u -n -i sh\n# Read more: https://github.com/lalyos/docker-nsenter\ndocker run --pid=host --privileged -it --rm justincormack/nsenter1"]

