library atn_interpreter_test;

import "package:unittest/unittest.dart";
import "package:antlr4dart/antlr4dart.dart";

part '../grammars/simple_no_block_lexer.dart';
part '../grammars/simple_no_block_parser.dart';
part '../grammars/set_parser.dart';
part '../grammars/peg_achilles_heel.dart';
part '../grammars/must_track_previous1.dart';
part '../grammars/must_track_previous2.dart';
part '../grammars/must_track_previous3.dart';
part '../grammars/must_track_previous4.dart';
part '../grammars/must_track_previous5.dart';
part '../grammars/ambig_alt_choose1.dart';
part '../grammars/ambig_alt_choose2.dart';
part '../grammars/ambig_alt_choose3.dart';
part '../grammars/ambig_alt_choose4.dart';
part '../grammars/ambig_alt_choose5.dart';
part '../grammars/must_track_previous_lexer.dart';
part '../grammars/simple_loop.dart';
part '../grammars/common_left.dart';
part '../grammars/arbitrary_left.dart';
part '../grammars/recursive_left_lexer.dart';
part '../grammars/recursive_left_parser.dart';

main() {
  test("testSimpleNoBlock", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new SimpleNoBlockParser(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
  });

  test("testSet", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new SetParser(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "b"), equals(1));
  });

  test("testPEGAchillesHeel", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new PEGAchillesHeel(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(2));
  });

  test("testMustTrackPreviousGoodAlt", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new PEGAchillesHeel(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ac"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(2));
  });

  test("testMustTrackPreviousGoodAltWithEOF", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new MustTrackPrevious1(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(2));
    try {
      _getMatchedAlt(lexerBuilder, parserBuilder, "a");
    } on NoViableAltException catch (re) {
      expect(re.offendingToken.tokenIndex, equals(1));
      expect(re.offendingToken.type, equals(3));
    }
  });

  test("testMustTrackPreviousGoodAlt2", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new MustTrackPrevious2(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(3));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ad"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abd"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abcd"), equals(3));
  });

  test("testMustTrackPreviousGoodAlt2WithEOF", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new MustTrackPrevious3(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(3));
    try {
      _getMatchedAlt(lexerBuilder, parserBuilder, "abd");
    } on NoViableAltException catch (re) {
      expect(re.offendingToken.tokenIndex, equals(2));
      expect(re.offendingToken.type, equals(4));
    }
  });

  test("testMustTrackPreviousGoodAlt3", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new MustTrackPrevious4(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(3));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ad"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abd"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abcd"), equals(3));
  });

  test("testMustTrackPreviousGoodAlt3WithEOF", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new MustTrackPrevious5(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "a"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(3));
    try {
      _getMatchedAlt(lexerBuilder, parserBuilder, "abd");
    } on NoViableAltException catch (re) {
      expect(re.offendingToken.tokenIndex, equals(2));
      expect(re.offendingToken.type, equals(4));
    }
  });

  test("testAmbigAltChooseFirst", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new AmbigAltChoose1(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(1));
  });

  test("testAmbigAltChooseFirstWithFollowingToken", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new AmbigAltChoose2(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abcd"), equals(1));
  });

  test("testAmbigAltChooseFirstWithFollowingToken2", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new AmbigAltChoose3(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abd"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abdc"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "cd"), equals(3));
  });

  test("testAmbigAltChooseFirst2", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new AmbigAltChoose4(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(3));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abd"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abcd"), equals(3));
  });

  test("testAmbigAltChooseFirst2WithEOF", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new AmbigAltChoose5(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "abc"), equals(3));
    try {
      _getMatchedAlt(lexerBuilder, parserBuilder, "abd");
    } on NoViableAltException catch (re) {
      expect(re.offendingToken.tokenIndex, equals(2));
      expect(re.offendingToken.type, equals(4));
    }
  });

  test("testSimpleLoop", () {
    LexerBuilder lexerBuilder = (source) => new MustTrackPreviousLexer(source);
    ParserBuilder parserBuilder = (tSource) => new SimpleLoop(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "aab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "aaaaaab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "aabd"), equals(1));
  });

  test("testCommonLeftPrefix", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new CommonLeft(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ab"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "ac"), equals(2));
  });

  test("testArbitraryLeftPrefix", () {
    LexerBuilder lexerBuilder = (source) => new SimpleNoBlockLexer(source);
    ParserBuilder parserBuilder = (tSource) => new ArbitraryLeft(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "aac"), equals(2));
  });

  test("testRecursiveLeftPrefix", () {
    LexerBuilder lexerBuilder = (source) => new RecursiveLeftLexer(source);
    ParserBuilder parserBuilder = (tSource) => new RecursiveLeftParser(tSource);
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "34b"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "34c"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "(34)b"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "(34)c"), equals(2));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "((34))b"), equals(1));
    expect(_getMatchedAlt(lexerBuilder, parserBuilder, "((34))c"), equals(2));
  });
}

typedef Lexer LexerBuilder(StringSource source);
typedef Parser ParserBuilder(CommonTokenSource tSource);

int _getMatchedAlt(LexerBuilder lexerBuilder,
                  ParserBuilder parserBuider,
                  String input) {
  StringSource source = new StringSource(input);
  Lexer lexer = lexerBuilder(source);
  var tSource = new CommonTokenSource(lexer);
  Parser parser = parserBuider(tSource);
  List<int> types = _getTokenTypesViaAtn(lexer.input, lexer.interpreter, lexer.DEFAULT_MODE);
  Atn atn = parser.atn;
  _IntTokenSource inputSource = new _IntTokenSource(types);
  ParserAtnSimulator interp = parser.interpreter;
  AtnState startState = atn.ruleToStartState[parser.ruleNames.indexOf("a")];
  if (startState.transition(0).target is BlockStartState ) {
    startState = startState.transition(0).target;
  }
  return _matchAtn(parser, inputSource, startState);
}

List<int> _getTokenTypesViaAtn(source, LexerAtnSimulator lexInterp, mode) {
  List tokenTypes = new List();
  int ttype;
  do {
    ttype = lexInterp.match(source, mode);
    tokenTypes.add(ttype);
  } while (ttype != Token.EOF);
  return tokenTypes;
}

int _matchAtn(Parser parser,
             TokenSource input,
             AtnState startState) {
  if (startState.numberOfTransitions == 1) {
    return 1;
  } else if (startState is DecisionState) {
    return parser.interpreter.adaptivePredict(input, startState.decision, null);
  } else if (startState.numberOfTransitions > 0) {
    return 1;
  } else {
    return -1;
  }
}

class _IntTokenSource implements TokenSource {
  List types;
  int p = 0;
  _IntTokenSource(this.types);

  void consume() { p++; }

  int lookAhead(int i) => lookToken(i).type;

  int get mark => index;

  int get index => p;

  void release(int marker) {
    seek(marker);
  }

  void seek(int index) {
    p = index;
  }

  int get length => types.length;

  String get sourceName => null;

  Token lookToken(int i) {
    CommonToken t;
    int rawIndex = p + i - 1;
    if (rawIndex >= types.length ) t = new CommonToken.ofType(Token.EOF);
    else t = new CommonToken.ofType(types[rawIndex]);
    t.tokenIndex = rawIndex;
    return t;
  }

  Token get(int i) {
    return new CommonToken.ofType(types[i]);
  }

  TokenProvider get tokenProvider => null;

  String get text {
    throw new UnsupportedError("can't give strings");
  }

  String getText(_, __) {
    throw new UnsupportedError("can't give strings");
  }

  String getTextIn(_) {
    throw new UnsupportedError("can't give strings");
  }
}