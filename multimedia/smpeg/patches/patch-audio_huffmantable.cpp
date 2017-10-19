$NetBSD: patch-audio_huffmantable.cpp,v 1.1 2017/10/19 15:59:22 jperkin Exp $

Fix build with GCC >= 6.

--- audio/huffmantable.cpp.orig	1999-08-26 04:37:52.000000000 +0000
+++ audio/huffmantable.cpp
@@ -9,6 +9,7 @@
 #include "config.h"
 #endif
 
+#include <climits>
 #include "MPEGaudio.h"
 
 static const unsigned int
@@ -550,11 +551,11 @@ htd33[ 31][2]={{ 16,  1},{  8,  1},{  4,
 
 const HUFFMANCODETABLE MPEGaudio::ht[HTN]=
 {
-  { 0, 0-1, 0-1, 0,  0, htd33},
+  { 0, UINT_MAX, UINT_MAX, 0,  0, htd33},
   { 1, 2-1, 2-1, 0,  7,htd01},
   { 2, 3-1, 3-1, 0, 17,htd02},
   { 3, 3-1, 3-1, 0, 17,htd03},
-  { 4, 0-1, 0-1, 0,  0, htd33},
+  { 4, UINT_MAX, UINT_MAX, 0,  0, htd33},
   { 5, 4-1, 4-1, 0, 31,htd05},
   { 6, 4-1, 4-1, 0, 31,htd06},
   { 7, 6-1, 6-1, 0, 71,htd07},
@@ -564,7 +565,7 @@ const HUFFMANCODETABLE MPEGaudio::ht[HTN
   {11, 8-1, 8-1, 0,127,htd11},
   {12, 8-1, 8-1, 0,127,htd12},
   {13,16-1,16-1, 0,511,htd13},
-  {14, 0-1, 0-1, 0,  0, htd33},
+  {14, UINT_MAX, UINT_MAX, 0,  0, htd33},
   {15,16-1,16-1, 0,511,htd15},
   {16,16-1,16-1, 1,511,htd16},
   {17,16-1,16-1, 2,511,htd16},
