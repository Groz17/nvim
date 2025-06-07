vim.b.minisurround_config = {
  custom_surroundings = {
    ["d"] = { output = { left = "dbg!(", right = ")" }, input = { "dbg!%(().-()%)" } },
  },
}
