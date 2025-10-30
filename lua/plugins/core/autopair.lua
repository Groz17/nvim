-- disable in snacks input?
-- autopair <> in comments (actually just in strings)
-- how to disable end-pair-insertion? I'd use tabout for that...
-- The tabout mapping allows you to jump to end (or out) of pairs. (works with anything [quotes as well])

-- fai in modo che quando cancelli una estremità di un commento multiline venga cancellata anche l'altra
return {
  -- you could use a mapping like m-( like in emacs?
  -- make it so that when you press , or ; or punctuation at the start of parenthesis it goes outside... (,) -> (),
  'altermo/ultimate-autopair.nvim',
  -- event = { 'InsertEnter', 'CmdlineEnter', 'TermEnter', 'CursorMoved' },
  event = { 'InsertEnter', 'CmdlineEnter', 'TermEnter'  },
  -- branch = 'v0.6',
  opts = {
    { '{', '},', p = 11, multiline = false, cond = function(fn) return fn.in_node({ 'table_constructor' }) end, },
    -- https://github.com/Bekaboo/nvim/blob/3b23808a3f9740ecc024c4ec979e495eb4648dbe/lua/configs/ultimate-autopair.lua#L39
    -- usa any non-alphanumeric character and their escaped version, useful for regex
    { '\\(', '\\)' },
    { '\\[', '\\]' },
    { '\\{', '\\}' },
    { "\\'", "\\'" },
    { '\\"', '\\"' },
    { '[=[', ']=]', ft = { 'lua' } },
    { '<<<', '>>>', ft = { 'cuda' } },
    -- insert semicolon java before pressing <cr>?
    -- { '>', '<', newline = true , p = 11 },
    -- comment doesn't work?
    { '<', '>', ft = { 'html' } },
    -- todo: and not in bash/shell filetype?
    { '<', '>', cond = function(fn) return fn.in_string() or fn.in_node('comment') end, cmap = true, },
    { '<', '>', -- Condition for #include
      cond = function()
        local current_line = vim.api.nvim_get_current_line()
        return current_line:match('^%s*#%s*include[^%w]') ~= nil
      end,
      ft = { 'c', 'cpp' },
    },
    { '/*', '*/', ft = { 'c', 'cpp', 'cuda' }, newline = true, space = true },
    -- Paring '$' and '*' are handled by snippets,
    -- only use autopair to delete matched pairs here
    { '$', '$', ft = { 'markdown', 'tex','typst' }, --[[disable_start = true, disable_end = true,]] },
    { '*', '*', ft = { 'markdown' }, disable_start = true, disable_end = true },

    bs = {
      map = { '<c-h>', '<bs>' },
      cmap = { '<c-h>', '<bs>' },
      space = 'balance',
    },
    -- cr mapping that doesn't split paren/quotes? usa alt-o
    cr = {
      enable = false, -- causes issues to docker ftplugin (and maybe orgmode?) autocmds
      autoclose = true,
    },
    -- https://github.com/abecodes/tabout.nvim/issues/19
    -- would be cool if this worked with endwise (like tags)
    space2 = {
      -- Doesn't work well with regexes (mainly in character classes)
      enable = true,
    },
    -- close={enable=true},
    -- doeSnt work w/ multicursor
    fastwarp = {
      multi = true,
      nocursormove = false,
      {},
      -- what about before parenthesis? (http://danmidwood.com/content/2014/11/21/animated-paredit.html)
      -- mapping to put parenthesis at the end/start of current scope? like to add to multiline array for ex...
      {
        hopout = true,
        faster = true,
        -- map = '<c-s-0>',
        map = '<a-k>',
        cmap = '<a-k>',
        rmap = '<a-j>',
        rcmap = '<a-j>',
      },
    },
    extensions = {
      cond = {
        cond = function(fn)
          return not (fn.in_macro()          -- for multicursor; TODO: update with multicursor function and not whole hydra function
          -- or require('hydra.statusline').is_active()
)
        end,
      },
      suround = { p = 21 },
      fly = { nofilter = true },
      -- enable in telescope
      filetype = { p = 90, nft = {}, tree = true },
    },

    -- config_internal_pairs = {
    --   { '"', '"', fly = true },
    --   { "'", "'", fly = true },
    -- },
  },
}
