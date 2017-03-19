FROM alpine:latest
#
# Need rdiff-backup for core functionality, ssh to connect to other stuff
# and busybox to allow the ssh environment config script to work.
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --update \
      	busybox \
        ca-certificates \
        tzdata \
        python \
        py-pip \
        shadow@testing \
    && pip install --upgrade pip \
    && pip install gmvault \
    && rm -rf /var/cache/apk/* \
    && addgroup gmvault \
    && adduser -D -G gmvault -g "GMvault Backup" gmvault
#
#
LABEL org.freenas.interactive="true" \
      org.freenas.version="0.0.2" \
      org.freenas.upgradeable="true" \
      org.freenas.expose-ports-at-host="false" \
      org.freenas.autostart="false" \
      org.freenas.volumes="[ { \"name\": \"/data\", \"type\": \"host\", \"descr\": \"Data volume\" } ]"
#
COPY gmvault_all_in_dir.sh /usr/local/bin/
COPY gmvault_auth.sh /usr/local/bin/
COPY gmvault_one_account.sh /usr/local/bin/
COPY VERSION .
COPY README.md .
#
# We run as user rdiff
USER gmvault
#
# Pair of volumes to use for config and stored data
VOLUME ["/data"]
#
#
# Run the gmvault scaffold
ENTRYPOINT ["/usr/local/bin/gmvault_all_in_dir.sh"]
