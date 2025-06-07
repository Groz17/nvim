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
    -- event = "VeryLazy",
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    keys = function(_, keys)
      ---@see https://github.com/yetone/avante.nvim/wiki/Recipe-and-Tricks
      -- prefil edit window with common scenarios to avoid repeating query and submit immediately
      local prefill_edit_window = function(request)
        require('avante.api').edit()
        local code_bufnr = vim.api.nvim_get_current_buf()
        local code_winid = vim.api.nvim_get_current_win()
        if code_bufnr == nil or code_winid == nil then
          return
        end
        vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
        -- Optionally set the cursor position to the end of the input
        vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
        -- Simulate Ctrl+S keypress to submit
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
      end

      -- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
      local avante_grammar_correction = 'Correct the text to standard English, but keep any code blocks inside intact.'
      local avante_keywords = 'Extract the main keywords from the following text'
      local avante_code_readability_analysis = [[
      You must identify any readability issues in the code snippet.
      Some readability issues to consider:
      - Unclear naming
      - Unclear purpose
      - Redundant or obvious comments
      - Lack of comments
      - Long or complex one liners
      - Too much nesting
      - Long variable names
      - Inconsistent naming and code style.
      - Code repetition
      You may identify additional problems. The user submits a small section of code from a larger file.
      Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
      If there's no issues with code respond with only: <OK>
      ]]
      local avante_optimize_code = 'Optimize the following code'
      local avante_summarize = 'Summarize the following text'
      local avante_translate = 'Translate this into Chinese, but keep any code blocks inside intact'
      local avante_explain_code = 'Explain the following code'
      local avante_complete_code = 'Complete the following codes written in ' .. vim.bo.filetype
      local avante_add_docstring = 'Add docstring to the following codes'
      local avante_fix_bugs = 'Fix the bugs inside the following codes if any'
      local avante_add_tests = 'Implement tests for the following code'

      require('which-key').add {
        { '<leader>aq', group = 'Avante queries' }, -- NOTE: add for avante.nvim
        {
          mode = { 'n', 'x' },
          { '<leader>aqg', function() require('avante.api').ask { question = avante_grammar_correction } end, desc = 'Grammar Correction(ask)' },
          { '<leader>aqk', function() require('avante.api').ask { question = avante_keywords } end, desc = 'Keywords(ask)' },
          { '<leader>aql', function() require('avante.api').ask { question = avante_code_readability_analysis } end, desc = 'Code Readability Analysis(ask)' },
          { '<leader>aqo', function() require('avante.api').ask { question = avante_optimize_code } end, desc = 'Optimize Code(ask)' },
          { '<leader>aqm', function() require('avante.api').ask { question = avante_summarize } end, desc = 'Summarize text(ask)' },
          { '<leader>aqn', function() require('avante.api').ask { question = avante_translate } end, desc = 'Translate text(ask)' },
          { '<leader>aqx', function() require('avante.api').ask { question = avante_explain_code } end, desc = 'Explain Code(ask)' },
          { '<leader>aqc', function() require('avante.api').ask { question = avante_complete_code } end, desc = 'Complete Code(ask)' },
          { '<leader>aqd', function() require('avante.api').ask { question = avante_add_docstring } end, desc = 'Docstring(ask)' },
          { '<leader>aqb', function() require('avante.api').ask { question = avante_fix_bugs } end, desc = 'Fix Bugs(ask)' },
          { '<leader>aqu', function() require('avante.api').ask { question = avante_add_tests } end, desc = 'Add Tests(ask)' },
        },
      }

      require('which-key').add {
        -- NOTE: duplicate code?
        { '<leader>aq', group = 'Avante queries' }, -- NOTE: add for avante.nvim
        {
          mode = { 'x' },
          { '<leader>aqG', function() prefill_edit_window(avante_grammar_correction) end, desc = 'Grammar Correction' },
          { '<leader>aqK', function() prefill_edit_window(avante_keywords) end, desc = 'Keywords' },
          { '<leader>aqO', function() prefill_edit_window(avante_optimize_code) end, desc = 'Optimize Code(edit)' },
          { '<leader>aqC', function() prefill_edit_window(avante_complete_code) end, desc = 'Complete Code(edit)' },
          { '<leader>aqD', function() prefill_edit_window(avante_add_docstring) end, desc = 'Docstring(edit)' },
          { '<leader>aqB', function() prefill_edit_window(avante_fix_bugs) end, desc = 'Fix Bugs(edit)' },
          { '<leader>aqU', function() prefill_edit_window(avante_add_tests) end, desc = 'Add Tests(edit)' },
        },
      }
      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Opts                                                    │
      -- ╰─────────────────────────────────────────────────────────╯
      require'which-key'.add({'<leader>at', group = "Avante toggle"})
      ---@type avante.Config
      local opts = require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

      local mappings = {}
      for fun, mapping in pairs(opts.mappings) do
       table.insert(mappings, { mapping, function() require("avante.api")[fun]() end, desc = "avante: " .. fun, mode = { "n", "x" } })
      end

      -- local mappings = {
      --   { opts.mappings.ask, function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "x" } },
      --   { opts.mappings.refresh, function() require("avante.api").refresh() end, desc = "avante: refresh", mode = "x" },
      --   { opts.mappings.edit, function() require("avante.api").edit() end, desc = "avante: edit", mode = { "n", "x" } },
      --   -- TODO: wait for mapping in opts...
      --   -- magari mettin in setup...
      --   { '<leader>aq', function() require('avante.diff').conflicts_to_qf_items(function(items) if #items > 0 then vim.fn.setqflist(items, "r") vim.cmd('copen') end end) end, desc = "avante: convert generated conflict to quickfix items" }
      -- }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)

      table.insert(mappings,{ "<leader>aQ",

      function()
        require('avante.diff').conflicts_to_qf_items(function(items)
          if #items > 0 then
            vim.fn.setqflist(items, "r")
            vim.cmd('copen')
          end
        end)
      end, desc = "convert generated conflict to quickfix items" })

      -- TODO: use providers defined in vendors? w/ snacks... if more than 2
      table.insert(mappings,{ "<leader>ap", ":AvanteSwitchProvider<space>"})

      return vim.list_extend(mappings, keys)
    end,
    ---@class avante.Config
    opts = function() return{
      -- should only work with shoud_attach copilot.lua config right?
      provider = "copilot",
      -- provider = "ollama",
      -- https://github.com/yetone/avante.nvim/issues/811#issuecomment-2482151455
      ollama = {
        endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
        model = "deepseek-r1:latest",
      },
      -- provider = "ollama",
      -- auto_suggestions_provider = "ollama", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      -- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
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
        ask = "<leader>aa", -- ask
        edit = "<leader>ae", -- edit
        refresh = "<leader>ar", -- refresh
        focus = '<leader>af',
        stop = '<leader>aS',
        debug = '<leader>atd',
        hint = '<leader>ath',
        suggestion = '<leader>ats',
        get = '<leader>atg',
        submit = {
          -- like comments in microsoft word 
          -- insert = "<c-cr>",
          -- NOTE: emacs-like keybinding
          insert = "<c-c><c-c>",
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
  -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub:get_active_servers_prompt()
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
    }end,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.icons",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      'ravitemer/mcphub.nvim',
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
--https://dev.to/ottercyborg/neovim-my-setup-for-developer-assistant-with-local-language-models-2nim
-- map("n", "“<A-m>", function()
-- require("gen").select_model()
-- end, { desc = "Select gen.nvim model" })
--
-- magari usa vim.ui.select
-- vim.fn.systemlist("curl --silent --no-buffer http://" .. options.host .. ":" .. options.port .. "/v1/models")
      -- local list = vim.fn.json_decode(response)
      -- 
