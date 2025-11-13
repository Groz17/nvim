return
-- TODO: disable fidget spinner at the bottom?
{
  -- what about scheme?, for treesitter
  'williamboman/mason.nvim',
  cmd = {
    'Mason',
    'MasonUpdate',
    'MasonInstall',
    'MasonUninstall',
    'MasonUninstallAll',
    'MasonLog',
  },
  -- Lazy-loading the plugin, or somehow deferring the setup, is not recommended.
  lazy = false,
  build = ':MasonUpdate',  -- :MasonUpdate updates registry contents
  -- opts = {
  --   -- border = "single",
  --   -- winhighlight = "Normal:Normal,FloatBorder:VertSplit,CursorLine:CursorLine,Search:Search",
  -- },
  opts = {
    -- upgrade java 21
    -- registries = {
    --   "github:nvim-java/mason-registry"
    -- },
    ensure_installed = { -- divide by categories like lsp, etc...?
      'tinymist',
      'html-lsp',
      'docker',
      'systemd-language-server'
      -- 'harper'
      -- "html-lsp", "basedpyright", "bash-debug-adapter", "bash-language-server", "biome", "clangd",
      -- "css-lsp", "harper-ls", "java-debug-adapter", "java-test", "jdtls", "lua-language-server", "perlnavigator", "rust-analyzer", "shfmt", "sqlls", "taplo", "vim-language-server",
    },
  },

  -- vim.api.nvim_create_user_command("MasonInstallAll", function()
  --   vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
  -- end, {})
}
