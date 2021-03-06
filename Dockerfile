FROM lsiobase/alpine.python3:3.8

# Set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"
# Let it run for a minute before shutting down
ENV S6_KILL_GRACETIME=60000

# Add edge/testing repositories.
RUN printf "\
@edge http://nl.alpinelinux.org/alpine/edge/main\n\
@testing http://nl.alpinelinux.org/alpine/edge/testing\n\
@community http://nl.alpinelinux.org/alpine/edge/community\n\
" >> /etc/apk/repositories

# Copy local files.
COPY etc/ /etc
RUN chmod -v +x \
    /etc/cont-init.d/*  \
    /etc/services.d/*/run

RUN pip install -U pip setuptools>=36 urllib3[socks] subliminal flexget

# Ports and volumes.
EXPOSE 5050/tcp
VOLUME /config
WORKDIR /config
