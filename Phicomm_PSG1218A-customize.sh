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

([ -d files ] && rm -rf files) || echo "files not found, skip"
([ -d package/diy ] && rm -rf package/diy) || echo "diy not found, skip"

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改机器名称
sed -i 's/OpenWrt/Phicomm_K2/g' package/base-files/files/bin/config_generate

# luci-app-ssr-plus
git clone https://github.com/fw876/helloworld package/diy/luci-app-ssr-plus

# Modify zzz-default-settings
export orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date +"%Y-%m-%d")
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" package/lean/default-settings/files/zzz-default-settings
