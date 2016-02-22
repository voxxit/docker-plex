#!/bin/bash
set -x

if [ ! -d "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server" ]; then
  mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"
fi

if [ ! -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/Preferences.xml ]; then
  cp /Preferences.xml "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/Preferences.xml
fi

if [ -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/plexmediaserver.pid ]; then
  rm -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server"/plexmediaserver.pid
fi

chown -R plex:plex ${PLEX_MEDIA_SERVER_HOME} ${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}

ulimit -s ${PLEX_ULIMIT}

exec "${PLEX_MEDIA_SERVER_HOME}/Plex Media Server"

exec "$@"
