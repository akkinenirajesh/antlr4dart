library sll_sees_eof_in_ll;

import "package:test/test.dart";
import "package:antlr4dart/antlr4dart.dart";
import '../test_error_listener.dart';

part '../grammars/sll_sees_eof_in_ll_parser.dart';
part '../grammars/sll_sees_eof_in_ll_lexer.dart';

main() {
  test("testSLLSeesEOFInLLGrammar", () {
    var csource = new StringSource("34 abc");
    var lexer = new SLLSeesEOFInLLLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new SLLSeesEOFInLLParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    var expectedMsgs = [
      "reportAttemptingFullContext d=0 (e), input='34abc'",
      "reportContextSensitivity d=0 (e), input='34'"
    ];
    expect(errorListener.errorMessages, equals(expectedMsgs));
  });
}
