import 'package:excode/src/home/models/lang_model.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_highlight/themes/codepen-embed.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/grayscale.dart';
import 'package:flutter_highlight/themes/gruvbox-dark.dart';
import 'package:flutter_highlight/themes/gruvbox-light.dart';
import 'package:flutter_highlight/themes/hybrid.dart';
import 'package:flutter_highlight/themes/idea.dart';
import 'package:flutter_highlight/themes/kimbie.dark.dart';
import 'package:flutter_highlight/themes/kimbie.light.dart';
import 'package:flutter_highlight/themes/lightfair.dart';
import 'package:flutter_highlight/themes/monokai.dart';
import 'package:flutter_highlight/themes/night-owl.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:flutter_highlight/themes/obsidian.dart';
import 'package:flutter_highlight/themes/ocean.dart';
import 'package:flutter_highlight/themes/purebasic.dart';
import 'package:flutter_highlight/themes/qtcreator_dark.dart';
import 'package:flutter_highlight/themes/qtcreator_light.dart';
import 'package:flutter_highlight/themes/rainbow.dart';
import 'package:flutter_highlight/themes/school-book.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
import 'package:flutter_highlight/themes/sunburst.dart';
import 'package:flutter_highlight/themes/tomorrow-night-blue.dart';
import 'package:flutter_highlight/themes/tomorrow-night-bright.dart';
import 'package:flutter_highlight/themes/tomorrow-night.dart';
import 'package:flutter_highlight/themes/tomorrow.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:flutter_highlight/themes/xt256.dart';
import 'package:flutter_highlight/themes/zenburn.dart';
import 'package:highlight/languages/awk.dart';
import 'package:highlight/languages/bash.dart';
import 'package:highlight/languages/basic.dart';
import 'package:highlight/languages/brainfuck.dart';
import 'package:highlight/languages/clojure.dart';
import 'package:highlight/languages/coffeescript.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/crystal.dart';
import 'package:highlight/languages/cs.dart';
import 'package:highlight/languages/d.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/elixir.dart';
import 'package:highlight/languages/erlang.dart';
import 'package:highlight/languages/fortran.dart';
import 'package:highlight/languages/fsharp.dart';
import 'package:highlight/languages/go.dart';
import 'package:highlight/languages/groovy.dart';
import 'package:highlight/languages/haskell.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/julia.dart';
import 'package:highlight/languages/kotlin.dart';
import 'package:highlight/languages/lisp.dart';
import 'package:highlight/languages/llvm.dart';
import 'package:highlight/languages/lua.dart';
import 'package:highlight/languages/markdown.dart';
import 'package:highlight/languages/matlab.dart';
import 'package:highlight/languages/nimrod.dart';
import 'package:highlight/languages/ocaml.dart';
import 'package:highlight/languages/perl.dart';
import 'package:highlight/languages/php.dart';
import 'package:highlight/languages/pony.dart';
import 'package:highlight/languages/powershell.dart';
import 'package:highlight/languages/prolog.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/r.dart';
import 'package:highlight/languages/ruby.dart';
import 'package:highlight/languages/rust.dart';
import 'package:highlight/languages/scala.dart';
import 'package:highlight/languages/scheme.dart';
import 'package:highlight/languages/smalltalk.dart';
import 'package:highlight/languages/sql.dart';
import 'package:highlight/languages/swift.dart';
import 'package:highlight/languages/typescript.dart';
import 'package:highlight/languages/verilog.dart';
import 'package:highlight/languages/x86asm.dart';

enum Themes {
  a11yDark,
  a11yLight,
  androidStudio,
  atomOneDark,
  atomOneLight,
  codePen,
  darcula,
  dracula,
  github,
  grayscale,
  gruvboxDark,
  gruvboxLight,
  hybrid,
  idea,
  kimbieDark,
  kimbieLight,
  lightFair,
  monokai,
  nightOwl,
  nord,
  obsidian,
  ocean,
  pureBasic,
  qtCreatorDark,
  qtCreatorLight,
  rainbow,
  schoolBook,
  solarizedDark,
  solarizedLight,
  sunburst,
  tomorrow,
  tomorrowBlue,
  tomorrowDay,
  tomorrowNight,
  vs,
  xcode,
  xt256,
  zenburn,
}

