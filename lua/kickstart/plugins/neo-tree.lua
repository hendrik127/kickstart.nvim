-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['h'] = 'close_node', -- Close the current folder
          ['l'] = 'open', -- Open the current folder
        },
      },
    },
  },
  init = function()
    -- Auto-open NeoTree when a directory is opened in Neovim
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function(data)
        -- Check if the file is a directory
        local directory = vim.fn.isdirectory(data.file) == 1
        if directory then
          -- Change to the directory
          vim.cmd.cd(data.file)
          -- Open NeoTree
          vim.cmd 'Neotree reveal'
        end
      end,
    })
  end,
}
