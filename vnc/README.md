# VNC Server for any cloud linux

## Setup

## Installing VNC server

```
apt install vnc4server
```

## Config files

1. xstartup

Create a file `~/.vnc/xstartup`

Inside that file, initialize your desktop session of choice.

For example,

```
mate-session &
```

Or

```
cinnamon-session &
```
