#!/bin/bash

echo $DEPENDS_UBUNTU
echo $REPO_URL
echo $REPO_BRANCH

echo $CONFIG_FILE
echo $DIY_SET
echo $DIY_LOGO

if [ "$BUILD_BRANCH" == "openwrt-22.03" ] || [ "$BUILD_BRANCH" == "openwrt-23.05" ]; then
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/wechatpush/api/logo.jpg
  SET_FILE=package/default-settings/files/zzz-default-settings
  #svn export https://github.com/Lienol/openwrt/branches/22.03/package/default-settings package/default-settings
  #git clone https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
  #git clone https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
  #sed -i '/LUCI_DEPENDS:=/s/$/ +@LUCI_LANG_zh_Hans/' package/feeds/luci/luci-base/Makefile
  #for pkg in $(find package/feeds/*/luci-app*/po -maxdepth 0 -type d); do
  #  if [ ! -d "$pkg/zh_Hans" ] && [ -d "$pkg/zh-cn" ]; then 
  #    ln -sf zh-cn "$pkg/zh_Hans"
  #  fi
  #done
elif [ $BUILD_BRANCH == lede ]; then
  LOGO_FILE=package/xzhhzx222/luci-app-wechatpush/root/usr/share/serverchan/api/logo.jpg
  SET_FILE=package/lean/default-settings/files/zzz-default-settings
  #rm -rf package/feeds/luci/luci-theme-argon
  #git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/xzhhzx222/luci-theme-argon
  #git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git package/xzhhzx222/luci-app-wechatpush
fi

#[ -e $DIY_LOGO ] && mv -vf $DIY_LOGO $LOGO_FILE
#[ -e $DIY_SET ] && mv -vf $DIY_SET $SET_FILE
#sed -i 's/VER_DATE/'"$(date +%y.%m.%d)"'/g' $SET_FILE

echo $LOGO_FILE
echo $SET_FILE
