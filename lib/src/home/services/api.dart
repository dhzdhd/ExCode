import 'package:dio/dio.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/services/language.dart';

enum Languages {
  bash,
  brainfuck,
  clojure,
  cobol,
  coffeeScript,
  crystal,
  dart,
  typeScript,
  javaScript,
  basic,
  fSharp,
  cSharp,
  fsi,
  dragon,
  elixir,
  emacs,
  erlang,
  forth,
  freebasic,
  awk,
  gawk,
  c,
  cpp,
  d,
  fortran,
  go,
  golfScript,
  groovy,
  haskell,
  verilog,
  japt,
  java,
  julia,
  kotlin,
  lisp,
  llvm,
  lua,
  nasm,
  nasm64,
  nim,
  oCaml,
  matlab,
  osabie,
  pascal,
  perl,
  php,
  ponylang,
  prolog,
  powershell,
  python2,
  python,
  racket,
  raku,
  rockstar,
  r,
  ruby,
  rust,
  scala,
  smallTalk,
  sqlite3,
  swift,
  vlang,
  zig
}

class ApiHandler {
  static const _executeUrl = 'https://emkc.org/api/v2/piston/execute';
  static const _runtimeUrl = 'https://emkc.org/api/v2/piston/runtimes';
  static final Map<String, String> _langVersionMap = {};

  static Map<String, String> get langVersionMap => _langVersionMap;

  static Future<void> initRuntimeVersionData() async {
    final res = await dio.get(_runtimeUrl);
    for (var i in res.data) {
      _langVersionMap[i['language']] = i['version'];
    }
    print(_langVersionMap);
  }

  static Languages getLangFromName(String name) {
    return langMap[name]!.lang;
  }

  static String getNameFromLang(Languages lang) {
    return langMap.keys.firstWhere((element) => langMap[element]!.lang == lang);
  }

  static String sanitizeContent(String content) {
    return content.replaceAll('\u{00B7}', ' ');
  }

  static Future<Map<String, String>> executeCode(
      Languages lang, String content) async {
    late final Response<Map<String, dynamic>> res;
    final data = {
      'language': getNameFromLang(lang),
      'version': _langVersionMap[getNameFromLang(lang)],
      'files': [
        {'content': sanitizeContent(content)}
      ],
      'stdin': '',
      'args': ['1', '2', '3'],
      'compile_timeout': 10000,
      'run_timeout': 3000,
    };

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
