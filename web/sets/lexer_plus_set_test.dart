library lexer_plus_set;

import "package:test/test.dart";
import "package:antlr4dart/antlr4dart.dart";
import '../test_error_listener.dart';

part '../grammars/lexer_plus_set_parser.dart';
part '../grammars/lexer_plus_set_lexer.dart';

main() {
  test("testLexerPlusSet", () {
    var csource = new StringSource("abaac");
    var lexer = new LexerPlusSetLexer(csource);
    var tsource = new CommonTokenSource(lexer);
    var parser = new LexerPlusSetParser(tsource);
    var errorListener = new TestErrorListener();
    parser.addErrorListener(errorListener);
    parser.a();
    expect(errorListener.errorMessages.isEmpty, isTrue);
    expect(parser.log, equals(["abaac"]));
  });
}
