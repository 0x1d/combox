FROM debian:11

COPY ctl.sh bin
RUN bash /bin/ctl.sh install