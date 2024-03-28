FROM ubuntu:18.04 as builder
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libc6-dev-i386 \
    libpng-dev \
    bison \
    flex \
    wget \
    xvfb \
    xorg-dev \
    libxxf86vm-dev \
    libx11-dev:i386 \
    libfreetype6-dev:i386 \
    libx11-dev \
    sed
#WORKDIR /home/container
RUN curl -sS -L https://github.com/wine-mirror/wine/archive/refs/tags/wine-8.12.tar.gz | tar zx -C /opt
RUN mkdir /opt/wine32-build /opt/wine64-build
RUN cd /opt/wine64-build && ../wine-wine-8.12/configure --without-freetype --enable-win64 && make -j4
#RUN cd /opt/wine32-build && ../wine-wine-8.12/configure --without-freetype && make -j4 && make install
RUN cd /opt/wine32-build && ../wine-wine-8.12/configure --without-freetype --with-wine64=../wine64-build && make -j4 && make install
# --without-x --without-freetype
RUN cd /opt/wine64-build && make install


FROM ubuntu:18.04
LABEL org.opencontainers.image.source https://github.com/Redforce04/MidnightGhostHuntServer
RUN dpkg --add-architecture i386
#RUN apt install -y xvfb wget
WORKDIR /home/container
RUN apt-get update
RUN apt-get install -y --install-recommends wine-stable
RUN apt-get update && apt-get install -y \
    wget \
    xvfb \
    libpng-dev \
    libc6:i386 \
    # libx11-dev \
    # libx11-dev:i386 \
    libwine \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local /usr/local
RUN mkdir -p /home/.wine
RUN export WINEPREFIX=/home/.wine
#ENV WINEPREFIX=/home/.wine
RUN export WINEPATH=/home/.wine
#ENV WINEPATH=/home/.wine
RUN wineboot --init
RUN winecfg
#RUN [ "sh", "-c", "Xvfb :0 -screen 0 320x240x8 &"]
RUN export DISPLAY=:0.0
#ARG DISPLAY=:0.0
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x winetricks
RUN cp winetricks /usr/local/bin
#RUN DISPLAY=:0.0 sh winetricks msxml4
#RUN wget https://aka.ms/vs/17/release/vc_redist.x64.exe
#RUN wine64 vc_redist.x64.exe /install /silent /norestart
RUN export WINEARCH=win64
RUN export WINEDEBUG="fixme-all"
RUN adduser -D -h /home/container container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
#RUN chmod 777 -R /home/.wine
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
