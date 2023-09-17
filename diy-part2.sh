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

if [ "$REPO_URL" = "https://github.com/openwrt/openwrt" ]; then
  [ -e $DIY_LOGO ] && mv -f $DIY_LOGO package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
  svn export https://github.com/Lienol/openwrt/branches/22.03/package/default-settings package/default-settings
else
  [ -e $DIY_LOGO ] && mv -f $DIY_LOGO package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
  mv package/lean/default-settings package/
fi
[ -e $DIY_SETTING ] && mv -f $DIY_SETTING package/default-settings/files/zzz-default-settings
sed -i 's/VER_DATE/'"$(date +%y.%m.%d)"'/g' package/default-settings/files/zzz-default-settings

# 更改默认主题
rm -rf package/feeds/luci/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile

# 删除serverchan
rm -rf package/feeds/luci/luci-app-serverchan

# 替换update_cloudflare_com_v4.sh
# wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh
