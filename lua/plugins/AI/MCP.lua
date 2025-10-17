-- usalo per nebo database kanata, etc...
-- usalo per vimwiki/wiki
-- awesome-mcp-servers
-- can u connect to multiple servers at the same time? multiple ports?
return {
  'ravitemer/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'MCPHub',
  build = 'bundled_build.lua', -- Bundles mcp-hub locally
  opts = {
    -- TODO: metti i server in .local/share/nvim
    use_bundled_binary = true, -- Use local binary
    extensions = {
      avante = {
        auto_approve_mcp_tool_calls = false, -- Auto approves mcp tool calls
        make_slash_commands = true, -- make /slash commands from MCP server prompts
      },
    },
  },
}
