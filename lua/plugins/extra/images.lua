return {
  -- TODO: integra con mini.files? (https://github.com/HakonHarnes/img-clip.nvim#oilnvim)
  -- .img-clip.lua file
  -- how to abort? it doesn't when pressing <esc> in input field... (if empty input abort???)
  {
    'HakonHarnes/img-clip.nvim',
    -- event = "VeryLazy",
    opts = {
      default = {
        relative_to_current_file = true,
        use_absolute_path = false,
        dir_path = 'resources/notes'
      }
    },
    keys = {
      {
        "<f17>M",
        function()
          Snacks.picker.files {
            ft = { "jpg", "jpeg", "png", "webp" },
            confirm = function(self, item, _)
              self:close()
              require("img-clip").paste_image({}, "./" .. item.file) -- ./ is necessary for img-clip to recognize it as path
            end,
          }
        end,
        desc = "Select and embed images"
      },
    },
    cmd = 'YankMedia',
    config = function()
      vim.api.nvim_create_user_command('YankMedia', 'PasteImage',{})
    end
  },
  {
    "r-pletnev/pdfreader.nvim",
    dependencies = {
      "folke/snacks.nvim", -- image rendering
    },
    event = 'BufRead *.pdf',
    cond = false,
    lazy = true,
    opts = {},
    keys = {
      { 'gg', '<cmd>PDFReader setPage ' .. vim.v.count1 .. '<cr>', buffer = true },
      { 'j',  'n',                                                remap = true, buffer = true },
      { 'k',  'p',                                                remap = true, buffer = true },
    },
  }

  --   {
  --   },
}
--
-- investigate this option
-- use_absolute_path = false,
-- filetypes = {
--   vimwiki = {
--     download_images = true,
