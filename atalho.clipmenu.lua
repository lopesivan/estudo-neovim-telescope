map(
  { 'n', 'i' },
  '<leader>pc',
  function() require('core.utils.clipmenu_telescope').clipmenu() end,
  { desc = 'Clipmenu (Telescope)' }
)

