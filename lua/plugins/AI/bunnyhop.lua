-- can it work cross file?
return {
  'PLAZMAMA/bunnyhop.nvim',
  cond = false,
  -- maybe use copilot.lua dependency?
  lazy = false, -- This plugin does not support lazy loading for now
  -- Setting the keybinding for hopping to the predicted location.
  -- Change it to whatever suits you.
  keys = {
    {
      -- "<C-h>",
      '<CR>',
      function() require('bunnyhop').hop() end,
      desc = '[H]op to predicted location.',
    },
  },
  opts = {}, -- if using copilot
  -- Or
  -- opts = {adapter = "hugging_face", api_key = "HF_API_KEY", model = "Qwen/Qwen2.5-Coder-32B-Instruct"}, -- if using hugging face
}
