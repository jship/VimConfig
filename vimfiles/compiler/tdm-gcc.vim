" Modified version of mingw version for tdm-gcc.

if exists("current_compiler")
  finish
endif
let current_compiler = "tdm-gcc"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" A workable errorformat for Mingw
"CompilerSet errorformat=%f:%l:%c:\ %m

" default make
CompilerSet makeprg=mingw32-make.exe

