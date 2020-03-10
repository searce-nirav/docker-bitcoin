# # # Stage 1 # # #
# Download bitcoin-core

FROM debian:9 as download
ARG DOWNLOAD_URL="https://bitcoin.org/bin/bitcoin-core-0.19.1/bitcoin-0.19.1-x86_64-linux-gnu.tar.gz"

RUN apt-get -yq update && apt-get -yq install curl

RUN curl "${DOWNLOAD_URL}" --output "bitcoin-core.tar.gz"
RUN tar -xzf "bitcoin-core.tar.gz"

# # # Stage 2 # # #
# Setup the final image

FROM jlesage/baseimage-gui:debian-9
ENV APP_NAME="BitcoinCoreGUI"

COPY --from=download /bitcoin-*/bin /bitcoin-core
COPY startapp.sh /startapp.sh

RUN chmod +x /bitcoin-core/*
