This is a docker-based full toolkit for developing gameboy games.

![screeenshot](./screenshot.png)

All you need is docker, and it should run on any OS:

```sh
mkdir work
docker run --name='gb' --rm -it -p 8080:8080 -v "${PWD}/work:/home/gbdev" konsumer/gb
```

Then open http://localhost:8080

A bunch of tools are installed, with an X-windows server, that runs VNC. It's got fluxbox and some windows tools setup with wine.

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

## TODO

* make desktop/menu files for everything
* make demo project
* make a tutorial with demo project