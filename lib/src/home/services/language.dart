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

const defaultLanguage = 'python';

final Map<String, LangModel> langMap = {
  // ! Add support for extensions
  'bash': LangModel(
    mode: bash,
    name: 'bash',
    lang: Language.bash,
    ext: '.sh',
    template: '''var="Hello, World!"
printf "%s\\n" "\$var"''',
  ),
  'brainfuck': LangModel(
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
  'clojure': LangModel(
    mode: clojure,
    name: 'clojure',
    lang: Language.clojure,
    ext: '.clj',
    template: '''(defn hello [] (print "Hello, World!"))
(hello)''',
  ),
  'cobol': LangModel(
    // ! Compiler output
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
  'coffeescript': LangModel(
    mode: coffeescript,
    name: 'typescript',
    lang: Language.coffeeScript,
    ext: '.coffee',
    template: '''console.log("Hello, World!")''',
  ),
  'crystal': LangModel(
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
  'dart': LangModel(
    mode: dart,
    name: 'dart',
    lang: Language.dart,
    ext: '.dart',
    template: '''void main() {
    print('Hello, World!');
}''',
  ),
  'typescript': LangModel(
    mode: typescript,
    name: 'typescript',
    lang: Language.typeScript,
    ext: '.ts',
    template: '''console.log("Hello, World!");''',
  ),
  'javascript': LangModel(
    mode: javascript,
    name: 'javascript',
    lang: Language.javaScript,
    ext: '.js',
    template: '''console.log("Hello, World!");''',
  ),
  'basic.net': LangModel(
    // !
    mode: basic,
    name: 'basic',
    lang: Language.basic,
    ext: '.vb',
    template: '''10 PRINT "Hello, World!"''',
  ),
  'fsharp.net': LangModel(
    // ! Compiler output
    mode: fsharp,
    name: 'fsharp',
    lang: Language.fSharp,
    ext: '.fs',
    template: '''printfn "Hello, World!"''',
  ),
  'csharp.net': LangModel(
    // !
    mode: cs,
    name: 'csharp',
    lang: Language.cSharp,
    ext: '.cs',
    template: '''Console.WriteLine("Hello, World!");''',
  ),
  'fsi': LangModel(
    mode: fsharp,
    name: 'fsi',
    lang: Language.fsi,
    ext: '.fsx',
    template: '''printfn "Hello, World!"''',
  ),
  'dragon': LangModel(
    mode: markdown,
    name: 'dragon',
    lang: Language.dragon,
    ext: '.dgn',
    template: '''show "Hello, World!"''',
  ),
  'elixir': LangModel(
    mode: elixir,
    name: 'elixir',
    lang: Language.elixir,
    ext: '.ex',
    template: '''IO.puts("Hello, World!")''',
  ),
  'emacs': LangModel(
    mode: lisp,
    name: 'emacs',
    lang: Language.emacs,
    ext: '.el',
    template: '''(princ "Hello, World!")''',
  ),
  'erlang': LangModel(
    // !
    mode: erlang,
    name: 'erlang',
    lang: Language.erlang,
    ext: '.erl',
    template: '''-module(hello).
-export([hello_world/0]).

hello_world() -> io:fwrite("Hello, World!\\n").''',
  ),
  'forth': LangModel(
    // ! Compiler output
    mode: markdown,
    name: 'forth',
    lang: Language.forth,
    ext: '.fth',
    template: '''." Hello, World!" CR''',
  ),
  'freebasic': LangModel(
    mode: basic,
    name: 'freebasic',
    lang: Language.freebasic,
    ext: '.bas',
    template: '''Print "Hello, World!"''',
  ),
  'awk': LangModel(
    mode: awk,
    name: 'awk',
    lang: Language.awk,
    ext: '.awk',
    template: '''BEGIN { print "Hello, World!" }''',
  ),
  'gawk': LangModel(
    // ! No version
    mode: awk,
    name: 'gawk',
    lang: Language.gawk,
    ext: '.gawk.awk',
    template: '''BEGIN { print "Hello, World!" }''',
  ),
  'c': LangModel(
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
  'c++': LangModel(
    mode: cpp,
    name: 'cpp',
    lang: Language.cpp,
    ext: '.cpp',
    template: '''#include <iostream>

int main()
{
  std::cout << "Hello, World!\\n";
  return 0;
}''',
  ),
  'd': LangModel(
    mode: d,
    name: 'd',
    lang: Language.d,
    ext: '.d',
    template: '''import std.stdio;

void main() {
    writeln("Hello, World!");
}''',
  ),
  'fortran': LangModel(
    mode: fortran,
    name: 'fortran',
    lang: Language.fortran,
    ext: '.f',
    template: '''program Hello
  print *, "Hello, World!"
end program Hello''',
  ),
  'go': LangModel(
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
  'golfscript': LangModel(
    mode: markdown,
    name: 'golfscript',
    lang: Language.golfScript,
    ext: '.gs',
    template: ''''Hello, World!\'''',
  ),
  'groovy': LangModel(
    mode: groovy,
    name: 'groovy',
    lang: Language.groovy,
    ext: '.groovy',
    template: '''println "Hello, World!"''',
  ),
  'haskell': LangModel(
    mode: haskell,
    name: 'haskell',
    lang: Language.haskell,
    ext: '.hs',
    template: '''main :: IO ()
main = putStrLn "Hello, World!"''',
  ),
  'iverilog': LangModel(
    mode: verilog,
    name: 'verilog',
    lang: Language.verilog,
    ext: '.verilog.v',
    template: '''module HELLO_WORLD();
  initial begin
    \$display("Hello, World!");
    \$finish;
  end
endmodule''',
  ),
  'japt': LangModel(
    mode: markdown,
    name: 'japt',
    lang: Language.japt,
    ext: '.japt.js',
    template: '''"Hello, World!''',
  ),
  'java': LangModel(
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
  'julia': LangModel(
    mode: julia,
    name: 'julia',
    lang: Language.julia,
    ext: '.jl',
    template: '''println("Hello, World!")''',
  ),
  'kotlin': LangModel(
    mode: kotlin,
    name: 'kotlin',
    lang: Language.kotlin,
    ext: '.kt',
    template: '''fun main() {
    println("Hello, World!")
}''',
  ),
  'lisp': LangModel(
    mode: lisp,
    name: 'lisp',
    lang: Language.lisp,
    ext: '.lisp',
    template: '''(print "Hello, World!")''',
  ),
  'llvm_ir': LangModel(
    mode: llvm,
    name: 'llvm',
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
  'lua': LangModel(
    mode: lua,
    name: 'lua',
    lang: Language.lua,
    ext: '.lua',
    template: '''print("Hello, World!")''',
  ),
  'nasm': LangModel(
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
  'nasm64': LangModel(
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
  'nim': LangModel(
    mode: nimrod,
    name: 'nim',
    lang: Language.nim,
    ext: '.nim',
    template: '''echo "Hello, World!"''',
  ),
  'ocaml': LangModel(
    // !
    mode: ocaml,
    name: 'ocaml',
    lang: Language.oCaml,
    ext: '.ml',
    template: '''println("Hello, World!")''',
  ),
  'octave': LangModel(
    mode: matlab,
    name: 'matlab',
    lang: Language.matlab,
    ext: '.m',
    template: '''disp('Hello, World!');''',
  ),
  'osabie': LangModel(
    mode: markdown,
    name: 'osabie',
    lang: Language.osabie,
    ext: '.abe',
    template: '''"Hello, World!''',
  ),
  'pascal': LangModel(
    // ! Compiler output
    mode: markdown,
    name: 'pascal',
    lang: Language.pascal,
    ext: '.pas',
    template: '''program Hello;
begin
  writeln ('Hello, World!');
end.''',
  ),
  'perl': LangModel(
    mode: perl,
    name: 'perl',
    lang: Language.perl,
    ext: '.perl.pl',
    template: '''print "Hello, World!\\n";''',
  ),
  'php': LangModel(
    mode: php,
    name: 'php',
    lang: Language.php,
    ext: '.php',
    template: '''Hello, World!''',
  ),
  'ponylang': LangModel(
    // !
    mode: pony,
    name: 'ponylang',
    lang: Language.ponylang,
    ext: '.pony',
    template: '''actor Main
  new create(env: Env) =>
    env.out.print("Hello, world!")''',
  ),
  'prolog': LangModel(
    // ! No output
    mode: prolog,
    name: 'prolog',
    lang: Language.prolog,
    ext: '.prolog.pl',
    template: '''main() :- write("Hello, World!"), nl.''',
  ),
  'powershell': LangModel(
    mode: powershell,
    name: 'powershell',
    lang: Language.powershell,
    ext: '.ps',
    template: ''''Hello, World!\'''',
  ),
  'python2': LangModel(
    mode: python,
    name: 'python2',
    lang: Language.python2,
    ext: '.py2.py',
    template: '''print 'Hello, World!\'''',
  ),
  'python': LangModel(
    mode: python,
    name: 'python',
    lang: Language.python,
    ext: '.py3.py',
    template: '''print("Hello, World!")''',
  ),
  'racket': LangModel(
    mode: scheme,
    name: 'racket',
    lang: Language.racket,
    ext: '.rkt',
    template: '''#lang racket
(displayln "Hello, World!")''',
  ),
  'raku': LangModel(
    mode: perl,
    name: 'raku',
    lang: Language.raku,
    ext: '.raku',
    template: '''say 'Hello, World!';''',
  ),
  'rockstar': LangModel(
    mode: markdown,
    name: 'rockstar',
    lang: Language.rockstar,
    ext: '.rock',
    template: '''Say "Hello, World!"''',
  ),
  'rscript': LangModel(
    mode: r,
    name: 'r',
    lang: Language.r,
    ext: '.r',
    template: '''print("Hello, World!")''',
  ),
  'ruby': LangModel(
    mode: ruby,
    name: 'ruby',
    lang: Language.ruby,
    ext: '.rb',
    template: '''puts "Hello, World!"''',
  ),
  'rust': LangModel(
    mode: rust,
    name: 'rust',
    lang: Language.rust,
    ext: '.rs',
    template: '''fn main() {
    println!("Hello, World!");
}''',
  ),
  'scala': LangModel(
    // !
    mode: scala,
    name: 'scala',
    lang: Language.scala,
    ext: '.scala',
    template: '''object Hello {
    def main(args: Array[String]) = {
        println("Hello, World!")
    }
}''',
  ),
  'smalltalk': LangModel(
    // ! Compiler output
    mode: smalltalk,
    name: 'smalltalk',
    lang: Language.smallTalk,
    ext: '.cs',
    template: '''Transcript show: 'Hello, world!'.''',
  ),
  'sqlite3': LangModel(
    mode: sql,
    name: 'sqlite3',
    lang: Language.sqlite3,
    ext: '.sqlite',
    template: '''CREATE TABLE helloworld (phrase TEXT);
INSERT INTO helloworld VALUES ("Hello, World!");
SELECT * FROM helloworld;
''',
  ),
  'swift': LangModel(
    mode: swift,
    name: 'swift',
    lang: Language.swift,
    ext: '.swift',
    template: '''print("Hello, World!")''',
  ),
  'vlang': LangModel(
    mode: markdown,
    name: 'vlang',
    lang: Language.vlang,
    ext: '.v',
    template: '''fn main() {
    println('Hello, World!')
}''',
  ),
  'zig': LangModel(
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
};
