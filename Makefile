#
# Copyright (C) 2020 tencentcloud <https://github.com/Tencent-Cloud-Plugins>
#
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-tencentddns
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=tencentcloud <https://github.com/Tencent-Cloud-Plugins>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-tencentddns
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for tencentddns
	PKGARCH:=all
	DEPENDS:=+openssl-util +curl
endef

define Package/luci-app-tencentddns/description
	LuCI Support for TencentDDNS.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-tencentddns/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-tencentddns ]; then
		( . /etc/uci-defaults/luci-tencentddns ) && \
		rm -f /etc/uci-defaults/luci-tencentddns
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Package/luci-app-tencentddns/prerm
#!/bin/sh
/etc/init.d/tencentddns stop
exit 0
endef

define Package/luci-app-tencentddns/conffiles
/etc/config/tencentddns
endef

define Package/luci-app-tencentddns/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/tencentddns.po $(1)/usr/lib/lua/luci/i18n/tencentddns.zh-cn.lmo
endef

$(eval $(call BuildPackage,luci-app-tencentddns))