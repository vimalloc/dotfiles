" Fix for readline issue with binding.pry
let test#ruby#rspec#executable = 'RUBYOPT="-W0" bundle exec rspec'
let test#javascript#jest#executable = 'pnpm jest'

let test#strategy = "neovim"
let test#neovim#term_position = "horizontal botright 25"

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tl :TestLast<CR>

" Allow using escape to move to command mode in terminal and scroll upwards
tnoremap <Esc> <C-\><C-n>
