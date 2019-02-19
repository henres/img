FROM  r.j3ss.co/img as img

FROM alpine:3.8 AS base

RUN apk add --no-cache git bash

COPY --from=img /usr/bin/img /usr/bin/img
COPY --from=img /usr/bin/runc /usr/bin/runc
COPY --from=img /usr/bin/newuidmap /usr/bin/newuidmap
COPY --from=img /usr/bin/newgidmap /usr/bin/newgidmap

RUN chmod u+s /usr/bin/newuidmap /usr/bin/newgidmap \
    && adduser --disabled-password -u 1000 user \
    && mkdir -p /run/user/1000 \
    && chown -R user /run/user/1000 /home/user \
    && echo user:100000:65536 | tee /etc/subuid | tee /etc/subgid

RUN passwd -l root

FROM base AS release
USER user
ENV USER user
ENV HOME /home/user
ENV XDG_RUNTIME_DIR=/run/user/1000
WORKDIR /home/user/src
ENTRYPOINT [ "/bin/bash" ]
