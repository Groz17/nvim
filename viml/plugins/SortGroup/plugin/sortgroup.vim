if exists('g:loaded_sortgroup')
    finish
endif
let g:loaded_sortgroup = 1

command! -range=% -bang -nargs=+ SortGroup <line1>,<line2>call sortgroup#sort_by_header(<bang>0, <q-args>)
