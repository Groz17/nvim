-- Find a way to make a function of the commands provided so you can you use it in :?substitute(...\=)

-- Create the `tags` file
-- command! MakeTags !ctags -R .

-- command! GCC w | !gcc % -o %< && ./%< <CR>

-- https://www.reddit.com/r/vim/comments/4ouh89/comment/d4fx3iq/?utm_source=share&utm_medium=web2x&context=3
  -- vertical above new
-- Espandi al caso in cui il buffer originale non ha un file associato (usa u0?)
vim.api.nvim_create_user_command('DiffOrig', [[
  vertical new
  set buftype=nofile
  set bufhidden=wipe
  set noswapfile
  r #
  0d_
  let &filetype=getbufvar('#', '&filetype')
  execute 'autocmd BufWipeout <buffer> diffoff!'
  diffthis
  wincmd p
  diffthis
  setlocal diffopt=vertical,indent-heuristic,algorithm:histogram
]],

  {
    -- nargs = 0,
    desc = "Open user snippet package.json file"
  })

-- '[,']
-- from vim.keymap.set to lazy's keys (I have to do this a lot)
  -- v/^\s*--/s/vim\.keymap\.set(\(.*\))\s*/{mode=\1}, | s/mode="n",/
-- TODO: per multiline mappings, usa treesj api per collassarle in single line
-- TODO: align by desc with mini.ai or easy-align
-- first v/.../ is unnecessary
  -- '<,'>v/^\s*--/g/^\s*vim\.keymap\.set/s/vim\.keymap\.set(\(.*\))\s*$/{mode=\1},/ | s/mode="n",// | s/,\zs\s*{\(.*\)}/\1/
-- would have been nice to reuse global search
-- maybe put those 2 commands in lazy spec? also these only work for single-line mappings
-- vim.api.nvim_create_user_command('Keymap2keys', [[
--   '<,'>g/^\s*vim\.keymap\.set(.*)\s*$/s/^\s*vim\.keymap\.set(\(.*\))\s*$/{mode=\1},/ | s/mode=['"]n['"],// | s/,\zs\s*{\(.*\)}/\1/
--   '<,'>lua vim.lsp.buf.format({ range = { ["start"] = vim.api.nvim_buf_get_mark(0,"<"), ["end"] = vim.api.nvim_buf_get_mark(0,">"), } })
-- ]],
--   { range = true }
-- )

-- useful with global command
vim.api.nvim_create_user_command('Keymap2keys', [[
  s/^\s*vim\.keymap\.set(\(.*\))\s*$/{mode=\1},/ | s/mode=['"]\s*n\s*['"],// | s/,\zs\s*{\(.*\)}/\1/
]],
  { range = true }
)

-- How to use s:, <SID> here?
vim.api.nvim_create_user_command('Keys2keymap', [[
  fun! Keys2keymap(line)
  let key = a:line
  let mode=matchstr(key,'\(,\s*\)\=mode\s*=\s*\zs\({[^}]*}\|[''"]\a[''"]\)')
  let key = substitute(key,'\(,\zs\s*\)\=\s*mode\s*=\s*' .. mode .. '\s*,\=','','')
  if mode == ""
  let mode=string('n')
  endif
  let key = substitute(key,',\zs\(\s*\a\+\s*=\s*.*\)\ze}\s*,\s*$', '{\1}','')
  let key = substitute(key,'^\s*{','vim.keymap.set(' .. mode .. ',','')
  let key = substitute(key,'}\s*,\s*$',')','')
  return key
  endfun

  g/^\s*{.*}\s*,\s*$/call setline('.',Keys2keymap(getline('.')))
  " "'<,'>!stylua --collapse-simple-statement Always --column-width 999 -
]],
  -- how to have default line as range?
  { range = true }
)

-- https://github.com/StefanBRas/.files/blob/73d037c74ef56e5c924a489f9428e849b52ead11/.config/nvim/lua/commands/init.lua#L4
--[[ ignore this for now
vim.cmd 'command -nargs=1 -complete=filetype NRMM' ..
            'let b:nrrw_aucmd_create = "set ft=" . <q-args>' ..
            '| :execute ":g/```{" . <q-args> . "/+1,/```/-1 NRP' ..
            '| NRM'

--]]
--

-- -- for html
-- -- vim.api.nvim_buf_create_user_command('DeleteColumn', function(opts)
-- vim.api.nvim_create_user_command('DeleteColumn', function(opts)

-- -- vim.fn.system("xidel -e 'x:replace-nodes(//*[self::td|self::th][(position()-N) mod 8 eq 0],())' --html")
-- -- vim.fn.system([[xidel -se --variable="num_columns=$(xidel -e 'count(//tr[1]/th)')"  --variable"=chosen_column="]]..opts.args..
-- [[ 'x:replace-nodes(//*[self::td|self::th][(position()-N) mod 8 eq 0],())' --html ]])

--   local stdin = vim.api.nvim_buf_get_lines(0,0,-1,0)
-- -- local num_columns = vim.fn.system("xidel -e 'count(//tr[1]/th)'",stdin)
-- local num_columns = vim.fn.system("xidel -e 'count(//table[1]/tr[1]/th)'",stdin)
-- vim.api.nvim_buf_set_lines(0,0,-1,0, vim.fn.split(vim.fn.system("xidel -s --variable=num_columns="..num_columns..
-- " --variable=chosen_column="..opts.args.." -e 'x:replace-nodes(//*[self::td|self::th][(position()-$chosen_column) mod $num_columns eq 0],())' --html",stdin),"\n"))
-- end ,
--   {nargs = 1, range= true}

-- )

-- vim.api.nvim_create_user_command('PerlGrep','perldo $_=$_=~/<args>/?$_:""',{nargs = 1})
vim.api.nvim_create_user_command('PerlGrep','perldo $_=$_=~/<args>/?$_:""',{nargs = 1})

-- from vim help
vim.api.nvim_create_user_command('TermHl', function()
  local b = vim.api.nvim_create_buf(false, true)
  local chan = vim.api.nvim_open_term(b, {})
  vim.api.nvim_chan_send(chan, table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n'))
  vim.api.nvim_win_set_buf(0, b)
end, { desc = 'Highlights ANSI termcodes in curbuf' })

vim.api.nvim_create_user_command('DebugEmacsConfig', [[
vimgrep/^#+begin_src\c/ ~/.config/emacs/config.org
let list = getqflist()->map({_,v->#{lnum:v.lnum,text:v.text}})
let list_length = list->len()
let rand_left = rand()%list_length
let rand_right = rand()%(list_length-rand_left)
let random_subset = list[rand_left:rand_left+rand_right]->map({_,v->v.lnum})
for line in random_subset | exe line..'s/^/;;/' | endfor
wincmd n
pu=random_subset
]]
, { desc = 'Test Emacs config...' })

-- https://www.reddit.com/r/neovim/comments/1ov1gtr/difftool_wrapper/
vim.api.nvim_create_user_command('DirDiff', function(opts)
  if vim.tbl_count(opts.fargs) ~= 2 then
    vim.notify('DirDiff requires exactly two directory arguments', vim.log.levels.ERROR)
    return
  end

  vim.cmd 'tabnew'
  vim.cmd.packadd 'nvim.difftool'
  require('difftool').open(opts.fargs[1], opts.fargs[2], {
    rename = {
      detect = false,
    },
    ignore = { '.git' },
  })
end, { complete = 'dir', nargs = '*' })
