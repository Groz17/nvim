-- https://github.com/yetone/avante.nvim/issues/1772
-- how to specify initial (once) string? like always generate code blocks?
---https://github.com/dlants/magenta.nvim
---@see https://www.reddit.com/r/neovim/comments/1hzjnz1/supercharge_your_llm_completionchatbot_plugin/
-- <esc> to dismiss avante diffs?
-- how to combine commands? like /clear&&question?
-- how to specify context? like send last two message and the 5th last?
-- Utilize tools like `tiktoken` for precise token counting.
-- https://github.com/yetone/avante.nvim/blob/main/lua/avante/api.lua
-- https://github.com/yetone/avante.nvim/wiki
--https://github.com/yetone/avante.nvim/pull/527
-- stay in prompt after answer?
-- for all these questions use llm git github issues/discussions as MCP
-- use orgmode?
return {
    "yetone/avante.nvim",
    keys = { "<leader>a" },
    init = function ()
      -- views can only be fully collapsed with the global statusline
      vim.opt.laststatus = 3

    end,
    version = false, -- set this if you want to always pull the latest change
    ---@class avante.Config
    opts = {
      mode = 'legacy',
      provider = "copilot",
      -- provider = "ollama",
      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
          model = "deepseek-r1:latest",
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = false,
        auto_set_keymaps = true,
        -- maybe auto apply (without having to choose theirs) when there's only one conflict and auto apply with choosing if there are many conflicts?
        auto_apply_diff_after_generation = true,
        -- auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = true,
      },
      mappings = {
        -- use v:count to choose provider?
        submit = {
          -- NOTE: emacs-like keybinding
          insert = "<cr>",
        },
      },
      windows = {
        ask = { floating=true },
      },
      -- https://github.com/yetone/avante.nvim/?tab=readme-ov-file#blinkcmp-users
      file_selector = {
        provider = 'snacks'
      },
      web_search_engine = {
        provider = "tavily",
        providers = {
          tavily = {
            extra_request_body = {
              include_answer = "advanced",
            },     -- 
          },
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.icons",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- 'ravitemer/mcphub.nvim',
    {
      -- support for image pasting
      "img-clip.nvim",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- -- required for Windows users
          -- use_absolute_path = true,
        },
      },
    }
    },
}
