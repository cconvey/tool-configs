-- TODO:
--   [ ] keybidings for the LSP integration
--   [ ] less-invasive display of LSP warnings/errors
--   [ ] apply .clang-format on file save (project-specific); uses LSP I think.
--   [ ] maybe import some/all of other plugins from ~/.vimrc

vim.opt.showmatch = true               -- show matching brackets.
vim.opt.ignorecase = true              -- case insensitive matching
vim.opt.mouse=v                 -- middle-click paste with mouse
vim.opt.hlsearch=true                -- highlight search results
vim.opt.autoindent=true              -- indent a new line the same amount as the line just typed
vim.opt.number=true                  -- add line numbers
vim.opt.wildmode=longest,list   -- get bash-like tab completions
vim.opt.cc={100}                   -- set colour columns for good coding style
vim.opt.tabstop=4               -- number of columns occupied by a tab character
vim.opt.expandtab=true               -- convert tabs to white space
vim.opt.shiftwidth=4            -- width for autoindents
vim.opt.softtabstop=4           -- see multiple spaces as tabstops so <BS> does the right thing

vim.cmd("filetype plugin indent on")   -- allows auto-indenting depending on file type

local Plug = vim.fn['plug#']
vim.call('plug#begin', '/home/cconvey/.local/share/nvim/plugged')
Plug ('preservim/nerdtree', {on='NERDTreeToggle'})
Plug 'neovim/nvim-lspconfig'
--Plug 'neovim/nvim-cmp'
Plug 'mhartington/formatter.nvim'
vim.call('plug#end')

vim.api.nvim_set_keymap('n', "<C-n>", ":NERDTreeToggle %:p:h<CR>", {noremap=true})

local lspconfig_root_dir_func = function()
    return vim.fs.dirname(vim.fs.find({ "compile_commands.json", "compile_flags.txt" }, { upward = true })[1])
end

local lspconfig = require('lspconfig')

lspconfig.clangd.setup({
    name = "Clangd",
    cmd = { "clangd-15" },
    root_dir = lspconfig_root_dir_func,
})
