#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate


# 删除已存在的软件包
# rm -rf feeds/luci/applications/luci-app-openclash/
# rm -rf feeds/luci/applications/luci-app-passwall/
# rm -rf feeds/luci/applications/luci-app-rtp2httpd/
# rm -rf feeds/luci/applications/luci-app-wechatpush/
# rm -rf feeds/luci/themes/luci-theme-argon*/
# rm -rf feeds/packages/net/rtp2httpd/
# rm -rf package/feeds/luci/luci-app-openclash/
# rm -rf package/feeds/luci/luci-app-passwall/
# rm -rf package/feeds/luci/luci-app-rtp2httpd/
# rm -rf package/feeds/luci/luci-app-wechatpush/
# rm -rf package/feeds/luci/luci-theme-argon*/
# rm -rf package/feeds/packages/rtp2httpd/

PKG_DIR=package/xzhhzx222
echo "------------ Check Start ------------"
echo "PKG_DIR=$PKG_DIR"
echo "------------- Check End -------------"

# 修改stackia/rtp2httpd
mv -vf $PKG_DIR/rtp2httpd/Makefile.versioned $PKG_DIR/rtp2httpd/Makefile
mv -vf $PKG_DIR/luci-app-rtp2httpd/Makefile.versioned $PKG_DIR/luci-app-rtp2httpd/Makefile

CLASH_DIR=$PKG_DIR/luci-app-openclash/root/etc/openclash
echo "------------ Check Start ------------"
echo "CLASH_DIR=$CLASH_DIR"
echo "------------- Check End -------------"

# 修改vernesong/OpenClash
# rm -vf $CLASH_DIR/*.dat
curl -Ls -o $CLASH_DIR/GeoIP.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
curl -Ls -o $CLASH_DIR/GeoSite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
# rm -vf $CLASH_DIR/*.ipset
curl -Ls -o $CLASH_DIR/china_ip_route.ipset https://github.com/Hackl0us/GeoIP2-CN/raw/release/CN-ip-cidr.txt
curl -Ls -o $CLASH_DIR/china_ip6_route.ipset https://ispip.clang.cn/all_cn_ipv6.txt
# rm -vf $CLASH_DIR/*.mmdb
curl -Ls -o $CLASH_DIR/Country.mmdb https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
curl -Ls -o $CLASH_DIR/ASN.mmdb https://raw.githubusercontent.com/xishang0128/geoip/release/GeoLite2-ASN.mmdb
mkdir -p $CLASH_DIR/core
curl -Ls -o $CLASH_DIR/core/core.tar.gz https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64-v1.tar.gz
tar -zxf $CLASH_DIR/core/core.tar.gz -C $CLASH_DIR/core
mv -vf $CLASH_DIR/core/clash $CLASH_DIR/core/clash_meta
rm -vf $CLASH_DIR/core/core.tar.gz
# rm -f $CLASH_DIR/rule_provider/*

# 修改sundaqiang/openwrt-packages
sed -i 's/Wake on LAN/Wake on LAN +/g' $PKG_DIR/luci-app-wolplus/luasrc/controller/wolplus.lua
sed -i 's/wolplus/Wake on LAN +/g' $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/macclient/Host Clients/g' $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/name/Name/g' $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/macaddr/MAC Address/g' $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/maceth/Network Interface/g' $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/awake/Awake/g' $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
echo >> $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgid \"Wake on LAN is a mechanism to remotely boot computers in the local network.\"" >> $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgstr \"网络唤醒++是一个远程唤醒本地计算机的工具\"" >> $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
echo >> $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgid \"Wake Up Host\"" >> $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgstr \"唤醒设备\"" >> $PKG_DIR/luci-app-wolplus/po/zh_Hans/wolplus.po

# 修改luci-app-wechatpush
LOGO_FILE=$PKG_DIR/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
# sed -i 's/\${str_linefeed}/\\\\n/g' $PKG_DIR/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
sed -i 's/\${1} ${nowtime}/${nowtime}\\\\n${1}/g' $PKG_DIR/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json

# 修改luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile

# 修改default-settings
SET_FILE=package/emortal/default-settings/files/99-default-settings
sed -i '/define Package\/default-settings-chn/,/endef/d' package/emortal/default-settings/Makefile
sed -i '/default-settings-chn/d' package/emortal/default-settings/Makefile
sed -i 's/+luci/& +@LUCI_LANG_zh_Hans +luci-i18n-base-zh-cn/g' package/emortal/default-settings/Makefile

DIY_LOGO=$GITHUB_WORKSPACE/diy/openwrt.jpg
DIY_SET=$GITHUB_WORKSPACE/diy/default.settings
DIY_SH=$GITHUB_WORKSPACE/diy/jimmywrt.sh
echo "------------ Check Start ------------"
echo "LOGO_FILE=$LOGO_FILE"
echo "SET_FILE=$SET_FILE"
echo "DIY_LOGO=$DIY_LOGO"
echo "DIY_SET=$DIY_SET"
echo "DIY_SH=$DIY_SH"
echo "------------- Check End -------------"

[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE
[ -e $DIY_SH ] && mkdir -p files/etc && mv -vf $DIY_SH files/etc/
