#!/bin/sh

# Update openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION=JimmyWrt" >> /etc/openwrt_release

# System Settings
uci set system.@system[0].hostname='JimmyWrt'
uci commit system

# DDNS Settings
while uci -q get ddns.@service[-1] > /dev/null; do
  uci del ddns.@service[-1]
done
# jm
uci set ddns.cf_jm=service
uci set ddns.cf_jm.enabled='0'
uci set ddns.cf_jm.lookup_host='jm.xzhhzx222.com'
uci set ddns.cf_jm.use_ipv6='0'
uci set ddns.cf_jm.service_name='cloudflare.com-v4'
uci set ddns.cf_jm.domain='jm@xzhhzx222.com'
uci set ddns.cf_jm.username='Bearer'
uci set ddns.cf_jm.ip_source='interface'
uci set ddns.cf_jm.ip_interface='pppoe-wan'
uci set ddns.cf_jm.interface='wan'
uci set ddns.cf_jm.use_syslog='2'
uci set ddns.cf_jm.check_interval='5'
uci set ddns.cf_jm.check_unit='minutes'
uci set ddns.cf_jm.force_interval='24'
uci set ddns.cf_jm.force_unit='hours'
# jimmy
uci set ddns.cf_jimmy=service
uci set ddns.cf_jimmy.enabled='0'
uci set ddns.cf_jimmy.lookup_host='jimmy.xzhhzx222.com'
uci set ddns.cf_jimmy.use_ipv6='0'
uci set ddns.cf_jimmy.service_name='cloudflare.com-v4'
uci set ddns.cf_jimmy.domain='jimmy@xzhhzx222.com'
uci set ddns.cf_jimmy.username='Bearer'
uci set ddns.cf_jimmy.ip_source='interface'
uci set ddns.cf_jimmy.ip_interface='pppoe-wan'
uci set ddns.cf_jimmy.interface='wan'
uci set ddns.cf_jimmy.use_syslog='2'
uci set ddns.cf_jimmy.check_interval='5'
uci set ddns.cf_jimmy.check_unit='minutes'
uci set ddns.cf_jimmy.force_interval='24'
uci set ddns.cf_jimmy.force_unit='hours'
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
while uci -q get firewall.@redirect[-1] > /dev/null; do
  uci del firewall.@redirect[-1]
done
for i in $(seq 0 8); do
  uci add firewall redirect
  uci set firewall.@redirect[-1].target='DNAT'
  uci set firewall.@redirect[-1].family='ipv4'
  uci add_list firewall.@redirect[-1].proto='tcp'
  uci set firewall.@redirect[-1].src='wan'
  uci set firewall.@redirect[-1].dest='lan'
done
for i in $(seq 0 8); do
  if [ $i -le 1 ]; then
    uci set firewall.@redirect[$i].dest_ip='192.168.0.1'
  elif [ $i -le 4 ]; then
    uci set firewall.@redirect[$i].dest_ip='192.168.0.2'
  else
    uci set firewall.@redirect[$i].dest_ip='192.168.0.3'
  fi
done
for i in $(seq 0 3); do
  uci set firewall.@redirect[$i].enabled='0'
done
uci set firewall.@redirect[0].name='Pve WebUI'
uci set firewall.@redirect[0].src_dport='28006'
uci set firewall.@redirect[0].dest_port='8006'
uci set firewall.@redirect[1].name='Pve SSH'
uci set firewall.@redirect[1].src_dport='28022'
uci set firewall.@redirect[1].dest_port='22'
uci set firewall.@redirect[2].name='OpenWrt SSH'
uci set firewall.@redirect[2].src_dport='27022'
uci set firewall.@redirect[2].dest_port='22'
uci set firewall.@redirect[3].name='OpenWrt WebUI'
uci set firewall.@redirect[3].src_dport='27081'
uci set firewall.@redirect[3].dest_port='80'
uci set firewall.@redirect[4].name='OpenWrt Socks'
uci set firewall.@redirect[4].src_dport='27893'
uci set firewall.@redirect[4].dest_port='7893'
uci set firewall.@redirect[5].name='Nas Qb'
uci set firewall.@redirect[5].proto='tcp udp'
uci set firewall.@redirect[5].src_dport='16888'
uci set firewall.@redirect[5].dest_port='16888'
uci set firewall.@redirect[6].name='Nas SSH'
uci set firewall.@redirect[6].src_dport='27023'
uci set firewall.@redirect[6].dest_port='22'
uci set firewall.@redirect[7].name='Nas Http'
uci set firewall.@redirect[7].src_dport='27080'
uci set firewall.@redirect[7].dest_port='27080'
uci set firewall.@redirect[8].name='Nas Https'
uci set firewall.@redirect[8].src_dport='27443'
uci set firewall.@redirect[8].dest_port='27443'
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
uci add_list network.@device[-1].ports='eth5'
uci add_list network.@device[-1].ports='eth4'
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

exit 0
