$NetBSD: patch-Source_WebCore_xml_XPathGrammar.y,v 1.1 2012/07/31 13:59:55 prlw1 Exp $

Fix for Bug 92264: Build fix with newer bison 2.6.
https://bugs.webkit.org/show_bug.cgi?id=92264

--- Source/WebCore/xml/XPathGrammar.y.orig	2012-04-22 23:27:00.000000000 +0000
+++ Source/WebCore/xml/XPathGrammar.y
@@ -34,6 +34,7 @@
 #include "XPathParser.h"
 #include "XPathPath.h"
 #include "XPathPredicate.h"
+#include "XPathStep.h"
 #include "XPathVariableReference.h"
 #include <wtf/FastMalloc.h>
 
@@ -44,8 +45,6 @@
 #define YYLTYPE_IS_TRIVIAL 1
 #define YYDEBUG 0
 #define YYMAXDEPTH 10000
-#define YYPARSE_PARAM parserParameter
-#define PARSER static_cast<Parser*>(parserParameter)
 
 using namespace WebCore;
 using namespace XPath;
@@ -53,6 +52,7 @@ using namespace XPath;
 %}
 
 %pure_parser
+%parse-param { WebCore::XPath::Parser* parser }
 
 %union
 {
@@ -71,7 +71,7 @@ using namespace XPath;
 %{
 
 static int xpathyylex(YYSTYPE* yylval) { return Parser::current()->lex(yylval); }
-static void xpathyyerror(const char*) { }
+static void xpathyyerror(void*, const char*) { }
     
 %}
 
@@ -118,7 +118,7 @@ static void xpathyyerror(const char*) { 
 Expr:
     OrExpr
     {
-        PARSER->m_topExpr = $1;
+        parser->m_topExpr = $1;
     }
     ;
 
@@ -138,7 +138,7 @@ AbsoluteLocationPath:
     '/'
     {
         $$ = new LocationPath;
-        PARSER->registerParseNode($$);
+        parser->registerParseNode($$);
     }
     |
     '/' RelativeLocationPath
@@ -150,7 +150,7 @@ AbsoluteLocationPath:
     {
         $$ = $2;
         $$->insertFirstStep($1);
-        PARSER->unregisterParseNode($1);
+        parser->unregisterParseNode($1);
     }
     ;
 
@@ -159,22 +159,22 @@ RelativeLocationPath:
     {
         $$ = new LocationPath;
         $$->appendStep($1);
-        PARSER->unregisterParseNode($1);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->registerParseNode($$);
     }
     |
     RelativeLocationPath '/' Step
     {
         $$->appendStep($3);
-        PARSER->unregisterParseNode($3);
+        parser->unregisterParseNode($3);
     }
     |
     RelativeLocationPath DescendantOrSelf Step
     {
         $$->appendStep($2);
         $$->appendStep($3);
-        PARSER->unregisterParseNode($2);
-        PARSER->unregisterParseNode($3);
+        parser->unregisterParseNode($2);
+        parser->unregisterParseNode($3);
     }
     ;
 
@@ -183,58 +183,58 @@ Step:
     {
         if ($2) {
             $$ = new Step(Step::ChildAxis, *$1, *$2);
-            PARSER->deletePredicateVector($2);
+            parser->deletePredicateVector($2);
         } else
             $$ = new Step(Step::ChildAxis, *$1);
-        PARSER->deleteNodeTest($1);
-        PARSER->registerParseNode($$);
+        parser->deleteNodeTest($1);
+        parser->registerParseNode($$);
     }
     |
     NAMETEST OptionalPredicateList
     {
         String localName;
         String namespaceURI;
-        if (!PARSER->expandQName(*$1, localName, namespaceURI)) {
-            PARSER->m_gotNamespaceError = true;
+        if (!parser->expandQName(*$1, localName, namespaceURI)) {
+            parser->m_gotNamespaceError = true;
             YYABORT;
         }
         
         if ($2) {
             $$ = new Step(Step::ChildAxis, Step::NodeTest(Step::NodeTest::NameTest, localName, namespaceURI), *$2);
-            PARSER->deletePredicateVector($2);
+            parser->deletePredicateVector($2);
         } else
             $$ = new Step(Step::ChildAxis, Step::NodeTest(Step::NodeTest::NameTest, localName, namespaceURI));
-        PARSER->deleteString($1);
-        PARSER->registerParseNode($$);
+        parser->deleteString($1);
+        parser->registerParseNode($$);
     }
     |
     AxisSpecifier NodeTest OptionalPredicateList
     {
         if ($3) {
             $$ = new Step($1, *$2, *$3);
-            PARSER->deletePredicateVector($3);
+            parser->deletePredicateVector($3);
         } else
             $$ = new Step($1, *$2);
-        PARSER->deleteNodeTest($2);
-        PARSER->registerParseNode($$);
+        parser->deleteNodeTest($2);
+        parser->registerParseNode($$);
     }
     |
     AxisSpecifier NAMETEST OptionalPredicateList
     {
         String localName;
         String namespaceURI;
-        if (!PARSER->expandQName(*$2, localName, namespaceURI)) {
-            PARSER->m_gotNamespaceError = true;
+        if (!parser->expandQName(*$2, localName, namespaceURI)) {
+            parser->m_gotNamespaceError = true;
             YYABORT;
         }
 
         if ($3) {
             $$ = new Step($1, Step::NodeTest(Step::NodeTest::NameTest, localName, namespaceURI), *$3);
-            PARSER->deletePredicateVector($3);
+            parser->deletePredicateVector($3);
         } else
             $$ = new Step($1, Step::NodeTest(Step::NodeTest::NameTest, localName, namespaceURI));
-        PARSER->deleteString($2);
-        PARSER->registerParseNode($$);
+        parser->deleteString($2);
+        parser->registerParseNode($$);
     }
     |
     AbbreviatedStep
@@ -259,23 +259,23 @@ NodeTest:
         else if (*$1 == "comment")
             $$ = new Step::NodeTest(Step::NodeTest::CommentNodeTest);
 
-        PARSER->deleteString($1);
-        PARSER->registerNodeTest($$);
+        parser->deleteString($1);
+        parser->registerNodeTest($$);
     }
     |
     PI '(' ')'
     {
         $$ = new Step::NodeTest(Step::NodeTest::ProcessingInstructionNodeTest);
-        PARSER->deleteString($1);        
-        PARSER->registerNodeTest($$);
+        parser->deleteString($1);
+        parser->registerNodeTest($$);
     }
     |
     PI '(' LITERAL ')'
     {
         $$ = new Step::NodeTest(Step::NodeTest::ProcessingInstructionNodeTest, $3->stripWhiteSpace());
-        PARSER->deleteString($1);        
-        PARSER->deleteString($3);
-        PARSER->registerNodeTest($$);
+        parser->deleteString($1);
+        parser->deleteString($3);
+        parser->registerNodeTest($$);
     }
     ;
 
@@ -293,14 +293,14 @@ PredicateList:
     {
         $$ = new Vector<Predicate*>;
         $$->append(new Predicate($1));
-        PARSER->unregisterParseNode($1);
-        PARSER->registerPredicateVector($$);
+        parser->unregisterParseNode($1);
+        parser->registerPredicateVector($$);
     }
     |
     PredicateList Predicate
     {
         $$->append(new Predicate($2));
-        PARSER->unregisterParseNode($2);
+        parser->unregisterParseNode($2);
     }
     ;
 
@@ -315,7 +315,7 @@ DescendantOrSelf:
     SLASHSLASH
     {
         $$ = new Step(Step::DescendantOrSelfAxis, Step::NodeTest(Step::NodeTest::AnyNodeTest));
-        PARSER->registerParseNode($$);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -323,13 +323,13 @@ AbbreviatedStep:
     '.'
     {
         $$ = new Step(Step::SelfAxis, Step::NodeTest(Step::NodeTest::AnyNodeTest));
-        PARSER->registerParseNode($$);
+        parser->registerParseNode($$);
     }
     |
     DOTDOT
     {
         $$ = new Step(Step::ParentAxis, Step::NodeTest(Step::NodeTest::AnyNodeTest));
-        PARSER->registerParseNode($$);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -337,8 +337,8 @@ PrimaryExpr:
     VARIABLEREFERENCE
     {
         $$ = new VariableReference(*$1);
-        PARSER->deleteString($1);
-        PARSER->registerParseNode($$);
+        parser->deleteString($1);
+        parser->registerParseNode($$);
     }
     |
     '(' Expr ')'
@@ -349,15 +349,15 @@ PrimaryExpr:
     LITERAL
     {
         $$ = new StringExpression(*$1);
-        PARSER->deleteString($1);
-        PARSER->registerParseNode($$);
+        parser->deleteString($1);
+        parser->registerParseNode($$);
     }
     |
     NUMBER
     {
         $$ = new Number($1->toDouble());
-        PARSER->deleteString($1);
-        PARSER->registerParseNode($$);
+        parser->deleteString($1);
+        parser->registerParseNode($$);
     }
     |
     FunctionCall
@@ -369,8 +369,8 @@ FunctionCall:
         $$ = createFunction(*$1);
         if (!$$)
             YYABORT;
-        PARSER->deleteString($1);
-        PARSER->registerParseNode($$);
+        parser->deleteString($1);
+        parser->registerParseNode($$);
     }
     |
     FUNCTIONNAME '(' ArgumentList ')'
@@ -378,9 +378,9 @@ FunctionCall:
         $$ = createFunction(*$1, *$3);
         if (!$$)
             YYABORT;
-        PARSER->deleteString($1);
-        PARSER->deleteExpressionVector($3);
-        PARSER->registerParseNode($$);
+        parser->deleteString($1);
+        parser->deleteExpressionVector($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -389,14 +389,14 @@ ArgumentList:
     {
         $$ = new Vector<Expression*>;
         $$->append($1);
-        PARSER->unregisterParseNode($1);
-        PARSER->registerExpressionVector($$);
+        parser->unregisterParseNode($1);
+        parser->registerExpressionVector($$);
     }
     |
     ArgumentList ',' Argument
     {
         $$->append($3);
-        PARSER->unregisterParseNode($3);
+        parser->unregisterParseNode($3);
     }
     ;
 
@@ -412,9 +412,9 @@ UnionExpr:
         $$ = new Union;
         $$->addSubExpression($1);
         $$->addSubExpression($3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -430,9 +430,9 @@ PathExpr:
     {
         $3->setAbsolute(true);
         $$ = new Path(static_cast<Filter*>($1), $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     |
     FilterExpr DescendantOrSelf RelativeLocationPath
@@ -440,10 +440,10 @@ PathExpr:
         $3->insertFirstStep($2);
         $3->setAbsolute(true);
         $$ = new Path(static_cast<Filter*>($1), $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($2);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($2);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -453,9 +453,9 @@ FilterExpr:
     PrimaryExpr PredicateList
     {
         $$ = new Filter($1, *$2);
-        PARSER->unregisterParseNode($1);
-        PARSER->deletePredicateVector($2);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->deletePredicateVector($2);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -465,9 +465,9 @@ OrExpr:
     OrExpr OR AndExpr
     {
         $$ = new LogicalOp(LogicalOp::OP_Or, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -477,9 +477,9 @@ AndExpr:
     AndExpr AND EqualityExpr
     {
         $$ = new LogicalOp(LogicalOp::OP_And, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -489,9 +489,9 @@ EqualityExpr:
     EqualityExpr EQOP RelationalExpr
     {
         $$ = new EqTestOp($2, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -501,9 +501,9 @@ RelationalExpr:
     RelationalExpr RELOP AdditiveExpr
     {
         $$ = new EqTestOp($2, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -513,17 +513,17 @@ AdditiveExpr:
     AdditiveExpr PLUS MultiplicativeExpr
     {
         $$ = new NumericOp(NumericOp::OP_Add, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     |
     AdditiveExpr MINUS MultiplicativeExpr
     {
         $$ = new NumericOp(NumericOp::OP_Sub, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -533,9 +533,9 @@ MultiplicativeExpr:
     MultiplicativeExpr MULOP UnaryExpr
     {
         $$ = new NumericOp($2, $1, $3);
-        PARSER->unregisterParseNode($1);
-        PARSER->unregisterParseNode($3);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($1);
+        parser->unregisterParseNode($3);
+        parser->registerParseNode($$);
     }
     ;
 
@@ -546,8 +546,8 @@ UnaryExpr:
     {
         $$ = new Negative;
         $$->addSubExpression($2);
-        PARSER->unregisterParseNode($2);
-        PARSER->registerParseNode($$);
+        parser->unregisterParseNode($2);
+        parser->registerParseNode($$);
     }
     ;
 
