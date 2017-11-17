## Jump into the Docker For Mac VM

I always have to google how can I jump into the VM running
Docker if I use the recommended **Docker For Mac** 

If you use docker-machine, you can `docker machine ssh`
But **Docker For Mac** doesn't runs sshd. So how can you
enter the vm?

## Usage

```
eval "$(docker run lalyos/nsenter)"
```

which is equivalent of:
```
docker run --pid=host --privileged -it --rm justincormack/nsenter1
```

But the only image you have to remember is **lalyos/nsenter**, if you run it
without any docker parameter, ut will print out the usage:

```
$ docker run lalyos/nsenter

# eval "$(docker run lalyos/nsenter)"
docker run --pid=host --privileged -it --rm justincormack/nsenter1
```

## tl;dr

There are several other ways, if you are interested, read on:

## nsenter

Docker uses linux namespaces for container isolation. In the standard Debian image
there is a cli tool **nsenter** which stands for "Namespace Enter". So you can ask
Docker itself to start a container, but instead of creating a new isolated nasespace(container)

, enter the Namespace of the process pid 1. Which is the equivalent of a regular  **telnet** or **ssh**

The full command to achive this:
```
docker run --pid=host --privileged -it --rm debian nsenter -t 1 -m -u -n -i sh
```

## nsenter - light

Unfortunately the debian image itself is **~100Mb**.

Credit goes to Justin Cormack for creating [justincormack/nsenter1](https://github.com/justincormack/nsenter1)
He just wrote the same functionality in 50 lines of c program. Which is put in a **scratch** image, weghting in at **~80kB** 

## Screen

**Docker For Mac** uses hyperkit (Level1 hypervisor) and exposes the VM-s terminal as a file. You can simple use **screen** tool to attach to the terminal of the VM.

```
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
```

screen has its all control escapes, the most importants are:
- detach: `Ctrl-a d`
- show help: `Ctrl-a ?`
