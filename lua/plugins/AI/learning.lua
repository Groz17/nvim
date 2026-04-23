return {
  "Hashino/learning.nvim",
  cond=false,
  opts = {
      eagerness = 0.25, -- how eager the plugin is to show suggestions, between 0 and 1. higher means more suggestions

      provider = {
        api_key = "", -- your API key. be careful putting it in your dotfiles
        api_url = "", -- the URL for the API of your provider, example https://api.openai.com/v1/chat/completions
        model = "", -- the model you want to use, should be specified in the docs of your provider
      },
  },
}
