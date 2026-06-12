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


# 添加Openwrt-Passwall/openwrt-passwall
# echo 'src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' >>feeds.conf.default
# echo 'src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall.git;main' >>feeds.conf.default
# echo 'src-git passwall2_luci https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main' >>feeds.conf.default

# 添加sundaqiang/openwrt-packages
echo 'src-git sundaqiang https://github.com/sundaqiang/openwrt-packages.git;master' >>feeds.conf.default

PKG_DIR=package/xzhhzx222
echo "------------ Check Start ------------"
echo "PKG_DIR=$PKG_DIR"
echo "------------- Check End -------------"

# 添加Lienol/openwrt-package
# git clone https://github.com/Lienol/openwrt-package.git package/Lienol/openwrt-package
# mv -vf package/Lienol/openwrt-package/luci-app-control-weburl/ $PKG_DIR/
# rm -rf package/Lienol/

# 添加sirpdboy/luci-app-advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git $PKG_DIR/luci-app-advanced

# 添加fw876/helloworld
git clone https://github.com/fw876/helloworld.git package/fw876/helloworld
mv -vf package/fw876/helloworld/*/ $PKG_DIR/
rm -rf package/fw876

# 添加vernesong/OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/vernesong/OpenClash
mv -vf package/vernesong/OpenClash/luci-app-openclash/ $PKG_DIR/
rm -rf package/vernesong/

# 添加stackia/rtp2httpd
git clone https://github.com/stackia/rtp2httpd.git package/stackia/rtp2httpd
mv -vf package/stackia/rtp2httpd/openwrt-support/*/ $PKG_DIR/
# mv -vf package/stackia/rtp2httpd/openwrt-support/rtp2httpd $PKG_DIR/
# mv -vf package/stackia/rtp2httpd/openwrt-support/luci-app-rtp2httpd $PKG_DIR/
rm -rf package/stackia/

# 添加sirpdboy/luci-app-timecontrol
git clone https://github.com/sirpdboy/luci-app-timecontrol.git $PKG_DIR/luci-app-timecontrol

# 添加luci-app-wechatpush
git clone https://github.com/tty228/luci-app-wechatpush.git $PKG_DIR/luci-app-wechatpush

# 添加luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git $PKG_DIR/luci-theme-argon

echo "------------ Check Start ------------"
ls -l $PKG_DIR/
echo "------------- Check End -------------"
