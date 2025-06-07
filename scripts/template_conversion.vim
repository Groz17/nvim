" from vim-template to template.nvim
%s/%HERE%/{{_cursor_}}/ge
%s/%FFILE%/{{_file_name_}}/ge
%s/%MAIL%/{{_email_}}/ge
%s/%USER%/{{_author_}}/ge
%s/%CLASS%/{{_lua:vim.fn.substitute(expand("%:t:r:r:r"), "\\([a-zA-Z]\\+\\)", "\\u\\1\\e", "g")_}}/ge
%s/%FDATE%/{{_lua:os.execute('date "+%F +%H:%M"')_}}/ge
%s/%FDIR%/{{_lua:vim.fn.expand("%:p:h:t")_}}/ge
%s/%FILE%/{{_lua:vim.fn.expand('%:t:r')_}}/ge
%s/%GUARD%/{{_lua:vim.fn.toupper(substitute(expand("%:t"), "[^a-zA-Z0-9]", "_", "g"))_}}/ge
%s/%LICENSE%/{{_lua:"MIT"_}}/ge
%s/%YEAR%/{{_lua:os.execute('date +%Y')_}}/ge
w
