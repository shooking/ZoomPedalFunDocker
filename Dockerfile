# Dockerize ZoomPedalFun's b1xfour001.py
#
# On your Linux system, allow any host to write to the X11 - this will change in future!
#
# (as root) xhost +
#
# Ensure your Zoom B1XFour/G1XFour/G3n/B3n/G5n is plugged in an visible
# amidi -l
# root@Ubuntu23:/home/shooking# amidi -l
#Dir Device    Name
#IO  hw:0,0    ES1371
#IO  hw:1,0,0  ZOOM G Series MIDI 1
#
#
# Build this docker file:
#
# sudo docker --debug build --tag python-zpf .
#
# Now run the docker - in this case the image was called python-zpf:latest
# It might require 3 runs - working on this (bug in the b1xfour/zoomzt2_shooking handshake)
#
# sudo docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -h $HOSTNAME -v $HOME/.Xauthority:/home/lyonn/.Xauthority -it --rm --device /dev/snd python-zpf1:latest
#

# Let's try 3.8
FROM python:3.8-slim-buster
WORKDIR /
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -y install git-all \
    && git clone https://github.com/shooking/ZoomPedalFun.git \
    && apt-get -y install g++ \
    && apt-get -y install jackd1 \
    && apt-get -y install jackd2 \
    && apt-get -y install libjack-dev \
    && apt-get -y install libasound2-dev \
    && apt-get -y install alsa-tools \
    && apt-get -y install alsa-utils \
    && apt-get -y install python3-tk  \
    && apt-get -y install python3-pil.imagetk \
    && cd /ZoomPedalFun/python \
    && pip3 install -r requirements.txt

CMD cd /ZoomPedalFun/python &&  python3 b1xfour001.py

