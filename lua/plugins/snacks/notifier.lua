-- persistant notifications? log? also with command/keybinding trigger source
-- mapping to disable notification per next command/mapping? for when u are w/ friends and wanna show off/hide stuff
return {
  'snacks.nvim',
  opts = {
    notifier = {
      width = {
        -- how to center align?
        min = 30,
        max = 40
      },
    },
  },
  keys = {
    { 'g>', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    -- { "g<", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<f18>e","<cmd>NoiceSnacks<cr>", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },
}
