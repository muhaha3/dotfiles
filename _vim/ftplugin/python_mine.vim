"------------------------------------------------------------
" Code Style
"------------------------------------------------------------
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal textwidth=79
setlocal number

if v:version >= 703
    setlocal colorcolumn=80
endif

"------------------------------------------------------------
" Django
"------------------------------------------------------------
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
