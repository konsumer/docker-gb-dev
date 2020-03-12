FROM jgoerzen/debian-base-minimal

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install unzip git build-essential byacc bison flex pkg-config libpng-dev xvfb x11vnc xdotool wget tar supervisor net-tools dwm gnupg2
RUN wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' |tee /etc/apt/sources.list.d/winehq.list
RUN apt-get update && apt-get -y install winehq-stable
RUN mkdir /opt/wine-stable/share/wine/mono && wget -O - https://dl.winehq.org/wine/wine-mono/4.9.4/wine-mono-bin-4.9.4.tar.gz |tar -xzv -C /opt/wine-stable/share/wine/mono 
RUN mkdir /opt/wine-stable/share/wine/gecko && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi 
RUN apt-get -y full-upgrade && apt-get clean
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV WINEPREFIX /root/wine
ENV WINEARCH win32
ENV DISPLAY :0
ENV WINEDEBUG=-all

WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /opt/ && mv /opt/noVNC-1.1.0 /opt/novnc
RUN wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /opt/ && mv /opt/websockify-0.9.0 /opt/novnc/utils/websockify

RUN echo "xterm*background: black\nxterm*foreground: lightgray" > /root/.Xresources

ADD novnc.html /opt/novnc/index.html

RUN git clone https://github.com/rednex/rgbds.git /opt/rgbds && cd /opt/rgbds && make && make install

RUN mkdir /opt/gbdk /opt/gbtd /opt/gbmb /opt/bgb && \
  cd /opt/gbdk && wget https://github.com/andreasjhkarlsson/gbdk-n/files/1677076/gbdevelopmentkit.zip && gbdevelopmentkit.zip && rm gbdevelopmentkit.zip \
  cd /opt/gbtd && wget http://www.devrs.com/gb/hmgd/gbtd22.zip && unzip gbtd22.zip && rm gbtd22.zip \
  cd /opt/gbmb && wget http://www.devrs.com/gb/hmgd/gbmb18.zip && unzip gbmb18.zip && rm gbmb18.zip \
  cd /opt/bgb && wget http://bgb.bircd.org/bgb.zip && unzip bgb.zip && rm bgb.zip

# TODO install js/wasm-based tools?

EXPOSE 8080
VOLUME /root/

CMD ["/usr/bin/supervisord"]