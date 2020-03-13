FROM jgoerzen/debian-base-minimal

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install zenity libncurses5 unzip git build-essential byacc bison flex pkg-config libpng-dev xvfb x11vnc xdotool wget tar supervisor net-tools fluxbox gnupg2
RUN wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' |tee /etc/apt/sources.list.d/winehq.list
RUN apt-get update && apt-get -y install winehq-stable
RUN mkdir /opt/wine-stable/share/wine/mono && wget -O - https://dl.winehq.org/wine/wine-mono/4.9.4/wine-mono-bin-4.9.4.tar.gz |tar -xzv -C /opt/wine-stable/share/wine/mono 
RUN mkdir /opt/wine-stable/share/wine/gecko && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi 
RUN apt-get -y full-upgrade && apt-get clean

RUN useradd -ms /bin/bash gbdev
RUN chown -R gbdev /var/log/supervisor

RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /opt/ && mv /opt/noVNC-1.1.0 /opt/novnc
RUN wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /opt/ && mv /opt/websockify-0.9.0 /opt/novnc/utils/websockify

RUN git clone https://github.com/rednex/rgbds.git /opt/rgbds && cd /opt/rgbds && make && make install

RUN mkdir /opt/gbdk /opt/gbtd /opt/gbmb /opt/bgb && \
  cd /opt/gbdk && wget https://github.com/andreasjhkarlsson/gbdk-n/files/1677076/gbdevelopmentkit.zip && unzip gbdevelopmentkit.zip && rm gbdevelopmentkit.zip && \
  cd /opt/gbtd && wget http://www.devrs.com/gb/hmgd/gbtd22.zip && unzip gbtd22.zip && rm gbtd22.zip && \
  cd /opt/gbmb && wget http://www.devrs.com/gb/hmgd/gbmb18.zip && unzip gbmb18.zip && rm gbmb18.zip && \
  cd /opt/bgb && wget http://bgb.bircd.org/bgb.zip && unzip bgb.zip && rm bgb.zip && \
  cd /opt && wget "https://openmpt.org/download_file.php?file=OpenMPT-1.28.09.00.zip" -O OpenMPT-1.28.09.00.zip && unzip OpenMPT-1.28.09.00.zip && rm OpenMPT-1.28.09.00.zip && mv OpenMPT-1.28.09.00 openmpt

# TODO install js/wasm-based tools?

ADD novnc.html /opt/novnc/index.html
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD help.html /opt/help.html
ADD menu /etc/X11/fluxbox/fluxbox-menu

EXPOSE 8080

ENV HOME /home/gbdev
ENV WINEPREFIX /home/gbdev/wine
ENV WINEARCH win32
ENV DISPLAY :0
ENV WINEDEBUG=-all
ENV GBDK=/opt/gbdk
ENV RGBDS=/opt/rgbds

# USER gbdev
WORKDIR /home/gbdev
VOLUME /home/gbdev

CMD ["/usr/bin/supervisord"]