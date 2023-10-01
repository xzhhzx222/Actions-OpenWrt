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

# if [[ $BUILD_BRANCH == openwrt-* ]]; then
# elif [ $BUILD_BRANCH = lede ]; then
# fi

case $BUILD_BRANCH in
  immortalwrt)
    LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
    SET_FILE=package/emortal/default-settings/files/99-default-settings
    rm -vrf "$SET_FILE-chinese"
    touch "$SET_FILE-chinese"
    echo "------------ Check Start ------------"
    cat "$SET_FILE-chinese"
    echo "------------- Check End -------------"
    rm -vrf package/feeds/luci/luci-app-openclash
    rm -vrf package/feeds/luci/luci-app-passwall
    rm -vrf package/feeds/luci/luci-app-vssr
    rm -vrf package/feeds/luci/luci-app-wechatpush
    rm -vrf package/feeds/luci/luci-theme-argon
    git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
    git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
    sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile
    echo "------------ Check Start ------------"
    cat package/feeds/luci/luci-light/Makefile
    echo "------------- Check End -------------"
    ;;
  lede)
    LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
    SET_FILE=package/lean/default-settings/files/zzz-default-settings
    # wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh
    git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
    rm -vrf package/feeds/luci/luci-theme-argon
    git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
    ;;
  lienol)
    LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
    SET_FILE=package/default-settings/files/zzz-default-settings
    rm -vrf package/feeds/lienol/luci-app-softethervpn
    svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-softethervpn package/xzhhzx222/luci-app-softethervpn
    git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
    rm -vrf package/feeds/luci/luci-theme-argon
    git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
    ;;
  openwrt-*)
    LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
    SET_FILE=package/default-settings/files/zzz-default-settings
    rm -vrf package/feeds/lienol/luci-app-softethervpn
    svn export https://github.com/immortalwrt/luci/trunk/luci.mk package/feeds/luci.mk
     svn export https://github.com/Lienol/openwrt/branches/22.03/package/default-settings package/default-settings
    svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-softethervpn package/xzhhzx222/luci-app-softethervpn
    git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
    git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
    sed -i '/LUCI_DEPENDS:=/s/$/ +@LUCI_LANG_zh_Hans/' package/feeds/luci/luci-base/Makefile
    for pkg in $(find package/feeds/*/luci-app*/po -maxdepth 0 -type d); do
      if [ ! -d "$pkg/zh_Hans" ] && [ -d "$pkg/zh-cn" ]; then 
        ln -sf zh-cn "$pkg/zh_Hans"
      fi
    done
    ;;
esac

echo "------------ Check Start ------------"
echo "LOGO_FILE=$LOGO_FILE"
echo "SET_FILE=$SET_FILE"
echo "------------- Check End -------------"

[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE

sed -i "s/DISTRIB_REVISION=/DISTRIB_REVISION=\'Ver $(date +%y.%m.%d)\'/" $SET_FILE
echo "------------ Check Start ------------"
cat $SET_FILE
echo "------------- Check End -------------"

rm -vrf package/feeds/luci/luci-app-serverchan

sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile
