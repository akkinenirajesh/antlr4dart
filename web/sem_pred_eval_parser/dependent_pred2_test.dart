library dependent_pred2;

import "package:test/test.dart";
import "package:antlr4dart/antlr4dart.dart";
import '../test_error_listener.dart';

part "../grammars/dependent_pred2_parser.dart";
part "../grammars/dependent_pred2_lexer.dart";

main() {
  test("testDependentPredsInGlobalFOLLOW", () {
    var csource = new StringSource("a!");
    var lexer = new DependentPred2Lexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new DependentPred2Parser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.s();
    expect(errorListener.errorMessages.isEmpty, isTrue);
    expect(parser.log, ["eval=true", "parse"]);
  });
}
