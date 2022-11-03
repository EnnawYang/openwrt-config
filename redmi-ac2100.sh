#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

rm -rf files
rm -rf package/diy

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改机器名称
sed -i 's/OpenWrt/RM2100/g' package/base-files/files/bin/config_generate

# atmaterial主题
# git clone https://github.com/yangsongli/luci-theme-atmaterial package/mine/luci-theme-atmaterial

# luci-app-ssr-plus
git clone https://github.com/fw876/helloworld package/diy/luci-app-ssr-plus

# Modify zzz-default-settings
export orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date +"%Y-%m-%d")
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" package/lean/default-settings/files/zzz-default-settings

# 更改默认主题
#sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

# 防火墙wan口入站数据修改成ACCEPT(第21行)。如您的网络是公网，建议注释掉此项。
#sed -i '21s/REJECT/ACCEPT/g' package/network/config/firewall/files/firewall.config

# 允许远程主机连接到本地 SSH 转发端口。如您的网络是公网，建议注释掉此项。
#sed -i "4a\ \toption GatewayPorts 'on'" package/network/services/dropbear/files/dropbear.config
