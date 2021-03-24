FROM alpine
EXPOSE 19132/udp

RUN apk update
RUN apk add freetype git nodejs=14.16.0-r0 npm=14.16.0-r0 wine gnutls ncurses-libs tzdata

WORKDIR /root
RUN mkdir /root/bdsx && \
    mkdir /root/bdsx/bedrock_server && \
    mkdir /root/bds && \
    ln -s /root/bds/server.properties /root/bdsx/bedrock_server/server.properties && \
    ln -s /root/bds/permissions.json /root/bdsx/bedrock_server/permissions.json && \
    ln -s /root/bds/whitelist.json /root/bdsx/bedrock_server/whitelist.json && \
    ln -sn /root/bds/scripts /root/bdsx && \
    ln -sn /root/bds/worlds /root/bdsx/bedrock_server && \
    ln -sn /root/bds/backups /root/bdsx/bedrock_server

WORKDIR /root/bdsx
RUN git init
RUN git config pull.ff only
RUN git remote add upstream https://github.com/karikera/bdsx.git

COPY ./index.ts /root/bdsx/index-new.ts
COPY ./bdsx-startup.sh /root/bdsx/bdsx-startup.sh
COPY ./entrypoint.sh /root/entrypoint.sh

RUN ls -R /root

ENTRYPOINT /root/entrypoint.sh
