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


# 更改luci/openwrt
if [[ $BUILD_BRANCH == lede-18.06 ]]; then
  sed -i '/luci/d' feeds.conf.default
  echo 'src-git luci https://github.com/coolsnowwolf/luci' >>feeds.conf.default
# elif [[ $BUILD_BRANCH == lede-23.05 ]]; then
#   sed -i '/luci/d' feeds.conf.default
#   echo 'src-git luci https://github.com/openwrt/luci.git;openwrt-23.05' >>feeds.conf.default
fi

# 添加fw876/helloworld
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default

# 添加xiaorouji/openwrt-passwall
# echo 'src-git passwall_pkg https://github.com/xiaorouji/openwrt-passwall.git;packages' >>feeds.conf.default
# echo 'src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;luci' >>feeds.conf.default
# echo 'src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git' >>feeds.conf.default

# 添加sundaqiang/openwrt-packages
echo 'src-git sundaqiang https://github.com/sundaqiang/openwrt-packages.git;master' >>feeds.conf.default