const langThemeMap = {
  Themes.a11yDark: a11yDarkTheme,
  Themes.a11yLight: a11yLightTheme,
  Themes.androidStudio: androidstudioTheme,
  Themes.atomOneDark: atomOneDarkTheme,
  Themes.atomOneLight: atomOneLightTheme,
  Themes.codePen: codepenEmbedTheme,
  Themes.darcula: darculaTheme,
  Themes.dracula: draculaTheme,
  Themes.github: githubTheme,
  Themes.grayscale: grayscaleTheme,
  Themes.gruvboxDark: gruvboxDarkTheme,
  Themes.gruvboxLight: gruvboxLightTheme,
  Themes.hybrid: hybridTheme,
  Themes.idea: ideaTheme,
  Themes.kimbieDark: kimbieDarkTheme,
  Themes.kimbieLight: kimbieLightTheme,
  Themes.lightFair: lightfairTheme,
  Themes.monokai: monokaiTheme,
  Themes.nightOwl: nightOwlTheme,
  Themes.obsidian: obsidianTheme,
  Themes.ocean: oceanTheme,
  Themes.pureBasic: purebasicTheme,
  Themes.qtCreatorDark: qtcreatorDarkTheme,
  Themes.qtCreatorLight: qtcreatorLightTheme,
  Themes.rainbow: rainbowTheme,
  Themes.schoolBook: schoolBookTheme,
  Themes.solarizedDark: solarizedDarkTheme,
  Themes.solarizedLight: solarizedLightTheme,
  Themes.sunburst: sunburstTheme,
  Themes.tomorrow: tomorrowTheme,
  Themes.tomorrowBlue: tomorrowNightBlueTheme,
  Themes.tomorrowDay: tomorrowNightBrightTheme,
  Themes.tomorrowNight: tomorrowNightTheme,
  Themes.vs: vsTheme,
  Themes.xcode: xcodeTheme,
  Themes.xt256: xt256Theme,
  Themes.zenburn: zenburnTheme,
  Themes.nord: nordTheme
};

Map<String, TextStyle> getThemeFromEnum(Themes theme) {
  return langThemeMap[theme]!;
}

Themes getEnumFromString(String theme) {
  return langThemeMap.keys.firstWhere((element) => element.name == theme);
}

Themes getEnumFromTheme(Map<String, TextStyle> theme) {
  return langThemeMap.keys
      .firstWhere((element) => langThemeMap[element] == theme);
}

const defaultLanguage = Language.python;

LangModel getLangFromName(String name) {
  return langList.firstWhere(
    (element) => element.name == name,
    // orElse: () => langList.firstWhere((element) => element.name == 'python'),
  );
}

LangModel getLangFromExt(String ext) {
  return langList.firstWhere(
    (element) => element.ext == ext,
    // orElse: () => langList.firstWhere((element) => element.name == 'python'),
  );
}

LangModel getLangFromEnum(Language lang) {
  return langList.firstWhere(
    (element) => element.lang == lang,
    // orElse: () => langList.firstWhere((element) => element.name == 'python'),
  );
}

