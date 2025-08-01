-- https://github.com/yetone/avante.nvim/issues/1772
-- how to specify initial (once) string? like always generate code blocks?
-- how to switch between models? i wanna use gemini
-- in chat, copilot shouldn't work when disabled?
---https://github.com/dlants/magenta.nvim
---@see https://www.reddit.com/r/neovim/comments/1hzjnz1/supercharge_your_llm_completionchatbot_plugin/
-- <esc> to dismiss avante diffs?
-- how to combine commands? like /clear&&question?
-- how to specify context? like send last two message and the 5th last?
-- Utilize tools like `tiktoken` for precise token counting.
-- https://github.com/yetone/avante.nvim/blob/main/lua/avante/api.lua
-- https://github.com/yetone/avante.nvim/wiki
--https://github.com/yetone/avante.nvim/pull/527
-- add option to tell copilot/LLM to be more verbose and also show how many tokens you've got left
-- come sapere quali file usa come source?
-- TODO: crea mapping per copiare/yankare solo codice (tra ``` e ```)
-- TODO: after /clear the cursor should stay in the input window
-- how to put selected code window on top?
-- stay in prompt after answer?
-- for all these questions use llm git github issues/discussions as MCP
-- use orgmode?
return {
  
    -- use demicolon for ]x, [x
    -- does copilot have access to my whole buffer? how to disable and only let it know visual selection/other way specified by me?
    -- hint???
    -- history in chat with ^n, ^p???
    "yetone/avante.nvim",
    -- commit = 'd5a4db8',
    -- visual mode doesn't really matter to avante?
    init = function ()
      -- views can only be fully collapsed with the global statusline
      vim.opt.laststatus = 3

    end,
    -- TODO: show in statusline how many tokens remain https://github.com/yetone/avante.nvim/issues/367
    version = false, -- set this if you want to always pull the latest change
    ---@class avante.Config
    opts = {
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
          -- like comments in microsoft word 
          -- insert = "<c-cr>",
          -- NOTE: emacs-like keybinding
          insert = "<cr>",
        },
      },
      hints = { enabled = false },
      windows = {
        ask = { floating=true },
        -- TODO: use dynamic size (enlarge when multiple lines)
        -- position = "top", -- the position of the sidebar
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

      -- MCP ---
system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
        return {
            require("mcphub.extensions.avante").mcp_tool(),
        }
    end,
    disabled_tools = {
        "list_files",    -- Built-in file operations
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",         -- Built-in terminal access
    },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.icons",
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
