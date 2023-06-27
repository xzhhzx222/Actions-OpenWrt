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

# # 添加passwall
# echo 'src-git passwall_pkg https://github.com/xiaorouji/openwrt-passwall;packages' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall;luci' >>feeds.conf.default
# echo 'src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2' >>feeds.conf.default
# 添加ssrplus
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 添加advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/xzhhzx222/luci-app-advanced
# 添加control
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol package/xzhhzx222/luci-app-control-timewol
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl package/xzhhzx222/luci-app-control-weburl
# # 添加helloworld
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/xzhhzx222/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/xzhhzx222/luci-app-vssr
# 添加openclash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/xzhhzx222/luci-app-openclash
# 添加parentcontrol
git clone https://github.com/sirpdboy/luci-app-parentcontrol.git package/xzhhzx222/luci-app-parentcontrol
# 添加serverchan
git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
# 添加timecontrol
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol package/xzhhzx222/luci-app-timecontrol
# 添加wolplus
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus package/xzhhzx222/luci-app-wolplus

# 添加argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon-18.06
