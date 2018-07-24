$NetBSD: patch-airprint-scheduler_printers.c,v 1.1 2018/07/24 12:19:21 bouyer Exp $

From debian:
From 7147c814439aafb26ff0262a7d6b8ef56d20969f Mon Sep 17 00:00:00 2001
From: Till Kamppeter <till.kamppeter@gmail.com>
Date: Tue, 9 Aug 2016 18:11:04 +0200
Subject: For PWG Raster, add required IPP attributes

Add required by IPP Everywhere for PWG Raster when PWG Raster as input format
is supported

Bug-Upstream: https://www.cups.org/str.php?L4428
Last-Update: 2015-02-10
Patch-Name: pwg-raster-attributes.patch
---
 scheduler/printers.c | 77 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/scheduler/printers.c b/scheduler/printers.c
index bb99907ad..a0ebcbd3e 100644
--- scheduler/printers.c.orig
+++ scheduler/printers.c
@@ -2199,9 +2199,10 @@ cupsdSetPrinterAttrs(cupsd_printer_t *p)/* I - Printer to setup */
   cupsd_location_t *auth;		/* Pointer to authentication element */
   const char	*auth_supported;	/* Authentication supported */
   ipp_t		*oldattrs;		/* Old printer attributes */
-  ipp_attribute_t *attr;		/* Attribute data */
+  ipp_attribute_t *attr, *attr2;	/* Attribute data */
   char		*name,			/* Current user/group name */
 		*filter;		/* Current filter */
+  mime_type_t   *type;
 
 
   DEBUG_printf(("cupsdSetPrinterAttrs: entering name = %s, type = %x\n", p->name,
@@ -2538,6 +2539,80 @@ cupsdSetPrinterAttrs(cupsd_printer_t *p)/* I - Printer to setup */
   DEBUG_printf(("cupsdSetPrinterAttrs: leaving name = %s, type = %x\n", p->name,
                 p->type));
 
+  /* 
+   * Add "pwg-raster-document-xxx-supported" attributes if PWG Raster input
+   * is supported
+   */
+  for (type = (mime_type_t *)cupsArrayFirst(p->filetypes);
+       type;
+       type = (mime_type_t *)cupsArrayNext(p->filetypes))
+  {
+    if (!_cups_strcasecmp(type->super, "image"))
+    {
+      if (!_cups_strcasecmp(type->type, "pwg-raster"))
+      {
+	if (p->ppd_attrs != NULL &&
+	    (attr = ippFindAttribute(p->ppd_attrs,
+				     "printer-resolution-supported",
+				     IPP_TAG_ZERO)) != NULL)
+	{
+	  attr2 = ippAddResolutions(p->attrs, IPP_TAG_PRINTER,
+				    "pwg-raster-document-resolution-supported",
+				    attr->num_values, IPP_RES_PER_INCH,
+				    NULL, NULL);
+	  for (i = 0; i < attr->num_values; i ++)
+	  {
+	    attr2->values[i].resolution.xres =
+	      attr->values[i].resolution.xres;
+	    attr2->values[i].resolution.yres =
+	      attr->values[i].resolution.yres;
+	    attr2->values[i].resolution.units = IPP_RES_PER_INCH;
+	  }
+	}
+	else
+	{
+	  static const int	pwg_raster_document_resolution_supported[] =
+	  {
+	    300,
+	    600,
+	    1200
+	  };
+	  ippAddResolutions(p->attrs, IPP_TAG_PRINTER,
+			    "pwg-raster-document-resolution-supported",
+			    (int)(sizeof(pwg_raster_document_resolution_supported) /
+				  sizeof(pwg_raster_document_resolution_supported[0])),
+			    IPP_RES_PER_INCH,
+			    pwg_raster_document_resolution_supported,
+			    pwg_raster_document_resolution_supported);
+	}
+	ippAddString(p->attrs, IPP_TAG_PRINTER, IPP_TAG_KEYWORD,
+		     "pwg-raster-document-sheet-back", NULL, "normal");
+	static const char * const pwg_raster_document_type_supported[] =
+	{
+	  "adobergb-8",
+	  "adobergb-16",
+	  "black-1",
+	  "black-8",
+	  "black-16",
+	  "cmyk-8",
+	  "cmyk-16",
+	  "rgb-8",
+	  "rgb-16",
+	  "sgray-1",
+	  "sgray-8",
+	  "sgray-16",
+	  "srgb-8",
+	  "srgb-16"
+	};
+	ippAddStrings(p->attrs, IPP_TAG_PRINTER, IPP_TAG_KEYWORD,
+		      "pwg-raster-document-type-supported",
+		      (int)(sizeof(pwg_raster_document_type_supported) /
+			    sizeof(pwg_raster_document_type_supported[0])), NULL,
+		      pwg_raster_document_type_supported);
+      }
+    }
+  }
+
  /*
   * Add name-default attributes...
   */

From bbc3507a260d29db3fc5601826f33c10f9dccd1e Mon Sep 17 00:00:00 2001
From: Till Kamppeter <till.kamppeter@gmail.com>
Date: Tue, 9 Aug 2016 18:11:29 +0200
Subject: Patch to support Apple AirPrint (printing from iPhone, iPad, iPod
 Touch to a CUPS server)

Bug-Ubuntu: https://bugs.launchpad.net/bugs/711779
Bug-Ubuntu: https://bugs.launchpad.net/bugs/1054495
Bug-Debian: http://bugs.debian.org/700961
Bug: https://cups.org/str.php?L4341
Last-Update: 2015-02-10

Patch-Name: airprint-support.patch
---
 conf/mime.convs.in   | 3 +++
 conf/mime.types      | 3 +++
 scheduler/conf.c     | 2 +-
 scheduler/dirsvc.c   | 6 ++++++
 scheduler/printers.c | 4 +++-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/scheduler/printers.c b/scheduler/printers.c
index a0ebcbd3e..b5fe9e031 100644
--- scheduler/printers.c.orig
+++ scheduler/printers.c
@@ -3765,7 +3765,9 @@ add_printer_formats(cupsd_printer_t *p)	/* I - Printer */
       }
       else if (!_cups_strcasecmp(type->super, "image"))
       {
-        if (!_cups_strcasecmp(type->type, "jpeg"))
+        if (!_cups_strcasecmp(type->type, "urf"))
+	  strlcat(pdl, "image/urf,", sizeof(pdl));
+	else if (!_cups_strcasecmp(type->type, "jpeg"))
 	  strlcat(pdl, "image/jpeg,", sizeof(pdl));
 	else if (!_cups_strcasecmp(type->type, "png"))
 	  strlcat(pdl, "image/png,", sizeof(pdl));
