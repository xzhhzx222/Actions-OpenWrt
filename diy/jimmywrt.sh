#!/bin/sh

# Update openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='JimmyWrt'" >> /etc/openwrt_release

# System Settings
uci set system.@system[0].hostname='JimmyWrt'
uci commit system

# DDNS Settings
# jm
uci set ddns.cf_root.lookup_host='jm.xzhhzx222.com'
uci set ddns.cf_root.domain='jm@xzhhzx222.com'
# jimmy
uci set ddns.cf_www.lookup_host='jimmy.xzhhzx222.com'
uci set ddns.cf_www.domain='jimmy@xzhhzx222.com'
uci commit ddns

# DHCP Settings
while uci -q get dhcp.@host[-1] > /dev/null; do
  uci del dhcp.@host[-1]
done
for i in $(seq 0 4); do
  uci add dhcp host
  uci set dhcp.@host[$i].ip='192.168.0.1'$i''
  uci set dhcp.@host[$i].leasetime='infinite'
  if [ $i -gt 0 ]; then
    uci set dhcp.@host[$i].name='Lobby-PC'$i''
  fi
done
uci set dhcp.@host[0].name='Jimmy-Server'
uci set dhcp.@host[0].mac='E0:94:67:4A:1A:69'
uci set dhcp.@host[1].mac='A8:A1:59:20:60:D5'
uci set dhcp.@host[2].mac='A8:A1:59:20:60:A1'
uci set dhcp.@host[3].mac='A8:A1:59:20:60:D7'
uci set dhcp.@host[4].mac='A8:A1:59:20:60:9F'
uci commit dhcp

# Firewall Settings
uci del firewall.@zone[2]
for i in $(seq 0 8); do
  if [ $i -le 1 ]; then
    uci set firewall.@redirect[$i].dest_ip='192.168.0.1'
  elif [ $i -le 4 ]; then
    uci set firewall.@redirect[$i].dest_ip='192.168.0.2'
  else
    uci set firewall.@redirect[$i].dest_ip='192.168.0.3'
  fi
done
uci commit firewall

# Network Settings
# lan
uci set network.lan.ipaddr='192.168.0.2'
while uci -q get network.@device[1] > /dev/null; do
  uci del network.@device[1]
done
uci del network.@device[-1].ports
uci add_list network.@device[-1].ports='eth0'
uci add_list network.@device[-1].ports='eth1'
uci add_list network.@device[-1].ports='eth2'
uci add_list network.@device[-1].ports='eth4'
uci add_list network.@device[-1].ports='eth5'
uci add_list network.@device[-1].ports='tap_vpn'
# wan
uci set network.wan.device='eth3'
# iptv
uci del network.iptv
uci commit network

# Timewol Settings
while uci -q get timewol.@macclient[-1] > /dev/null; do
  uci del timewol.@macclient[-1]
done
for i in $(seq 0 3); do
  uci add timewol macclient
  uci set timewol.@macclient[$i].maceth='br-lan'
  uci set timewol.@macclient[$i].minute='30'
  uci set timewol.@macclient[$i].hour='11'
done
uci set timewol.@macclient[0].macaddr='A8:A1:59:20:60:D5'
uci set timewol.@macclient[1].macaddr='A8:A1:59:20:60:A1'
uci set timewol.@macclient[2].macaddr='A8:A1:59:20:60:D7'
uci set timewol.@macclient[3].macaddr='A8:A1:59:20:60:9F'
uci set timewol.@basic[0].enable='1'
uci commit timewol

# Wechatpush Settings
uci set wechatpush.config.device_name='JimmyWrt'
uci commit wechatpush

# Wolplus Settings
while uci -q get wolplus.@macclient[-1] > /dev/null; do
  uci del wolplus.@macclient[-1]
done
for i in $(seq 1 4); do
  uci set wolplus.pc$i=macclient
  uci set wolplus.pc$i.name='Lobby-PC'$i''
  uci set wolplus.pc$i.maceth='br-lan'
done
uci set wolplus.pc1.macaddr='A8:A1:59:20:60:D5'
uci set wolplus.pc2.macaddr='A8:A1:59:20:60:A1'
uci set wolplus.pc3.macaddr='A8:A1:59:20:60:D7'
uci set wolplus.pc4.macaddr='A8:A1:59:20:60:9F'
uci commit wolplus

sed -i "/dhcp-option/d" "/etc/dnsmasq.conf"

exit 0
