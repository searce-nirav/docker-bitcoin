# Docker - Bitcoin Core GUI client

Run the Bitcoin Core GUI wallet on a Docker container, accesible via web browser and VNC.
Built over the [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) image (debian-9 version).

**This image is experimental and might have undesirable effects. Use it under your responsability**

## Getting started

```bash
docker volume create --name=bitcoin-data
docker run -d --name=bitcoin-core-gui -p 5800:5800 -p 5900:5900 -v bitcoin-data:/config davidlor/bitcoin-core-gui
```

**On the first run the Welcome window opens, where you will be prompted for the data location.
You should set it to somewhere inside `/config`** (by default, is set to `/config/.bitcoin`)

## Volume (persistence)

The Bitcoin Core data directory is set to `/config/.bitcoin` by default. A volume is created for `/config`,
but you might want to mount the `/config/.bitcoin` directory on other volume or a bind mount.

You can even mount sub-directories of the Bitcoin data directory, such as:
- `/config/.bitcoin/blocks` for the blockchain
- `/config/.bitcoin/wallet.dat` for your wallet
- `/config/.bitcoin/bitcoin.conf` for the client configuration
- `/config/xdg/config/Bitcoin/Bitcoin-Qt.conf` for the frontend (bitcoin-qt) configuration

## Other settings

Please refer to the [documentation of the base image](https://github.com/jlesage/docker-baseimage-gui) for
VNC/webui related settings, such as securing the connection and so on.

## Changelog

- 0.2.1 - Compile Bitcoin Core QT on Dockerfile, adding support for ZeroMQ. Add volume in Dockerfile.
- 0.1.1 - Add Bitcoin logo as container favicon
- 0.0.1 - Initial release

## TODO

- ~~Automate getting the latest Bitcoin Core version~~,
  ~~Download Bitcoin Core from torrent (using aria2) for faster download speed~~ : (0.2.1) Now we build from source
  (official Github repository) so the latest version is always used.
- ~~Do not ask for data location on first client start~~ : now we set the HOME directory to /config, so the default
  data dir is `/config/.bitcoin`. Is better to keep the Welcome window for the first time the container + volume start.
- SquashFS + OverlayFS support for blockchain compression
- Multi-arch support
