This is a docker-based full toolkit for developing gameboy games.

![screeenshot](./screenshot.png)

All you need is docker, and it should run on any OS:

```sh
mkdir work
docker run --name='gb' --rm -it -p 8080:8080 -v "${PWD}/work:/home/gbdev" konsumer/gb
```

Then open http://localhost:8080

A bunch of tools are installed, with an X-windows server, that runs VNC. It's got fluxbox and some windows tools setup with wine.

I also included [gbtdg](https://github.com/chrisantonellis/gbtdg) which is great for making splash images, at http://localhost:8080/gbtdg/

`/home/gbdev` is meant to be your working directory, as you are logged in as `gbdev`. This helps with permissions on mac/linux, as it makes it all run as user-1. In the above `docker run` example, I am volume-mounting it to a dir `work/`, so I can compile stuff in that dir. You can mount it however you like, though.

Some useful things to do:

```sh
# run text-mode bash inside container
docker exec -it gb bash

## inside container

# run Gameboy Tile Designer
wine /opt/gbtd/GBTD.EXE

# run Gameboy Map Builder
wine /opt/gbmb/GBMB.EXE

# run BGB Gameboy Emulator
wine /opt/bgb/bgb.exe
```

There is also GBDK/RGBDS installed in `/opt`, so you can use those in your makefiles. I also added some of these tools to the fluxbox menu (right-click on desktop.)

If you want to try it out, put the `example/` dir in your work folder, and run this:

```sh
docker run --name='gb' -d --rm -p 8080:8080 -v "${PWD}/work:/home/gbdev" konsumer/gb
docker exec -it gb bash
cd example
make
wine /opt/bgb/bgb.exe demo.gb
docker kill gb
```

## local

If you want to load all the same stuff on a debian/ubuntu machine, locally (not in docker) it will run much faster, and be integrated better with your system. Have a look at the Dockerfile to see what steps that need to be completed. Basically, just run every line that starts with `RUN` and add all the env-vars to your `~/.bashrc`, like this:

```sh
export WINEPREFIX=$HOME/wine
export WINEARCH=win32
export WINEDEBUG=-all
export GBDK_DIR=/opt/gbdk
export RGBDS_DIR=/opt/rgbds
```


## TODO

* add BGB/no$gmb rgbds debug snippet to makefile
* make demo project
* make a tutorial with demo project