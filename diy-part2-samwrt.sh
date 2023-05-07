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

# 替换default-settings
mv -vf package/self-settings/default-settings/samwrt-settings package/lean/default-settings/files/zzz-default-settings
sed -i 's/23.02.02/'"$(date +%y.%m.%d)"'/g' package/lean/default-settings/files/zzz-default-settings

# 替换serverchan
rm -rf package/feeds/luci/luci-app-serverchan
# mv -vf package/self-settings/serverchan/samwrt.jpg package/feeds/luci/luci-app-serverchan/root/usr/bin/serverchan/api/logo.jpg
mv -vf package/self-settings/serverchan/samwrt.jpg package/xzhhzx222/luci-app-serverchan/root/usr/share/serverchan/api/logo.jpg

# 删除多余配置
rm -rf package/self-settings
