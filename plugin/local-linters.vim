" Use local eslint and stylelint.
" Inspired by https://github.com/mtscout6/syntastic-local-eslint.vim

if exists("g:local_linters_loaded")
  finish
endif

let g:local_linters_loaded = 1

let s:stylelint_path = system('PATH=$(npm bin):$PATH && which stylelint')
let syntastic_scss_stylelint_exec = substitute(s:stylelint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

if executable(syntastic_javascript_eslint_exec)
    let g:syntastic_javascript_checkers = [ 'eslint' ]
endif

if executable(syntastic_scss_stylelint_exec)
    let g:syntastic_scss_checkers = [ 'stylelint' ]
endif
