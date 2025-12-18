return {
    "salkin-mada/openscad.nvim",
    ft = 'openscad',
    config = function()
        vim.g.openscad_load_snippets = true
        vim.g.openscad_fuzzy_finder = 'snacks'
        vim.g.openscad_pdf_command = 'sioyek'

        vim.g.openscad_cheatsheet_toggle_key = '<Enter>'
        vim.g.openscad_help_trig_key = '<A-h>'
        vim.g.openscad_manual_trig_key = '<A-m>'
        vim.g.openscad_exec_openscad_trig_key = '<C-c><C-c>'
        vim.g.openscad_top_toggle = '<A-c>'
        require("openscad")
    end,
    dependencies = { "L3MON4D3/LuaSnip", "snacks.nvim" },
}
