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

DIY_SET=$GITHUB_WORKSPACE/diy/set/$BUILD_VER.settings
DIY_LOGO=$GITHUB_WORKSPACE/diy/img/$BUILD_VER.jpg

echo "------------ Check Start ------------"
echo "CONFIG_FILE=$CONFIG_FILE"
echo "DIY_SET=$DIY_SET"
echo "DIY_LOGO=$DIY_LOGO"
echo "------------- Check End -------------"

if [[ $BUILD_BRANCH == openwrt-* ]]; then
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
  SET_FILE=package/default-settings/files/zzz-default-settings
  svn export https://github.com/Lienol/openwrt/branches/22.03/package/default-settings package/default-settings
  git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
  sed -i '/LUCI_DEPENDS:=/s/$/ +@LUCI_LANG_zh_Hans/' package/feeds/luci/luci-base/Makefile
  for pkg in $(find package/feeds/*/luci-app*/po -maxdepth 0 -type d); do
    if [ ! -d "$pkg/zh_Hans" ] && [ -d "$pkg/zh-cn" ]; then 
      ln -sf zh-cn "$pkg/zh_Hans"
      echo $pkg
      ls -l $pkg
    fi
  done
elif [ $BUILD_BRANCH = lede ]; then
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
  SET_FILE=package/lean/default-settings/files/zzz-default-settings
  # wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh
  git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  rm -rf package/feeds/luci/luci-theme-argon
  git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
fi

echo "------------ Check Start ------------"
echo "LOGO_FILE=$LOGO_FILE"
echo "SET_FILE=$SET_FILE"
echo "------------- Check End -------------"

[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE

sed -i "s/DISTRIB_REVISION='.*'/DISTRIB_REVISION=\'Ver $(date +%y.%m.%d)\'/" $SET_FILE

rm -rf package/feeds/luci/luci-app-serverchan

sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile
