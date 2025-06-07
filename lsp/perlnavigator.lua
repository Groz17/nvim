return {
  cmd = {
    'node',
    require('mason-registry').get_package('perlnavigator'):get_install_path()
      .. '/node_modules/perlnavigator-server/out/server.js',
    '--stdio',
  },
  filetypes = {'perl'}
}
