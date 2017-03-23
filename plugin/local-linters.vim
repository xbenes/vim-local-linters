" Use local eslint and stylelint and tslint
" Inspired by https://github.com/mtscout6/syntastic-local-eslint.vim

if exists("g:local_linters_loaded")
  finish
endif

let g:local_linters_loaded = 1

function! Sanitize(string)
    return substitute(a:string, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

function! GetCurrentDir()
    let s:current_dir = system('echo $(pwd)')
    return Sanitize(s:current_dir)
endfunction

function! Compose(linter, linter_binary, current_dir)
    let s:path_composed = 'PATH=' . a:current_dir . '/node_modules/' . a:linter . '/bin' . ':$PATH && which ' . a:linter_binary
    let s:linter_which = system(s:path_composed)
    return Sanitize(s:linter_which)
endfunction

let s:current_dir = GetCurrentDir()
let syntastic_javascript_eslint_exec = Compose('eslint', 'eslint.js', s:current_dir)
let syntastic_typescript_tslint_exec = Compose('tslint', 'tslint', s:current_dir)
let syntastic_scss_stylelint_exec = Compose('stylelint', 'stylelint.js', s:current_dir)

if executable(syntastic_javascript_eslint_exec)
    let g:syntastic_javascript_checkers = [ 'eslint' ]
endif

if executable(syntastic_scss_stylelint_exec)
    let g:syntastic_scss_checkers = [ 'stylelint' ]
endif

if executable(syntastic_typescript_tslint_exec)
    let g:syntastic_typescript_checkers = [ 'tslint' ]
endif
