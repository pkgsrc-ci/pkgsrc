# $NetBSD: buildlink3.mk,v 1.6 2004/09/21 16:54:06 jmmv Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
GNOME2_PIXMAPS_BUILDLINK3_MK:=	${GNOME2_PIXMAPS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gnome2-pixmaps
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngnome2-pixmaps}
BUILDLINK_PACKAGES+=	gnome2-pixmaps

.if !empty(GNOME2_PIXMAPS_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.gnome2-pixmaps+=	gnome2-pixmaps>=2.8.0
BUILDLINK_PKGSRCDIR.gnome2-pixmaps?=	../../graphics/gnome2-pixmaps
.endif	# GNOME2_PIXMAPS_BUILDLINK3_MK

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