final List<LangModel> langList = [
  // ! Add support for extensions
  LangModel(
    mode: bash,
    name: 'bash',
    lang: Language.bash,
    ext: '.sh',
    template: '''var="Hello, World!"
printf "%s\\n" "\$var"''',
  ),
  LangModel(
    mode: brainfuck,
    name: 'brainfuck',
    lang: Language.brainfuck,
    ext: '.bf',
    template: '''>++++++++[<+++++++++>-]<.
>++++[<+++++++>-]<+.
+++++++..
+++.
>>++++++[<+++++++>-]<++.
------------.
>++++++[<+++++++++>-]<+.
<.
+++.
------.
--------.
>>>++++[<++++++++>-]<+.''',
  ),
  LangModel(
    mode: clojure,
    name: 'clojure',
    lang: Language.clojure,
    ext: '.clj',
    template: '''(defn hello [] (print "Hello, World!"))
(hello)''',
  ),
  LangModel(
    mode: markdown,
    name: 'cobol',
    lang: Language.cobol,
    ext: '.cbl',
    template: '''IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO-WORLD.

PROCEDURE DIVISION.
  DISPLAY "Hello, World!".
  STOP RUN.''',
  ),
  LangModel(
    mode: coffeescript,
    name: 'typescript',
    lang: Language.coffeeScript,
    ext: '.coffee',
    template: '''console.log("Hello, World!")''',
  ),
  LangModel(
    mode: crystal,
    name: 'crystal',
    lang: Language.crystal,
    ext: '.cr',
    template: '''"Hello, World!".each_char do |char|
  print char
end
print '\\n'
''',
  ),
  LangModel(
    mode: dart,
    name: 'dart',
    lang: Language.dart,
    ext: '.dart',
    template: '''void main() {
    print('Hello, World!');
}''',
  ),
  LangModel(
    mode: typescript,
    name: 'typescript',
    lang: Language.typeScript,
    ext: '.ts',
    template: '''console.log("Hello, World!");''',
  ),
  LangModel(
    mode: javascript,
    name: 'javascript',
    lang: Language.javaScript,
    ext: '.js',
    template: '''console.log("Hello, World!");''',
  ),
  LangModel(
    mode: basic,
    name: 'basic.net',
    lang: Language.basic,
    ext: '.vb',
    template: '''Imports System

Module HWModule
   Sub Main()
     Console.WriteLine("Hello World!")
   End Sub
End Module''',
  ),
  LangModel(
    mode: fsharp,
    name: 'fsharp.net',
    lang: Language.fSharp,
    ext: '.fs',
    template: '''printfn "Hello, World!"''',
  ),
  LangModel(
    mode: cs,
    name: 'csharp.net',
    lang: Language.cSharp,
    ext: '.cs',
    template: '''namespace HelloWorld
{
    class Hello {
        static void Main(string[] args)
        {
            System.Console.WriteLine("Hello World!");
        }
    }
}''',
  ),
  LangModel(
    mode: fsharp,
    name: 'fsi',
    lang: Language.fsi,
    ext: '.fsx',
    template: '''printfn "Hello, World!"''',
  ),
  LangModel(
    mode: markdown,
    name: 'dragon',
    lang: Language.dragon,
    ext: '.dgn',
    template: '''show "Hello, World!"''',
  ),
  LangModel(
    mode: elixir,
    name: 'elixir',
    lang: Language.elixir,
    ext: '.ex',
    template: '''IO.puts("Hello, World!")''',
  ),
  LangModel(
    mode: lisp,
    name: 'emacs',
    lang: Language.emacs,
    ext: '.el',
    template: '''(princ "Hello, World!")''',
  ),
  LangModel(
    // !
    mode: erlang,
    name: 'erlang',
    lang: Language.erlang,
    ext: '.erl',
    template: '''-module(helloworld).
-export([start/0]).

start() ->
   io:fwrite("Hello, world!\n").''',
  ),
  LangModel(
    // ! Compiler output
    mode: markdown,
    name: 'forth',
    lang: Language.forth,
    ext: '.fth',
    template: '''." Hello, World!" CR''',
  ),
  LangModel(
    mode: basic,
    name: 'freebasic',
    lang: Language.freebasic,
    ext: '.bas',
    template: '''Print "Hello, World!"''',
  ),
  LangModel(
    mode: awk,
    name: 'awk',
    lang: Language.awk,
    ext: '.awk',
    template: '''BEGIN { print "Hello, World!" }''',
  ),
  LangModel(
    // ! No version
    mode: awk,
    name: 'gawk',
    lang: Language.gawk,
    ext: '.gawk.awk',
    template: '''BEGIN { print "Hello, World!" }''',
  ),
  LangModel(
    mode: cpp,
    name: 'c',
    lang: Language.c,
    ext: '.c',
    template: '''#include <stdio.h>

int main()
{
    printf("Hello, World!\\n");
}''',
  ),
  LangModel(
    mode: cpp,
    name: 'c++',
    lang: Language.cpp,
    ext: '.cpp',
    template: '''#include <iostream>

int main()
{
  std::cout << "Hello, World!\\n";
  return 0;
}''',
  ),
  LangModel(
    mode: d,
    name: 'd',
    lang: Language.d,
    ext: '.d',
    template: '''import std.stdio;

void main() {
    writeln("Hello, World!");
}''',
  ),
  LangModel(
    mode: fortran,
    name: 'fortran',
    lang: Language.fortran,
    ext: '.f',
    template: '''program Hello
  print *, "Hello, World!"
end program Hello''',
  ),
  LangModel(
    mode: go,
    name: 'go',
    lang: Language.go,
    ext: '.go',
    template: '''package main
import "fmt"

func main() {
    fmt.Println("Hello, World!")
}''',
  ),
  LangModel(
    mode: markdown,
    name: 'golfscript',
    lang: Language.golfScript,
    ext: '.gs',
    template: ''''Hello, World!\'''',
  ),
  LangModel(
    mode: groovy,
    name: 'groovy',
    lang: Language.groovy,
    ext: '.groovy',
    template: '''println "Hello, World!"''',
  ),
  LangModel(
    mode: haskell,
    name: 'haskell',
    lang: Language.haskell,
    ext: '.hs',
    template: '''main :: IO ()
main = putStrLn "Hello, World!"''',
  ),
  LangModel(
    mode: verilog,
    name: 'iverilog',
    lang: Language.verilog,
    ext: '.verilog.v',
    template: '''module HELLO_WORLD();
  initial begin
    \$display("Hello, World!");
    \$finish;
  end
endmodule''',
  ),
  LangModel(
    mode: markdown,
    name: 'japt',
    lang: Language.japt,
    ext: '.japt.js',
    template: '''"Hello, World!''',
  ),
  LangModel(
    mode: java,
    name: 'java',
    lang: Language.java,
    ext: '.java',
    template: '''public class Main {
  public static void main(String[] args) {
    System.out.println("Hello, World!");
  }
}''',
  ),
  LangModel(
    mode: julia,
    name: 'julia',
    lang: Language.julia,
    ext: '.jl',
    template: '''println("Hello, World!")''',
  ),
  LangModel(
    mode: kotlin,
    name: 'kotlin',
    lang: Language.kotlin,
    ext: '.kt',
    template: '''fun main() {
    println("Hello, World!")
}''',
  ),
  LangModel(
    mode: lisp,
    name: 'lisp',
    lang: Language.lisp,
    ext: '.lisp',
    template: '''(print "Hello, World!")''',
  ),
  LangModel(
    mode: llvm,
    name: 'llvm_ir',
    lang: Language.llvm,
    ext: '.ll',
    template:
        '''@.str = private unnamed_addr constant [13 x i8] c"Hello World\\0A\\00"

declare i32 @puts(i8* nocapture) nounwind

define i32 @main() { ; i32()*
    %cast210 = getelementptr [13 x i8],[13 x i8]* @.str, i64 0, i64 0

    call i32 @puts(i8* %cast210)
    ret i32 0
}

!0 = !{i32 42, null, !"string"}
!foo = !{!0}''',
  ),
  LangModel(
    mode: lua,
    name: 'lua',
    lang: Language.lua,
    ext: '.lua',
    template: '''print("Hello, World!")''',
  ),
  LangModel(
    mode: x86Asm,
    name: 'nasm',
    lang: Language.nasm,
    ext: '.asm',
    template: '''SECTION .DATA
	hello:     db 'Hello, World!',10
	helloLen:  equ \$-hello

SECTION .TEXT
	GLOBAL _start

_start:
	mov eax,4            ; 'write' system call = 4
	mov ebx,1            ; file descriptor 1 = STDOUT
	mov ecx,hello        ; string to write
	mov edx,helloLen     ; length of string to write
	int 80h              ; call the kernel

	; Terminate program
	mov eax,1            ; 'exit' system call
	mov ebx,0            ; exit with error code 0
	int 80h              ; call the kernel''',
  ),
  LangModel(
    mode: x86Asm,
    name: 'nasm64',
    lang: Language.nasm64,
    ext: '.nasm64.asm',
    template: '''SECTION .DATA
	hello:     db 'Hello, World!',10
	helloLen:  equ \$-hello

SECTION .TEXT
	GLOBAL _start

_start:
	mov eax,4            ; 'write' system call = 4
	mov ebx,1            ; file descriptor 1 = STDOUT
	mov ecx,hello        ; string to write
	mov edx,helloLen     ; length of string to write
	int 80h              ; call the kernel

	; Terminate program
	mov eax,1            ; 'exit' system call
	mov ebx,0            ; exit with error code 0
	int 80h              ; call the kernel''',
  ),
  LangModel(
    mode: nimrod,
    name: 'nim',
    lang: Language.nim,
    ext: '.nim',
    template: '''echo "Hello, World!"''',
  ),
  LangModel(
    mode: ocaml,
    name: 'ocaml',
    lang: Language.oCaml,
    ext: '.ml',
    template: '''print_string "Hello world!\n"''',
  ),
  LangModel(
    mode: matlab,
    name: 'octave',
    lang: Language.matlab,
    ext: '.m',
    template: '''disp('Hello, World!');''',
  ),
  LangModel(
    mode: markdown,
    name: 'osabie',
    lang: Language.osabie,
    ext: '.abe',
    template: '''"Hello, World!''',
  ),
  LangModel(
    mode: markdown,
    name: 'pascal',
    lang: Language.pascal,
    ext: '.pas',
    template: '''program Hello;
begin
  writeln ('Hello, World!');
end.''',
  ),
  LangModel(
    mode: perl,
    name: 'perl',
    lang: Language.perl,
    ext: '.perl.pl',
    template: '''print "Hello, World!\\n";''',
  ),
  LangModel(
    mode: php,
    name: 'php',
    lang: Language.php,
    ext: '.php',
    template: '''Hello, World!''',
  ),
  LangModel(
    mode: pony,
    name: 'ponylang',
    lang: Language.ponylang,
    ext: '.pony',
    template: '''actor Main
  new create(env: Env) =>
    env.out.print("Hello, world!")''',
  ),
  LangModel(
    mode: prolog,
    name: 'prolog',
    lang: Language.prolog,
    ext: '.prolog.pl',
    template: ''':- initialization(main).
main :- write('Hello World!'), nl, halt.''',
  ),
  LangModel(
    mode: powershell,
    name: 'powershell',
    lang: Language.powershell,
    ext: '.ps',
    template: ''''Hello, World!\'''',
  ),
  LangModel(
    mode: python,
    name: 'python2',
    lang: Language.python2,
    ext: '.py2.py',
    template: '''print 'Hello, World!\'''',
  ),
  LangModel(
    mode: python,
    name: 'python',
    lang: Language.python,
    ext: '.py',
    template: '''print("Hello, World!")''',
  ),
  LangModel(
    mode: scheme,
    name: 'racket',
    lang: Language.racket,
    ext: '.rkt',
    template: '''#lang racket
(displayln "Hello, World!")''',
  ),
  LangModel(
    mode: perl,
    name: 'raku',
    lang: Language.raku,
    ext: '.raku',
    template: '''say 'Hello, World!';''',
  ),
  LangModel(
    mode: markdown,
    name: 'rockstar',
    lang: Language.rockstar,
    ext: '.rock',
    template: '''Say "Hello, World!"''',
  ),
  LangModel(
    mode: r,
    name: 'rscript',
    lang: Language.r,
    ext: '.r',
    template: '''print("Hello, World!")''',
  ),
  LangModel(
    mode: ruby,
    name: 'ruby',
    lang: Language.ruby,
    ext: '.rb',
    template: '''puts "Hello, World!"''',
  ),
  LangModel(
    mode: rust,
    name: 'rust',
    lang: Language.rust,
    ext: '.rs',
    template: '''fn main() {
    println!("Hello, World!");
}''',
  ),
  LangModel(
    mode: scala,
    name: 'scala',
    lang: Language.scala,
    ext: '.scala',
    template: '''@main def hello() = println("Hello, World!")''',
  ),
  LangModel(
    mode: smalltalk,
    name: 'smalltalk',
    lang: Language.smallTalk,
    ext: '.cs',
    template: '''Transcript show: 'Hello, world!'.''',
  ),
  LangModel(
    mode: sql,
    name: 'sqlite3',
    lang: Language.sqlite3,
    ext: '.sqlite',
    template: '''CREATE TABLE helloworld (phrase TEXT);
INSERT INTO helloworld VALUES ("Hello, World!");
SELECT * FROM helloworld;
''',
  ),
  LangModel(
    mode: swift,
    name: 'swift',
    lang: Language.swift,
    ext: '.swift',
    template: '''print("Hello, World!")''',
  ),
  LangModel(
    mode: markdown,
    name: 'vlang',
    lang: Language.vlang,
    ext: '.v',
    template: '''fn main() {
    println('Hello, World!')
}''',
  ),
  LangModel(
    mode: markdown,
    name: 'zig',
    lang: Language.zig,
    ext: '.zig',
    template: '''const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\\n", .{"World"});
}''',
  ),
];
