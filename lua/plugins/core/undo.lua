-- https://www.reddit.com/r/neovim/comments/1ij6cvp/get_a_warning_when_youre_undoing_past_your/ (https://github.com/mvllow/session-undo.nvim)
-- https://github.com/jiaoshijie/undotree
-- Is there a way not to move the cursor after undoing?
return {

  {
    'tzachar/highlight-undo.nvim',
    init = function()
      -- vim.api.nvim_set_hl(0, 'Highlight_Undo', { fg = '#abf3fd', bg = '#262d3f', bold=true, italic = true })
      -- vim.api.nvim_set_hl(0, 'Highlight_Undo', { fg = '#fff3fd', bg = '#f62d3f', bold=true, italic = true })
    end,
    keys = {
      { "u" },
      { "<C-r>" },
    },
    opts = {
    }
  },
  {
    --https://www.reddit.com/r/neovim/comments/1ijfnm2/selectundo_undo_specific_parts_of_your_code/
    "SunnyTamang/select-undo.nvim",
    cond = false,
    -- persistent_undo = true,  -- Enables persistent undo history
    -- mapping = true,          -- Enables default keybindings
    opts = {},
    -- _ mnemonic for lines?
    -- there's also <f12>u
    line_mapping = "<c-_>", -- Undo for entire lines
    partial_mapping =
    "<c-/>"                 -- Undo for selected characters -- Note: dont use this line as gu can also handle partial undo
    -- {mode="x","gu",desc="undo change in selected portion"}
  }

}
