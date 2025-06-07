return
{
  "azratul/live-share.nvim",
  cond = false,
  dependencies = {
    "jbyuki/instant.nvim",
  },
  config = function()
    vim.g.instant_username = "groz"
    require("live-share").setup({
      service = "serveo.net"
    })
  end
}
