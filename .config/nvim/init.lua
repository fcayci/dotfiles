--------------------------------------------------
-- Set default leader
--------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


--------------------------------------------------
-- Install package manager - Lazy
--------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


--------------------------------------------------
-- Setup Lazy
--------------------------------------------------
require('lazy').setup({
  -- Theme
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
      },
    },
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Better lua integration
    { 'folke/neodev.nvim', opts = {} },
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
    },
  },

  -- Parser, highlight
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Show keys
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Comment
  { 'numToStr/Comment.nvim',   opts = {} },

  -- awesome code outline
  'stevearc/aerial.nvim',

  -- sticky buffers
  { 'stevearc/stickybuf.nvim', opts = {} },

  -- File tree view
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
    dependencies =
    {
      'nvim-lua/plenary.nvim',
      "nvim-tree/nvim-web-devicons",
      'MunifTanjim/nui.nvim',
    },
  },

  -- Show todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Pretty diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },

  -- Tmux integration
  'numToStr/Navigator.nvim',

  -- Folding support
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = 'v:lua.ScFa' },
              { text = { '%s' },                  click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          })
        end,

      },
    },
    event = 'BufReadPost',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
    init = function()
      vim.keymap.set('n', 'zR', function()
        require('ufo').openAllFolds()
      end)
      vim.keymap.set('n', 'zM', function()
        require('ufo').closeAllFolds()
      end)
    end,
  },
})


--------------------------------------------------
-- Vim Settings
--------------------------------------------------
vim.o.hlsearch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.spell = true
vim.o.mouse = 'a'
vim.o.formatoptions = 'qrn1j'
vim.o.breakindent = true
vim.o.scrolloff = 3
vim.o.undofile = true
vim.o.signcolumn = 'yes'
vim.o.completeopt = 'menu,noselect'
vim.o.path = '.,/usr/include,,**'
vim.o.termguicolors = true
vim.o.clipboard = 'unnamedplus'

vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.tabstop = 8
vim.o.softtabstop = 0

vim.o.textwidth = 100
vim.o.whichwrap = 'b,s,<,>,h,l,[,]'
vim.o.wrap = true

vim.o.list = true
vim.opt.listchars = { tab = '▸ ', extends = '❯', precedes = '❮', trail = '·' }

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true


--------------------------------------------------
-- Keymaps
--------------------------------------------------
vim.keymap.set({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

vim.keymap.set('n', '#', ':noh<cr>')

-- Split management
vim.keymap.set('n', '<leader><left>', ':leftabove  vsp<cr>', { desc = 'Left split' })
vim.keymap.set('n', '<leader><right>', ':rightbelow  vsp<cr>', { desc = 'Right split' })
vim.keymap.set('n', '<leader><up>', ':leftabove  sp<cr>', { desc = 'Up split' })
vim.keymap.set('n', '<leader><down>', ':rightbelow  sp<cr>', { desc = 'Down split' })
-- Zoom splits
vim.keymap.set('n', '<leader>zi', '<c-w>_ <c-w>|', { desc = '[z]oom [i]n' })
vim.keymap.set('n', '<leader>zo', '<c-w>=', { desc = '[z]oom [o]ut' })
-- Better move between splits
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- Center the word on search
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Don't move on *
vim.keymap.set('n', '*', '*N')

-- Deal with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable u in visual mode
vim.keymap.set('v', 'u', '<nop>')

-- Text formatting
vim.keymap.set('n', 'Q', 'gqip')
vim.keymap.set('v', 'Q', 'gq')
vim.keymap.set('n', 'vv', '^vg_', { desc = 'Select block' })

-- Keep selection when indenting/outdenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Toggle numbers
vim.keymap.set('n', '<leader>n', ':set nonumber!<cr>:set relativenumber!<cr>', { desc = 'toggle [n]umbers' })

-- clean trailing white spaces
vim.keymap.set('n', '<leader>wc', [[:%s/\s\+$//e<cr>]], { desc = '[w]hitespace [c]lear' })

-- Rename word
vim.keymap.set('n', '<leader>rw', ':%s/\\<<c-r><c-w>\\>//gc<left><left><left>', { desc = '[r]ename [w]ord' })


--------------------------------------------------
-- VIM CMDs
--------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('yankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'yankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '200' })
  end
})

-- Remove white space on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Format on save on given file patterns
augroup('Format', { clear = true })
autocmd('BufWritePre', {
  pattern = { '*.lua', '*.rs', },
  callback = function()
    vim.lsp.buf.format()
  end,
  group = 'Format',
})

augroup('DiagnosticFloat', { clear = true })
autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
  group = 'DiagnosticFloat',
})


--------------------------------------------------
-- PLUGINS
--------------------------------------------------


--------------------------------------------------
-- LSP Setup
--------------------------------------------------
local lspconfig = require('lspconfig')
-- local on_attach = function(_, bufnr)

-- Get rid if inline diagnostics. Only keep the symbols
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    show_signs = true,
    -- Disable a feature
    update_in_insert = false,
  })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>sd', vim.diagnostic.setloclist, { desc = '[s]how [d]iagnostics' })

-- Format
vim.keymap.set('v', '<leader>fs', vim.lsp.buf.format, { desc = "[f]ormat [s]election" })
vim.keymap.set('n', '<leader>fa', vim.lsp.buf.format, { desc = "[f]ormat [a]ll" })

