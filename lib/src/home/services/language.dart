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

Map<String, TextStyle> getThemeFromEnum(Themes theme) {
  switch (theme) {
    case Themes.a11yDark:
      return a11yDarkTheme;
    case Themes.a11yLight:
      return a11yLightTheme;
    case Themes.androidStudio:
      return androidstudioTheme;
    case Themes.atomOneDark:
      return atomOneDarkTheme;
    case Themes.atomOneLight:
      return atomOneLightTheme;
    case Themes.codePen:
      return codepenEmbedTheme;
    case Themes.darcula:
      return darculaTheme;
    case Themes.dracula:
      return draculaTheme;
    case Themes.github:
      return githubTheme;
    case Themes.grayscale:
      return grayscaleTheme;
    case Themes.gruvboxDark:
      return gruvboxDarkTheme;
    case Themes.gruvboxLight:
      return gruvboxLightTheme;
    case Themes.hybrid:
      return hybridTheme;
    case Themes.idea:
      return ideaTheme;
    case Themes.kimbieDark:
      return kimbieDarkTheme;
    case Themes.kimbieLight:
      return kimbieLightTheme;
    case Themes.lightFair:
      return lightfairTheme;
    case Themes.monokai:
      return monokaiTheme;
    case Themes.nightOwl:
      return nightOwlTheme;
    case Themes.obsidian:
      return obsidianTheme;
    case Themes.ocean:
      return oceanTheme;
    case Themes.pureBasic:
      return purebasicTheme;
    case Themes.qtCreatorDark:
      return qtcreatorDarkTheme;
    case Themes.qtCreatorLight:
      return qtcreatorLightTheme;
    case Themes.rainbow:
      return rainbowTheme;
    case Themes.schoolBook:
      return schoolBookTheme;
    case Themes.solarizedDark:
      return solarizedDarkTheme;
    case Themes.solarizedLight:
      return solarizedLightTheme;
    case Themes.sunburst:
      return sunburstTheme;
    case Themes.tomorrow:
      return tomorrowTheme;
    case Themes.tomorrowBlue:
      return tomorrowNightBlueTheme;
    case Themes.tomorrowDay:
      return tomorrowNightBrightTheme;
    case Themes.tomorrowNight:
      return tomorrowNightTheme;
    case Themes.vs:
      return vsTheme;
    case Themes.xcode:
      return xcodeTheme;
    case Themes.xt256:
      return xt256Theme;
    case Themes.zenburn:
      return zenburnTheme;
    case Themes.nord:
    default:
      return nordTheme;
  }
}

