library lexer_star_set;

import "package:test/test.dart";
import "package:antlr4dart/antlr4dart.dart";
import '../test_error_listener.dart';

part '../grammars/lexer_star_set_parser.dart';
part '../grammars/lexer_star_set_lexer.dart';

main() {
  test("testLexerStarSet", () {
    var csource = new StringSource("abaac");
    var lexer = new LexerStarSetLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new LexerStarSetParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.a();
    expect(errorListener.errorMessages.isEmpty, isTrue);
    expect(parser.log, equals(["abaac"]));
  });
}
