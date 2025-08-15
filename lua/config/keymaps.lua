-- find better way for comment string of multiple chars
-- vim: foldmethod=expr foldexpr=getline(v\:lnum)=~'^--\ ┣'?'>1'\:getline(v\:lnum)=~'^--\ ─'?'>2'\:'=':
-- Rules:
-- Never use literal spaces in a mapping, use <space> (formatting may take those away and it's more explicit):
  -- sii esplicito con lo spazio finale:
  -- { '<leader>gC',     ':Git commit -v -q<space>' },
-- Use uppercase version of a mapping if you need to add command/function arguments, for example use lowercase for current file (%) and uppercase for other files (used in fugitive, eunuch, etc...)
  -- Maybe instead you could add a colon after the mapping (use gc: instead)
-- Don't use leader(s) mappings for operators (ex: surround), use them for stuff like windows (undotree), or general plugin mappings that don't define an operator (or text object of course)
-- Iniziale uppercase per desc field (apparte vim-unimpaired): rg 'desc\s*=\s*\W+[a-z]' --vimgrep |v -q-
-- Usa ... in desc when there are args, like for fugitive/nvim-devdocs (maybe another symbols for 0/1 args and another for 0/n and another for 1/n?)
-- take inspiration from emacs/nano mappings 
-- leader: categories, space: mapping di convenienza, like <space>{j,k} for diagnostics

-- considera telescope non come un plugin ma come un comando in core

---see https://github.com/echasnovski/mini.nvim/blob/91f7a680fe5765b68456ab6e7b910d478da083b9/lua/mini/basics.lua#L548-L549

 -- scriptease mapping? fallback to that/syntax if no treesitter...
 -- works with right click too
vim.keymap.set('n', 'zS', '<cmd>Inspect<CR>')

---see [How to insert newline without entering insert mode? : r/neovim](https://www.reddit.com/r/neovim/comments/10kah18/how_to_insert_newline_without_entering_insert_mode/)
-- Add empty lines before and after cursor line
-- vim.keymap.set('n', '<c-s-cr>', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
-- vim.keymap.set('n', '<c-cr>', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- add mapping in visual mode for commenting and adding todo, etc... (using v:count and gc), like 4gc for HACK or something

-- vim.keymap.set('n','<leader>N','<cmd>tabnew|e /tmp/notes.anki|set ft=anki<cr>')
-- vim.cmd[[
-- " I'd like to know if there's not a window above, if not use <c-w>j
-- nnoremap <expr> k v:count1>=line('.')?'<c-w>k':'k'
-- " I'd like to know if there's not a window below, if not use <c-w>k
-- nnoremap <expr> j v:count1>line('$')-line('.')?'<c-w>j':'j'
-- nnoremap <expr> h v:count1>=charcol('.')?'<c-w>h':'h'
-- nnoremap <expr> l v:count1>charcol('$')-1-charcol('.')?'<c-w>l':'l'
-- ]]

-- /usr/local/share/nvim/runtime/doc/cmdline.txt
-- how to never make it quit? like a repl
vim.cmd([[autocmd CmdwinEnter * map <buffer> <C-CR> <CR>q:]])

-- vim-for-php-programmers.pdf
-- map CTRL-L to piece-wise copying of the line above the current one
-- vim.keymap.set('i','<C-L>', '@@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s')
-- fixa per copiare word?
-- these two show up in which-key, FIX
-- vim.keymap.set('i','yW', '@@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s')
-- vim.keymap.set('i','yw', '@@@<ESC>hhjywkl?@@@<CR>P/@@@<CR>3s')

-- paste but leave empty lines above/below
-- vim.keymap.set('n', "<KEY>",[[o<esc>p]])
-- vim.keymap.set('n', "<KEY>",[[O<esc>P]])

-- vim.keymap.set('n', 'z<C-g>', "<cmd>call setreg('+', getreg('%').'#'.line('.'))<CR><C-g>")

-- vim.keymap.set('c', '<c-s>', "submatch")
-- check if \= before though
-- vim.keymap.set('c', '\d (da 0 a 9)', "submatch (da0 a 9)")

-- kinda cool: mappings similar to the one with <++> as placeholder
-- vim.keymap.set('n', '<space><space>', "<CMD>bmod<CR>")

--select whatever's just been pasted, or read into the buffer via :r! etc, respecting line/char visual mode. (https://www.reddit.com/r/vim/comments/4aab93/weekly_vim_tips_and_tricks_thread_1/)
-- vim.keymap.set('n', 'gV', function() return '`[' .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. '`]' end, { expr = true })
vim.keymap.set('n', 'gV', function() vim.api.nvim_feedkeys("`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]", "n", false) end, { desc =  "Switch to VISUAL using last paste/change" })

-- vim.keymap.set("n", "gV", [['`[' . strpart(getregtype(), 0, 1) . '`]']], { expr = true })

-- TODO: control
vim.keymap.set('!',[[<M-\>]], [[<CMD>s/\(^.*\zs\(\s*\)\)\%#\s*/\=cursor(0,strlen(submatch(1))-strlen(submatch(2)))<CR>]])

vim.keymap.set('n', '<bs>', '<cmd>restart<cr>', { desc =  "Restart" })

-- vim.keymap.set('n', '<C-S-R>', "<CMD>exec 'undo' undotree()['seq_last']<CR>")

-- https://github.com/LazyVim/LazyVim/blob/13a4a84e3485a36e64055365665a45dc82b6bf71/lua/lazyvim/config/keymaps.lua#L64
-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- ┣ File Operations
-- INFO: "<C-R>=expand("%:t")<CR>" -> expands the current filename in the command line

-- from https://yazi-rs.github.io/docs/quick-start
-- what about g<c-y>? y and then modifier?
vim.keymap.set('n', [[<space>yy]], [[<cmd>let @" = expand("%:p")   | echo 'cb> ' . @"<CR>]])
vim.keymap.set('n', [[<space>yd]], [[<cmd>let @" = expand("%:p:h") | echo 'cb> ' . @"<CR>]])
vim.keymap.set('n', [[<space>yf]], [[<cmd>let @" = expand("%:p:t") | echo 'cb> ' . @"<CR>]])
-- n stands for name? good if so
vim.keymap.set('n', [[<space>yn]], [[<cmd>let @" = expand("%:p:r") | echo 'cb> ' . @"<CR>]])
-- yank filename + line [souce :))]
vim.keymap.set('n', [[<space>yl]], [[<cmd>let @" = expand("%:p") .. ":" .. line(".")   | echo 'cb> ' . @"<CR>]])

-- also create concatente yank
-- create also for normal mode
-- maybe also add last line?
vim.keymap.set('x','<space>y',function()
    vim.cmd.norm('y')
    vim.fn.setreg(vim.v.register, vim.list_extend({vim.fn.expand('%:p') .. ":" .. vim.fn.line("'<")},vim.fn.getreg(vim.v.register,'',true)))
end)

-- create one that instead insert the current block header (function, class, etc...) with its line number ofc (for context)
-- vim.keymap.set('x','<leader>y',function()

-- ┣ Insert and append inside text object
-- https://gist.github.com/wellle/9289224

-- usa kanata for these, and/or comfy j<.> mapping in insert mode
vim.cmd([[
" insert and append inside text object (it's cool with remote flash.nvim's operator)
" use same mappings as adding separator at start/end of line, like <leader>, (start) | ,: (end) -> c (or other letter) <leader> | c:
" nnoremap <silent> s :set opfunc=Append<CR>g@
" nnoremap <silent> S :set opfunc=Insert<CR>g@

"nnoremap <silent> <A-h> :set opfunc=Insert<CR>g@
"nnoremap <silent> <A-l> :set opfunc=Append<CR>g@
" actually useless, since you have 4 combinations with {A,I} and {a,i}
" nnoremap <silent> <f13>k :set opfunc=Append<CR>g@
" nnoremap <silent> <f13>j :set opfunc=Insert<CR>g@

" maybe make this work with mini-ai and also make four mappings: {before,after}\ {initial,final}\ text\ object\; (MiniAi.move_cursor() and g[)
" actually it already works: sib, sab, Sib, Sab
function! Append(type, ...)
" change inside n character? use v:count (or to add spaces/newlines)
" normal! `]
normal! `]
" make this work with treesitter-textobjects like loop, etc... (modify if condition); actually, you could do cIVif to force linewise motion
if a:type == 'char'
call feedkeys("a", 'n')
else
call feedkeys("o", 'n')
endif
endfunction
function! Insert(type, ...)
normal! `[
if a:type == 'char'
call feedkeys("i", 'n')
else
call feedkeys("O", 'n')
endif
endfunction


]])

-----------------------------------------------------------
---- Change inside middle (on the screen) function
-----------------------------------------------------------

-- ciMf

-----------------------------------------------------------
---- How to apply operator to all text objects inside a region?
-----------------------------------------------------------

---@see https://github.com/ibhagwan/fzf-lua/issues/532#issuecomment-1269523365
vim.keymap.set('t', '<M-r>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })

-- Mirrors i3/window manager mappings
-- use similar mappings of visual-split.vim
-- Maybe open with the path of the buffer that calls it?
-- TODO: check if normal file, like not fugitive or healthcheck file
-- vim.keymap.set('n', '<c-`>', '<CMD>vert split term://%:p:h//bash<CR>')
-- vim.keymap.set('n', '<c-space>', '<CMD>split term://%:p:h//bash<CR>')
-- vim.keymap.set('n', '<leader><cr>', '<CMD>vert split term://%:p:h//bash<CR>')
-- usa right shift 😀  
-- vim.keymap.set('n', '<leader><s-cr>', '<CMD>bot 17split term://%:p:h//bash<CR>')
-- https://www.reddit.com/r/neovim/comments/138wi21/open_terminal_in_split_with_working_directory_of/
-- vim.keymap.set('n', '<leader><cr>', '<CMD>vsplit term://%:p:h//bash <CR>')
-- vim.keymap.set('n', '<leader><s-cr>', '<CMD>bot 17split term://%:p:h//bash<CR>')
-- nnoremap <silent> <leader><cr> :vert :term<cr>L
-- vim.keymap.set('t','<leader><esc>',[[<c-\><c-n>]])
vim.keymap.set('t','<s-esc>',[[<c-\><c-n>]])
-- vim.keymap.set('t','jk',[[<c-\><c-n>]])
-- magari usali anche in insert mode (con betterescape ofc)
-- press <c-v> before j,k,l to insert them without executing mapping
-- Rarely it just says the message, but doesn't save
-- Doesn't work well with sc-im
-- vim.keymap.set('t','jj','<CR>')
-- vim.keymap.set('t','jk',[[<c-\><c-n>]])
-- vim.keymap.set('t','jl',[[<c-\><c-n>]])
-- jk seems more comfortable (magari fai mapping complesso in blink.cmp?)
-- kanata macro?
-- Seems a little harder to press (you need more mental effort), to save only when you really mean it!
-- what about tabout mappings?
-- ha senso usare <esc> qui?
-- comfortable with left hand right?
-- TODO: fai che quando è a inizio della riga fa due spazi... (^%s*)
-- maybe check if the next character is not a newline (for markdown)
-- magari non usarlo per command-line mode? troppo rischioso
-- TODO: how to insert space between string? i wanna set ttimeoutlen to 0
-- fixa bug quando devi inserire spazio prima di salvare...
-- forces u to use alt terminal trick
--
-- for snippets mappings
-- vim.keymap.set('n','<tab>','<nop>')

-- magari go to right after (l?)
-- vim.keymap.set('i','<space><space><space>','<space><cmd>up<cr><esc>l')
-- vim.keymap.set('i','<space><space><space>','<space><cmd>up<cr><esc>')
-- https://github.com/rdpopov/nvim-sak
-- TODO: just one undo block?
vim.keymap.set('x','<space><space>', ":normal ",{desc="Execute normal mode command over visual selection"})
-- what about this without <ESC>?
-- use space for general QOL keymaps and leader (s/l,a/;) for plugins/mappings not categorized?

-- scratch buffer
-- non devo escapare |???
-- vim.keymap.set('n','<c-w>N','<cmd>bo new<bar>startinsert<CR>')

-- https://www.reddit.com/r/neovim/comments/pibo9c/how_to_focus_an_opened_floating_window/
-- <c-w><space> similar to i3 mapping win+space
vim.cmd([[function! s:GotoFirstFloat() abort
for w in range(1, winnr('$'))
let c = nvim_win_get_config(win_getid(w))
if c.focusable && !empty(c.relative)
execute w . 'wincmd w'
endif
endfor
endfunction
noremap <f16><space> :<c-u>call <sid>GotoFirstFloat()<cr>]])

-- vim.cmd[[cmap <M-C-e> <c-\>eexpandcmd(getcmdline())<CR>]]
vim.keymap.set('c','<M-C-e>',[[<c-\>eexpandcmd(getcmdline())<CR>]])

-- https://www.reddit.com/r/neovim/comments/1be2fty/comment/kusw4dl/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- vim.keymap.set('i', 'df', '<c-o>', { desc = 'Ergonomic <C-o>' })
-- vim.keymap.set('i', 'fd', '<c-o>', { desc = 'Ergonomic <C-o>' })
-- vim.keymap.set('i', 'jd', '<c-o>', { desc = 'Ergonomic <C-o>' })

-- if !common#functions#HasPlug('ResizeWindow.vim')
-- nnoremap <M--> :resize +3<CR>
-- nnoremap <M-_> :resize -3<CR>
-- nnoremap <M-(> :vertical resize -3<CR>
-- nnoremap <M-)> :vertical resize +3<CR>
-- endif
-- doesn't seem to work in kitty
-- vim.keymap.set('n','<c-s-k>','<CMD>exe "abo " ..  (v:count ?? "") .. "split"<cr>')
-- vim.keymap.set('n','<c-s-h>','<CMD>exe "abo " ..  (v:count ?? "") .. "vsplit"<cr>')
-- vim.keymap.set('n','<c-s-j>','<CMD>exe "rightbelow " ..  (v:count ?? "") .. "split"<cr>')
-- vim.keymap.set('n','<c-s-l>','<CMD>exe "rightbelow " ..  (v:count ?? "") .. "vsplit"<cr>')
-- -- cool mappings
-- vim.keymap.set('n','<c-w>k','<CMD>exe "abo " ..  (v:count ?? "") .. "new|startinsert"<cr>')
-- vim.keymap.set('n','<c-w>h','<CMD>exe "abo " ..  (v:count ?? "") .. "vnew|startinsert"<cr>')
-- vim.keymap.set('n','<c-w>j','<CMD>exe "rightbelow " ..  (v:count ?? "") .. "new|startinsert"<cr>')
-- vim.keymap.set('n','<c-w>l','<CMD>exe "rightbelow " ..  (v:count ?? "") .. "vnew|startinsert"<cr>')
-- vim.keymap.set('n','<c-w><c-k>','<CMD>exe "abo " ..  (v:count ?? "") .. "new|startinsert"<cr>')
-- vim.keymap.set('n','<c-w><c-h>','<CMD>exe "abo " ..  (v:count ?? "") .. "vnew|startinsert"<cr>')
-- vim.keymap.set('n','<c-w><c-j>','<CMD>exe "rightbelow " ..  (v:count ?? "") .. "new|startinsert"<cr>')
-- -- pressing <c-o>telescope filetype inserts an A randomly
-- vim.keymap.set('n','<c-w><c-l>','<CMD>exe "rightbelow " ..  (v:count ?? "") .. "vnew|startinsert"<cr>')
-- :[count]winc[md] {arg} solution???

-- Fullscreen buffer
-- nnoremap <leader>f :tab split<CR>

-- ┣ Translation
--~ -> synonym (Google).
--nnoremap <leader>~ thesanosaurus :))
-- google trans command line synonym

--nnoremap <silent> <leader>t :w !trans :it ''<cr>
-- nnoremap <silent> cot :w !trans :it ''<cr>
-- Uppercase letters are supercharged versions of the corrisponding lowercase letters
-- nnoremap <silent> coT :exe 'w !trans -b :'.input('> ').' ""'<cr>
-- nnoremap <silent> <leader>T :exe 'w !trans -b :'.input('> ').' ""'<cr>



-- paste (from https://github.com/aligrudi/neatvi)
-- can't use in command-line mode sadly
-- inoremap <c-p> <c-r>+
-- ino <silent><expr> <c-p> pumvisible() ? "\<c-p>" : "\<c-r>+"

-- cnoremap <C-R><C-L> <C-R>=substitute(getline('.'), '^\s*', '', '')<CR>
--
-- add mapping that pastes but with a space before


-- ZJ AND ZK FOR OPENED FOLD?
--  go to the header one level down/up
-- nnoremap zK 2[zzz
-- nnoremap zJ 2]zzz

-- ┣ Edit

-- kanata k: also mnemonic for keyboard
vim.api.nvim_exec2([[
for f in readdir(expand('~/dotfiles'),{f->f=~'^[^_].\+.org$'})
    "exe "nnoremap <leader>e".f[0] "<cmd>tab drop ~/dotfiles/".f.."<cr>"
    call v:lua.vim.keymap.set('n','<leader>e'.f[0],"<cmd>tab drop ~/dotfiles/".f.."<cr>",#{desc: f[:-5]})
endfor
]],{})

-- -- magari versione uppercase per scripts?
-- -- vim.keymap.set('n','<leader>eq',function() return [[<CMD>tab drop ~/.config/nvim/]] .. vim.bo.filetype .. [[/query.scm<cr>]] end,{expr = true, desc="Treesitter queries"})
-- -- select one plugin file and then list all plugins inside (like for ex first select treesitter and then open telescope again and list textobjects, context, and jump to the corresponding spec) {lazy treesitter}
-- -- vim.keymap.set('n','<leader>eP', [[<cmd>lua require("telescope.builtin").live_grep{cwd = vim.fn.stdpath("config") .. "/lua/plugins",additional_args}<cr>]], { silent = true, desc = "Plugins" })
-- -- rg -o --vimgrep --pcre2 '^\s*[^-]['\''"][a-zA-Z0-9]+([-_][a-zA-Z0-9]+)*/\K[a-zA-Z0-9]+([-_\.][a-zA-Z0-9]+)*[-_\.]?[a-zA-Z0-9]+(?=['\''"])' | sort -t: -k4 -u
-- -- vim.keymap.set('n','<leader>eg', [[<CMD>exe "tab drop ".systemlist('git rev-parse --show-toplevel 2> /dev/null')[0]."/.gitignore"<cr>]],{desk="Local Git"})
-- -- magari append `` to end of mapping
-- vim.keymap.set('n','<space>ei', [[<CMD>exe "tab drop" systemlist('git rev-parse --show-toplevel 2> /dev/null')[0]."/.gitignore"<cr>]],{desc="Local gitignore"})
-- vim.keymap.set('n','<space>eI', [[<CMD>tab drop ~/.gitignore<cr>]],{desc="Global gitignore"})
-- vim.keymap.set('n','<space>eg', [[<CMD>exe "tab drop" systemlist('git rev-parse --show-toplevel 2> /dev/null')[0]."/.gitconfig"<cr>]],{desc="Local gitconfig"})
-- vim.keymap.set('n','<space>eG', [[<CMD>tab drop ~/.gitconfig<cr>]],{desc="Global gitconfig"})
vim.keymap.set('n','<space>ev', [[<CMD>tab drop ~/.config/nvim/lua/config/keymaps.lua<cr>]],{desc="Vim keymaps"})
-- vim.keymap.set('n','<space>ez', [[<CMD>tab drop ~/.config/zellij/config.kdl<cr>]],{desc="Zellij"})
vim.keymap.set('n','<space>ee', [[<CMD>tab drop ~/.config/emacs/config.org<cr>``]],{desc="Emacs"})
vim.keymap.set('n','<space>e<cr>', [[<CMD>tab drop ~/dotfiles/_ghostty.org<cr>``]],{desc="Ghostty"})
-- -- vim.keymap.set('n','<space>eq', [[<CMD>tab drop ~/.config/qutebrowser/config.py<cr>]],{desc="Qutebrowser"})
-- vim.keymap.set('n','<space>eq',function() return [[<CMD>tab drop ~/.config/nvim/]] .. vim.bo.filetype .. [[/query.scm<cr>]] end,{expr = true, desc="Treesitter queries"})
-- vim.keymap.set('n','<space>ex', [[<CMD>tab drop ~/.config/xournalpp/plugins/vi-xournalpp/keybindings.lua<cr>]],{desc="Xournalpp"})
-- vim.keymap.set('n','<space>el', [[<CMD>tab drop ~/.config/lazygit/config.yml<cr>]],{desc="Lazygit"})
-- -- vim.keymap.set('n','<space>eP', [[<cmd>lua require("telescope.builtin").live_grep{cwd = vim.fn.stdpath("config") .. "/lua/plugins",additional_args}<cr>]], { silent = true, desc = "Plugins" })
-- -- rg -o --vimgrep --pcre2 '^\s*[^-]['\''"][a-zA-Z0-9]+([-_][a-zA-Z0-9]+)*/\K[a-zA-Z0-9]+([-_\.][a-zA-Z0-9]+)*[-_\.]?[a-zA-Z0-9]+(?=['\''"])' | sort -t: -k4 -u
-- -- ev.? dove . e o/k/... per options, keymaps, etc...? neovim api menu?

-- wait for these to get into neovim core
-- operator mapping?
vim.keymap.set({'n', 'x'}, 'g}', "<CMD>'}-<CR>")
vim.keymap.set({'n', 'x'}, 'g{', "<CMD>'{+<CR>")

-- Centering :substitute matches
-- would be cool to have presubstitute autocommand to use this option...
-- com! -nargs=* -complete=command ZZWrap let &scrolloff=999 | exec <q-args> | let &so=0
-- noremap <Leader>sc :ZZWrap %s///gc<Left><Left><Left><Left>
-- add slash (didn't want to use arrow keys)
-- noremap <Leader>sc :ZZWrap %s//gc<Left><Left><Left>

-- posizionati sulla riga adeguata
-- delete duplicate
-- <leader>d for debugging?
-- vim.keymap.set('x','<leader>dd',[[:!awk '\!NF <Bar><Bar> \!x[$0]++'<CR>]],{silent=true})
-- ignore whitespace?
-- Make it an operator like dD (same thing with deleting empty lines (maybe dS?))
-- vim.keymap.set('x','<leader>DD',[[:!awk '\!NF <Bar><Bar> \!x[$0]++'<CR>]],{silent=true})
vim.keymap.set('x','<BS>',[[:!awk '\!NF <Bar><Bar> \!x[$0]++'<CR>]])
-- S in shift sta per space (space remove mnemonic)
-- maybe s-bs to remove duplicates ignoring whitespace?
vim.keymap.set('x','<S-BS>',[[:g/^$/d_<CR>]])
-- vim.keymap.set('x','<a-BS>',[=[:g/^\s\+$/d_<CR>]=])
vim.keymap.set('x','<a-BS>',[[:g/^\s*$/d_<CR>]])
vim.keymap.set('x','<c-BS>',[[:s/\s\+$<CR>]])

-- use substitute to delete everything that's not an url in lines before passing to curl...
vim.keymap.set('n','<space>#',[[<CMD>echo (systemlist("xidel --input-format html -e 'normalize-space(//title)' " .string(shellescape(matchstr(getline("."),'https\=:\/\/[^ ]*'))))[0])<cr>]], {desc="Show URL title"})
-- how to display title like dunstify? so for ex you could do it for youtube links: YT\nTITLE
-- vim.keymap.set('n','<leader>ti',[[<CMD>echo luaeval('vim.notify(_A)',trim(systemlist("xidel --input-format html -e //title " .string(shellescape(matchstr(getline("."),'https\=:\/\/[^ ]*'))))[0]))<cr>]], {silent=true})
-- add error handling (video removed, etc...)
-- to avoid pressing ENTER... exe "set cmdheight=".line("'>")-line("'<) ... command ... set cmdheight=1
-- xnoremap <silent><silent>  <leader>st :<c-u>echo join(systemlist("htmlq meta[property=\"og\\:title\"] --attribute content -f <(curl -Ls " .join(getline("'<","'>")).")"),"\n")<cr>

-- blockdenting {Is there a pretty-printer (formatter) for Perl? [perlfaq3]}
-- map! <c-o> {<cr>}<esc>O<c-t>
-- inoremap <c-o> {<cr>}<esc>O<c-t>
-- inoremap <c-b> {<cr>}<esc>O<c-t>
-- ce gia autoindent no?
-- inoremap <c-b> {<cr>}<esc>O
-- magari usare shellescape no eh? sytemlist also?
-- vim.cmd([[exe "inoremap <a-r> \<c-r>=systemlist('')[0]<left><left><left><left><left>"]])

-- you can type \zz to toggle the value of 'scrolloff' between 0 and 999: 
-- nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

-- nnoremap <a-r> :mode<cr>

-- vnoremap g/ <ESC>/\%V

-- vertical scope
-- note: g? in the example overwrites the superfun native rot13 command
-- nnoremap <expr> g/ '/<C-u>\%>'.(col(".")-v:count1).'v\%<'.(col(".")+v:count1).'v'
-- nnoremap <expr> g? '?<C-u>\%>'.(col(".")-v:count1).'v\%<'.(col(".")+v:count1).'v'

-- End macros in command mode
-- cnoremap <c-q> <c-f>i<c-o>q

-- maybe to a textyankpost and let @"=@1?
-- smart dd (https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/)
-- What if there's a v:count?
-- do it for x,c, etc... also for stuff like d2j if all are blank lines...
vim.keymap.set( "n", "dd", function() return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or 'dd' end, { expr = true } )

-- Remove last character from line
-- mapping comodo, usa middle finger per entrambi i tasti
-- Make those work with v:count and dot-repeat
-- what about these in insert mode?
-- use repeat#set?
-- use a 1-letter mapping? like ctrl (maybe modifier)
vim.keymap.set("n", "dx", 'm`$"_x``')
-- vim.keymap.set("n", "dX", 'm`^"_x``')
vim.keymap.set("n", "dX", 'm`0"_x``h')

-- create mapping in insert mode to go back to previous quote if inside string, previous brace if inside parenthesis, etc...

-- ┣ diff mappings

-- add mapping that doesn't show context lines
-- use <c-w>o instead of going to other window and deleting it...
-- vim.keymap.set('n', "dO",[[<cmd>DiffOrig<CR>]])
-- like emacs mapping

vim.keymap.set('n', "d=",[[<cmd>DiffOrig<CR>]])
-- vim.keymap.set("n", "du", '<CMD>diffupdate!<CR>')

-- telescope or maybe even create hydra for diffopt options to test diffs
-- vim.keymap.set("n", "d" .. vim.g.tleader, ':set diffopt=$(telescope list diffopt options)')
-- add multiple selection option? separate by commas?
vim.keymap.set("n", "dO", function()
   -- TODO: parsa vimdoc
    vim.ui.select({
        'filler',
        'context:{n}',
        'iblank',
        'icase',
        'iwhite',
        'iwhiteall',
        'iwhiteeol',
        'horizontal',
        'vertical',
        'closeoff',
        'hiddenoff',
        'foldcolumn:{n}',
        'followwrap',
        'internal',
        'indent-heuristic',
        'linematch:{n}',
        'algorithm:{text}',
    }, {
            prompt = 'Select diffopt option:',
            format_item = function(item)
                -- show help description on preview
                return item
            end,
        }, function(choice)
            -- also add option to remove
            -- open secondo telescope with algorithm options
            -- if choice == 'algorithm:{text}' then
            if choice:sub(#choice) == '}' then

                if choice == 'algorithm:{text}' then
                    -- maybe remove algorithm if already there?
                    vim.ui.select({ 'myers', 'minimal', 'patience', 'histogram' }, { prompt = 'Select algorithm:'}, function(algorithm) vim.opt.diffopt:append('algorithm:' .. algorithm) end)
                else
                    choice = vim.fn.substitute(choice,'{n}$','','')
                    vim.ui.input({ prompt = 'Enter value for '..choice..': ' }, function(input)
                        vim.opt.diffopt:append(choice .. tonumber(input))
                    end)
                end

            else
                vim.opt.diffopt:append(choice)
            end
        end)
end)

-- mapping to fold on an already-performed search:
-- fold search
-- autocmd VimEnter *.vim  normal <leader>H
-- nnoremap <expr> <silent> <leader>fs ":let @/=".string(input('Inserisci stringa: '))."\<cr>:setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\\\|\\\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2\<CR>"

-- Spelling (mnemonic: [z]pelling)
-- vim.keymap.set("n", "zl", function() telescope.spell_suggest() end)
-- vim.keymap.set("n", "za", "1z=") -- Autocorrect word under cursor (= select 1st suggestion)

-- quicker typing
-- vim.keymap.set("i", "!!", ' {}<Left><CR><Esc>O') -- {} with proper linebreak

-- /tmp/.mount_nvimXBe5JS/usr/share/nvim/runtime/doc/spell.txt:123
vim.cmd([[
nnoremap z?  exe 'spellrare'  expand('<cWORD>')<CR>
nnoremap z/  exe 'spellrare!' expand('<cWORD>')<CR>
]])

---@see https://github.com/mwgkgk/dotfiles/blob/48c6344109aba79edd7e30d644fd33f49a1f945d/vim/plugin/mappings.vim#L454
-- Edit previous command:
-- c-: -> misto fra : e <c-p>
-- vim.keymap.set('n',--[[<c-:>]]'<c-s-;>',':<C-p>')
-- like emacs (anche se quella era per eval, vabbe)
vim.keymap.set('n',--[[<c-:>]]'<f12><a-s-;>',':<C-p>')

-- Insert system() (maybe inspired by zsh?)
-- magari usa ! o $?
-- o check out emacs mappings?
vim.keymap.set('i', '<C-r>(',[[<C-r>=system('')<Left><Left>]])

-- https://vim.fandom.com/wiki/Folding_with_Regular_Expression
-- vim.keymap.set('n','z/',[[<Cmd>setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>]])

-- https://github.com/justinmk/config/blob/1d514cf4f154adb4995ba776e93987e221de3b64/.config/nvim/plugin/my/keymaps.lua#L4
vim.cmd[[
" copy current (relative) filename (to gui-clipboard if available)
"nnoremap "%y <cmd>let @+=fnamemodify(@%, ':.')<cr>
"nnoremap g: :lua<space>
]]

vim.keymap.set({'i','n'}, '<M-S-;>',[[<c-\><c-n>:lua<space>]]) -- like M-: for elisp in emacs

-- https://www.reddit.com/r/neovim/comments/1k27y0t/go_back_to_the_start_of_a_search_for_the_current/
-- All the ways to start a search, with a description
local mark_search_keys = {
    ["/"] = "Search forward",
    ["?"] = "Search backward",
    ["*"] = "Search current word (forward)",
    ["#"] = "Search current word (backward)",
    ["£"] = "Search current word (backward)",
    ["g*"] = "Search current word (forward, not whole word)",
    ["g#"] = "Search current word (backward, not whole word)",
    ["g£"] = "Search current word (backward, not whole word)",

    -- ["]]"] = "Search current word (backward, not whole word)",
    -- ["[["] = "Search current word (backward, not whole word)",
}

-- Before starting the search, set a mark `s`
for key, desc in pairs(mark_search_keys) do
    vim.keymap.set("n", key, "ms" .. key, { desc = desc })
end

-- Clear search highlight when jumping back to beginning
vim.keymap.set("n", "`s", function()
    vim.cmd("normal! `s")
    -- vim.cmd("normal `s")
    vim.cmd.nohlsearch()
end)

-- demicolon?
-- for _, bracket in ipairs{"[","]"} do
-- vim.keymap.set("n", bracket, function()
--     local char = vim.fn.getcharstr()
--     vim.cmd.norm(bracket..char)
--     vim.keymap.set({"n","o","x"},';', bracket..char)
--     vim.keymap.set({"n","o","x"},',', bracket..char)
-- end)
-- end

-- https://www.reddit.com/r/neovim/comments/1k4efz8/share_your_proudest_config_oneliners/
-- Duplicate line and comment the first line. I use it all the time while coding.
-- TODO: make this an operator (and preserve cursor column?)
vim.keymap.set("n", "ycc", '"yy" . v:count1 . "gcc\']p"', { remap = true, expr = true })

-- https://www.reddit.com/r/neovim/comments/1knaoni/the_most_ineffecient_shortcuts/
-- use inefficient keybindings with simpler equivalent for mappings? (find/create list for that)
-- vim.keymap.set('n','1j','...')
-- vim.keymap.set('n','1J','...')
--
-- ┣ Niceties
-- https://www.reddit.com/r/neovim/comments/1kv7som/search_within_selection_in_neovim/
vim.keymap.set('x', 'z/', '<C-\\><C-n>`</\\%V', { desc = 'Search forward within visual selection' })
vim.keymap.set('x', 'z?', '<C-\\><C-n>`>?\\%V', { desc = 'Search backward within visual selection' })
vim.keymap.set('n', 'z/', '/\\%><C-r>=line("w0")-1<CR>l\\%<<C-r>=line("w$")+1<CR>l', { desc = 'Search in viewport' })

-- similar to hyprland mapping
vim.keymap.set('n', '<space><bs>', '<cmd>restart<cr>', { desc = 'Restart Neovim' })

-- ─ comments
--local labels=vim.json.decode(vim.fn.system([[ast-grep run --pattern 'local defaults = { $$$B }' ]] .. vim.fn.stdpath('data') .. [['/lazy/todo-comments.nvim/lua/todo-comments/config.lua']] .. [[| sed 's/^[^:]\+:[0-9]\+://' | sed '1s/local defaults =/return/' | yq -pl -oj | jq '[.keywords|to_entries[]|[.key,((.value.alt) // empty)]|flatten]|map(first)']]))
-- TODO: maybe use v:count like in todo-comments? fallo per tutte le keyword (usando v:count) (per ora aggiunge v:count-1 in piu che non e male)
-- also for these you could add (identifier, like name or email for projects when you work with other people)
vim.keymap.set('n', 'gcJ', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs> TODO: ', { desc = 'TODO Below' })
-- vim.keymap.set('n', 'gcJ', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs> '..labels[vim.v.count1]..': ', { desc = 'TODO Below' })
vim.keymap.set('n', 'gcK', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs> TODO: ', { desc = 'TODO Above' })
-- vim.keymap.set('n', 'gcK', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs> '..labels[vim.v.count1]..': ', { desc = 'TODO Below' })

-- https://github.com/echasnovski/mini.nvim/issues/321#issuecomment-1539603757
-- vim.keymap.set('n', '<M-m>', [[<Cmd>call append(line('.'), '') | call append(line('.')-1, '')<CR>]])
-- vim.keymap.set('x', '<M-m>', [[:<C-u>call append(line("'>"), '') | call append(line("'<")-1, '')<CR>]])
-- TODO: find a way to do this w/ mini.surround (it outputs ^M)
-- vim.keymap.set('n', '<M-s>', [[<Cmd>call append(line('.'), repeat(' ', indent('.')) .. '-- stylua: ignore end') | call append(line('.')-1, repeat(' ', indent('.')) .. '-- stylua: ignore start')<CR>]])
-- vim.keymap.set('x', '<M-s>', [[:<C-u>call append(line("'>"), repeat(' ', indent('.')) .. '-- stylua: ignore end') | call append(line("'<")-1, repeat(' ', indent('.')) .. '-- stylua: ignore start')<CR>]])
vim.keymap.set('n', 'gcs', [[<Cmd>call append(line('.'), repeat(' ', indent('.')) .. '-- stylua: ignore end') | call append(line('.')-1, repeat(' ', indent('.')) .. '-- stylua: ignore start')<CR>]])
-- vim.keymap.set('x', 'gcs', [[:<C-u>call append(line("'>"), repeat(' ', indent('.')) .. '-- stylua: ignore end') | call append(line("'<")-1, repeat(' ', indent('.')) .. '-- stylua: ignore start')<CR>]])
-- vim.keymap.set('x', 'gcq', [[:<C-u>call append(line("'>"), repeat(' ', indent('.')) .. '-- stylua: ignore end') | call append(line("'<")-1, repeat(' ', indent('.')) .. '-- stylua: ignore start')<CR>]])
-- and then delete ignore lines?
-- vim.keymap.set('x', 'gQ', [[:<C-u>call append(line("'>"), repeat(' ', indent('.')) .. '-- stylua: ignore end') | call append(line("'<")-1, repeat(' ', indent('.')) .. '-- stylua: ignore start')<CR>gggqG]])

-- vim.keymap.set('i', '<m-;>', '<c-r>=&l:commentstring<cr><bs><bs>')
-- vim.keymap.set('i', '<m-;>', '&l:commentstring->substitute(" %s"," ","")', {expr=true})
vim.keymap.set('i', '<m-;>', '<end> <c-r>=&l:commentstring<cr><bs><bs>')
vim.keymap.set('n', '<m-;>', 'A <c-r>=&l:commentstring<cr><bs><bs>')
-- vim.keymap.set('i', '<m-s-3>', '<esc>m`I<c-r>=&commentstring<cr><bs><bs><c-o>``')
-- FIX: doesnt work
-- vim.keymap.set('i', '<m-s-3>',
-- function()
-- local cmt_len = string.len(vim.bo.commentstring)-2
-- vim.cmd.norm('<esc>m`I<c-r>=&commentstring<cr><bs><bs><esc>``'..cmt_len..'l')
-- vim.cmd.norm('<esc>m`I<c-r>=&commentstring<cr>') -- doesn't work
-- '<esc>m`I<c-r>=&l:commentstring<cr><bs><bs><esc>``'
-- ..string.len(vim.bo.commentstring)-2 ..'l'
-- function()return
-- '<cr><esc>kgccgJa'end,{expr=true}
-- '<cr><esc>kgccgJa'
-- )
-- end)
-- delete comment
-- maybe `] at the end? doesn't work tho


-- should check if &commentstring is empty (<expr> mapping)
vim.keymap.set('n', 'gco', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })
-- check if there are @see annotations in other languages
-- fallo per tutte le annotazioni in tutti i linguaggi (usando v:count)
-- add mapping to automatically add clipboard???
-- vim.keymap.set('n', 'gcs', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs>-@see ', { desc = 'Check out Below' })
-- vim.keymap.set('n', 'gcS', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs>-@see ', { desc = 'Check out Above' })
vim.keymap.set('n', 'gc<cr>', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs>-@see ', { desc = 'Check out Below' })
vim.keymap.set('n', 'gc<s-cr>', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fxa<bs><bs>-@see ', { desc = 'Check out Above' })
-- TODO: also add annotation keymaps ---@... (or maybe snippets)

-- TODO: add block comment is newline, if it doesn't exist in the language strip newline
-- sometimes i want to enter insert mode
-- TODO: don't duplicate &commentstring
-- vim.keymap.set('n', 'gcp', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fx"_xp', { desc = 'Add Comment Below' })
-- vim.keymap.set('n', 'gcp', [['<cmd>let @"=@"->split("\n")->map({_,v->'.&l:commentstring[:-4].'." ".v})->join("\n")<cr>p']], { expr = true,desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcp', function()
vim.cmd[[let @"=@"->split("\n")->map({_,v->&l:commentstring[:-4]." ".v})->join("\n")]]
end
, { desc = 'Add Comment Below' }) -- TODO: add v:count
vim.keymap.set('n', 'gc>p', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fx"_xp>>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gc<p', 'o<esc>V"_cx<esc><cmd>normal gcc<cr>fx"_xp<<', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcP', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fx"_xp', { desc = 'Add Comment Above' })
vim.keymap.set('n', 'gc>P', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fx"_xp>>', { desc = 'Add Comment Above' })
vim.keymap.set('n', 'gc<P', 'O<esc>V"_cx<esc><cmd>normal gcc<cr>fx"_xp<<', { desc = 'Add Comment Above' })
vim.keymap.set('x', 'gy', "ygvgc'>p", { remap= true,desc = 'Add Comment Above' })
---@see https://github.com/echasnovski/mini.nvim/issues/283#issuecomment-1565259857
vim.keymap.set('x', 'gi', ':normal gcc<CR>') -- i la puoi vedere come invert TODO: fixa blank lines...

-- ─ save after exiting insert mode
-- vim.keymap.set('n','<c-w>Q','<cmd>q!<cr>')
-- https://www.reddit.com/r/emacs/comments/mtuvyw/people_should_not_bombard_newbies_with_messages/
-- nice nice just for notetaking?
-- magari crea autocmd da insert mode? cosi quando ad esempio usi <a-p> in insert mode lo
-- combina con git tracking
vim.keymap.set('i','<esc>','<esc><cmd>up<cr>')
-- one saves, the other doesn't :d
vim.keymap.set('i','<c-]>','<esc>')
-- don't work?
-- vim.keymap.set('i','<esc>',"&buftype==''?'<esc><cmd>up<cr>':'<esc>'", {expr=true})
-- vim.cmd[[inoremap<expr><esc> &buftype==''?'<esc><cmd>up<cr>':'<esc>']]
-- vim.keymap.set({'i','n'},'<f16>',function()
-- local char = vim.fn.getchar()
-- vim.cmd(char)
-- end
-- )

-- Make the dot command work as expected in visual mode
-- https://www.reddit.com/r/vim/comments/3y2mgt/
vim.keymap.set("x", ".", "<cmd>norm! .<cr>")


-- ─ for these check if buffer is modifiable
-- vim.keymap.set('n', '<s-cr>', "O<esc>O")
-- vim.keymap.set('n', '<space><space>', "]]zz", {remap=true})
-- vim.keymap.set('n', '<space><space>', "]]")
-- vim.keymap.set('n', '<space><s-space>', "[[zz", {remap=true})

-- ┣ Kanata
-- return to previous mode?

-- https://gist.github.com/kawarimidoll/496cb16b40af33e8d84daff6dde8a16f
local all = vim.fn.split('nvsxoilct', [[.\zs]])
      -- modes = { "n", "v", "x", "s", "o", "i", "c", "t" },
-- how to go previos mode? like one shot norm command like ^o but for all modes?
vim.keymap.set(all,'<f16>',function() return[[<c-\><c-n>]]..vim.v.count..[[<c-w>]] end,{expr=true})

-- ┣ EMACS PARITY
-- pseudo keys like in emacs for function keys (kanata?)
-- ─ <c-x>
-- doesn't work?
-- rinomina in ctl-x-map? like in emacs
vim.keymap.set({'n','i'},'<f12><c-e>',[["<cmd>lua "..getline('.')..'<cr>']], {expr=true})
-- like in readline
vim.keymap.set({'c'},'<f12><c-e>','<c-f>')
-- vim.keymap.set({'n','i'},'<f12>h',"<cmd>norm! G$Vgg0<cr>")
vim.keymap.set({'n','o'},'<f12>h',"<cmd>norm! G$Vgg0<cr>")
vim.keymap.set('i','<f12>h',"<esc>gg0VG$<C-g>")

vim.keymap.set({'n','i'},'<f12><c-o>','<cmd>norm! cip<cr>')

-- i need to imitate emacs
-- vim.keymap.set('i','<c-x><c-s>','<cmd>up<cr>')
vim.keymap.set('i','<f12><c-s>','<cmd>up<cr>')
-- magari c-x c-s-s for sudowrite?
vim.keymap.set('n', '<f12><c-s>', '<CMD>up<CR>', {desc = "Save Current File" })
-- vim.keymap.set('n','<f12>k','<cmd>q!<cr>')


-- vim.keymap.set('i','<f14><c-k>','<cmd>q!<cr>')
-- vim.keymap.set('i','<f12>k','<cmd>q!<cr>')
-- more concise to use indicate modes? lua/viml function?
-- not sure if this is correct...
-- vim.keymap.set({'n','x','i','t','c'},'<f12>k',[[<c-\><c-n><cmd>q!<cr>]])
-- vim.keymap.set({'n','x','i','t','c'},'<c-c>',[[<c-c>]])
-- non funge?
-- vim.keymap.set({'n','x','i','t','c'},'<f12><c-c>',[[<c-\><c-n><cmd>qa<cr>]])
vim.keymap.set({'n','x','i','t','c'},'<f12><c-c>',[[<c-\><c-n><cmd>qa!<cr>]]) -- comfirmation b4?
-- select statement w/ treesitter & execute?
-- vim.keymap.set({'n','x','i','t','c'},'<f12><c-e>',[[viSg=]])

-- emacs is corrupting me
-- vim.keymap.set('n','<c-g>','<c-c>')
--
-- ─ <m-s>
vim.keymap.set('i','<m-s>.','<c-o>*') -- add c-s/c-r
-- vim.keymap.set('i','<m-s>,','<c-o>#') -- add c-s/c-r ;; like xref./,

-- ─ <c-h>
-- vim.keymap.set({'n','i'},'<f18>k',[[<c-\><c-n>:h ]]) -- add c-s/c-r
-- TODO: usa snacks
vim.keymap.set({'n','x','i','t','c'},'<f18>K',[["<c-\><c-n>:FloatingHelp "..(mode()=='n'?'':mode()->tolower()..'_')]], {expr=true})
-- how to escape single quote for fzf?
vim.keymap.set({'n','x','i','t','c'},'<f18>r',[[<c-\><c-n><cmd>FloatingHelp user-manual<cr>]] )
vim.keymap.set({'n','x','i','t','c'},'<f18><c-f>',[[<c-\><c-n><cmd>FloatingHelp faq<cr>]] )
-- ─ others
-- org mode
-- insert mode in visual mode like emacs?

vim.keymap.set({'n',},'<tab>',[[za]])
-- vim.keymap.set({'i',},'<c-o>',[[za]])

-- https://stackoverflow.com/questions/5312235/how-do-i-correct-vim-spelling-mistakes-quicker
-- flyspell
vim.keymap.set('i','<m-tab>','<c-g>u<Esc>[s1z=`]a<c-g>u')
-- f for fix
-- vim.keymap.set('i','jf','<c-g>u<Esc>[s1z=`]a<c-g>u')

vim.keymap.set('i','<m-tab>','<c-g>u<Esc>[s1z=`]a<c-g>u')

vim.keymap.set({'n','i'},'<c-s-/>',[[<cmd>exe "norm! \<c-r>"<cr>]]) --redo?
vim.keymap.set({'n','i'},'<c-/>',"<cmd>norm! u<cr>")
vim.keymap.set({'n','i'},'<m-s-,>',"<cmd>norm! gg0<cr>")
vim.keymap.set({'n','i'},'<m-s-.>',"<cmd>norm! G$<cr>")

-- vim.keymap.set('i','<tab>',"<c-f>")
-- vim.keymap.set('i','<c-l>',"<c-o>zz")

-- https://www.reddit.com/r/vim/comments/112e8ne/vim_function_to_move_following_word_into/
-- slurp
-- vim.keymap.set('i', "<M-s>",[[<esc>lxepi]])
-- vim.keymap.set('!', "<M-s>",[[<esc>lxepi]])
-- barf
-- vim.keymap.set('i', "<M-b>",[[<esc>lxgepi]])

-- like ^x^l? maybe blink source?
-- vim.keymap.set('i', '<c-l>',function()Snacks.picker.lines()end)
-- like emacs
-- vim.keymap.set('i', '<c-l>',[[<C-o>zz]])
-- vim.keymap.set('i', '<m-t>',[[<Esc>hxpa]])

-- open current file/line in emacs (terminal and GUI) and viceversa?
-- vim.keymap.set('n','<space>oe',function() vim.fn.system('emacsclient -c -nw +'..vim.fn.line('.') .. ' '..vim.fn.expand('%:p'))end)
-- vim.keymap.set('n','<space>oe',function() return '<cmd>!emacsclient -c -nw +'..vim.fn.line('.') .. ' '..vim.fn.expand('%:p')..'< /dev/tty<cr>'end, {expr=true})
-- replace or create new terminal tab?
-- vim.keymap.set('n','<space>oe',function() return '<cmd>!emacsclient -c -nw %:S +'..vim.fn.line('.')..'<cr>'end, {expr=true})
--

-- would be cool to return to cursor left by emacs (maybe went to another buffer as well) (also would be nice if it worked in visual mode as well)
-- f15 to move between neovim windows, ^w for emacs
vim.keymap.set('n','<space>&', function()
    if vim.bo.filetype == '' then return end
    local line_nr = tostring(vim.fn.line('.'))
    local path = vim.fn.expand('%:p')
    local column_nr = tostring(vim.fn.col('.'))

    Snacks.terminal.open({"emacsclient","-a",'',"-t","+"..line_nr..":"..column_nr,path})
end
)

-- argument prefix for GUI
vim.keymap.set('n','<space>u<space>&',function() vim.fn.system('emacsclient -a "" -c +'..vim.fn.line('.')..':'..vim.fn.col('.')..' '..vim.fn.expand('%:p'))end)

-- how TO map in all modes?
vim.keymap.set({'n','i','x','o'},'<c-m-a>',function() vim.cmd("TSTextobjectGotoPreviousStart @function.outer")end)
vim.keymap.set({'n','i','x','o'},'<c-m-e>',function() vim.cmd("TSTextobjectGotoNextEnd @function.outer")end)
vim.keymap.set({'n','i'},'<c-m-h>', [[<c-\><c-n><cmd>norm vaf<cr>]])
-- fixa terminal mapping M-^?
vim.keymap.set({'n','i'},'<m-s-6>', [[<cmd>norm! kJ<cr>]])

vim.keymap.set({'n','i'},'<m-s-[>', [[<cmd>norm! {<cr>]])
vim.keymap.set({'n','i'},'<m-s-]>', [[<cmd>norm! }<cr>]])

-- do these for cmdline, coward!
vim.keymap.set({'n',},'<m--><m-l>', [[<c-\><c-n><cmd>norm 2bgue2ea<cr>]])
vim.keymap.set({'i'},'<m--><m-l>', [[<esc>2bgue2ea]])
vim.keymap.set({'n',},'<m--><m-u>', [[<c-\><c-n><cmd>norm 2bgUe2ea<cr>]])
vim.keymap.set({'i'},'<m--><m-u>', [[<esc>2bgUe2ea]])

vim.keymap.set({'n','i','x','o','t'},'<f12>1',[[<c-\><c-n><cmd>wincmd o<cr>]])
vim.keymap.set({'n','i','x','o','t'},'<f12>0',[[<c-\><c-n><cmd>wincmd c<cr>]])

vim.keymap.set({'c'},'<c-m-j>', [[<cr>]]) -- like ivy

-- vim.keymap.set({'i'},'<c-g>', [[<esc>]])
vim.keymap.set({'c'},'<c-g>', [[<c-c>]])
vim.keymap.set({'x'},'<c-g>', [[<esc>]])

-- to use for example in multicursors mode
vim.keymap.set({'n','i','x','o'},'<f12>(',[[<c-\><c-n><cmd>norm! qqqqq<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>)',[[<c-\><c-n><cmd>norm! q<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>e',[[<c-\><c-n><cmd>norm! Q<cr>]])

-- K for man, <c-h>o for :help? what about lsp?
-- https://github.com/janpeterd/dotfiles/blob/a89868aa31a4d7ea66f325cda38d3522a5891dfe/dot_config/nvim/plugin/remap.lua#L16
-----------
-- Center
------------
local last_press_time = 0
local press_count = 0

vim.keymap.set({"n","i"}, "<C-l>", function()
  -- function that does the following:
  -- keymap is pressed once: center current line in the view
  -- keymap is pressed twice: set currentl line at the top of the view
  -- keymap is pressed for a third time: set currentl line at the bottom of the view
  local current_time = vim.uv.now()

  -- Reset count if more than 500ms have passed since last keypress
  if current_time - last_press_time > 500 then
    press_count = 0
  end

  press_count = press_count + 1
  last_press_time = current_time

  if press_count == 1 then
    -- Center current line in the view
    vim.cmd "normal! zz"
  elseif press_count == 2 then
    -- Set current line at the top of the view
    vim.cmd "normal! zt"
  elseif press_count == 3 then
    -- Set current line at the bottom of the view
    vim.cmd "normal! zb"
    -- Reset count after third press
    press_count = 0
  end
end)

-- TODO: not really previous, just alternate
vim.keymap.set({'n','i','x','o'},'<c-m-v>',[[<cmd>call win_execute(bufwinid(bufname(0)),'noautocmd exe "norm! '..v:count..'\<c-d>"')<cr>]])
vim.keymap.set({'n','i','x','o'},'<c-m-s-v>',[[<cmd>call win_execute(bufwinid(bufname(0)),'noautocmd exe "norm! '..v:count..'\<c-u>"')<cr>]])

vim.keymap.set({'n','i','x','o'},'<m-r>',[[<c-\><c-n><cmd>norm! M<cr>i]])

vim.keymap.set({'n','i','x','o'},'<f12>t0',[[<c-\><c-n><cmd>tabclose<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>t1',[[<c-\><c-n><cmd>tabonly<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>t2',[[<c-\><c-n><cmd>tabnew<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>to',[[<c-\><c-n><cmd>tabnext<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>tO',[[<c-\><c-n><cmd>tabprevious<cr>]])
-- noremap <silent> <c-x>5 <cmd>echo "Frames are only in Emacs/GNU Emacs"<cr>

vim.keymap.set({'n','i','x','o'},'<f12>o',[[<c-\><c-n><cmd>wincmd w<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>2',[[<c-\><c-n><cmd>exe "norm! ]]..vim.v.count..[[\<c-w>s\<c-w>\<c-p>"<cr>]])
vim.keymap.set({'n','i','x','o'},'<f12>3',[[<c-\><c-n><cmd>exe "norm! ]]..vim.v.count..[[\<c-w>v\<c-w>\<c-p>"<cr>]])

-- distinguish visual mode coming from and insert? select mode!
vim.keymap.set('s','<c-w>','<bs>')
vim.keymap.set('x','<a-w>','<c-o>y')
vim.keymap.set('x','<c-w>','d')
vim.keymap.set('x','<a-w>','y')

---@see https://github.com/echasnovski/mini.nvim/discussions/1042
vim.keymap.set({"i", "n"}, "<A-Space>", "<Cmd>normal! ciw <CR>", { desc = "Just one space" })

vim.keymap.set("i" , "<c-]>", "<c-o>f", { desc = "readline: character-search" })
vim.keymap.set("i" , "<c-m-]>", "<c-o>F", { desc = "readline: character-search-backward" })

vim.keymap.set({"n","i"} , "<a-h>", [[<c-\><c-n><cmd>norm! vipok<cr>]], { desc = "readline: character-search-backward" })
vim.keymap.set({"n","i"} , "<f12>44", [[<cmd>vnew<cr>]], { desc = "Open in other window" })
vim.keymap.set("x" , "<m-;>", [[gc]], { remap = true,desc = "Comment"})

vim.api.nvim_create_user_command('Occur','lvimgrep /<args>/%|bel vert lopen',{nargs = 1})
vim.keymap.set({"n","i"} , "<m-s>o", [[:Occur<space>]], {desc = "Occur"})


-- commands
-- vim.api.nvim_create_user_command('Sort_paragraphs','emacsclient -e sort-paragraphs?')

-- for mappings that don't have an equivalent plugin in neovim, open emacs and keyfeed those
-- vim.keymap.set('n','<c-c>m','emacsclient --eval keypress <C-c>m', {desc = 'emms'})
