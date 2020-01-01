#!/bin/bash
geometry="1280x960" # Screen resolution. Override if you want
vncserver -kill :1
vncserver -geometry $geometry
