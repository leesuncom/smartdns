#
# Copyright (c) 2018-2023 Nick Peng (pymumu@gmail.com)
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=smartdns
PKG_VERSION:=1.2023.41
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://www.github.com/pymumu/smartdns.git
PKG_MIRROR_HASH:=skip
PKG_SOURCE_VERSION:=60a3719ec739be2cc1e11724ac049b09a75059cb

PKG_MAINTAINER:=Nick Peng <pymumu@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

MAKE_VARS += VER=$(PKG_VERSION) 
MAKE_PATH:=src

define Package/smartdns
  SECTION:=net
  CATEGORY:=Network
  TITLE:=smartdns server
  DEPENDS:=+libpthread +libopenssl
  URL:=https://www.github.com/pymumu/smartdns/
endef

define Package/smartdns/description
SmartDNS is a local DNS server which accepts DNS query requests from local network clients,
gets DNS query results from multiple upstream DNS servers concurrently, and returns the fastest IP to clients.
Unlike dnsmasq's all-servers, smartdns returns the fastest IP, and encrypt DNS queries with DoT or DoH.
endef

define Package/smartdns/conffiles
/etc/smartdns/conf.d/anti-ad-for-smartdns.conf
/etc/smartdns/domain-set/gfwlist.txt
/etc/smartdns/domain-set/cn.txt
/etc/smartdns/domain-set/ipv4list.txt
/etc/config/smartdns
/etc/smartdns/address.conf
/etc/smartdns/blacklist-ip.conf
/etc/smartdns/custom.conf
/etc/smartdns/domain-block.list
/etc/smartdns/domain-forwarding.list
/etc/smartdns/up.sh
endef

define Package/smartdns/install
	$(INSTALL_DIR) $(1)/usr/sbin $(1)/etc/config $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/smartdns $(1)/etc/smartdns/domain-set/ $(1)/etc/smartdns/conf.d/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/smartdns $(1)/usr/sbin/smartdns
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/package/openwrt/files/etc/init.d/smartdns $(1)/etc/init.d/smartdns
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/package/openwrt/address.conf $(1)/etc/smartdns/address.conf
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/package/openwrt/blacklist-ip.conf $(1)/etc/smartdns/blacklist-ip.conf
	$(INSTALL_CONF) $(CURDIR)/conf/custom.conf $(1)/etc/smartdns/custom.conf
	$(INSTALL_CONF) $(CURDIR)/conf/smartdns.conf $(1)/etc/config/smartdns
	$(INSTALL_CONF) $(CURDIR)/conf/up.sh $(1)/etc/smartdns/up.sh
	$(INSTALL_CONF) $(CURDIR)/conf/domain-forwarding.list $(1)/etc/smartdns/domain-forwarding.list
	$(INSTALL_CONF) $(CURDIR)/conf/domain-block.list $(1)/etc/smartdns/domain-block.list
	$(INSTALL_CONF) $(CURDIR)/conf/conf.d/anti-ad-for-smartdns.conf $(1)/etc/smartdns/conf.d/anti-ad-for-smartdns.conf
	$(INSTALL_CONF) $(CURDIR)/conf/domain-set/gfwlist.txt $(1)/etc/smartdns/domain-set/gfwlist.txt
	$(INSTALL_CONF) $(CURDIR)/conf/domain-set/cn.txt $(1)/etc/smartdns/domain-set/cn.txt
        $(INSTALL_CONF) $(CURDIR)/conf/domain-set/ipv4list.txt $(1)/etc/smartdns/domain-set/ipv4list.txt
endef

$(eval $(call BuildPackage,smartdns))
