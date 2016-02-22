FROM debian:latest

MAINTAINER Joshua Delsman <j@srv.im>

ENV VERSION 0.9.15.5.1712-ba5070a

RUN  useradd --system --uid 1000 -M --shell /usr/sbin/nologin plex \
  && apt-get update \
  && apt-get -y install wget \
  && wget https://downloads.plex.tv/plex-media-server/${VERSION}/plexmediaserver_${VERSION}_amd64.deb \
  && dpkg -i plexmediaserver_${VERSION}_amd64.deb \
  && apt-get -y remove --purge wget \
  && apt-get -y autoremove --purge \
  && rm -rf /var/lib/apt/lists/* plexmediaserver_${VERSION}_amd64.deb

ENV PLEX_USER plex
ENV PLEX_MEDIA_SERVER_MAX_STACK_SIZE 10000
ENV PLEX_MEDIA_SERVER_MAX_LOCK_MEM 3000
ENV PLEX_MEDIA_SERVER_MAX_OPEN_FILES 4096
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /etc/plexmediaserver
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV LD_LIBRARY_PATH ${PLEX_MEDIA_SERVER_HOME}

COPY start.sh /start.sh
COPY Preferences.xml /Preferences.xml

EXPOSE 32400/tcp

WORKDIR ${PLEX_MEDIA_SERVER_HOME}

ENTRYPOINT [ "/start.sh" ]
CMD [ "./Plex Media Server" ]
