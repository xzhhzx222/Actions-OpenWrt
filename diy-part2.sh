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

rm -vrf package/feeds/luci/luci-app-serverchan
rm -vrf package/feeds/luci/luci-app-wechatpush
rm -vrf package/feeds/luci/luci-theme-argon*
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile

if [[ $BUILD_BRANCH != lienol-* || openwrt-* ]]; then
  svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol package/xzhhzx222/luci-app-control-timewol
  svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl package/xzhhzx222/luci-app-control-weburl
  svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol package/xzhhzx222/luci-app-timecontrol
fi

if [[ $BUILD_BRANCH != lede-* ]]; then
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
  git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  # sed -i 's/+IPV6:.* //' package/feeds/packages/miniupnpd/Makefile
  # echo "------------ Check Start ------------"
  # grep "DEPENDS:=" package/feeds/packages/miniupnpd/Makefile
  # echo "------------- Check End -------------"
  # sed -i 's/\${str_linefeed}/\\\\n/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
  sed -i 's/\${1} ${nowtime}/${nowtime}\\\\n${1}/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
  git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
  case $BUILD_BRANCH in
    immortalwrt-*)
      SET_FILE=package/emortal/default-settings/files/99-default-settings
      rm -vrf "$SET_FILE-chinese"
      touch "$SET_FILE-chinese"
      rm -vrf package/feeds/luci/luci-app-openclash
      rm -vrf package/feeds/luci/luci-app-passwall
      rm -vrf package/feeds/luci/luci-app-vssr
      ;;
    lienol-*)
      SET_FILE=package/default-settings/files/zzz-default-settings
      ;;
    openwrt-*)
      SET_FILE=package/default-settings/files/zzz-default-settings
      rm -vrf package/feeds/lienol/luci-app-softethervpn
      svn export https://github.com/immortalwrt/luci/trunk/luci.mk package/feeds/luci.mk
      svn export https://github.com/Lienol/openwrt/branches/22.03/package/default-settings package/default-settings
      svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-softethervpn package/xzhhzx222/luci-app-softethervpn
      sed -i '/LUCI_DEPENDS:=/s/$/ +@LUCI_LANG_zh_Hans/' package/feeds/luci/luci-base/Makefile
      for pkg in $(find package/feeds/*/luci-app*/po -maxdepth 0 -type d); do
        if [ ! -d "$pkg/zh_Hans" ] && [ -d "$pkg/zh-cn" ]; then 
          ln -sf zh-cn "$pkg/zh_Hans"
        fi
      done
      ;;
    esac
else
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
  SET_FILE=package/lean/default-settings/files/zzz-default-settings
  # wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh
  git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
fi

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
