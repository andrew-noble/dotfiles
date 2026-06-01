vim.g.mapleader = ' ' -- leader/prefix for the telescope stuff
vim.opt.relativenumber = true -- add relative lines numbers
vim.opt.showmode = false -- mode shown in status line instead
vim.opt.clipboard = 'unnamedplus' -- sync with OS clipboard
vim.opt.breakindent = true
vim.opt.undofile = true -- persist undo history across sessions
vim.opt.ignorecase = true -- case-insensitive search...
vim.opt.smartcase = true -- ...unless capitals used
vim.opt.updatetime = 250 -- time before tooltips appear
vim.opt.timeoutlen = 500 -- time to wait for key sequence
vim.opt.splitright = true -- splits open right/below (not left/above)
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.confirm = true -- prompt to save instead of failing on :q
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('n', 'H', '<C-w>h')
vim.keymap.set('n', 'L', '<C-w>l')
vim.keymap.set('n', '<Esc>', '<cmd>noh<CR><Esc>')

-- flash text when yanked
-- (this is an autocommand. It's like a hook or event listener in that it gets
-- triggers when an event happens, as opposed to manual triggering)
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- simplee statusline
vim.pack.add { 'https://github.com/echasnovski/mini.nvim' }
require('mini.statusline').setup()

-- color scheme
vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- disable italics in comments
  },
}
vim.cmd.colorscheme 'tokyonight-night'

-- formatting with conform (automatically cleans up indents, etc)
vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  format_on_save = { timeout_ms = 500 },
  formatters_by_ft = {
    python = { 'isort', 'black' }, -- add new formatters here
    html = { 'prettier' },
  },
  formatters = {
    black = { prepend_args = { '--line-length', '100' } },
    prettier = { prepend_args = { '--print-width', '100' } },
  },
}

-- syntax highlighting with tree sitter
vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }
require('nvim-treesitter').install({ 'bash', 'lua', 'python', 'html', 'markdown' })

-- treesitter text objects: yaf/yif (function), yac/yic (class), etc.
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }
require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true, -- jump forward to next text object if not inside one
  },
}
local ts_select = require('nvim-treesitter-textobjects.select').select_textobject
vim.keymap.set({ 'x', 'o' }, 'af', function() ts_select('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() ts_select('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() ts_select('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() ts_select('@class.inner', 'textobjects') end)

-- diagnostics: virtual text inline + float auto-pops when cursor rests on an error
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  float = { border = 'rounded' },
}
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
})

-- git blame inline on current line; priority=1 so diagnostics win when both are present
vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = { delay = 400, virt_text_priority = 1 },
}

-- LSP: start pyright when opening python files
-- (requires: pip install pyright)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.lsp.start({
      name = 'pyright',
      cmd = { 'pyright-langserver', '--stdio' },
      settings = {
        python = {
          analysis = {
            extraPaths = { '/opt/ros/jazzy/lib/python3.12/site-packages' },
          },
        },
      },
    })
  end,
})

-- show completion popup automatically while typing
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = false })
  end,
})

vim.opt.number = true -- add line numbers

-- telescope, a fzf tool to open files
vim.pack.add { 'https://github.com/nvim-lua/plenary.nvim' } -- a dependency of telescope
vim.pack.add { 'https://github.com/nvim-telescope/telescope.nvim' }
require('telescope').setup()

-- keymaps for telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)

-- bufferline, it shows the open buffers along the top like tabs
vim.pack.add { 'https://github.com/akinsho/bufferline.nvim' }
require('bufferline').setup()
