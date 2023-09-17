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
rm -rf package/feeds/luci/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile

# #
 sed -i '/LUCI_DEPENDS:=/s/$/ +@LUCI_LANG_zh_Hans/' package/feeds/luci/luci-base/Makefile

# 删除serverchan
rm -rf package/feeds/luci/luci-app-serverchan

# 替换update_cloudflare_com_v4.sh
# wget -O package/feeds/packages/ddns-scripts/files/update_cloudflare_com_v4.sh https://raw.githubusercontent.com/openwrt/packages/master/net/ddns-scripts/files/usr/lib/ddns/update_cloudflare_com_v4.sh
