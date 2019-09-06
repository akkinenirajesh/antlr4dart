library if_then_else;

import "package:test/test.dart";
import "package:antlr4dart/antlr4dart.dart";
import '../test_error_listener.dart';

part '../grammars/if_then_else_parser.dart';
part '../grammars/if_then_else_lexer.dart';

main() {
  test("testFullContextIF_THEN_ELSEParse1", () {
    var csource = new StringSource("{ if x then return }");
    var lexer = new IfThenElseLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new IfThenElseParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    expect(errorListener.errorMessages.isEmpty, isTrue);
  });

  test("testFullContextIF_THEN_ELSEParse2", () {
    var csource = new StringSource("{ if x then return else foo }");
    var lexer = new IfThenElseLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new IfThenElseParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    var expectedMsgs = [
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportContextSensitivity d=1 (stat), input='else'"
    ];
    expect(errorListener.errorMessages, equals(expectedMsgs));
  });

  test("testFullContextIF_THEN_ELSEParse3", () {
    var csource = new StringSource("{ if x then if y then return else foo }");
    var lexer = new IfThenElseLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new IfThenElseParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    var expectedMsgs = [
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportAmbiguity d=1 (stat): ambigAlts={1, 2}, input='elsefoo}'"
    ];
    expect(errorListener.errorMessages, equals(expectedMsgs));
  });

  test("testFullContextIF_THEN_ELSEParse4", () {
    var csource = new StringSource("{ if x then if y then return else foo else bar }");
    var lexer = new IfThenElseLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new IfThenElseParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    var expectedMsgs = [
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportContextSensitivity d=1 (stat), input='elsefooelse'",
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportContextSensitivity d=1 (stat), input='else'"
    ];
    expect(errorListener.errorMessages, equals(expectedMsgs));
  });

  test("testFullContextIF_THEN_ELSEParse5", () {
    var csource = new StringSource("{ if x then return else foo\n"
        "if x then if y then return else foo }");
    var lexer = new IfThenElseLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new IfThenElseParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    var expectedMsgs = [
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportContextSensitivity d=1 (stat), input='else'",
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportAmbiguity d=1 (stat): ambigAlts={1, 2}, input='elsefoo}'"
    ];
    expect(errorListener.errorMessages, equals(expectedMsgs));
  });

  test("testFullContextIF_THEN_ELSEParse6", () {
    var csource = new StringSource("{ if x then return else foo\n" +
        "if x then if y then return else foo }");
    var lexer = new IfThenElseLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new IfThenElseParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    var expectedMsgs = [
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportContextSensitivity d=1 (stat), input='else'",
      "reportAttemptingFullContext d=1 (stat), input='else'",
      "reportAmbiguity d=1 (stat): ambigAlts={1, 2}, input='elsefoo}'"
    ];
    expect(errorListener.errorMessages, equals(expectedMsgs));
  });
}
