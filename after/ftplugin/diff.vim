" see: https://vim.fandom.com/wiki/Folding_for_diff_files
setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)
function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^\(diff\|---\|+++\|@@\) '
    return 1
  elseif line[0] =~ '[-+ ]'
    return 2
  else
    return 0
  endif
endfunction

"-- doesn't work (also without after)
"-- vim.opt.fillchars:append { diff = "╱" }
