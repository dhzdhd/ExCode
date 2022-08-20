import 'package:dio/dio.dart';
import 'package:excode/src/factory.dart';

enum Languages {
  bash,
  brainfuck,
  clojure,
  cobol,
  coffeeScript,
  cow,
  crystal,
  dart,
  dash,
  nodeTS,
  nodeJS,
  basic,
  fSharp,
  cSharp,
  fsi,
  dragon,
  elixir,
  emacs,
  erlang,
  file,
  forte,
  freebasic,
  awk,
  c,
  cpp,
  d,
  fortran,
  go,
  golfScript,
  groovy,
  haskell,
  husk,
  iverilog,
  japt,
  java,
  jelly,
  julia,
  kotlin,
  lisp,
  llvm_ir,
  lolcode,
  lua,
  nasm,
  nasm64,
  nim,
  oCaml,
  octave,
  osabie,
  paradoc,
  pascal,
  perl,
  php,
  ponylang,
  prolog,
  pure,
  powershell,
  pyth,
  python2,
  python,
  raku,
  rockstar,
  rscript,
  ruby,
  rust,
  scala,
  sqlite3,
  swift,
  vlang,
  vyxal,
  yeethon,
  zig
}

class ApiHandler {
  static const _executeUrl = 'https://emkc.org/api/v2/piston/execute';
  static const _runtimeUrl = 'https://emkc.org/api/v2/piston/runtimes';
  static final Map<String, String> _langVersionMap = {};
  static final _languageMap = {
    ...Map.fromIterables(
        Languages.values, Languages.values.map((e) => e.name.toLowerCase())),
    Languages.coffeeScript: 'coffeescript',
    Languages.nodeTS: 'typescript',
    Languages.nodeJS: 'javascript',
    Languages.basic: 'basic.net',
    Languages.cSharp: 'csharp.net',
    Languages.fSharp: 'fsharp.net',
    Languages.cpp: 'c++',
    Languages.golfScript: 'golfscript',
    Languages.oCaml: 'ocaml',
  };

  static Future<void> initRuntimeVersionData() async {
    final res = await dio.get(_runtimeUrl);
    for (var i in res.data) {
      _langVersionMap[i['language']] = i['version'];
    }
  }

  static Languages getLangFromName(String name) {
    return _languageMap.keys
        .firstWhere((element) => _languageMap[element] == name);
  }

  static String getNameFromLang(Languages lang) {
    return _languageMap[lang]!;
  }

  static Map<String, dynamic> getDataFromLang(Languages lang) {
    return {
      'language': _languageMap[lang],
      'version': _langVersionMap[_languageMap[lang]]
    };
  }

  static String sanitizeContent(String content) {
    return content.replaceAll('\u{00B7}', ' ');
  }

  static Future<Map<String, String>> executeCode(
      Languages lang, String content) async {
    late final Response<Map<String, dynamic>> res;
    final data = {
      'language': lang.name,
      'version': _langVersionMap.containsKey(lang.name)
          ? _langVersionMap[lang.name]
          : '',
      'files': [
        {'content': sanitizeContent(content)}
      ],
      'stdin': '',
      'args': ['1', '2', '3'],
      'compile_timeout': 10000,
      'run_timeout': 3000,
    };

    if (!_langVersionMap.containsKey(lang.name)) {
      data.addAll(getDataFromLang(lang));
    }

    try {
      print(data);
      res = await dio.post(_executeUrl, data: data);
    } on DioError catch (err) {
      return {'output': 'No output', 'err': err.message};
    }

    print(res.data);

    if (res.data!['run']['stdout'].isEmpty) {
      res.data!['run']['stdout'] = 'No output';
    }
    if (res.data!['run']['stderr'].isEmpty) {
      res.data!['run']['stderr'] = 'No errors';
    }

    if (res.data!.containsKey('compile')) {
      if (res.data!['compile']['stdout'].isEmpty &&
          res.data!['compile']['stderr'].isEmpty) {
        return {
          'output': res.data!['run']['stdout'],
          'err': res.data!['run']['stderr'],
        };
      } else {
        if (res.data!['compile']['stdout'].isEmpty) {
          res.data!['compile']['stdout'] = 'No output';
        }
        if (res.data!['compile']['stderr'].isEmpty) {
          res.data!['compile']['stderr'] = 'No errors';
        }
        return {
          'output': res.data!['compile']['stdout'],
          'err': res.data!['compile']['stderr'],
        };
      }
    }

    return {
      'output': res.data!['run']['stdout'],
      'err': res.data!['run']['stderr'],
    };
  }
}
