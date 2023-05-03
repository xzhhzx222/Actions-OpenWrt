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

# 更改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' package/feeds/luci/luci/Makefile

# 替换update_cloudflare_com_v4.sh
wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh

# 替换default-settings
mv -vf package/self-settings/default-settings/jimmywrt-settings package/lean/default-settings/files/zzz-default-settings
sed -i 's/23.02.02/'"$(date +%y.%m.%d)"'/g' package/lean/default-settings/files/zzz-default-settings

# 替换serverchan
rm -rf package/feeds/luci/luci-app-serverchan
# mv -vf package/self-settings/serverchan/jimmywrt.jpg package/feeds/luci/luci-app-serverchan/root/usr/bin/serverchan/api/logo.jpg
mv -vf package/self-settings/serverchan/jimmywrt.jpg package/xzhhzx222/luci-app-serverchan/root/usr/share/serverchan/api/logo.jpg

# 删除多余配置
rm -rf package/self-settings