final Map<String, LangModel> langMap = {
  'bash': LangModel(
    mode: bash,
    name: 'bash',
    lang: Languages.bash,
    baseCode: '''var="Hello, World!"
printf "%s\n" "\$var"''',
  ),
  'brainfuck': LangModel(
    mode: brainfuck,
    name: 'brainfuck',
    lang: Languages.brainfuck,
    baseCode: '''>++++++++[<+++++++++>-]<.
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
    lang: Languages.clojure,
    baseCode: '''(def hello (fn [] "Hello, World!"))
(hello)''',
  ),
  'cobol': LangModel(
    mode: markdown,
    name: 'cobol',
    lang: Languages.cobol,
    baseCode: '''IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO-WORLD.

PROCEDURE DIVISION.
  DISPLAY "Hello, World!".
  STOP RUN.''',
  ),
  'coffeescript': LangModel(
    mode: coffeescript,
    name: 'typescript',
    lang: Languages.coffeeScript,
    baseCode: '''console.log("Hello, World!")''',
  ),
  'crystal': LangModel(
    mode: crystal,
    name: 'crystal',
    lang: Languages.crystal,
    baseCode: '''"Hello, World!".each_char do |char|
  print char
end
print '\\n'
''',
  ),
  'dart': LangModel(
    mode: dart,
    name: 'dart',
    lang: Languages.dart,
    baseCode: '''void main() {
    print('Hello, World!');
}''',
  ),
  'typescript': LangModel(
    mode: typescript,
    name: 'typescript',
    lang: Languages.typeScript,
    baseCode: '''console.log("Hello, World!");''',
  ),
  'javascript': LangModel(
    mode: javascript,
    name: 'javascript',
    lang: Languages.javaScript,
    baseCode: '''console.log("Hello, World!");''',
  ),
  'basic.net': LangModel(
    mode: basic,
    name: 'basic',
    lang: Languages.basic,
    baseCode: '''10 PRINT "Hello, World!"''',
  ),
  'fsharp.net': LangModel(
    mode: fsharp,
    name: 'fsharp',
    lang: Languages.fSharp,
    baseCode: '''printfn "Hello, World!"''',
  ),
  'csharp.net': LangModel(
    mode: cs,
    name: 'csharp',
    lang: Languages.cSharp,
    baseCode: '''Console.WriteLine("Hello, World!");''',
  ),
  'fsi': LangModel(
    mode: fsharp,
    name: 'fsi',
    lang: Languages.fsi,
    baseCode: '''printfn "Hello, World!"''',
  ),
  'dragon': LangModel(
    mode: markdown,
    name: 'dragon',
    lang: Languages.dragon,
    baseCode: '''show "Hello, World!"''',
  ),
  'elixir': LangModel(
    mode: elixir,
    name: 'elixir',
    lang: Languages.elixir,
    baseCode: '''IO.puts("Hello, World!")''',
  ),
  'emacs': LangModel(
    mode: lisp,
    name: 'emacs',
    lang: Languages.emacs,
    baseCode: '''(princ "Hello, World!")''',
  ),
  'erlang': LangModel(
    mode: erlang,
    name: 'erlang',
    lang: Languages.erlang,
    baseCode: '''-module(hello).
	-export([hello_world/0]).

	hello_world() -> io:fwrite("Hello, World!\n").''',
  ),
  'forth': LangModel(
    mode: markdown,
    name: 'forth',
    lang: Languages.forth,
    baseCode: '''." Hello, World!" CR''',
  ),
  'freebasic': LangModel(
    mode: basic,
    name: 'freebasic',
    lang: Languages.freebasic,
    baseCode: ''' Print "Hello, World!"''',
  ),
  'awk': LangModel(
    mode: awk,
    name: 'awk',
    lang: Languages.awk,
    baseCode: '''BEGIN { print "Hello, World!" }''',
  ),
  'gawk': LangModel(
    // ! no version
    mode: awk,
    name: 'gawk',
    lang: Languages.gawk,
    baseCode: '''BEGIN { print "Hello, World!" }''',
  ),
  'c': LangModel(
    mode: cpp,
    name: 'c',
    lang: Languages.c,
    baseCode: '''#include <stdio.h>

int main()
{
    printf("Hello, World!\n");
}''',
  ),
  'c++': LangModel(
    mode: cpp,
    name: 'cpp',
    lang: Languages.cpp,
    baseCode: '''#include <iostream>

int main()
{
  std::cout << "Hello, World!\n";
  return 0;
}''',
  ),
  'd': LangModel(
    mode: d,
    name: 'd',
    lang: Languages.d,
    baseCode: '''import std.stdio;

void main() {
    writeln("Hello, World!");
}''',
  ),
  'fortran': LangModel(
    mode: fortran,
    name: 'fortran',
    lang: Languages.fortran,
    baseCode: '''program Hello
  print *, "Hello, World!"
end program Hello''',
  ),
  'go': LangModel(
    mode: go,
    name: 'go',
    lang: Languages.go,
    baseCode: '''package main
import "fmt"

func main() {
    fmt.Println("Hello, World!")
}''',
  ),
  'golfscript': LangModel(
    mode: markdown,
    name: 'golfscript',
    lang: Languages.golfScript,
    baseCode: ''''Hello, world!\'''',
  ),
  'groovy': LangModel(
    mode: groovy,
    name: 'groovy',
    lang: Languages.groovy,
    baseCode: '''println "Hello, World!"''',
  ),
  'haskell': LangModel(
    mode: haskell,
    name: 'haskell',
    lang: Languages.haskell,
    baseCode: '''main :: IO ()
main = putStrLn "Hello, World!"''',
  ),
  'iverilog': LangModel(
    mode: verilog,
    name: 'verilog',
    lang: Languages.verilog,
    baseCode: '''module HELLO_WORLD();
  initial begin
    \$display("Hello, World!");
    \$finish;
  end
endmodule''',
  ),
  'japt': LangModel(
    mode: markdown,
    name: 'japt',
    lang: Languages.japt,
    baseCode: '''"Hello, World!''',
  ),
  'java': LangModel(
    mode: java,
    name: 'java',
    lang: Languages.java,
    baseCode: '''public class Main {
  public static void main(String[] args) {
    System.out.println("Hello, World!");
  }
}''',
  ),
  'julia': LangModel(
    mode: julia,
    name: 'julia',
    lang: Languages.julia,
    baseCode: '''println("Hello, World!")''',
  ),
  'kotlin': LangModel(
    mode: kotlin,
    name: 'kotlin',
    lang: Languages.kotlin,
    baseCode: '''fun main() {
    println("Hello, World!")
}''',
  ),
  'lisp': LangModel(
    mode: lisp,
    name: 'lisp',
    lang: Languages.lisp,
    baseCode: '''(print "Hello, World!")''',
  ),
  'llvm_ir': LangModel(
    mode: llvm,
    name: 'llvm',
    lang: Languages.llvm,
    baseCode:
        '''@.str = private unnamed_addr constant [13 x i8] c"hello world\\0A\\00"

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
    lang: Languages.lua,
    baseCode: '''print("Hello, World!")''',
  ),
  'nasm': LangModel(
    mode: x86Asm,
    name: 'nasm',
    lang: Languages.nasm,
    baseCode: '''SECTION .DATA
	hello:     db 'Hello world!',10
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
    lang: Languages.nasm64,
    baseCode: '''SECTION .DATA
	hello:     db 'Hello world!',10
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
    lang: Languages.nim,
    baseCode: '''echo "Hello World"''',
  ),
  'ocaml': LangModel(
    mode: ocaml,
    name: 'ocaml',
    lang: Languages.oCaml,
    baseCode: '''println("Hello, World!")''',
  ),
  'octave': LangModel(
    mode: matlab,
    name: 'matlab',
    lang: Languages.matlab,
    baseCode: '''disp('Hello, World!');''',
  ),
  'osabie': LangModel(
    mode: markdown,
    name: 'osabie',
    lang: Languages.osabie,
    baseCode: '''"Hello, World!''',
  ),
  'pascal': LangModel(
    mode: markdown,
    name: 'pascal',
    lang: Languages.pascal,
    baseCode: '''program Hello;
begin
  writeln ('Hello, World!');
end.''',
  ),
  'perl': LangModel(
    mode: perl,
    name: 'perl',
    lang: Languages.perl,
    baseCode: '''print "Hello, World!\n";''',
  ),
  'php': LangModel(
    mode: php,
    name: 'php',
    lang: Languages.php,
    baseCode: '''Hello, World!''',
  ),
  'ponylang': LangModel(
    mode: pony,
    name: 'ponylang',
    lang: Languages.ponylang,
    baseCode: '''actor Main
  new create(env: Env) =>
    env.out.print("Hello, world!")''',
  ),
  'prolog': LangModel(
    mode: prolog,
    name: 'prolog',
    lang: Languages.prolog,
    baseCode: '''main() :- write("Hello, World!"), nl.''',
  ),
  'powershell': LangModel(
    mode: powershell,
    name: 'powershell',
    lang: Languages.powershell,
    baseCode: ''''Hello, World!\'''',
  ),
  'python2': LangModel(
    mode: python,
    name: 'python2',
    lang: Languages.python2,
    baseCode: '''print 'Hello, World!\'''',
  ),
  'python': LangModel(
    mode: python,
    name: 'python',
    lang: Languages.python,
    baseCode: '''print("Hello, World!")''',
  ),
  'racket': LangModel(
    mode: scheme,
    name: 'racket',
    lang: Languages.racket,
    baseCode: '''#lang racket
(displayln "Hello, World!")''',
  ),
  'raku': LangModel(
    mode: perl,
    name: 'raku',
    lang: Languages.raku,
    baseCode: '''say 'Hello, World!';''',
  ),
  'rockstar': LangModel(
    mode: markdown,
    name: 'rockstar',
    lang: Languages.rockstar,
    baseCode: '''Say "Hello World"''',
  ),
  'rscript': LangModel(
    mode: r,
    name: 'r',
    lang: Languages.r,
    baseCode: '''print("Hello, World!")''',
  ),
  'ruby': LangModel(
    mode: ruby,
    name: 'ruby',
    lang: Languages.ruby,
    baseCode: '''puts "Hello, World!"''',
  ),
  'rust': LangModel(
    mode: rust,
    name: 'rust',
    lang: Languages.rust,
    baseCode: '''fn main() {
    println!("Hello, World!");
}''',
  ),
  'scala': LangModel(
    mode: scala,
    name: 'scala',
    lang: Languages.scala,
    baseCode: '''object Hello {
    def main(args: Array[String]) = {
        println("Hello, World!")
    }
}''',
  ),
  'smalltalk': LangModel(
    mode: smalltalk,
    name: 'smalltalk',
    lang: Languages.smallTalk,
    baseCode: '''Transcript show: 'Hello, world!'.''',
  ),
  'sqlite3': LangModel(
    mode: sql,
    name: 'sqlite3',
    lang: Languages.sqlite3,
    baseCode: '''CREATE TABLE helloworld (phrase TEXT);
INSERT INTO helloworld VALUES ("Hello, World!");
SELECT COUNT(*) FROM helloworld;
''',
  ),
  'swift': LangModel(
    mode: swift,
    name: 'swift',
    lang: Languages.swift,
    baseCode: '''print("Hello, World!")''',
  ),
  'vlang': LangModel(
    mode: markdown,
    name: 'vlang',
    lang: Languages.vlang,
    baseCode: '''fn main() {
    println('Hello, World!')
}''',
  ),
  'zig': LangModel(
    mode: markdown,
    name: 'zig',
    lang: Languages.zig,
    baseCode: '''const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"World!"});
}''',
  ),
};

