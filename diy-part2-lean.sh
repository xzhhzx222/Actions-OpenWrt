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

# 修改默认ip
sed -i 's/192.168.1.1/192.168.1.250/g' package/base-files/files/bin/config_generate
# 修改默认主机名称
sed -i 's/OpenWrt/SamLede/g' package/base-files/files/bin/config_generate
# 禁用dns缓存
sed -i '/dnsmasq/a\option cachesize 0' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/\(option cachesize\)/\t\1/' package/network/services/dnsmasq/files/dhcp.conf
# 禁用ipv6解析
sed -i '/filter_aaaa/s/0/1/g' package/network/services/dnsmasq/files/dhcp.conf
# 添加用户
#sed -i '$a li:x:1000:100:li:/mnt/homes/li:/bin/false' package/base-files/files/etc/passwd
#sed -i '$a sophie:x:1001:100:sophie:/mnt/homes/sophie:/bin/false' package/base-files/files/etc/passwd
#sed -i '$a xzhhzx222:x:1002:100:xzhhzx222:/mnt/homes:/bin/false' package/base-files/files/etc/passwd
#sed -i '$a guest:x:1003:100:guest:/mnt/homes/guest:/bin/false' package/base-files/files/etc/passwd
echo 'li:x:1000:100:li:/mnt/homes/li:/bin/false' >>package/base-files/files/etc/passwd
echo 'sophie:x:1001:100:sophie:/mnt/homes/sophie:/bin/false' >>package/base-files/files/etc/passwd
echo 'xzhhzx222:x:1002:100:xzhhzx222:/mnt/homes:/bin/false' >>package/base-files/files/etc/passwd
echo 'guest:x:1003:100:guest:/mnt/homes/guest:/bin/false' >>package/base-files/files/etc/passwd
# turboacc开启bbr
sed -i '/bbr/s/0/1/g' package/lean/luci-app-turboacc/root/etc/config/turboacc
sed -i '/bridge/s/1/0/g' package/lean/luci-app-turboacc/root/etc/config/turboacc
# 修改默认root密码
sed -i 's#root::0#root:$1$yW9piKyc$OT6rrlpcoPRvf1Vk.Zm9N/:18415#g' package/base-files/files/etc/shadow
# 设置用户密码
#sed -i '$a li:$1$Ow7vwy1O$lCGrGnn4g3YKBCFQ60/yJ.:18664:0:99999:7:::' package/base-files/files/etc/shadow
#sed -i '$a sophie:$1$QSEsYP5O$HphTBwlP28deKNymcaKFf0:18664:0:99999:7:::' package/base-files/files/etc/shadow
#sed -i '$a xzhhzx222:$1$3L7KoROG$MUcqm4H6jza4/83CBOsSH/:18664:0:99999:7:::' package/base-files/files/etc/shadow
#sed -i '$a guest:$1$H7u9QR91$OT6NJ/3psLSpT41fw.zqX1:18815:0:99999:7:::' package/base-files/files/etc/shadow
echo 'li:$1$Ow7vwy1O$lCGrGnn4g3YKBCFQ60/yJ.:18664:0:99999:7:::' >>package/base-files/files/etc/shadow
echo 'sophie:$1$QSEsYP5O$HphTBwlP28deKNymcaKFf0:18664:0:99999:7:::' >>package/base-files/files/etc/shadow
echo 'xzhhzx222:$1$3L7KoROG$MUcqm4H6jza4/83CBOsSH/:18664:0:99999:7:::' >>package/base-files/files/etc/shadow
echo 'guest:$1$H7u9QR91$OT6NJ/3psLSpT41fw.zqX1:18815:0:99999:7:::' >>package/base-files/files/etc/shadow
# 禁用https重定向
sed -i '/redirect_https/s/1/0/g' package/network/services/uhttpd/files/uhttpd.config
# 允许外网访问
sed -i 's/rfc1918_filter 1/rfc1918_filter 0/g' package/network/services/uhttpd/files/uhttpd.config

# 添加advanced
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
# 添加argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# 添加dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman

# 更改默认主题
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile
