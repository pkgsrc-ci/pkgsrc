# $NetBSD: buildlink3.mk,v 1.2 2018/04/04 19:44:19 jaapb Exp $

BUILDLINK_TREE+=	ocaml-ppx_base

.if !defined(OCAML_PPX_BASE_BUILDLINK3_MK)
OCAML_PPX_BASE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ocaml-ppx_base+=	ocaml-ppx_base>=0.9.0
BUILDLINK_ABI_DEPENDS.ocaml-ppx_base+=	ocaml-ppx_base>=0.9.0nb2
BUILDLINK_PKGSRCDIR.ocaml-ppx_base?=	../../devel/ocaml-ppx_base
.endif	# OCAML_PPX_BASE_BUILDLINK3_MK

BUILDLINK_TREE+=	-ocaml-ppx_base
