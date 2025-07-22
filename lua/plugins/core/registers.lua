return
{
  -- TODO: check if clipboard was modified outside and update it
  -- autocmd/event to check if register value has changed? for @+...
  -- INFO: bel plugin
  -- TODO: works unless you switch i3 workspace
  'EtiamNullam/deferred-clipboard.nvim',
  opts = {
    lazy = true,
  },

}
