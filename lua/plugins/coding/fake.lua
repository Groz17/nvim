-- https://www.npmjs.com/package/@tehdb/faker-cli
return
{
  'tehdb/nvim-faker',
  -- build = 'npm install --global @tehdb/faker-cli',
  cmd = 'Faker',
  opts = {
    -- For faster `:Faker` command executions, it is recommended to install the faker CLI as a global npm package using `npm i -g @tehdb/faker-cli`. Otherwise, [npx](https://docs.npmjs.com/cli/v11/commands/npx) is used to run faker commands, which consumes more time to execute.
    -- use_global_package = true -- use gloabl npm package otherwise npx (default: false)
  }
}
