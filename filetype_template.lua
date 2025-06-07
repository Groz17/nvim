return {
  {
    '...',
    ft = '...2',
    config = function()
      -- NOTE: questo in realta va chiamato solo una volta (potresti avere piu filetype plugin per lo stesso filetype), una soluzione potrebbe mettere questa riga in ftplugin
      require'which-key'.add({'<localleader>', group = "(2) {Mini.Icons('filetype', (2))},", buffer = true})
      -- require'which-key'.add({'<localleader>', group = "Java " .. MiniIcons.get('filetype','java'), buffer = true})

      require'which-key'.add({'<localleader>r', group = "Refactoring", buffer = true})
      -- vim.keymap.set(...)

      require'which-key'.add({'<localleader>j', group = "CLI"})
      -- vim.keymap.set(...)
    end,
  }
}
