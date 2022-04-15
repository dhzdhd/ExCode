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

String getThemeLangFromEnum(Languages lang) {
  switch (lang) {
    case Languages.cobol: // ?
    case Languages.nodeTS:
      return 'typescript';
    case Languages.nodeJS:
    case Languages.golfScript:
      return 'javascript';
    case Languages.cSharp:
      return 'cs';
    case Languages.fsi:
      return 'fsharp';
    case Languages.emacs:
      return 'lisp';
    case Languages.file:
      return 'markdown';
    case Languages.forte: // ?
    case Languages.freebasic:
      return 'basic';
    case Languages.c:
    case Languages.dash:
      return 'cpp';
    case Languages.husk:
      return 'haskell';
    case Languages.iverilog:
      return 'verilog';
    case Languages.llvm_ir:
      return 'llvm';
    case Languages.nasm:
    case Languages.nasm64:
      return 'x86asm';
    case Languages.nim:
      return 'nimrod';
    case Languages.octave:
      return 'matlab';
    case Languages.osabie:
      return 'elixir';
    case Languages.pascal: // ?
    case Languages.ponylang:
      return 'pony';
    case Languages.pure:
      return 'purebasic';
    case Languages.cow:
    case Languages.japt:
    case Languages.jelly:
    case Languages.lolcode:
    case Languages.paradoc:
    case Languages.pyth:
    case Languages.python2:
    case Languages.vyxal:
    case Languages.yeethon:
      return 'python';
    case Languages.raku:
      return 'perl';
    case Languages.rockstar:
      return 'javascript';
    case Languages.rscript:
      return 'r';
    case Languages.sqlite3:
      return 'sql';
    case Languages.vlang: // ?
    case Languages.zig: // ?
      return 'markdown';
    default:
      return Languages.values[lang.index].name.toLowerCase();
  }
}
