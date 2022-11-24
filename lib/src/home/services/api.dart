import 'package:dio/dio.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/output_model.dart';
import 'package:excode/src/home/services/input_service.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:fpdart/fpdart.dart';

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
  }

  static Either<Languages, Languages> getLangFromName(String name) {
    return Either.tryCatch(
      () => langMap[name]!.lang,
      ((_, __) => langMap[defaultLanguage]!.lang),
    );
  }

  static Either<String, String> getNameFromLang(Languages lang) {
    return Either.tryCatch(
      () =>
          langMap.keys.firstWhere((element) => langMap[element]!.lang == lang),
      (_, __) => defaultLanguage,
    );
  }

  static String sanitizeContent(String content) {
    return content.replaceAll('\u{00B7}', ' ');
  }

  static Future<OutputModel> executeCode(Languages lang, String content) async {
    late final Response<Map<String, dynamic>> res;

    final langString = getNameFromLang(lang).match<String>((l) => l, (r) => r);
    final inputArgs = InputService.fetch();
    final data = {
      'language': langString,
      'version': _langVersionMap[langString],
      'files': [
        {'content': sanitizeContent(content)}
      ],
      'stdin': inputArgs.stdInArgs,
      'args': inputArgs.cmdLineArgs.split(','),
      'compile_timeout': 10000,
      'run_timeout': 3000,
    };

    try {
      print(data);
      res = await dio.post(_executeUrl, data: data);
    } on DioError catch (err) {
      return OutputModel(output: 'No output', error: err.message);
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
        return OutputModel(
          output: res.data!['run']['stdout'],
          error: res.data!['run']['stderr'],
        );
      } else {
        if (res.data!['compile']['stdout'].isEmpty) {
          res.data!['compile']['stdout'] = 'No output';
        }
        if (res.data!['compile']['stderr'].isEmpty) {
          res.data!['compile']['stderr'] = 'No errors';
        }

        return OutputModel(
          output: res.data!['compile']['stdout'],
          error: res.data!['compile']['stderr'],
        );
      }
    }

    return OutputModel(
      output: res.data!['run']['stdout'],
      error: res.data!['run']['stderr'],
    );
  }
}
