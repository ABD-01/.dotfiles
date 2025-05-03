nnoremap <silent> <Leader>v :call fzf#run({'right': winwidth('.') / 2,'sink':  'vertical botright split' })<CR>
nnoremap <silent> <Leader>s :call fzf#run({'down': '40%','sink': 'botright split' })<CR>
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
