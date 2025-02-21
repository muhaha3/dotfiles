"" ftdetects
augroup MyFileTypeDetect
    au!
    au BufRead,BufNewFile Capfile,Gemfile,*.cap,*.god set filetype=ruby
    au BufRead,BufNewFile *.json                set filetype=javascript
    au BufRead,BufNewFile *.md                  set filetype=markdown
    au BufRead,BufNewFile *.PL,*.psgi,*.t       set filetype=perl
    au BufRead,BufNewFile .tmux.conf,tmux.conf  set filetype=tmux
    au BufRead,BufNewFile *.jade                set filetype=jade
    au BufRead,BufNewFile *.less                set filetype=less
    au BufRead,BufNewFile *.coffee              set filetype=coffee
    au BufRead,BufNewFile *.hatena              set filetype=hatena
    au BufRead,BufNewFile *.pp                  set filetype=puppet
    au BufRead,BufNewFile *.scss                set filetype=scss
    au BufRead,BufNewFile *.ts                  set filetype=typescript
augroup END


"" Golang
" We take care to preserve the user's fileencodings and fileformats,
" because those settings are global (not buffer local), yet we want
" to override them for loading Go files, which are defined to be UTF-8.
let s:current_fileformats = ''
let s:current_fileencodings = ''

" define fileencodings to open as utf-8 encoding even if it's ascii.
function! s:gofiletype_pre()
  let s:current_fileformats = &g:fileformats
  let s:current_fileencodings = &g:fileencodings
  set fileencodings=utf-8 fileformats=unix
  setlocal filetype=go
endfunction

" restore fileencodings as others
function! s:gofiletype_post()
  let &g:fileformats = s:current_fileformats
  let &g:fileencodings = s:current_fileencodings
endfunction

augroup MyGolangConfig
    au!
    au BufNewFile *.go setlocal filetype=go fileencoding=utf-8 fileformat=unix
    au BufRead *.go call s:gofiletype_pre()
    au BufReadPost *.go call s:gofiletype_post()
augroup END
