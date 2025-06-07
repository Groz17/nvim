-- usa altro prefisso più generale (magari usi gitlab per esempio)
-- h = {
--   name = '+github',
-- },

-- Generate shareable file permalinks
-- "ruifm/gitlinker.nvim",
-- '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".copy_to_clipboard})<cr>',
-- "Copy link to clipboard",
--   "y", {
--   {
--     ".",
--     '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>',
--     "range url"
--   },
--   {
--     "*",
--     '<cmd>lua require"gitlinker".get_repo_url()<cr>',
--     "repo url"
--   }
-- },
--   "+url"
return{
  {
    -- TODO: use conventional commit?
    'skywind3000/vim-gpt-commit',
    -- ft = 'gitcommit',
    cmd = 'GptCommit',
    -- TODO: ft = gitcommit?
    config = function()
      -- if you don't want to set your api key directly, add to your .zshrc:
      -- export OPENAI_API_KEY='sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      -- vim.g.gpt_commit_key = os.getenv("OPENAI_API_KEY")
      -- uncomment this line below to enable proxy
      -- vim.g.gpt_commit_proxy = 'socks5://127.0.0.1:1080'

      -- uncomment the following lines if you want to use Ollama:
      vim.g.gpt_commit_engine = 'ollama'
      vim.g.gpt_commit_ollama_url = 'http://127.0.0.1:11434/api/chat'
      vim.g.gpt_commit_ollama_model = 'dolphin-mistral'
    end,
  },
  -- {'kana/vim-gf-diff', ft = 'git'}
  -- TODO: doesn't work
  -- {'kana/vim-gf-diff', ft = 'diff'}
}
  -- https://www.reddit.com/r/neovim/comments/1h95vs5/commitmentnvim_plugin_to_remind_you_to_commit/
