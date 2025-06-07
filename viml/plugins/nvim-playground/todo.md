make it work with images (imagemagick) and videos (ffmpeg) as well (use nxwm maybe)

add possibility to write multiline script for commands that don't support it? (use tr \\n ' ' before passing the command)

add possibility to save state (write state to /tmp/ file) (like a checkpoint), so the checkpoint becomes the file to filter

4 possible window disposition: preview left/right and filter buffer on the bottom right/left continuing the filtered buffer or on the full bottom occupying full width

vertical Jqplay?

https://github.com/phelipetls/vim-jqplay cerca cosa fanno i 10 commits behind della repo originale...
https://github.com/bfrg/vim-jqplay/issues/7

crea ex-commands from user config like PGAwk, PGJq, etc...

/doc/tags in .gitignore (CI?)

also make it work out of the box (for every filetype) for unix commands like join, etc... that accept stdin... (bash source?)

crea winbar like in rest.nvim with stdout and stderr

    prev = false -- pass false to disable only this default mapping

crea anche compiler.nvim (automatically set compiler tidy for html, etc...)

add recipes.md with your xidel and jq config...

in readme...
Related projects

nice to use this plugin chrisbra/NrrwRgn

start in insert mode when creating filter buffer

crea vimdoc file con md2vimdoc?

magari crea separate plugin with autocompletion/niceties (optional dependency)

would be cool to pair this plugin with a preview plugin (like show html with xidel or smth) to show zathura with html for ex...

usa vim9jit per portare vim-jplay to lua?

<!-- What about tab completion? (like for jq, xidel) it would be pretty cool (maybe omni-completion, maybe vim has already done the job for you for stuff like xml?) -->
General plugin for xpath, jq, etc... (any filter, like grep, awk, sed -f..., mlr -s, GraphQL?)
Use only one mapping for starting evaluation (sql, jq, xml, http, regex...) in Vim (maybe hydra?)
<!-- maybe also include tree-sitter play? luarocks? local dir to store data? -->
could also be used for lua filters (pandoc)

Chiama nvim-play e non play.nvim in onore vim-jqplay (meglio nvim-playground)
Basically a generalized version of vim-jqplay that works for any filetype. Rewrite in   Lua if possible
You could use dependencies if there are already made plugins, like vim-dadbod
<!-- Actually vim-dadbod maybe shouldn't be used here, it doesn't evaluate the current buffer? -->

Have this configuration: (don't define any mapping, but show the three in the example)

<!-- evaluators supported: jq, xidel (to abstract --from-file option mainly?, maybe don't actually support), ... add PRs for other you want (check out README.md for evaluator-specific data you have to provide) -->
opts = {

<!-- maybe also add possibility to add this to each evaluator (it would replace the default) (global and evaluator-specific options?)-->
events = {}
 (have 3 mappings per filetype like vim-jqplay, if for ex for dadbod leave two of those empty)
mappings = {
play = { '' },
scratch = {''},
scratch! (find better name) = {''},
run = {}
 },
evaluators = {
{  ft = {...},
cmd = { ... }
<!-- You can have multiple commands per filetype, an ui.select window will appear if that's the case --> (like for ex xidel could be used for json too...)
also add option for command: default options like -r for jq...
},
}

}

maybe also add shell command, like bash:
first use your specific command then set ft=bash and use the old output as input

also add generic commands that work for every filetype: awk, sed, etc... and use vim.ui.select to select the one you want (or create two mappings, one with the "default" one you choose and one with select)
do the select thing also with filetypes like for json it should open jq and yq for the second mapping (jq default)

supports xml, json and yaml, then add possiblity to add evaluators (just provide --from-file equivalent option and that's it I guess? and maybe hack a way to make it work with commands that don't have this option)
extend dictionary, use nil if you want to disable mappings/commands for a filetype

registra telescope extension to open a xml/json/etc... (supported filetypes) and open the other two buffers (maybe in another tab)? maybe overkill

also define K mapping that opens man page-documentation?

<leader>j non è sta genialata (<leader>j,k per diagnostic.)

## For example

{ filetype: { xml, xslt...},
command : {xidel, xmllint, ...} (first command found in path will be used),

const s:defaults = {
        \ 'exe': exepath('xidel'),
        \ 'opts': '',
        \ 'delay': 500,
        \ 'autocmds': ['InsertLeave', 'TextChanged'],
        \ 'mods': 'split'
        \ }

as completion, remove dashes and add them back in arguments... (len(option)>1 ? -- : -, o usa mapping per sicurezza), also usa man page or help per docs popup

at the end of github's readme.md...
Credits

    nvim-tree for the system opener module.

registra telescope extension per mostrare quali comandi puoi usare per filetype...
