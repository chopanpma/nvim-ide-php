" autocmd BufWritePost *.php silent! call CocAction('format')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType php setl formatexpr=CocAction('format')
augroup end

map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <F3> :NERDTreeToggle<CR>
nmap ,t :NERDTreeFind<CR>
