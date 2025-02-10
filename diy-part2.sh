#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate


# 删除已存在的软件包
rm -rf feeds/luci/applications/luci-app-openclash/
rm -rf feeds/luci/applications/luci-app-passwall*/
rm -rf feeds/luci/applications/luci-app-serverchan/
rm -rf feeds/luci/applications/luci-app-wechatpush/
rm -rf feeds/luci/themes/luci-theme-argon*/
rm -rf package/feeds/luci/luci-app-openclash/
rm -rf package/feeds/luci/luci-app-passwall*/
rm -rf package/feeds/luci/luci-app-serverchan/
rm -rf package/feeds/luci/luci-app-wechatpush/
rm -rf package/feeds/luci/luci-theme-argon*/

# 添加sirpdboy/luci-app-advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/xzhhzx222/luci-app-advanced

# 添加Lienol/openwrt-package
# git clone https://github.com/Lienol/openwrt-package.git package/Lienol/openwrt-package
# mv -vf package/Lienol/openwrt-package/luci-app-control-timewol/ package/xzhhzx222/
# mv -vf package/Lienol/openwrt-package/luci-app-control-weburl/ package/xzhhzx222/
# mv -vf package/Lienol/openwrt-package/luci-app-timecontrol/ package/xzhhzx222/
# rm -rf package/Lienol/

# 添加vernesong/OpenClash
CLASH_DIR=package/xzhhzx222/luci-app-openclash/root/etc/openclash

echo "------------ Check Start ------------"
echo "CLASH_DIR=$CLASH_DIR"
echo "------------- Check End -------------"

