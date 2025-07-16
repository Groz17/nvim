-- https://github.com/girishji/devdocs.vim?tab=readme-ov-file
-- https://github.com/luckasRanarison/nvim-devdocs/pull/12
-- https://github.com/luckasRanarison/nvim-devdocs/issues/79

-- https://github.com/luckasRanarison/nvim-devdocs/issues/55
-- https://github.com/Zeioth/dooku.nvim?tab=readme-ov-file#should-i-use-doge-or-dooku

-- <c-v> does not work...

-- does it makes sense to use vim.g.tleader here? dunno

-- usa glow as previewer?

-- support operator: (maybe gh->get help)
-- Plug 'KabbAmine/zeavim.vim'
-- nmap <leader>z <Plug>Zeavim
-- vmap <leader>z <Plug>ZVVisSelection
-- nmap gz <Plug>ZVOperator
-- nmap <leader><leader>z <Plug>ZVKeyDocset
return {
    {
     "maskudo/devdocs.nvim",
    cond = false,
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "DevDocs" },
    keys = {
      {
        "<leader>?o",
        mode = "n",
        "<cmd>DevDocs get<cr>",
        desc = "Get Devdocs",
      },
      {
        "<leader>?i",
        mode = "n",
        "<cmd>DevDocs install<cr>",
        desc = "Install Devdocs",
      },
      {
        "<leader>?v",
        mode = "n",
        function()
          local devdocs = require("devdocs")
          local installedDocs = devdocs.GetInstalledDocs()
          vim.ui.select(installedDocs, {}, function(selected)
            if not selected then
              return
            end
            local docDir = devdocs.GetDocDir(selected)
            -- prettify the filename as you wish
            Snacks.picker.files({ cwd = docDir })
          end)
        end,
        desc = "Get Devdocs",
      },
      {
        "<leader>?d",
        mode = "n",
        "<cmd>DevDocs delete<cr>",
        desc = "Delete Devdoc",
      }
    },
    opts = {
      ensure_installed = {
        "go",
        "html",
        -- "dom",
        "http",
        -- "css",
        -- "javascript",
        -- "rust",
        -- some docs such as lua require version number along with the language name
        -- check `DevDocs install` to view the actual names of the docs
        "lua~5.1",
        "openjdk~21"
      },
    },
  },
  -- {
  --   "KabbAmine/zeavim.vim",
  --   init = function()
  --     -- vim.g.zv_zeal_args = vim.g.has_unix and '--style=gtk+' or ''
  --
  --     -- vim.keymap.set('n', '<leader>z', '<Plug>Zeavim',{remap=true})
  --     -- vim.keymap.set('x', '<leader>z', '<Plug>ZVVisSelection',{remap=true})
  --     vim.keymap.set('n', 'gh', '<Plug>ZVOperator',{remap=true})
  --     -- vim.keymap.set('n', '<leader><leader>z', '<Plug>ZVKeyDocset',{remap=true})
  --   end
  -- }
}

-- use gK as operator for documentation...
