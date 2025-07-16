return {
  -- TODO: integra con mini.files? (https://github.com/HakonHarnes/img-clip.nvim#oilnvim)
  -- .img-clip.lua file
  -- how to abort? it doesn't when pressing <esc> in input field... (if empty input abort???)
  {
    'HakonHarnes/img-clip.nvim',
    -- event = "VeryLazy",
    opts = {
      default = {
      relative_to_current_file=true,
      use_absolute_path = false,
      dir_path = 'resources/notes'
    }
    },
    keys = {
      {
        "<f17>m",
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
      {
        "<leader>p",
        function()
          return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
          or require("img-clip").paste_image()
        end,desc = "Paste image" },
        { '<leader>P', function() require('img-clip').pasteImage({max_base64_size=math.huge,embed_image_as_base64=true}) end, desc = "Paste image as base64" },
      },

    },
    --   {
      -- "haydushki-fmi/exifVim"
      --   },
    }
    -- https://github.com/lambdalisue/vim-gin
    -- https://github.com/sankantsu/gin-diff-image.nvim?tab=readme-ov-file
    --
    -- investigate this option
    -- use_absolute_path = false,
    -- filetypes = {
      --   vimwiki = {
        --     download_images = true,
        --     -- TODO: use function dir_path = function() check if exists and also if you're in resources.md, etc... how to abort?
          --   },
          -- },
          -- { '<leader>ib', function() require('img-clip').pasteImage({embed_image_as_base64=true}) end, desc = "Paste image as base64" },
          -- find algorithm to get it under 10kb (combination of quality and resize?)
          -- INLINE: base64 option???
          -- { '<leader>ib', function() require('img-clip').pasteImage({embed_image_as_base64=true,process_cmd = "convert - -resize 30% -quality 70 -"}) end, desc = "Paste image as base64" },
          -- { '<leader>ib', function() require('img-clip').pasteImage({max_base64_size=math.huge,extension='jpg',embed_image_as_base64=true,process_cmd = "convert - -quality 60 JPEG:-"}) end, desc = "Paste image as base64" },
          -- copy_images = true mapping?
