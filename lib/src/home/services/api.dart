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
  static final Map<String, String> langVersionMap = {};

  static Future<void> initRuntimeVersionData() async {
    final res = await dio.get(_runtimeUrl);
    for (var i in res.data) {
      langVersionMap[i['language']] = i['version'];
    }
  }

  static Map<String, dynamic> getDataFromLang(Languages lang) {
    switch (lang) {
      case Languages.coffeeScript:
        return {
          'language': 'coffeescript',
          'version': langVersionMap['coffeescript']
        };
      case Languages.nodeTS:
        return {
          'language': 'typescript',
          'version': langVersionMap['typescript']
        };
      case Languages.nodeJS:
        return {
          'language': 'javascript',
          'version': langVersionMap['javascript']
        };
      case Languages.basic:
        return {
          'language': 'basic.net',
          'version': langVersionMap['basic.net']
        };
      case Languages.cSharp:
        return {
          'language': 'csharp.net',
          'version': langVersionMap['csharp.net']
        };
      case Languages.fSharp:
        return {
          'language': 'fsharp.net',
          'version': langVersionMap['fsharp.net']
        };
      case Languages.cpp:
        return {'language': 'c++', 'version': langVersionMap['c++']};
      case Languages.golfScript:
        return {
          'language': 'golfscript',
          'version': langVersionMap['golfscript']
        };
      case Languages.oCaml:
        return {'language': 'ocaml', 'version': langVersionMap['ocaml']};
      default:
        return {'language': 'python', 'version': langVersionMap['python']};
    }
  }

  static String sanitizeContent(String content) {
    return content.replaceAll('.', ' ');
  }

  static Future<Map<String, String>> executeCode(
      Languages lang, String content) async {
    late final Response res;
    final data = {
      'language': lang.name,
      'version': langVersionMap.containsKey(lang.name)
          ? langVersionMap[lang.name]
          : '',
      'files': [
        {'content': sanitizeContent(content)}
      ],
      'stdin': '',
      'args': ['1', '2', '3'],
      'compile_timeout': 10000,
      'run_timeout': 3000,
    };
    if (!langVersionMap.containsKey(lang.name)) {
      data.addAll(getDataFromLang(lang));
    }

    try {
      res = await dio.post(_executeUrl, data: data);
    } on DioError catch (err) {
      print(err.message);
      return {'error': err.message};
    } catch (err) {
      print(err);
      return {'error': err.toString()};
    }

    print(res.data);

    if (res.data.contains('compile')) {
      return {'output': ''};
    }

    if (res.data['run']['stdout'].isEmpty) {
      res.data['run']['stdout'] = 'No output';
    }
    if (res.data['run']['stderr'].isEmpty) {
      res.data['run']['stderr'] = 'No errors';
    }

    return {
      'output': res.data['run']['stdout'],
      'err': res.data['run']['stderr'],
    };
  }
}
