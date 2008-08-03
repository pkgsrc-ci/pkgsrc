# $NetBSD: buildlink3.mk,v 1.8 2008/08/03 15:21:56 taca Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
DARTS_BUILDLINK3_MK:=	${DARTS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	darts
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndarts}
BUILDLINK_PACKAGES+=	darts
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}darts

.if !empty(DARTS_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.darts+=	darts>=0.32
BUILDLINK_PKGSRCDIR.darts?=	../../devel/darts
BUILDLINK_DEPMETHOD.darts?=	build
.endif	# DARTS_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
