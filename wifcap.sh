# wifcap - WIFI capture helper
# 2012, 2013, Laurent Ghigonis <laurent@gouloum.fr>

script=`basename $0`
if [ $# -lt 3 -o $# -gt 4 ]; then
  echo "usage: $script output-prefix iface channel [libpcap_filter]"
  echo -e "\t\tchannel=x: activate hopping by running airodump-ng w/o channel"
  echo "example: sudo $script wlan0 nadege-flat x"
  exit 1
fi
if [ `id -u` -ne 0 ]; then
  echo "must be root"
  exit 1
fi
iface=$1
prefix=$2
channel=$3
if [ $# -eq 4 ]; then
  filter=$4
else
  filter=""
fi
iface_mon=mon0
date=$(date +%Y%m%d-%H%M%S)
output="${date}_${prefix}"

ifconfig $iface_mon >/dev/null 2>&1
if [ $? -ne 0 ]; then
  airmon-ng start $iface
fi

if [ $channel != "x" ]; then
  channel_cmd="--chan $channel"
  output="$output-ch$channel"
else
  channel_cmd=""
fi
output="$output.pcap"
tmux new-session -d -s wifcap "set -x; cd /tmp; tcpdump -Z nobody -s0 -w \"$output\" -ni $iface_mon $filter ||echo \"tcpdump failed !\"; read a"
tmux new-window -t wifcap "airodump-ng -i $iface_mon $channel_cmd"
tmux attach-session -t wifcap

