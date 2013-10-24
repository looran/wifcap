wifcap - WIFI capture helper
2012, 2013, Laurent Ghigonis <laurent@gouloum.fr>

Quickly create PCAPs from a Wifi interface, with optional channel hopping.
Creates a tmux session for background execution.


Example usage
=============

Capture on all channels:
$ sudo wifcap wlan0 nadege-flat x

Capture on channel 2:
$ sudo wifcap wlan0 nadege-flat 2


Installation
============

sudo make install
