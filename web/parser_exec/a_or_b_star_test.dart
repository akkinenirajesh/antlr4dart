library a_or_b_star;

import "package:test/test.dart";
import "package:antlr4dart/antlr4dart.dart";
import '../test_error_listener.dart';

part "../grammars/a_or_b_star_parser.dart";
part "../grammars/a_or_b_star_lexer.dart";

main() {
  test("testAorBStar", () {
    var csource = new StringSource("a 34 c");
    var lexer = new AOrBStarLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new AOrBStarParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.a();
    expect(errorListener.errorMessages.isEmpty, isTrue);
    expect(parser.log, equals(["a34c"]));
  });
}
