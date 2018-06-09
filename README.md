# docker-shogi-gui

## Build and Run

```sh
docker build -t shogi-gui .

# NOTE: Reference:
# Running GUI’s with Docker on Mac OS X
# https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

open -a Xquartz
# NOTE: "Allow connection from network clients" should be checked.

ip=$(ifconfig | grep -A10 en0 | grep 'inet ' | awk '{print $2}')
echo "$ip"
docker run -e DISPLAY=${ip}:0 --privileged -it shogi-gui /bin/bash

# in the container
LANG=ja_JP.UTF-8 mono /shogi/ShogiGUIv0.0.6.13/ShogiGUI.exe
```

## With apery

https://github.com/HiraokaTakuya/apery/releases

```sh
cd ~/shogi/engines
unzip apery_wcsc28.zip

docker run \
  -e DISPLAY=${ip}:0 \
  -v $HOME/shogi/engines:/shogi/engines \
  --privileged -it shogi-gui /bin/bash

# in the container
apt-get install g++ make
cd /shogi/engines/apery_wcsc28/src
make
mv apery ../bin

# Setup engine settings in ShogiGUI.
```
