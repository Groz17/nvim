-- add this line only if there are mappings in the plugins you specified (and maybe notify if there are no mappings for the current filetype)
require'which-key'.add({mode = { "n", "x" },'<localleader>', group = "Java " .. MiniIcons.get('filetype','java'), buffer = true,})