// String getThemeLangFromEnum(Languages lang) {
//   switch (lang) {
//     case Languages.cobol: // ?
//     case Languages.typeScript:
//       return 'typescript';
//     case Languages.javaScript:
//     case Languages.golfScript:
//       return 'javascript';
//     case Languages.cSharp:
//       return 'cs';
//     case Languages.fsi:
//       return 'fsharp';
//     case Languages.emacs:
//       return 'lisp';
//     case Languages.freebasic:
//       return 'basic';
//     case Languages.c:
//       return 'cpp';
//     case Languages.verilog:
//       return 'verilog';
//     case Languages.llvm:
//       return 'llvm';
//     case Languages.nasm:
//     case Languages.nasm64:
//       return 'x86asm';
//     case Languages.nim:
//       return 'nimrod';
//     case Languages.matlab:
//       return 'matlab';
//     case Languages.osabie:
//       return 'elixir';
//     case Languages.pascal: // ?
//     case Languages.ponylang:
//       return 'pony';
//     case Languages.japt:
//     case Languages.python2:
//       return 'python';
//     case Languages.raku:
//       return 'perl';
//     case Languages.rockstar:
//       return 'javascript';
//     case Languages.r:
//       return 'r';
//     case Languages.sqlite3:
//       return 'sql';
//     case Languages.vlang: // ?
//     case Languages.zig: // ?
//       return 'markdown';
//     default:
//       return Languages.values[lang.index].name.toLowerCase();
//   }
// }
