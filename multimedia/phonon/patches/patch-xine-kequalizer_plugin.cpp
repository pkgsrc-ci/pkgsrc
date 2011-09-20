$NetBSD: patch-xine-kequalizer_plugin.cpp,v 1.1 2011/09/20 16:50:54 joerg Exp $

--- xine/kequalizer_plugin.cpp.orig	2010-06-07 14:36:25.000000000 +0000
+++ xine/kequalizer_plugin.cpp
@@ -107,17 +107,17 @@ typedef struct
  */
 START_PARAM_DESCR(kequalizer_parameters_t)
 
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, preAmp, NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Equalizer pre-amp gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[0], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 1 60Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[1], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 2 170Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[2], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 3 310Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[3], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 4 600Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[4], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 5 1000Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[5], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 6 3000Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[6], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 7 6000Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[7], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 8 12000Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[8], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 9 14000Hz Gain"))
-PARAM_ITEM(POST_PARAM_TYPE_DOUBLE, eqBands[9], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 10 16000Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, preAmp, NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Equalizer pre-amp gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[0], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 1 60Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[1], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 2 170Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[2], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 3 310Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[3], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 4 600Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[4], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 5 1000Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[5], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 6 3000Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[6], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 7 6000Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[7], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 8 12000Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[8], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 9 14000Hz Gain"))
+PARAM_ITEM(kequalizer_parameters_t, POST_PARAM_TYPE_DOUBLE, eqBands[9], NULL, -KEQUALIZER_MAX_GAIN, KEQUALIZER_MAX_GAIN, 0, I18N_NOOP("Band 10 16000Hz Gain"))
 
 END_PARAM_DESCR(param_descr)
 
