$NetBSD: patch-src_libopts_proto.h,v 1.1 2014/08/30 12:45:11 adam Exp $

Avoid stdnoreturn.h.

--- src/libopts/proto.h.orig	2014-08-30 12:30:03.000000000 +0000
+++ src/libopts/proto.h
@@ -98,16 +98,16 @@ load_opt_line(tOptions * opts, tOptState
 /*
  *  Extracted from makeshell.c
  */
-static noreturn void
+static void
 option_exits(int exit_code);
 
-static noreturn void
+static void
 ao_bug(char const * msg);
 
 static void
 fserr_warn(char const * prog, char const * op, char const * fname);
 
-static noreturn void
+static void
 fserr_exit(char const * prog, char const * op, char const * fname);
 
 /*
