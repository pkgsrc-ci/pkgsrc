# $NetBSD: buildlink.mk,v 1.1 2001/06/26 03:57:29 jlam Exp $
#
# This Makefile fragment is included by packages that use SDL.
#
# To use this Makefile fragment, simply:
#
# (1) Optionally define BUILDLINK_DEPENDS.SDL to the dependency pattern
#     for the version of SDL desired.
# (2) Include this Makefile fragment in the package Makefile,
# (3) Add ${BUILDLINK_DIR}/include to the front of the C preprocessor's header
#     search path, and
# (4) Add ${BUILDLINK_DIR}/lib to the front of the linker's library search
#     path.

.if !defined(SDL_BUILDLINK_MK)
SDL_BUILDLINK_MK=	# defined

BUILDLINK_DEPENDS.SDL?=	SDL>=1.2.0
DEPENDS+=		${BUILDLINK_DEPENDS.SDL}:../../devel/SDL

BUILDLINK_PREFIX.SDL=	${LOCALBASE}
BUILDLINK_FILES.SDL=	include/SDL/*
BUILDLINK_FILES.SDL+=	lib/libSDL.*
BUILDLINK_FILES.SDL+=	lib/libSDLmain.*

.include "../../mk/bsd.prefs.mk"

.if defined(SDL_USE_NAS)
.include "../../audio/nas/buildlink.mk
.endif
.include "../../audio/esound/buildlink.mk"
.include "../../devel/pth/buildlink.mk"
.include "../../graphics/Mesa/buildlink.mk"

BUILDLINK_TARGETS.SDL=		SDL-buildlink
BUILDLINK_TARGETS.SDL+=		SDL-buildlink-config-wrapper
BUILDLINK_TARGETS+=		${BUILDLINK_TARGETS.SDL}

BUILDLINK_CONFIG.SDL=		${LOCALBASE}/bin/sdl-config
BUILDLINK_CONFIG_WRAPPER.SDL=	${BUILDLINK_DIR}/bin/sdl-config

.if defined(USE_CONFIG_WRAPPER) && defined(GNU_CONFIGURE)
CONFIGURE_ENV+=		SDL_CONFIG="${BUILDLINK_CONFIG_WRAPPER.SDL}"
.endif

pre-configure: ${BUILDLINK_TARGETS.SDL}
SDL-buildlink: _BUILDLINK_USE
SDL-buildlink-config-wrapper: _BUILDLINK_CONFIG_WRAPPER_USE

.include "../../mk/bsd.buildlink.mk"

.endif	# SDL_BUILDLINK_MK
