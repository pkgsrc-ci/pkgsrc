# $NetBSD: buildlink3.mk,v 1.2 2004/02/09 23:56:32 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBLZO_BUILDLINK3_MK:=	${LIBLZO_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	liblzo
.endif

.if !empty(LIBLZO_BUILDLINK3_MK:M+)
BUILDLINK_PACKAGES+=		liblzo
BUILDLINK_DEPENDS.liblzo+=	liblzo>=1.08
BUILDLINK_PKGSRCDIR.liblzo?=	../../archivers/liblzo
.endif # LIBLZO_BUILDLINK3_MK

BUILDLINK_DEPTH:=     ${BUILDLINK_DEPTH:S/+$//}
