-- **Custom section in snacks dashboard**
--  releases (github)
--  curl https://www.opensrsstatus.com/history.rss
-- search on github/web for cool feeds
-- https://www.semicolonandsons.com/email_subscribers/new
-- https://github.com/neo451/feed.nvim/wiki/Recipes
-- grep on contents as well?
return {
  'neo451/feed.nvim',
  cmd = 'Feed',
  opts = {
    feeds = {
      -- These two styles both work
      -- 'https://neovim.io/news.xml',
      -- tags given to a feed to be tagged to all its entries
      {
        'https://neovim.io/news.xml',
        name = 'Neovim',
        tags = { 'tech', 'news' },
      },
      'hackernews.com/rss', -- like so
      -- 'jvns.ca/atom.xml'
      -- https://raw.githubusercontent.com/eudoxia0/dotfiles/master/sources/feedlist.opml
				--   {
				-- 	"https://www.opensrsstatus.com/history.rss",
				-- 	name = "OpenSRS Status",
				-- 	tags = { "domains", "maintenance" }
				-- },
				{
					"ghostty-org/ghostty",
					name = "Ghostty",
					tags = { "terminal" }
				}
    },
  },
}
