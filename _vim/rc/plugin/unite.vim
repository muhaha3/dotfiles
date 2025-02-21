NeoBundle 'Shougo/unite.vim'
"NeoBundle 'yuku-t/unite-git'
NeoBundle 'Shougo/unite-outline'
"NeoBundle 'Shougo/unite-help'
"NeoBundle 'joker1007/unite-pull-request', { 'depends': 'mattn/webapi-vim' }
"let g:unite_enable_split_vertically = 1
"
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

" default profile
" ---------------
call unite#custom#profile('default', 'context', {
      \ 'winwidth': 50,
      \ 'start_insert': 1
      \ })

" The prefix key.
nnoremap [unite]  <Nop>
nmap     <space>  [unite]

" ctrlp.vim like behavior
" -----------------------
call unite#custom#profile('ctrlp', 'context', {
      \ 'start_insert': 1,
      \ 'winheight': 20,
      \ 'direction': 'botright',
      \ 'buffer_name': 'async'
      \ })
call unite#custom#source('file_rec/async,file_rec/git', 'ignore_pattern',
      \ '\v\/doc\/|.vagrant|.git\/|\/cache\/|.(png|gif|jpeg|jpg)$'
      \ )
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    " If current dir is root git directory.
    Unite -profile-name=ctrlp file_rec/git
  else
    Unite -profile-name=ctrlp file_rec/async:!
  endif
endfunction
nnoremap <silent> <C-p> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>

" unite/rails settings
" --------------------
NeoBundle 'basyura/unite-rails'
nnoremap <silent> [unite]p :<C-u>Unite -profile-name=ctrlp source<CR>rails/

" neomru
" ------
NeoBundle 'Shougo/neomru.vim'
"call unite#custom#source('file_mru', 'matchers', '.*\/$\|.*Application\ Data.*')
nnoremap <silent> [unite]m :<C-u>Unite -quick-match -profile-name=ctrlp neomru/file<CR>

nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir
            \ -buffer-name=files buffer bookmark file file/new<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir
            \ -buffer-name=files -prompt=%\ buffer bookmark file file/new<CR>
nnoremap <silent> [unite]/ :<C-u>Unite grep:.<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer<CR>
"nnoremap <silent> [unite]h :<C-u>Unite help<CR>
nnoremap <silent> [unite]t :<C-u>Unite
            \ -no-start-insert -immediately tab:no-current<CR>
nnoremap <silent> [unite]w :<C-u>Unite
            \ -no-start-insert -immediately window:no-current<CR>
nnoremap <silent> [unite]o :<C-u>Unite
            \ -vertical -no-quit -toggle -direction=botright
            \ -buffer-name=outline -winwidth=40 outline<CR>

augroup UniteFileType
    autocmd!
"    autocmd FileType vim    nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit help<CR>
"    autocmd FileType sh     nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/man<CR>
"    autocmd FileType erlang nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/erlang<CR>
"    autocmd FileType ruby   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/ri<CR>
"    autocmd FileType python nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/pydoc<CR>
"    autocmd FileType perl   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/perldoc<CR>
"
    autocmd FileType unite call s:unite_my_settings()
augroup END

function! s:unite_my_settings()
    " Overwrite settings
    nmap <buffer><ESC>  <Plug>(unite_exit)
    nmap <buffer><C-c>  <Plug>(unite_exit)
    nmap <buffer><C-x>  <Plug>(unite_redraw)
    "imap <buffer>jj     <Plug>(unite_insert_leave)
    imap <buffer><C-w>  <Plug>(unite_delete_backward_path)

    " <C-l>: manual neocomplete completion.
    "inoremap <buffer><C-l>  <C-x><C-u><C-p><Down>

    nmap <buffer><expr><C-d>  unite#do_action('delete')
    imap <buffer><expr><C-d>  unite#do_action('delete')
    nmap <buffer><expr><C-b>  unite#do_action('bookmark')
    imap <buffer><expr><C-b>  unite#do_action('bookmark')
    nmap <buffer><expr><C-k>  unite#do_action('above')
    imap <buffer><expr><C-k>  unite#do_action('above')
    nmap <buffer><expr><C-i>  unite#do_action('left')
    imap <buffer><expr><C-i>  unite#do_action('left')
endfunction
