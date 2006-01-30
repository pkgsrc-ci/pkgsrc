# $NetBSD: buildlink3.mk,v 1.3 2006/01/30 09:25:09 adam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FFTW_BUILDLINK3_MK:=	${FFTW_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	fftw
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfftw}
BUILDLINK_PACKAGES+=	fftw

.if !empty(FFTW_BUILDLINK3_MK:M+)
BUILDLINK_DEPENDS.fftw+=	fftw>=3.0
BUILDLINK_RECOMMENDED.fftw+=	fftw>=3.0.1nb1
BUILDLINK_PKGSRCDIR.fftw?=	../../math/fftw
.endif	# FFTW_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
