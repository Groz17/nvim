-- vim: foldmethod=expr foldexpr=getline(v\:lnum)=~'^--\ ┣'?'>1'\:getline(v\:lnum)=~'^--\ ─'?'>2'\:'=':
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ TODO: ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- find nice configs/categories
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ General ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- " ~~TODO: usa <space> come leader per programming, comma per altro~~
-- let mapleader = "\<Space>"
-- Set leader outside of keymaps to ensure that plugins know what to bind to
-- vim.g.mapleader = " "
-- look for the 2nd letter in the keymap to know which hand to use as leader
-- vim.g.mapleader = vim.keycode"<F13>"
-- vim.g.mapleader = vim.keycode"<f14>"
-- in accordanza con emacs...
vim.g.mapleader = vim.keycode"<space>"
-- vim.g.mapleader = "jk"
-- what about using mapleader for personal mappings e localleader for plugins? (or viceversa?) (https://www.reddit.com/r/neovim/comments/wta8k2/why_not_use_space_as_leader_key/)
-- for languages/filetype mappings?
-- f keys also useful so u can use them in insert/visual mode whichkey mappings
-- not too sure about this
-- vim.g.maplocalleader = vim.keycode[[<f15>]]
vim.g.maplocalleader = vim.keycode[[\]]
-- not sure
-- vim.g.maplocalleader = vim.keycode[[<c-c>]]

vim.opt.mouse:remove('a') -- Not use mouse
vim.opt.mousescroll  = 'ver:25,hor:6' -- Customize mouse scroll

vim.opt.showbreak="↪"

vim.opt.timeoutlen = 500 -- Mapping waiting time
-- Tip: per tradurre più parole usa visual mode
-- autocmd Filetype markdown,vimwiki set keywordprg=trans\ :it
-- autocmd Filetype markdown,vimwiki set keywordprg=trans\ en:it

-- https://github.com/neovim/neovim/issues/8427
-- per il momento usala, trova fix per :e, telescope commands, etc...
-- vim.opt.autochdir = true

-- aumenta fzf history
vim.opt.shada={"!","'500","<50","s10","h"}

vim.g.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal" -- removed blank

-- exclude hidden buffers when saving session {for possession.nvim}
vim.opt.sessionoptions:remove('buffers')

vim.g.health = { style = 'float' }
-- vim.o.winborder='border'

vim.wo.signcolumn = "yes:1"
-- It messes up cpfd'json
-- vim.o.fileencodings = "utf-8,sjis,euc-jp,latin"
vim.o.title = true
vim.o.autoindent = true

vim.o.switchbuf    = 'usetab'       -- Use already opened buffers when switching

vim.opt.joinspaces = false

-- FIX: doesn't work with autopairs
-- vim.opt.digraph = true
-- fai che se ctrl-k non e precedura da ctrl-j allora digraph? maybe use snippet lua to check if first item is selected?

-- lualine
-- how to show full parent directory when the window is small?
-- vim.opt.showtabline = 1
-- autocmd FileType * set showtabline=0

-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Spelling ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- vim.wo.spell = true
-- vim.o.spelllang    = 'en,uk,it,ru,ar'   -- Define spelling dictionaries
vim.o.spelloptions = 'camel'      -- Treat parts of camelCase words as seprate words
vim.opt.complete:append('kspell') -- Add spellcheck options for autocomplete
vim.opt.complete:remove('t')      -- Don't use tags for completion

vim.opt.dictionary = '/usr/share/dict/words'

-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ File management ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- Not save backup
-- vim.opt.backup = false
-- vim.opt.swapfile = false
-- vim.opt.writebackup = false
-- Undotree
vim.opt.undolevels = 10000         -- use many levels of undo
-- vim.cmd([[
-- if has('persistent_undo')
--   set undodir=$HOME/.vim/undo
--   set undofile 
-- endif 
-- ]])
-- Persistent undo
-- vim.opt.undofile = true                -- Save undo's after file closes
-- vim.opt.undodir="$HOME/.vim/undo" -- where to save undo histories
-- vim.opt.undolevels = 1000         -- How many undos
-- vim.opt.undoreload = 10000        -- number of lines to save for undo
-- Accept modeline of each file
vim.opt.modeline = true
-- no idea why I can make this local...
vim.opt.modelineexpr = true
-- after eventual shebang and emacs...
vim.opt.modelines = 3
-- -- Encoding
-- opt.fileencoding = 'utf-8'
-- -- End of file setting
-- opt.fileformat = 'unix'



-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Text layout ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- -- Tabs, indent
vim.opt.expandtab = true       -- When this option is enabled, vi will use spaces instead of tabs
vim.opt.shiftwidth  = 2 -- Determines the amount of whitespace to add in normal mode
vim.opt.smartindent = true
vim.opt.tabstop     = 2 -- Width of tab character
vim.opt.softtabstop = 2 -- Fine tunes the amount of white space to be added

vim.opt.wrap = false
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append "<>[]hl"
vim.opt.list = false
vim.opt.listchars = { trail = "-", tab = [[▸ ]], nbsp = "␣", eol = "$", extends = "❯", precedes ="❮" }
-- vim.opt.fillchars:append { diff = "╱" }
-- vim.opt_global.fillchars:append { diff = "╱" }

-- opt.fillchars = { eob = " " }

-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Memory, CPU ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
vim.opt.hidden = true           -- Enable background buffers
vim.opt.history = 10000           -- Remember N lines in history
-- vim.opt.lazyredraw = true       -- Faster scrolling
vim.opt.synmaxcol = 240         -- Max column for syntax highlight
vim.opt.updatetime = 250        -- ms to wait for trigger an event

-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Neovim UI ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- dunno if this is useful since I'm using leap.nvim
-- set relativenumber number
vim.opt.number = true           -- Show line number
-- vim.cmd[[let &stc='%=%{v:virtnum>0?"":printf("%X",v:lnum)} ']]
vim.opt.cursorline = true -- Highlight current line
vim.opt.showmatch = true        -- Highlight matching parenthesis
vim.opt.matchtime = 1
-- vim.opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
vim.opt.splitright = true       -- Vertical split to the right
vim.opt.splitbelow = false       -- Horizontal split to the bottom
vim.opt.ignorecase = true       -- Ignore case letters when search
vim.opt.smartcase = true        -- Ignore lowercase for the whole pattern
vim.opt.linebreak = true        -- Wrap on word boundary
vim.opt.termguicolors = true    -- Enable 24-bit RGB colors
-- hi Normal guibg=NONE ctermbg=NONE
-- vim.opt.laststatus = 2
vim.opt.laststatus=3            -- Set global statusline
-- set showtabline=2
vim.opt.showmode = false -- Not show redundant mode line with airline
-- Sexy Folds (https://www.reddit.com/r/neovim/comments/psl8rq/sexy_folds/)
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- https://www.reddit.com/r/neovim/comments/1h34lr4/neovim_now_has_the_builtin_lsp_folding_support/
-- vim.o.foldmethod = "expr"
-- vim.o.foldenable= false
-- fallback to treesitter if no lsp capabilities?
  -- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.wo.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

-- vim.opt.foldopen = 'block,hor,mark,percent,quickfix,tag,jump,search,undo' -- What movements open folds


-- maybe create highlight.lua file?
vim.cmd('hi Visual guibg=peru guifg=Black')
-- hi Visual guibg=#000066 guifg=#00ff99


vim.opt.infercase = true                       -- Adjust completions to match case

-- vim.opt.more = false

-- Diff

-- silent! setglobal dictionary+=/usr/share/dict/words


vim.opt.mps:append('<:>')

-- stop auto-insertion of comment symbols.
vim.opt.formatoptions:remove{ "c", "r", "o" }
-- vim.o.formatoptions = 'rqnl1j' -- Improve comment editing

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- make the search recursive
vim.opt.path:append('**')

-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Command mode ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- When completing, show all options, insert common prefix, then iterate
vim.opt.wildmode = {list = "longest", "full"}
vim.opt.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'
-- https://github.com/search?q=%2Fwildignore.*color%2F+language%3Alua+&type=code
--https://github.com/qw457812/dotfiles/blob/5d2090a1897806983945ad3d56ffc9db6c6039cc/dot_config/nvim/lua/config/options.lua#L17
vim.opt.wildignore:append(vim.api.nvim_get_runtime_file("colors/*.{vim,lua}", true))

-- Keep same column when going visual-block column
vim.opt.sol = false

-- Enable relative numbers only in Normal mode, and absolute numbers only in Insert mode
-- augroup toggle_relative_number
-- autocmd InsertEnter * :setlocal norelativenumber nonumber
-- autocmd InsertLeave * :setlocal relativenumber number

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.encoding = "utf-8"

-- vim.opt.diffopt:append({'vertical'})
-- [The linematch diffopt makes builtin diff so sweat! : r/neovim](https://www.reddit.com/r/neovim/comments/1ihpvaf/the_linematch_diffopt_makes_builtin_diff_so_sweat/)
vim.opt.diffopt="filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"
-- set diffopt=vertical,filler,internal,algorithm:histogram,indent-heuristic

-- display completion matches on your status line
vim.opt.wildmenu = true

-- don't use included files and tag complete for better performances. Add this to your vimrc for these options :
-- set complete-=t
-- set complete-=i

vim.opt.inccommand="split"

-- hi Cursor guifg=green guibg=green
-- TODO: hide cursor after some time?
vim.cmd[[
"hi Cursor2 guifg=red guibg=Violet
" change color when inside colored text? like hex plugin?
" light green when dark background, rose when light background
hi Cursor2 guifg=red guibg=#00ffa0
"maybe use in insert mode?
set guicursor=n-v-c:block-Cursor/lCursor,i-n:Cursor2/lCursor2
]]

-- set guicursor=n-c-v-i:block-nCursor
-- set guicursor=i:blinkoff400-blinkon250


-- https://github.com/dettonijr/spass-syntax-highlight
-- au BufRead,BufNewFile *.dfg set filetype=dfg

-- set guifont=DroidSansMono\ Nerd\ Font\ 11

-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Theme ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
vim.o.background = 'dark'
-- vim.cmd('colorscheme Tomorrow-Night')
-- vim.cmd('colorscheme habamax')


-- ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫ Startup ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
-- Disable nvim intro
vim.opt.shortmess:append "sI"
-- -- Show shorten messages in UI
-- opt.shortmess:append('filmnrxoOtT')

vim.o.exrc=true
