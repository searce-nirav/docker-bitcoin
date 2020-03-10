# Docker-BitcoinCoreGUI

Run the Bitcoin Core GUI wallet on a Docker container, accesible via web browser and VNC.
Built over the [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) image (debian-9 version).

## Volume (persistence)

The Bitcoin Core data directory is set to `/config/bitcoin`. By default a volume is created for `/config`,
but you might want to mount the `/config/bitcoin` directory on other volume or a bind mount.
You can even mount sub-directories of the Bitcoin data directory, such as:
- `/config/bitcoin/blocks` for the blockchain
- `/config/bitcoin/wallet.dat` for your wallet
- `/config/bitcoin/bitcoin.conf` for the client configuration

## Other settings

Please refer to the [documentation of the base image](https://github.com/jlesage/docker-baseimage-gui) for
VNC/webui related settings, such as securing the connection and so on.

## TODO

- Automate getting the latest Bitcoin Core version
- Multi-arch support
- Download Bitcoin Core from torrent (using aria2) for faster download speed
