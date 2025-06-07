function! Set(args, isPersistent) abort
  " remove whitespaces surrounding =
  let cmd = 'set ' . substitute(a:args, '\s*=\s*', '=', 'g')
  execute cmd

  if !a:isPersistent | return | endif

  " append modeline
  let commentstring = empty(&l:commentstring) ? 
    \ (empty(&g:commentstring) ? '# %s' : &g:commentstring) : &l:commentstring
  let modeline = substitute(commentstring,'%s',' vim: ' . cmd . ': ', '')
  call append(line('$'), '')
  call append(line('$'), trim(modeline))
endfunction

command! -nargs=+ -bang -bar  -complete=option                          Set           call Set(<q-args>, <bang>0)

command! -nargs=1 -bang -bar                                            SetSpelllang  Set<bang> spelllang=<args>
command! -nargs=1 -bang -bar -complete=filetype                         SetFileType   Set<bang> filetype=<args>
command! -nargs=1 -bang -bar -complete=customlist,s:complete_foldmethod SetFoldMethod Set<bang> foldmethod=<args>

function! s:complete_foldmethod(arglead, cmdline, cursorpos)
  return filter(['marker', 'indent', 'syntax', 'expr', 'manual', 'diff'], 'v:val =~? "^" . a:arglead')
endfunction
