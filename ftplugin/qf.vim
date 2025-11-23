" smooth scroll
" make this work for other motions like c-d, etc...
nnoremap<buffer><expr> k line('.')==1? 'G':'k'
nnoremap<buffer><expr> j line('.')==line('$')? 'gg':'j'
nnoremap<buffer> l <cr><c-w><c-p>
nnoremap<buffer> <m-cr> <cr><c-w><c-p>

nnoremap<buffer> <space> <cr><c-w><c-p>
nnoremap<buffer> <tab> <cr>
