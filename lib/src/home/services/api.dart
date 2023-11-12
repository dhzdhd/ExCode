import 'package:dio/dio.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/output_model.dart';
import 'package:excode/src/home/models/piston_model.dart';
import 'package:excode/src/home/services/input_service.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:fpdart/fpdart.dart';

enum Language {
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

  // static Either<Language, Language> getLangFromName(String name) {
  //   return Either.tryCatch(
  //     () => langMap[name]!.lang,
  //     ((_, __) => defaultLanguage),
  //   );
  // }

  // static Either<String, String> getNameFromLang(Language lang) {
  //   return Either.tryCatch(
  //     () =>
  //         langMap.keys.firstWhere((element) => langMap[element]!.lang == lang),
  //     (_, __) => defaultLanguage,
  //   );
  // }

  static String sanitizeContent(String content) {
    return content.replaceAll('\u{00B7}', ' ');
  }

  static Future<OutputModel> executeCode(Language lang, String content) async {
    late final Response<Map<String, dynamic>> res;

    final String langString = getLangFromEnum(lang).name;
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
      res = await dio.post(_executeUrl, data: data);
    } on DioException catch (err) {
      return OutputModel(
        output: 'No output',
        error: err.message ?? 'Error',
      );
    }

    print(res.data);

    Option<PistonModel> runModel = const None();
    Option<PistonModel> compileModel = const None();

    if (res.data
        case {
          'run': {
            'stdout': String stdout,
            'stderr': String stderr,
            'output': String output,
            'code': int? code,
            'signal': String? signal
          }
        }) {
      runModel = Some(PistonModel(
        stdout: stdout,
        stderr: stderr,
        output: output,
        code: code,
        signal: signal,
      ));
    }

    if (res.data
        case {
          'compile': {
            'stdout': String stdout,
            'stderr': String stderr,
            'output': String output,
            'code': int? code,
            'signal': String? signal
          }
        }) {
      compileModel = Some(PistonModel(
        stdout: stdout,
        stderr: stderr,
        output: output,
        code: code,
        signal: signal,
      ));
    }

    print(runModel);

    return switch (compileModel) {
      Some(value: PistonModel cModel) when runModel.isNone() =>
        OutputModel(output: cModel.stdout, error: cModel.stderr),
      _ => switch (runModel) {
          Some(value: PistonModel rModel) =>
            OutputModel(output: rModel.stdout, error: rModel.stderr),
          None() => const OutputModel(output: '', error: '')
        },
    };

    // if (res.data!['run']['stdout'].isEmpty) {
    //   res.data!['run']['stdout'] = 'No output';
    // }
    // if (res.data!['run']['stderr'].isEmpty) {
    //   res.data!['run']['stderr'] = 'No errors';
    // }

    // if (res.data!.containsKey('compile')) {
    //   if (res.data!['compile']['stdout'].isEmpty &&
    //       res.data!['compile']['stderr'].isEmpty) {
    //     return OutputModel(
    //       output: res.data!['run']['stdout'],
    //       error: res.data!['run']['stderr'],
    //     );
    //   } else {
    //     if (res.data!['compile']['stdout'].isEmpty) {
    //       res.data!['compile']['stdout'] = 'No output';
    //     }
    //     if (res.data!['compile']['stderr'].isEmpty) {
    //       res.data!['compile']['stderr'] = 'No errors';
    //     }

    //     return OutputModel(
    //       output: res.data!['compile']['stdout'],
    //       error: res.data!['compile']['stderr'],
    //     );
    //   }
    // }

    // return OutputModel(
    //   output: res.data!['run']['stdout'],
    //   error: res.data!['run']['stderr'],
    // );
  }
}
