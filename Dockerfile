# # # Build stage # # #

FROM jlesage/baseimage-gui:debian-9 as build

# Install build dependencies
# https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md#dependencies
# https://gist.github.com/itoonx/95aec9a3b4da01fd1fd724dffc056963
RUN apt-get -yq update && apt-get -yq install \
    git curl build-essential libtool autotools-dev autoconf pkg-config bsdmainutils openssl libssl-dev libboost-all-dev \
    libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler \
    libqrencode-dev libevent-dev libminiupnpc-dev libzmq3-dev

# Build & Install berkley db 4.8 from source
RUN mkdir -p /build/db4
WORKDIR /build
RUN curl -L 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz' -o db4.tar.gz && \
    tar -xzvf db4.tar.gz
WORKDIR /build/db-4.8.30.NC/build_unix
RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/build/db4
RUN make install

RUN git clone --depth=1 "https://github.com/bitcoin/bitcoin" "/build/bitcoin-git" && \
    mkdir -p /build/bitcoin && mkdir -p /build/libraries

# Build bitcoin from source
WORKDIR /build/bitcoin-git
RUN ./autogen.sh
RUN ./configure --with-zmq --with-qrencode LDFLAGS="-L/build/db4/lib/" CPPFLAGS="-I/build/db4/include/"
RUN make -s -j`nproc` ./src/qt/bitcoin-qt && \
    mv ./src/qt/bitcoin-qt /build/bitcoin-qt

# # # Final stage # # #

FROM jlesage/baseimage-gui:debian-9
ARG APP_ICON="https://bitcoin.org/img/icons/opengraph.png"
ENV APP_NAME="BitcoinCoreGUI"

RUN install_app_icon.sh "${APP_ICON}"

# Install dependencies
RUN apt-get -yq update && \
    apt-get -yq install libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 libqrencode-dev libevent-dev libminiupnpc-dev libzmq3-dev && \
    apt-get -yq autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /build/bitcoin-qt /usr/local/bin/bitcoin-qt
COPY --from=build /usr/lib/x86_64-linux-gnu/libboost* /usr/lib/x86_64-linux-gnu/

COPY startapp.sh /startapp.sh
VOLUME /config
