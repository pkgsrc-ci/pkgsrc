# $NetBSD: options.mk,v 1.2 2024/04/14 17:05:03 js Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.objfw
PKG_OPTIONS_OPTIONAL_GROUPS=	tls
PKG_OPTIONS_GROUP.tls=		openssl gnutls mbedtls
.if ${OPSYS} == "Darwin"
PKG_OPTIONS_GROUP.tls+=		securetransport
PKG_SUGGESTED_OPTIONS=		securetransport
.else
PKG_SUGGESTED_OPTIONS=		openssl
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mopenssl)
.  include "../../security/openssl/buildlink3.mk"
CONFIGURE_ARGS+=	--with-tls=openssl
PLIST_SRC+=		PLIST.tls
.  if ${OPSYS} == "Darwin"
PLIST_SRC+=		PLIST.tlsframework
.  endif
.elif !empty(PKG_OPTIONS:Mgnutls)
.  include "../../security/gnutls/buildlink3.mk"
CONFIGURE_ARGS+=	--with-tls=gnutls
PLIST_SRC+=		PLIST.tls
.  if ${OPSYS} == "Darwin"
PLIST_SRC+=		PLIST.tlsframework
.  endif
.elif !empty(PKG_OPTIONS:Msecuretransport)
CONFIGURE_ARGS+=	--with-tls=securetransport
PLIST_SRC+=		PLIST.tls
.  if ${OPSYS} == "Darwin"
PLIST_SRC+=		PLIST.tlsframework
.  endif
.elif !empty(PKG_OPTIONS:Mmbedtls)
.  include "../../security/mbedtls3/buildlink3.mk"
CONFIGURE_ARGS+=	--with-tls=mbedtls
PLIST_SRC+=		PLIST.tls
.  if ${OPSYS} == "Darwin"
PLIST_SRC+=		PLIST.tlsframework
.  endif
.else
CONFIGURE_ARGS+=	--without-tls
.endif
