# ZoomPedalFunDocker
Dockerized b1xfour001.py from ZoomPedalFun to make easier deployment.


On your Linux system:
    allow any host to write to the X11 - this will change in future!
```
(as root) xhost +
```
Ensure your Zoom B1XFour/G1XFour/G3n/B3n/G5n is plugged in an visible
```
amidi -l
root@Ubuntu23:/home/shooking# amidi -l
Dir Device    Name
IO  hw:0,0    ES1371
IO  hw:1,0,0  ZOOM G Series MIDI 1
```
Install docker on Pi (see https://raspberrytips.com/docker-on-raspberry-pi/)
Pay attention to need to reboot after allowing normal users to run docker!

Build this docker file:
```
docker --debug build --tag python-zpf-pi4 .
```

Now run the docker - in this case the image was called python-zpf-pi4:latest

    It might require 3 runs
        - working on this (bug in the b1xfour/zoomzt2_shooking handshake)
```
docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY -h $HOSTNAME \
    -v $HOME/.Xauthority:/$HOME/.Xauthority \
    -it --rm --device /dev/snd python-zpf-pi4:latest
```

And a GUI should open -you can interact with your B1XFour, G1XFour, G5n, G3n, B3n
