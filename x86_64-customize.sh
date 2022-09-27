#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#

rm -rf files
rm -rf package/diy

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改机器名称
sed -i 's/OpenWrt/x86_64/g' package/base-files/files/bin/config_generate

# 替换Lienol的可道云
# rm -rf package/lean/luci-app-kodexplorer
# svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-kodexplorer package/lean/luci-app-kodexplorer

# atmaterial主题
# git clone https://github.com/yangsongli/luci-theme-atmaterial package/diy/luci-theme-atmaterial

# luci-theme-argon for 18.06 by jerrykuku
rm -rf package/feeds/luci/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/diy/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/diy/luci-app-argon-config

# luci-app-ssr-plus
git clone https://github.com/fw876/helloworld package/diy/luci-app-ssr-plus

# v2rayA: A Linux web GUI client of Project V
#svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/v2raya package/diy/v2raya
#sed -i "s/..\/..\/lang/\$(TOPDIR)\/feeds\/packages\/lang/g" package/diy/v2raya/Makefile

# openwrt-gowebdav
git clone https://github.com/immortalwrt/openwrt-gowebdav package/diy/webdav

# A tele-aria2 bot for openwrt
# git clone https://github.com/EnnawYang/tele-aria2-openwrt package/diy/tele-aria2-openwrt

# flowerss-bot
# git clone https://github.com/EnnawYang/flowerss-bot-openwrt package/diy/flowerss-bot-openwrt

# luci-app-poweroff by eSir
git clone https://github.com/esirplayground/luci-app-poweroff package/diy/luci-app-poweroff

# Luci-app-dockerman
# git clone https://github.com/lisaac/luci-app-dockerman package/diy/luci-app-dockerman
# git clone https://github.com/lisaac/luci-lib-docker package/diy/luci-lib-docker

# luci-app-unblockneteasemusic from immortalwrt
# git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/diy/luci-app-unblockneteasemusic

# rtl8812au-ac USB Wi-Fi adapter driver
# svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8812au-ac package/diy/rtl8812au-ac

# rtl8821cu USB Wi-Fi adapter driver
# svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8821cu package/diy/rtl8821cu

# Modify luci-app-docker
# sed -i "s/START=25/START=99/g" package/lean/luci-app-docker/root/etc/init.d/dockerd
# sed -i "s/\"\/opt\/\"/\"\/opt\/docker\/\"/g" package/lean/luci-app-docker/root/etc/docker/daemon.json

# alist
git clone https://github.com/sbwml/luci-app-alist package/diy/alist

# Modify zzz-default-settings
export orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date +"%Y-%m-%d")
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" package/lean/default-settings/files/zzz-default-settings

# zsh
mkdir -p files/root
git clone https://github.com/robbyrussell/oh-my-zsh files/root/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions files/root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git files/root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions files/root/.oh-my-zsh/custom/plugins/zsh-completions
wget https://raw.githubusercontent.com/EnnawYang/openwrt-config/lean-lede/files/.zshrc -O files/root/.zshrc
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify distfeeds.conf
sed -i '/http/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/openwrt_luci/d' package/lean/default-settings/files/zzz-default-settings
mkdir -p files/etc/opkg
touch files/etc/opkg/distfeeds.conf
echo "src/gz openwrt_core https://openwrt.cc/snapshots/targets/x86/64/packages" >> files/etc/opkg/distfeeds.conf
echo "src/gz openwrt_base https://openwrt.cc/snapshots/packages/x86_64/base" >> files/etc/opkg/distfeeds.conf
echo "src/gz openwrt_luci https://openwrt.cc/snapshots/packages/x86_64/luci" >> files/etc/opkg/distfeeds.conf
echo "src/gz openwrt_packages https://openwrt.cc/snapshots/packages/x86_64/packages" >> files/etc/opkg/distfeeds.conf

# 更改默认主题
#sed -i 's/config internal themes/config internal themes\n    option Rosy  \"\/luci-static\/rosy\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

# 防火墙wan口入站数据修改成ACCEPT(第21行)。如您的网络是公网，建议注释掉此项。
#sed -i '21s/REJECT/ACCEPT/g' package/network/config/firewall/files/firewall.config

# 允许远程主机连接到本地 SSH 转发端口。如您的网络是公网，建议注释掉此项。
#sed -i "4a\ \toption GatewayPorts 'on'" package/network/services/dropbear/files/dropbear.config
