FROM debian:latest

# these are to stop debian in docker from complaining
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV SDCCDIR=/usr

RUN dpkg --add-architecture i386 && \
  apt-get update && apt-get -y install gnupg2 wget && \
  wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
  echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' |tee /etc/apt/sources.list.d/winehq.list && \
  apt-get update && apt-get -y install sdcc winehq-stable zenity libncurses5 unzip git build-essential byacc bison \
    flex pkg-config gawk libpng-dev xvfb x11vnc xdotool tar supervisor net-tools fluxbox && \
  mkdir /opt/wine-stable/share/wine/mono && wget -O - https://dl.winehq.org/wine/wine-mono/4.9.4/wine-mono-bin-4.9.4.tar.gz |tar -xzv -C /opt/wine-stable/share/wine/mono && \
  mkdir /opt/wine-stable/share/wine/gecko && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi && \
  wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi && \
  apt-get -y full-upgrade && apt-get clean && \
  useradd -ms /bin/bash gbdev && \
  wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /opt/ && mv /opt/noVNC-1.1.0 /opt/novnc && \
  wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /opt/ && mv /opt/websockify-0.9.0 /opt/novnc/utils/websockify && \
  git clone https://github.com/rednex/rgbds.git /opt/rgbds && cd /opt/rgbds && make && make install && \
  mkdir /opt/gbtd /opt/gbmb /opt/bgb && \
  cd /opt/gbtd && wget http://www.devrs.com/gb/hmgd/gbtd22.zip && unzip gbtd22.zip && rm gbtd22.zip && \
  cd /opt/gbmb && wget http://www.devrs.com/gb/hmgd/gbmb18.zip && unzip gbmb18.zip && rm gbmb18.zip && \
  cd /opt/bgb && wget http://bgb.bircd.org/bgb.zip && unzip bgb.zip && rm bgb.zip && \
  cd  && git clone https://github.com/chrisantonellis/gbtdg.git /opt/novnc/gbtdg

# this currently copies all of /usr/bin, ala https://github.com/Zal0/gbdk-2020/issues/10
# git clone https://github.com/Zal0/gbdk-2020.git /opt/gbdk && cd /opt/gbdk && make && make install

# TODO install js/wasm-based tools?

ADD novnc.html /opt/novnc/index.html
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD help.html /opt/help.html
ADD menu /etc/X11/fluxbox/fluxbox-menu

# set these in your .bashrc on a local install
ENV WINEPREFIX /home/gbdev/wine
ENV WINEARCH win32
ENV WINEDEBUG -all
ENV GBDK_DIR /opt/gbdk
ENV RGBDS_DIR /opt/rgbds

# Docker-stuff to make everything run correctly as gbdev user through VNC
ENV DISPLAY :0
EXPOSE 8080
ENV HOME /home/gbdev
WORKDIR /home/gbdev
VOLUME /home/gbdev

CMD ["/usr/bin/supervisord"]