vim.keymap.set('n', '<leader>ra', vim.lsp.buf.rename, { desc = "[r]ename [a]ll" })
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "[c]ode [a]action" })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = "[g]oto [d]efinition" })
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = "[g]oto [D]eclaration" })
vim.keymap.set('n', '<leader>gI', vim.lsp.buf.implementation, { desc = "[g]oto [I]mplementation" })
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = "show type [D]efinition" })
-- Enabled from telescope side
-- vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = '[g]oto [r]eferences' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })


--------------------------------------------------
-- nvim-cmp
--------------------------------------------------
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<cr>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true }),
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


--------------------------------------------------
-- mason
--------------------------------------------------
local servers = {
  clangd = {},
  rust_analyzer = {
    check = {
      command = "clippy",
    }
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require('mason-lspconfig').setup()

require("mason-lspconfig").setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      settings = servers[server_name],
    }
  end,
}

--------------------------------------------------
-- Telescope
--------------------------------------------------
-- Select multiple files and open in quickfix
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local custom_actions = {}

function custom_actions.fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()

  if num_selections > 1 then
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist(prompt_bufnr)
  else
    actions.file_edit(prompt_bufnr)
  end
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<c-u>'] = false,
        ['<c-d>'] = actions.cycle_previewers_next,
        ['<c-b>'] = actions.preview_scrolling_up,
        ['<c-f>'] = actions.preview_scrolling_down,
        -- close on escape
        ['<esc>'] = actions.close,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<cr>'] = custom_actions.fzf_multi_select
      },
      n = {
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<cr>'] = custom_actions.fzf_multi_select
      }
    },
    dynamic_preview_title = true,
    preview = { treesitter = false },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
vim.keymap.set('n', '<leader>sr', builtin.live_grep, { desc = '[s]earch by [r]ipgrep' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[s]earch [g]it files' })
vim.keymap.set('n', '<leader>sc', builtin.git_commits, { desc = '[s]earch git [c]ommits' })
vim.keymap.set('n', '<leader>sb', builtin.git_bcommits, { desc = '[s]earch git [b]commits' })
vim.keymap.set('n', '<leader>st', builtin.git_stash, { desc = '[s]earch git s[t]ash' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sy', builtin.treesitter, { desc = '[s]earch by local s[y]mbols' })
vim.keymap.set('n', '<leader>sl', builtin.lsp_document_symbols, { desc = '[s]earch [l]ocal symbols' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, { desc = '[s]each workspace [s]ymbols' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = '[g]oto [r]eferences' })


--------------------------------------------------
-- Treesitter
--------------------------------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python" },
  auto_install = true,
  sync_install = false,
  incremental_selection = { enable = false },

  highlight = {
    enable = true,
    -- disable highlighting if file is later than max_filesize
    disable = function(_, buf)
      local max_filesize = 400 * 1024 -- 400 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  indent = { enable = true },
}


--------------------------------------------------
-- nvim-web-devicons
--------------------------------------------------
require('nvim-web-devicons').setup()


--------------------------------------------------
-- aerial
--------------------------------------------------
require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<cr>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<cr>', { buffer = bufnr })
  end
})

vim.keymap.set('n', '<leader>t', '<cmd>AerialToggle!<cr>', { desc = 'toggle [t]ags' })


--------------------------------------------------
-- nvim-ufo
-------------------------------------------------- Custom function to show arrows instead of layers of numbers
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' ↙ %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

require('ufo').setup({
  fold_virt_text_handler = handler,
  open_fold_hl_timeout = 150,
  close_fold_kinds = { 'imports', 'comment' },
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>',
      jumpTop = '[',
      jumpBot = ']'
    }
  },
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:▶]]


--------------------------------------------------
-- Neo-tree
--------------------------------------------------
require('neo-tree').setup()
vim.keymap.set('n', '<leader>e', ':Neotree toggle<cr>', { desc = 'toggle [e]xplorer' })


--------------------------------------------------
-- Trouble
--------------------------------------------------
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = '[x] trouble [x]' })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
  { desc = '[x] trouble [w]orkspace diagnostics' })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
  { desc = '[x] trouble [d]ocument diagnostics' })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end,
  { desc = '[x] trouble [q]uickfix' })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end,
  { desc = '[x] trouble [l]ocal list' })
vim.keymap.set("n", "<leader>xr", function() require("trouble").toggle("lsp_references") end,
  { desc = '[x] trouble lsp [r]eferences' })


--------------------------------------------------
-- todo-comments
--------------------------------------------------
require('todo-comments').setup({
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })


--------------------------------------------------
-- Navigator - Tmux integration
--------------------------------------------------
require('Navigator').setup()

vim.keymap.set({ 'n', 't' }, '<c-h>', '<cmd>NavigatorLeft<cr>')
vim.keymap.set({ 'n', 't' }, '<c-l>', '<cmd>NavigatorRight<cr>')
vim.keymap.set({ 'n', 't' }, '<c-k>', '<cmd>NavigatorUp<cr>')
vim.keymap.set({ 'n', 't' }, '<c-j>', '<cmd>NavigatorDown<cr>')
vim.keymap.set({ 'n', 't' }, '<c-p>', '<cmd>NavigatorPrevious<cr>')


-- vim: ts=2 sts=2 sw=2 et
