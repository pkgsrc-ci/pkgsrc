# $NetBSD: buildlink3.mk,v 1.19 2015/04/25 14:23:06 tnn Exp $

BUILDLINK_TREE+=	OpenRM

.if !defined(OPENRM_BUILDLINK3_MK)
OPENRM_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.OpenRM+=	OpenRM>=1.5.1
BUILDLINK_ABI_DEPENDS.OpenRM+=	OpenRM>=1.5.2nb10
BUILDLINK_PKGSRCDIR.OpenRM?=	../../graphics/OpenRM

.include "../../graphics/MesaLib/buildlink3.mk"
.include "../../graphics/glu/buildlink3.mk"
.include "../../mk/jpeg.buildlink3.mk"
.include "../../x11/libXmu/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.endif # OPENRM_BUILDLINK3_MK

BUILDLINK_TREE+=	-OpenRM
