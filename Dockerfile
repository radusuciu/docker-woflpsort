FROM i386/ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    git \
    locales
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales


RUN adduser --disabled-password --gecos '' wolf
COPY run.sh /home/wolf/run.sh
RUN chmod 755  /home/wolf/run.sh
RUN chown -R wolf:wolf /home/wolf

USER wolf
WORKDIR /home/wolf

RUN git clone https://github.com/fmaguire/WoLFPSort.git wolfpsort
RUN cp wolfpsort/bin/binByPlatform/binary-i386/* wolfpsort/bin/

ENTRYPOINT ["/home/wolf/run.sh"]
