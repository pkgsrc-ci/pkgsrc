$NetBSD: patch-extern_libmv_third__party_glog_src_config__netbsd.h,v 1.3 2014/07/09 20:01:08 ryoon Exp $

* config file for NetBSD

--- extern/libmv/third_party/glog/src/config_netbsd.h.orig	2014-07-09 12:42:15.000000000 +0000
+++ extern/libmv/third_party/glog/src/config_netbsd.h
@@ -0,0 +1,177 @@
+/* src/config.h.  Generated from config.h.in by configure.  */
+/* src/config.h.in.  Generated from configure.ac by autoheader.  */
+
+/* Namespace for Google classes */
+#define GOOGLE_NAMESPACE google
+
+/* Define if you have the `dladdr' function */
+/* #undef HAVE_DLADDR */
+
+/* Define to 1 if you have the <dlfcn.h> header file. */
+#define HAVE_DLFCN_H 1
+
+#include <sys/param.h>
+/* Define to 1 if you have the <execinfo.h> header file. */
+#if __NetBSD_Version__ > 699001500
+#define HAVE_EXECINFO_H 1
+#else
+#undef HAVE_EXECINFO_H
+#endif
+
+/* Define if you have the `fcntl' function */
+#define HAVE_FCNTL 1
+
+/* Define to 1 if you have the <glob.h> header file. */
+#define HAVE_GLOB_H 1
+
+/* Define to 1 if you have the <inttypes.h> header file. */
+#define HAVE_INTTYPES_H 1
+
+/* Define to 1 if you have the `pthread' library (-lpthread). */
+#define HAVE_LIBPTHREAD 1
+
+/* Define to 1 if you have the <libunwind.h> header file. */
+/* #undef HAVE_LIBUNWIND_H */
+
+/* define if you have google gflags library */
+#define HAVE_LIB_GFLAGS 1
+
+/* define if you have google gmock library */
+/* #undef HAVE_LIB_GMOCK */
+
+/* define if you have google gtest library */
+/* #undef HAVE_LIB_GTEST */
+
+/* define if you have libunwind */
+/* #undef HAVE_LIB_UNWIND */
+
+/* Define to 1 if you have the <memory.h> header file. */
+#define HAVE_MEMORY_H 1
+
+/* define if the compiler implements namespaces */
+#define HAVE_NAMESPACES 1
+
+/* Define if you have the 'pread' function */
+#define HAVE_PREAD 1
+
+/* Define if you have POSIX threads libraries and header files. */
+#define HAVE_PTHREAD 1
+
+/* Define to 1 if you have the <pwd.h> header file. */
+#define HAVE_PWD_H 1
+
+/* Define if you have the 'pwrite' function */
+#define HAVE_PWRITE 1
+
+/* define if the compiler implements pthread_rwlock_* */
+#define HAVE_RWLOCK 1
+
+/* Define if you have the `sigaltstack' function */
+#define HAVE_SIGALTSTACK 1
+
+/* Define to 1 if you have the <stdint.h> header file. */
+#define HAVE_STDINT_H 1
+
+/* Define to 1 if you have the <stdlib.h> header file. */
+#define HAVE_STDLIB_H 1
+
+/* Define to 1 if you have the <strings.h> header file. */
+#define HAVE_STRINGS_H 1
+
+/* Define to 1 if you have the <string.h> header file. */
+#define HAVE_STRING_H 1
+
+/* Define to 1 if you have the <syscall.h> header file. */
+/* #undef HAVE_SYSCALL_H */
+
+/* Define to 1 if you have the <syslog.h> header file. */
+#define HAVE_SYSLOG_H 1
+
+/* Define to 1 if you have the <sys/stat.h> header file. */
+#define HAVE_SYS_STAT_H 1
+
+/* Define to 1 if you have the <sys/syscall.h> header file. */
+#define HAVE_SYS_SYSCALL_H 1
+
+/* Define to 1 if you have the <sys/time.h> header file. */
+#define HAVE_SYS_TIME_H 1
+
+/* Define to 1 if you have the <sys/types.h> header file. */
+#define HAVE_SYS_TYPES_H 1
+
+/* Define to 1 if you have the <sys/ucontext.h> header file. */
+#define HAVE_SYS_UCONTEXT_H 1
+
+/* Define to 1 if you have the <sys/utsname.h> header file. */
+#define HAVE_SYS_UTSNAME_H 1
+
+/* Define to 1 if you have the <ucontext.h> header file. */
+#define HAVE_UCONTEXT_H 1
+
+/* Define to 1 if you have the <unistd.h> header file. */
+#define HAVE_UNISTD_H 1
+
+/* define if the compiler supports using expression for operator */
+#define HAVE_USING_OPERATOR 1
+
+/* define if your compiler has __attribute__ */
+#define HAVE___ATTRIBUTE__ 1
+
+/* define if your compiler has __builtin_expect */
+#define HAVE___BUILTIN_EXPECT 1
+
+/* define if your compiler has __sync_val_compare_and_swap */
+/* #undef HAVE___SYNC_VAL_COMPARE_AND_SWAP */
+
+/* Name of package */
+#define PACKAGE "glog"
+
+/* Define to the address where bug reports for this package should be sent. */
+#define PACKAGE_BUGREPORT "opensource@google.com"
+
+/* Define to the full name of this package. */
+#define PACKAGE_NAME "glog"
+
+/* Define to the full name and version of this package. */
+#define PACKAGE_STRING "glog 0.3.2"
+
+/* Define to the one symbol short name of this package. */
+#define PACKAGE_TARNAME "glog"
+
+/* Define to the version of this package. */
+#define PACKAGE_VERSION "0.3.2"
+
+/* How to access the PC from a struct ucontext */
+/* #define PC_FROM_UCONTEXT uc_mcontext.gregs[REG_RIP] */
+
+/* Define to necessary symbol if this constant uses a non-standard name on
+   your system. */
+/* #undef PTHREAD_CREATE_JOINABLE */
+
+/* The size of `void *', as computed by sizeof. */
+#define SIZEOF_VOID_P 8
+
+/* Define to 1 if you have the ANSI C header files. */
+/* #undef STDC_HEADERS */
+
+#define STDC_HEADERS 1
+/* the namespace where STL code like vector<> is defined */
+#define STL_NAMESPACE std
+
+/* location of source code */
+#define TEST_SRC_DIR "."
+
+/* Version number of package */
+#define VERSION "0.3.2"
+
+/* Stops putting the code inside the Google namespace */
+#define _END_GOOGLE_NAMESPACE_ }
+
+/* Puts following code inside the Google namespace */
+#define _START_GOOGLE_NAMESPACE_ namespace google {
+
+/* isn't getting defined by configure script when clang compilers are used
+   and cuases compilation errors in stactrace/unwind modules */
+#ifdef __clang__
+#  define NO_FRAME_POINTER
+#endif
