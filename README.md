This is a docker-based full toolkit for developing gameboy games.

All you need is docker, and it should run on any OS:

```sh
mkdir work
docker run --rm -it -p 8080:8080 -v "${PWD}/work:/root" konsumer/gb
```

Then open http://localhost:8080

A bunch of tools are installed, with an X-windows server, that runs VNC. It's got dwm and some windows tools setup with wine.

## TODO

* make desktop/menu files for everything
* make demo project
* make a tutorial with demo project