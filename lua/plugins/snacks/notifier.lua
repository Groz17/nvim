-- persistant notifications?
-- mapping to disable notification per next command/mapping? for when u are w/ friends and wanna show off/hide stuff
return {
  'snacks.nvim',
  opts = {
    notifier = {
      width = {
        -- how to center align?
        min=30,max=40
      },
    },
  },
  keys = {
    -- { '<leader>nd', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    -- { "<leader>nn",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { 'g>', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    { "g<",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },
}
