-- https://github.com/pwntester/octo.nvim
-- maybe not necessary if using omnicompletion with blink?
vim.keymap.set("i", "@", "@<C-x><C-o>", { buffer = true })
vim.keymap.set("i", "#", "#<C-x><C-o>", { buffer = true })


require'which-key'.add{"<localleader>a", group = "Assignee/Reviewer" , buffer = true}
require'which-key'.add{"<localleader>c", group = "Comments" , buffer = true}
require'which-key'.add{"<localleader>e", group = "Reaction" , buffer = true}
require'which-key'.add{"<localleader>i", group = "Issues" , buffer = true}
require'which-key'.add{"<localleader>l", group = "Label" , buffer = true}
require'which-key'.add{"<localleader>p", group = "Pull requests" , buffer = true}
require'which-key'.add{"<localleader>r", group = "Repo" , buffer = true}
require'which-key'.add{"<localleader>s", group = "Review" , buffer = true}
require'which-key'.add{"<localleader>t", group = "Threads" , buffer = true}
