return {
  {
    "snacks.nvim",
    opts = function()
      -- how to put in quickfix window?
      -- Toggle the profiler
      Snacks.toggle.profiler():map("<f13>p")
      -- Toggle the profiler highlights
      Snacks.toggle.profiler_highlights():map("<f13>P")
    end,
    keys = {
      -- { "<leader>;", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
    }
  },
}
