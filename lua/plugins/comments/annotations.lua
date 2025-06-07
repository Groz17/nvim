return{
    -- is there another plugin that adds stuff like --stylua:ignore? (could use a gcs (or gci for ignore) binding)
    -- disable change in which-key window (because mapping starts with c)
    'danymat/neogen',
    -- maybe use gC{d,f,t,c}? usa gli stessi mapping di mini.ai like param, etc...
    -- Maybe gC? like gCO and gco, etc... gcA...
    keys = {
      -- In the end it's a comment 😉
      -- will generate annotation for the function, class or other relevant type you're currently in (for ex type = "file" when empty file I guess)
      -- https://github.com/isaksamsten/nvim-config/blob/8e1eb7a0977456005589fe1631b9b8c40b8b8307/lua/plugins/coding.lua#L504
      -- need the mapping in insert mode for java (combine with <a-o> to go to next line)
      -- { mode = { "n"--[[ , "i"]] },"<c-;>", function() require('neogen').generate() end, desc = "Generate annotation" },
      -- Mnemonic: [c]create [d]ocblocks (not used in visual mode, so I can use c)
      { "cdf", function() require('neogen').generate({type = 'func'}) end, desc = "Generate function annotation" },
      -- y because gy is lsp mapping for type definition
      { "cdc", function() require('neogen').generate({type = 'class'}) end, desc = "Generate class annotation" },
      -- { "cdy", function() require('neogen').generate({type = 'type'}) end, desc = "Generate type annotation" },
      { "cdt", function() require('neogen').generate({type = 'type'}) end, desc = "Generate type annotation" },
      -- v because av is the text object for the whole file
      {
        "cdd",
        function()
          vim.ui.select( { "func", "class", "type", "file" }, { prompt = "Annotation type to generate", },
            function(choice) require('neogen').generate({ type = choice }) end)
        end,
        desc = 'Generate desired annotation',
      },
    },
    opts = {
      enabled = true, --if you want to disable Neogen
      input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
      --  use your favorite snippet engine to control the annotation, like jumping between placeholders.
      snippet_engine = 'luasnip',
      -- TODO: jump mapping blink?
      -- TODO: what's your snippet engine?
      -- snippet_engine = 'nvim',
    },
    -- config = function(_,opts)
    --   require'neogen'.setup(opts)
    -- end
  }
