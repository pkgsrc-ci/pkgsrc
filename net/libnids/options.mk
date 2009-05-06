# $NetBSD: options.mk,v 1.7 2009/05/06 21:54:54 adrianp Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.libnids

PKG_OPTIONS_REQUIRED_GROUPS=	libnet
PKG_OPTIONS_GROUP.libnet=	libnet10 libnet11

PKG_SUPPORTED_OPTIONS=		glib

PKG_SUGGESTED_OPTIONS=		libnet10 glib

.include "../../mk/bsd.options.mk"

###
### libnet 1.0.x branch support
###
.if !empty(PKG_OPTIONS:Mlibnet10)
.	include "../../devel/libnet10/buildlink3.mk"
BUILDLINK_DEPMETHOD.libnet10+=	build
SUBST_SED.conf=	-e "s|libnet-config|libnet10-config|g"
.endif

###
### libnet 1.1.x branch support
###
.if !empty(PKG_OPTIONS:Mlibnet11)
.	include "../../devel/libnet11/buildlink3.mk"
BUILDLINK_DEPMETHOD.libnet11+=	build
SUBST_SED.conf=	-e "s|libnet-config|libnet11-config|g"
.endif

###
### glib support
###
.if !empty(PKG_OPTIONS:Mglib)
.include "../../devel/glib2/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--disable-libglib
.endif