git clone --depth=1 https://github.com/vernesong/OpenClash.git package/vernesong/OpenClash
mv -vf package/vernesong/OpenClash/luci-app-openclash/ package/xzhhzx222/
rm -rf package/vernesong/
rm -vf $CLASH_DIR/Geo*
curl -Ls -o $CLASH_DIR/GeoIP.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
curl -Ls -o $CLASH_DIR/GeoSite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
mkdir -p $CLASH_DIR/core
curl -Ls -o $CLASH_DIR/core/core.tar.gz https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz
# curl -Ls -o $CLASH_DIR/core/core.tar.gz https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64-v3.tar.gz
tar -zxf $CLASH_DIR/core/core.tar.gz -C $CLASH_DIR/core
mv -vf $CLASH_DIR/core/clash $CLASH_DIR/core/clash_meta
rm -vf $CLASH_DIR/core/core.tar.gz
rm -f $CLASH_DIR/rule_provider/*

# 链接sundaqiang/openwrt-packages
ln -vsf $PWD/feeds/sundaqiang/luci-app-easyupdate/po/zh-cn/ $PWD/feeds/sundaqiang/luci-app-easyupdate/po/zh_Hans
ln -vsf $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/ $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh-cn
# ln -vsf $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh-cn/ $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans
sed -i "s#curl \"https.*tag_name.*#curl \"https://api.github.com/repos/\${github[2]}/\${github[3]}/releases\" | jq -r '.[] | select(.name | startswith(\"$BUILD_VER\")) | .tag_name' | head -n 1#" feeds/sundaqiang/luci-app-easyupdate/root/usr/bin/easyupdate.sh
sed -i "s#curl \"https.*assets.*#curl \"https://api.github.com/repos/\${github[2]}/\${github[3]}/releases\" | jq -r \".[] | select(.name | startswith(\\\\\"$BUILD_VER\\\\\")) | select(.tag_name == \\\\\"\$(getCloudVer)\\\\\") | .assets[].browser_download_url\" | sed -n \"/\$suffix/p\")#" feeds/sundaqiang/luci-app-easyupdate/root/usr/bin/easyupdate.sh

case $BUILD_BRANCH in
  lede-23.05)
    LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
    SET_FILE=package/lean/default-settings/files/zzz-default-settings
    # 替换msd_lite
    # git clone -b openwrt-23.05 https://github.com/immortalwrt/packages.git package/immortalwrt/packages
    # rm -rf feeds/packages/net/msd_lite/
    # mv -vf package/immortalwrt/packages/net/msd_lite/ feeds/packages/net/
    # rm -rf package/immortalwrt/packages/
    # 添加luci-app-msd_lite
    # git clone -b openwrt-23.05 https://github.com/immortalwrt/luci.git package/immortalwrt/luci
    # mv -vf package/immortalwrt/luci/applications/luci-app-msd_lite/ feeds/luci/applications/
    # ln -vsf $PWD/feeds/luci/applications/luci-app-msd_lite/ $PWD/package/feeds/luci/
    # rm -rf package/immortalwrt/luci/
    # 添加luci-app-softethervpn
    git clone https://github.com/coolsnowwolf/luci.git package/coolsnowwolf/luci
    mv -vf package/coolsnowwolf/luci/applications/luci-app-softethervpn/ feeds/luci/applications/
    ln -vsf $PWD/feeds/luci/applications/luci-app-softethervpn/po/zh-cn/ $PWD/feeds/luci/applications/luci-app-softethervpn/po/zh_Hans
    ln -vsf $PWD/feeds/luci/applications/luci-app-softethervpn/ $PWD/package/feeds/luci/
    rm -rf package/coolsnowwolf/luci/
    # 添加luci-app-wechatpush
    git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
    # sed -i 's/\${str_linefeed}/\\\\n/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
    sed -i 's/\${1} ${nowtime}/${nowtime}\\\\n${1}/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
    # 添加luci-theme-argon
    git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
    sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile
    ;;
  immortalwrt-*)
    LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
    SET_FILE=package/emortal/default-settings/files/99-default-settings
    # 修改default-settings
    sed -i '/define Package\/default-settings-chn/,/endef/d' package/emortal/default-settings/Makefile
    sed -i '/default-settings-chn/d' package/emortal/default-settings/Makefile
    sed -i 's/+luci/& +@LUCI_LANG_zh_Hans +luci-i18n-base-zh-cn/g' package/emortal/default-settings/Makefile
    # 添加luci-app-wechatpush
    git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
    # sed -i 's/\${str_linefeed}/\\\\n/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
    sed -i 's/\${1} ${nowtime}/${nowtime}\\\\n${1}/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
    # 添加luci-theme-argon
    git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
    sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile
    ;;
esac

echo "------------ Check Start ------------"
ls -l package/xzhhzx222/
echo "------------- Check End -------------"

DIY_SET=$GITHUB_WORKSPACE/diy/set/${BUILD_VER,,}.settings
DIY_LOGO=$GITHUB_WORKSPACE/diy/img/${BUILD_VER,,}.jpg

echo "------------ Check Start ------------"
echo "LOGO_FILE=$LOGO_FILE"
echo "SET_FILE=$SET_FILE"
echo "DIY_SET=$DIY_SET"
echo "DIY_LOGO=$DIY_LOGO"
echo "------------- Check End -------------"

[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE

sed -i "s/DISTRIB_REVISION=/DISTRIB_REVISION=\'${RELEASE_VER}\'/" $SET_FILE
sed -i "s/DISTRIB_DESCRIPTION=/DISTRIB_DESCRIPTION=\'${BUILD_VER} \'/" $SET_FILE
sed -i "s#DISTRIB_GITHUB=#DISTRIB_GITHUB=\'${RELEASE_REPO}\'#" $SET_FILE
sed -i "s/DISTRIB_VERSIONS=/DISTRIB_VERSIONS=\'${RELEASE_TAG}\'/" $SET_FILE

echo "------------ Check Start ------------"
grep -m 1 "DISTRIB_REVISION=" $SET_FILE
grep "DISTRIB_GITHUB=" $SET_FILE
grep "DISTRIB_VERSIONS=" $SET_FILE
echo "------------- Check End -------------"
