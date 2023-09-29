#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

#
# 添加fw876/helloworld
#
if [ $BUILD_BRANCH != immortalwrt ]; then
  echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
fi

# #
# # 添加xiaorouji/openwrt-passwall
# #
# echo 'src-git passwall_pkg https://github.com/xiaorouji/openwrt-passwall;packages' >>feeds.conf.default
# echo 'src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall;luci' >>feeds.conf.default
# echo 'src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2' >>feeds.conf.default

#
# 添加Lienol/openwrt-package
#
if [[ $BUILD_BRANCH == openwrt-* ]]; then
  echo 'src-git lienol https://github.com/Lienol/openwrt-package.git;main' >>feeds.conf.default
fi
# echo 'src-git other https://github.com/Lienol/openwrt-package.git;other' >>feeds.conf.default

# #
# # 添加sundaqiang/openwrt-packages
# #
# echo 'src-git sundaqiang https://github.com/sundaqiang/openwrt-packages;master' >>feeds.conf.default

#
# 添加sirpdboy/luci-app-advanced
#
git clone https://github.com/sirpdboy/luci-app-advanced.git package/xzhhzx222/luci-app-advanced

# #
# # 添加jerrykuku/luci-app-vssr
# #
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/xzhhzx222/lua-maxminddb
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/xzhhzx222/luci-app-vssr

# #
# # 添加destan19/OpenAppFilter
# #
# git clone https://github.com/destan19/OpenAppFilter.git package/xzhhzx222/OpenAppFilter

#
# 添加vernesong/OpenClash
#
git clone https://github.com/vernesong/OpenClash.git package/xzhhzx222/OpenClash --depth=1
