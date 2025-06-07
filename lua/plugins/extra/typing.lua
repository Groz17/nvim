return{
    "nvzone/typr",
    dependencies = "nvzone/volt",
    cmd = {"Typr","TyprStats"},
    opts = {
        on_attach = function(buf)
        -- TODO: come si fa in lua?
        -- vim.keymap.del('i',)
        -- vim.cmd[[iunmap<buffer>]]
        -- vim.keymap.del('i',{buffer=buf})
        -- just do autopair stuff, or maybe keep jl
        end
    },
  }
