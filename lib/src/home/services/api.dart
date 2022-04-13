import 'package:dio/dio.dart';
import 'package:excode/src/factory.dart';

enum Languages {
  bash,
  brainfuck,
  cjam,
  clojure,
  cobol,
  coffeeScript,
  cow,
  crystal,
  dart,
  dash,
  denoTS,
  nodeTS,
  denoJS,
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
  static const _url = 'https://emkc.org/api/v2/piston/execute';

  static Map<String, dynamic> getDataFromLang(Languages lang) {
    switch (lang) {
      case Languages.python:
        return {'version': '3.10.0'};
      default:
        return {};
    }
  }

  static Future<Map<String, String>> executeCode(Languages lang) async {
    late final Response res;

    try {
      res = await dio.post(_url, data: {
        'language': lang.name,
        ...getDataFromLang(lang),
        'files': [
          {'content': 'print("HELLO")'}
        ],
        'stdin': '',
        'args': ['1', '2', '3'],
        'compile_timeout': 10000,
        'run_timeout': 3000,
      });
    } on DioError catch (err) {
      print(err.message);
      return {'error': err.message};
    }

    print(res.data);

    return {
      'output': res.data['run']['output'],
      'err': res.data['run']['stderr']
    };
  }
}
