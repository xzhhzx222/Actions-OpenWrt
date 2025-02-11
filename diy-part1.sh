#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default


# 添加fw876/helloworld
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default

# 添加xiaorouji/openwrt-passwall
# echo 'src-git passwall_pkg https://github.com/xiaorouji/openwrt-passwall-packages.git' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git' >>feeds.conf.default
# echo 'src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git' >>feeds.conf.default

# 添加sundaqiang/openwrt-packages
echo 'src-git sundaqiang https://github.com/sundaqiang/openwrt-packages.git;master' >>feeds.conf.default
