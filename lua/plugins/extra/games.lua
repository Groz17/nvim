-- https://github.com/jasonjmcghee/livelove
return
{
  -- support hot reloading + don't focus window when running? (maybe configure with WM...)
  "S1M0N38/love2d.nvim",
  -- maybe make it run only on a directory called Lua? for your projects? or files with .love extension? so it doesn't mess up with lua_ls? it does tho
  cmd = "LoveRun",
  opts = { restart_on_save = true },
  keys = {
    -- maybe better without <nop>? what's the diff?
    { "<localleader>v", ft = "lua", desc = "LÖVE", buffer = true},
    -- { "<localleader>v",'<nop>', ft = "lua", desc = "LÖVE", buffer = true},
    { "<localleader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE", buffer = true},
    { "<localleader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE", buffer = true},
  },
}
