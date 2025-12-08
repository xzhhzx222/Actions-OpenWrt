#!/bin/sh

# Update openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION=SamWrt" >> /etc/openwrt_release

# System Settings
uci set system.@system[0].hostname='SamWrt'
uci commit system

# DDNS Settings
while uci -q get ddns.@service[-1] > /dev/null; do
  uci del ddns.@service[-1]
done
# root
uci set ddns.cf_root=service
uci set ddns.cf_root.enabled='0'
uci set ddns.cf_root.lookup_host='xzhhzx222.com'
uci set ddns.cf_root.use_ipv6='0'
uci set ddns.cf_root.service_name='cloudflare.com-v4'
uci set ddns.cf_root.domain='@xzhhzx222.com'
uci set ddns.cf_root.username='Bearer'
uci set ddns.cf_root.ip_source='interface'
uci set ddns.cf_root.ip_interface='pppoe-wan'
uci set ddns.cf_root.interface='wan'
uci set ddns.cf_root.use_syslog='2'
uci set ddns.cf_root.check_interval='5'
uci set ddns.cf_root.check_unit='minutes'
uci set ddns.cf_root.force_interval='24'
uci set ddns.cf_root.force_unit='hours'
# www
uci set ddns.cf_www=service
uci set ddns.cf_www.enabled='0'
uci set ddns.cf_www.lookup_host='www.xzhhzx222.com'
uci set ddns.cf_www.use_ipv6='0'
uci set ddns.cf_www.service_name='cloudflare.com-v4'
uci set ddns.cf_www.domain='www@xzhhzx222.com'
uci set ddns.cf_www.username='Bearer'
uci set ddns.cf_www.ip_source='interface'
uci set ddns.cf_www.ip_interface='pppoe-wan'
uci set ddns.cf_www.interface='wan'
uci set ddns.cf_www.use_syslog='2'
uci set ddns.cf_www.check_interval='5'
uci set ddns.cf_www.check_unit='minutes'
uci set ddns.cf_www.force_interval='24'
uci set ddns.cf_www.force_unit='hours'
uci commit ddns

# DHCP Settings
while uci -q get dhcp.@host[-1] > /dev/null; do
  uci del dhcp.@host[-1]
done
for i in $(seq 0 4); do
  uci add dhcp host
  uci set dhcp.@host[-1].ip='10.0.0.1'$i''
  uci set dhcp.@host[-1].leasetime='infinite'
done
uci set dhcp.@host[0].name='Sam-Desktop'
uci set dhcp.@host[0].mac='70:4D:7B:63:0A:37'
uci set dhcp.@host[1].name='Sam-Legion'
uci set dhcp.@host[1].mac='B0:3C:DC:8C:71:DE'
uci set dhcp.@host[2].name='Sophie-Xiaoxin'
uci set dhcp.@host[2].mac='08:5B:D6:B0:76:83'
uci set dhcp.@host[3].name='Mom-Xiaomi13'
uci set dhcp.@host[3].mac='EE:CC:DA:BF:0A:04'
uci set dhcp.@host[4].name='Dad-K40S'
uci set dhcp.@host[4].mac='BE:36:F0:5E:0F:67'
uci commit dhcp

# Firewall Settings
while uci -q get firewall.@zone[2] > /dev/null; do
  uci del firewall.@zone[2]
done
uci add firewall zone
uci set firewall.@zone[-1].name='iptv'
uci add_list firewall.@zone[-1].network='iptv'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'
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
    uci set firewall.@redirect[$i].dest_ip='10.0.0.1'
  elif [ $i -le 4 ]; then
    uci set firewall.@redirect[$i].dest_ip='10.0.0.2'
  else
    uci set firewall.@redirect[$i].dest_ip='10.0.0.3'
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
uci set network.lan.ipaddr='10.0.0.2'
while uci -q get network.@device[1] > /dev/null; do
  uci del network.@device[1]
done
uci del network.@device[-1].ports
uci add_list network.@device[-1].ports='eth0'
uci add_list network.@device[-1].ports='eth1'
uci add_list network.@device[-1].ports='eth2'
uci add_list network.@device[-1].ports='eth3'
uci add_list network.@device[-1].ports='eth4'
uci add_list network.@device[-1].ports='tap_vpn'
# wan
if uci -q get network.wan > /dev/null; then
  uci set network.wan.device='eth5'
fi
# iptv
if uci -q get network.iptv > /dev/null; then
  uci del network.iptv
fi
uci set network.iptv=interface
uci set network.iptv.proto='none'
uci set network.iptv.device='br-iptv'
uci add network device
uci set network.@device[-1].type='bridge'
uci set network.@device[-1].name='br-iptv'
uci add_list network.@device[-1].ports='eth4.85'
uci add_list network.@device[-1].ports='eth5.85'
uci commit network

# Wechatpush Settings
uci set wechatpush.config.device_name='SamWrt'
uci commit wechatpush

# Wolplus Settings
uci set wolplus.pc1=macclient
uci set wolplus.pc1.name='Sam-Desktop'
uci set wolplus.pc1.maceth='br-lan'
uci set wolplus.pc1.macaddr='70:4D:7B:63:0A:37'
uci commit wolplus

# cat >> /etc/dnsmasq.conf <<EOF
# dhcp-option-force=125,00:00:00:00:1a:02:06:48:47:57:2d:43:54:03:04:5a:58:48:4e:0a:02:20:00:0b:02:00:55:0d:02:00:2e
# dhcp-option=15
# dhcp-option=28
# dhcp-option=60,00:00:01:06:68:75:61:71:69:6E:02:0A:48:47:55:34:32:31:4E:20:76:33:03:0A:48:47:55:34:32:31:4E:20:76:33:04:10:32:30:30:2E:55:59:59:2E:30:2E:41:2E:30:2E:53:48:05:04:00:01:00:50
# EOF
cat >> /etc/dnsmasq.conf <<EOF
dhcp-option-force=vi-encap:0,2,"HGW-CT"
dhcp-option-force=lan,125,00:00:00:00:10:02:06:48:47:57:2d:43:54:0a:02:20:00:0b:02:00:55
dhcp-option=lan,60,00:00:01:00:02:03:43:50:45:03:0e:45:38:20:47:50:4f:4e:20:52:4f:55:54:45:52:04:03:31:2E:30
dhcp-option=lan,15
dhcp-option=lan,28
EOF

exit 0
