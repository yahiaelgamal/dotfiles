-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- Settings (from .vimrc)
-- =============================================================================
vim.opt.backspace = "indent,eol,start"
vim.opt.history = 50
vim.opt.ruler = true
vim.opt.synmaxcol = 100000
vim.opt.encoding = "utf-8"

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.sidescroll = 1
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true

vim.opt.wildignore:append("*/tmp/*,*.so,*.swp,*.zip,*/*cache/*")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.clipboard = "unnamed"

vim.opt.timeout = true
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 50

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrapscan = false
vim.opt.virtualedit = "block"

vim.opt.display:append("uhex")
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.wrap = false

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.completeopt = "longest,menuone"
vim.opt.startofline = false

vim.opt.listchars = { tab = "▸ ", eol = "¬", trail = "~", extends = "▸", precedes = "◂" }

vim.opt.guifont = "Monoid:h11"

-- =============================================================================
-- Keymaps
-- =============================================================================
local map = vim.keymap.set

-- Emacs-like insert mode movement
map("i", "<C-f>", "<C-o>l")
map("i", "<C-b>", "<C-o>h")
map("i", "<C-e>", "<C-o>$")
map("i", "<C-a>", "<C-o>^")

-- Alt+Backspace deletes a word
map("i", "<M-BS>", "<C-w>")
map("c", "<M-BS>", "<C-w>")

-- Tab as Escape
map("i", "<TAB>", "<ESC>")
map("o", "<TAB>", "<ESC>")
map("v", "<TAB>", "<ESC>")

-- ; as :
map("n", ";", ":")

-- Clear search highlight
map("n", "//", ":noh<CR>")

-- Black hole deletion (persist yanked text)
map("n", "d", '"_d')
map("n", "dd", '"_dd')
map("n", "D", '"_D')
map("n", "x", '"_x')
map("n", "X", '"_X')

-- Don't lowercase in visual mode
map("v", "u", "<NOP>")

-- Previous buffer
map("n", "<C-Space>", "<C-^>")

-- Tab navigation
map("n", "tj", ":tabprevious<CR>")
map("n", "tk", ":tabnext<CR>")
map("n", "th", ":tabfirst<CR>")
map("n", "tl", ":tablast<CR>")

-- Fast scrolling with arrow keys
map("n", "<Right>", "20zl")
map("n", "<Left>", "20zh")
map("n", "<Up>", "20<C-y>")
map("n", "<Down>", "20<C-e>")

-- K just goes up (override default man page lookup)
map("n", "K", "k")

-- Enter selects completion
map("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-g>u<CR>"
end, { expr = true })

-- Leader mappings
map("n", "<leader>s", ":set lines=120 columns=100<CR>")
map("n", "<leader>b", ":set lines=2000 columns=2000<CR>")
map("n", "<leader>j", ":%!python3 -m json.tool<CR>")
map("n", "<leader>l", ":set list!<CR>")

-- Filename/path copy helpers
local function copy_filename() vim.fn.setreg("*", vim.fn.expand("%:t")) end
local function copy_full_path() vim.fn.setreg("*", vim.fn.expand("%:p")) end
local function copy_dir_path() vim.fn.setreg("*", vim.fn.expand("%:p:h")) end

map("n", "<leader>f", copy_filename)
map("n", "<leader>F", copy_full_path)
map("n", "<leader>D", copy_dir_path)

vim.api.nvim_create_user_command("FilenameCopy", copy_filename, {})
vim.api.nvim_create_user_command("FilenameCopyFullPath", copy_full_path, {})
vim.api.nvim_create_user_command("PathCopy", copy_dir_path, {})

-- Zoom toggle
local function zoom_toggle()
  if vim.fn.winnr("$") == 1 then return end
  if vim.t.zoom_restore then
    vim.cmd(vim.t.zoom_restore)
    vim.t.zoom_restore = nil
  else
    vim.t.zoom_restore = vim.fn.winrestcmd()
    vim.cmd("wincmd |")
    vim.cmd("wincmd _")
  end
end
map("n", "+", zoom_toggle)

-- Command abbreviations
vim.cmd("cabbrev W w")
vim.cmd("cabbrev Q q")
vim.cmd("cabbrev E e")
vim.cmd("cabbrev wQ! wq!")

-- Remove trailing whitespace command
vim.api.nvim_create_user_command("Notrailingspace", [[%s/\s\{1,}$//g]], {})
vim.api.nvim_create_user_command("RemoveBreakLines", [[g/^\s*$/d]], {})

-- =============================================================================
-- Filetype settings
-- =============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "txt" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == "" then vim.bo.filetype = "txt" end
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.hql", "*.q" },
  callback = function() vim.bo.filetype = "sql" end,
})

-- =============================================================================
-- Plugins
-- =============================================================================
require("lazy").setup({
  -- Markdown preview in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- File tree (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>d", ":NvimTreeToggle<CR>", desc = "Toggle file tree" } },
    opts = {},
  },

  -- Commenting (replaces NERDCommenter)
  {
    "numToStr/Comment.nvim",
    opts = {},
    keys = {
      { "<C-l>", function() require("Comment.api").toggle.linewise.current() end, mode = "n" },
      { "<C-l>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = "v" },
    },
  },

  -- Status line (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto" },
      sections = { lualine_c = { { "filename", path = 0 } } },
      tabline = { lualine_a = { "buffers" }, lualine_z = { "tabs" } },
    },
  },

  -- Fuzzy finder (replaces CtrlP)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>g", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
      { "<leader>B", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    },
  },

  -- Surround (replaces vim-surround)
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- Auto pairs (replaces delimitMate)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { map_cr = true },
  },

  -- Indent guides (replaces indentLine)
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- Motion (replaces easymotion)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
    },
  },

  -- LSP (replaces YouCompleteMe + ALE linting)
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     -- Add language servers as needed, e.g.:
  --     lspconfig.pyright.setup({})
  --     -- lspconfig.ts_ls.setup({})
  --
  --     map("n", "<leader>jd", vim.lsp.buf.definition)
  --     map("n", "<leader>h", vim.lsp.buf.hover)
  --     map("n", "<leader>rn", vim.lsp.buf.rename)
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config('pyright', {})
      vim.lsp.enable('pyright')

      -- map("n", "<leader>jd", vim.lsp.buf.definition)
      -- map("n", "<leader>h", vim.lsp.buf.hover)
      -- map("n", "<leader>rn", vim.lsp.buf.rename)

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
    end,
  },

  -- Formatting (replaces ALE fixers)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        python = { "black" },
      },
      format_on_save = { timeout_ms = 2000, lsp_fallback = true },
    },
  },

  -- Treesitter (better syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Colorscheme
  {
    "w0ng/vim-hybrid",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme hybrid")
    end,
  },

  --  add gitsigns
  { "lewis6991/gitsigns.nvim", config = true }
})


-- mapping
-- pressing p in quickfix window will view the position
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
      vim.keymap.set('n', 'p', '<CR><C-w>p', { buffer = true, silent = true })
    end,
  })

