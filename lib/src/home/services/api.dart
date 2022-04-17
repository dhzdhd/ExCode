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

  static Future<void> initRuntimeVersionData() async {
    final res = await dio.get(_runtimeUrl);
    for (var i in res.data) {
      _langVersionMap[i['language']] = i['version'];
    }
  }

  static Map<String, dynamic> getDataFromLang(Languages lang) {
    switch (lang) {
      case Languages.coffeeScript:
        return {
          'language': 'coffeescript',
          'version': _langVersionMap['coffeescript']
        };
      case Languages.nodeTS:
        return {
          'language': 'typescript',
          'version': _langVersionMap['typescript']
        };
      case Languages.nodeJS:
        return {
          'language': 'javascript',
          'version': _langVersionMap['javascript']
        };
      case Languages.basic:
        return {
          'language': 'basic.net',
          'version': _langVersionMap['basic.net']
        };
      case Languages.cSharp:
        return {
          'language': 'csharp.net',
          'version': _langVersionMap['csharp.net']
        };
      case Languages.fSharp:
        return {
          'language': 'fsharp.net',
          'version': _langVersionMap['fsharp.net']
        };
      case Languages.cpp:
        return {'language': 'c++', 'version': _langVersionMap['c++']};
      case Languages.golfScript:
        return {
          'language': 'golfscript',
          'version': _langVersionMap['golfscript']
        };
      case Languages.oCaml:
        return {'language': 'ocaml', 'version': _langVersionMap['ocaml']};
      default:
        return {'language': 'python', 'version': _langVersionMap['python']};
    }
  }

  static String sanitizeContent(String content) {
    return content;
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
      res = await dio.post(_executeUrl, data: data);
    } on DioError catch (err) {
      print(err.message);
      return {'output': 'No output', 'err': err.message};
    } catch (err) {
      print(err);
      return {'output': 'No output', 'err': err.toString()};
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
