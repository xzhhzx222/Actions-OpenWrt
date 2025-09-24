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
rm -rf feeds/luci/applications/luci-app-passwall/
rm -rf feeds/luci/applications/luci-app-timecontrol/
rm -rf feeds/luci/applications/luci-app-wechatpush/
rm -rf feeds/luci/themes/luci-theme-argon*/
rm -rf package/feeds/luci/luci-app-openclash/
rm -rf package/feeds/luci/luci-app-passwall/
rm -rf package/feeds/luci/luci-app-timecontrol/
rm -rf package/feeds/luci/luci-app-wechatpush/
rm -rf package/feeds/luci/luci-theme-argon*/

# 添加sirpdboy/luci-app-advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/xzhhzx222/luci-app-advanced

# 添加sirpdboy/luci-app-timecontrol
git clone https://github.com/sirpdboy/luci-app-timecontrol.git package/xzhhzx222/luci-app-timecontrol

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
rm -vf $CLASH_DIR/*.dat
curl -Ls -o $CLASH_DIR/GeoIP.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
curl -Ls -o $CLASH_DIR/GeoSite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
rm -vf $CLASH_DIR/*.ipset
curl -Ls -o $CLASH_DIR/china_ip_route.ipset https://github.com/Hackl0us/GeoIP2-CN/raw/release/CN-ip-cidr.txt
curl -Ls -o $CLASH_DIR/china_ip6_route.ipset https://ispip.clang.cn/all_cn_ipv6.txt
rm -vf $CLASH_DIR/*.mmdb
curl -Ls -o $CLASH_DIR/Country.mmdb https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
curl -Ls -o $CLASH_DIR/ASN.mmdb https://raw.githubusercontent.com/xishang0128/geoip/release/GeoLite2-ASN.mmdb
mkdir -p $CLASH_DIR/core
curl -Ls -o $CLASH_DIR/core/core.tar.gz https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz
tar -zxf $CLASH_DIR/core/core.tar.gz -C $CLASH_DIR/core
mv -vf $CLASH_DIR/core/clash $CLASH_DIR/core/clash_meta
rm -vf $CLASH_DIR/core/core.tar.gz
rm -f $CLASH_DIR/rule_provider/*

# 链接sundaqiang/openwrt-packages
# ln -vsf $PWD/feeds/sundaqiang/luci-app-easyupdate/po/zh-cn/ $PWD/feeds/sundaqiang/luci-app-easyupdate/po/zh_Hans
sed -i 's/Wake on LAN/Wake on LAN +/g' $PWD/feeds/sundaqiang/luci-app-wolplus/luasrc/controller/wolplus.lua
sed -i 's/wolplus/Wake on LAN +/g' $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/macclient/Host Clients/g' $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/name/Name/g' $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/macaddr/MAC Address/g' $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/maceth/Network Interface/g' $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
sed -i 's/awake/Awake/g' $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
echo >> $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgid \"Wake on LAN is a mechanism to remotely boot computers in the local network.\"" >> $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgstr \"网络唤醒++是一个远程唤醒本地计算机的工具\"" >> $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
echo >> $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgid \"Wake Up Host\"" >> $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
echo "msgstr \"唤醒设备\"" >> $PWD/feeds/sundaqiang/luci-app-wolplus/po/zh_Hans/wolplus.po
# sed -i "s#curl \"https.*tag_name.*#curl \"https://api.github.com/repos/\${github[2]}/\${github[3]}/releases\" | jq -r '.[] | select(.name | startswith(\"$BUILD_VER\")) | .tag_name' | head -n 1#" feeds/sundaqiang/luci-app-easyupdate/root/usr/bin/easyupdate.sh
# sed -i "s#curl \"https.*assets.*#curl \"https://api.github.com/repos/\${github[2]}/\${github[3]}/releases\" | jq -r \".[] | select(.name | startswith(\\\\\"$BUILD_VER\\\\\")) | select(.tag_name == \\\\\"\$(getCloudVer)\\\\\") | .assets[].browser_download_url\" | sed -n \"/\$suffix/p\")#" feeds/sundaqiang/luci-app-easyupdate/root/usr/bin/easyupdate.sh

# 添加luci-app-wechatpush
LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
# sed -i 's/\${str_linefeed}/\\\\n/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json
sed -i 's/\${1} ${nowtime}/${nowtime}\\\\n${1}/g' package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/qywx_mpnews.json

# 添加luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci-light/Makefile

case $BUILD_BRANCH in
  lede)
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
    ;;
  immortalwrt-*)
    SET_FILE=package/emortal/default-settings/files/99-default-settings
    # 修改default-settings
    sed -i '/define Package\/default-settings-chn/,/endef/d' package/emortal/default-settings/Makefile
    sed -i '/default-settings-chn/d' package/emortal/default-settings/Makefile
    sed -i 's/+luci/& +@LUCI_LANG_zh_Hans +luci-i18n-base-zh-cn/g' package/emortal/default-settings/Makefile
    ;;
esac

echo "------------ Check Start ------------"
ls -l package/xzhhzx222/
echo "------------- Check End -------------"

DIY_SET=$GITHUB_WORKSPACE/diy/default.settings
DIY_LOGO=$GITHUB_WORKSPACE/diy/openwrt.jpg

echo "------------ Check Start ------------"
echo "LOGO_FILE=$LOGO_FILE"
echo "SET_FILE=$SET_FILE"
echo "DIY_SET=$DIY_SET"
echo "DIY_LOGO=$DIY_LOGO"
echo "------------- Check End -------------"

[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE

sed -i "s/DISTRIB_REVISION=/DISTRIB_REVISION=\'${RELEASE_VER}\'/" $SET_FILE
sed -i "s/\"DISTRIB_DESCRIPTION=\"/\"DISTRIB_DESCRIPTION=\'${BUILD_VER} \'\"/" $SET_FILE
# sed -i "s#DISTRIB_GITHUB=#DISTRIB_GITHUB=\'${RELEASE_REPO}\'#" $SET_FILE
# sed -i "s/DISTRIB_VERSIONS=/DISTRIB_VERSIONS=\'${RELEASE_TAG}\'/" $SET_FILE

echo "------------ Check Start ------------"
grep -m 1 "DISTRIB_REVISION=" $SET_FILE
grep -m 1 "DISTRIB_DESCRIPTION=" $SET_FILE
# grep "DISTRIB_GITHUB=" $SET_FILE
# grep "DISTRIB_VERSIONS=" $SET_FILE
echo "------------- Check End -------------"
