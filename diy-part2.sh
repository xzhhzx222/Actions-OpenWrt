#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate


# 删除已存在的软件包
rm -vrf package/feeds/luci/luci-app-openclash
rm -vrf package/feeds/luci/luci-app-passwall
rm -vrf package/feeds/luci/luci-app-serverchan
rm -vrf package/feeds/luci/luci-app-vssr
rm -vrf package/feeds/luci/luci-app-wechatpush
rm -vrf package/feeds/luci/luci-theme-argon*

# 添加sirpdboy/luci-app-advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/xzhhzx222/luci-app-advanced

# 添加Lienol/openwrt-package
git clone https://github.com/Lienol/openwrt-package.git package/xzhhzx222/openwrt-package
mv -vf package/xzhhzx222/openwrt-package/luci-app-control-timewol package/xzhhzx222/luci-app-control-timewol
mv -vf package/xzhhzx222/openwrt-package/luci-app-control-weburl package/xzhhzx222/luci-app-control-weburl
mv -vf package/xzhhzx222/openwrt-package/luci-app-timecontrol package/xzhhzx222/luci-app-timecontrol
rm -vrf package/xzhhzx222/openwrt-package

# 添加vernesong/OpenClash
CLASH_DIR=package/xzhhzx222/OpenClash/luci-app-openclash/root/etc/openclash

echo "------------ Check Start ------------"
echo "CLASH_DIR=$CLASH_DIR"
echo "------------- Check End -------------"

git clone --depth=1 https://github.com/vernesong/OpenClash.git package/xzhhzx222/OpenClash
rm -vrf $CLASH_DIR/china_ip*
rm -vrf $CLASH_DIR/Geo*
curl -Ls -o $CLASH_DIR/GeoIP.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
curl -Ls -o $CLASH_DIR/GeoSite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
mkdir -p $CLASH_DIR/core
curl -Ls -o $CLASH_DIR/core/core.tar.gz https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz
tar zxf $CLASH_DIR/core/core.tar.gz -C $CLASH_DIR/core
mv -vf $CLASH_DIR/core/clash $CLASH_DIR/core/clash_meta
rm -vf $CLASH_DIR/core/core.tar.gz
rm -vf $CLASH_DIR/rule_provider/*

# 添加jerrykuku/luci-app-vssr
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/xzhhzx222/lua-maxminddb
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/xzhhzx222/luci-app-vssr

# 修改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile

if [[ $BUILD_BRANCH == immortalwrt-* ]]; then
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
  SET_FILE=package/emortal/default-settings/files/99-default-settings
  sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile
  # sed -i 's/+IPV6:.* //' package/feeds/packages/miniupnpd/Makefile
  #
  # echo "------------ Check Start ------------"
  # grep "DEPENDS:=" package/feeds/packages/miniupnpd/Makefile
  # echo "------------- Check End -------------"
  #
  git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  # sed -i 's/\${str_linefeed}/\\\\n/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
  sed -i 's/\${1} ${nowtime}/${nowtime}\\\\n${1}/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
  git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
  rm -vrf "$SET_FILE-chinese"
  touch "$SET_FILE-chinese"
else
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
  SET_FILE=package/lean/default-settings/files/zzz-default-settings
  # wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh
  git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
fi

echo "------------ Check Start ------------"
ls -l package/xzhhzx222
echo "------------- Check End -------------"

DIY_SET=$GITHUB_WORKSPACE/diy/set/${BUILD_VER,,}.settings
DIY_LOGO=$GITHUB_WORKSPACE/diy/img/${BUILD_VER,,}.jpg

echo "------------ Check Start ------------"
echo "LOGO_FILE=$LOGO_FILE"
echo "SET_FILE=$SET_FILE"
echo "DIY_SET=$DIY_SET"
echo "DIY_LOGO=$DIY_LOGO"
echo "------------- Check End -------------"

[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE

sed -i "s/DISTRIB_REVISION=/DISTRIB_REVISION=\'Ver $(date +%y.%m.%d)\'/" $SET_FILE

echo "------------ Check Start ------------"
grep "DISTRIB_REVISION=" $SET_FILE
echo "------------- Check End -------------"
