# My Neovim Config

A Neovim config based on ThePrimeagen's video [0 to LSP : Neovim RC From Scratch](https://youtu.be/w7i4amO_zaE?si=xstN83ebvGg8GgCt). It provides a familiar IDE experience and has a very simple structure It provides a familiar IDE experience and has a very simple structure, so you can easily add new plugins.

![nvim screenshot](nvim.png)

## Installation

### Install Neovim v0.9+

You can install Neovim with your package manager, but remember that when you update your packages Neovim may be upgraded to a newer version.
If you would like to make sure Neovim only updates when you want it to than [install from source](https://github.com/neovim/neovim/wiki/#install-from-source).

### Clone the config

Make sure to remove or backup your current `~/.config/nvim` directory.

```
git clone --depth 1 --branch v1.0.0 git@github.com:dnlklmts/nvim.git ~/.config/nvim
```

### Plugins

[Lazy](https://github.com/folke/lazy.nvim) is used as a plugin manager. You can manage installed plugins via the `:Lazy` command.

Run `nvim` and wait for the plugins to be installed.

**NOTE:** You'll probably notice [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) installing a bunch of parsers the next time you re-open Neovim.

[Mason](https://github.com/williamboman/mason.nvim) is used to install and manage LSP servers, DAP servers, linters, and formatters via the `:Mason` command.

#### Plugin dependencies

Some plugins depend on extra utilities.

- [ripgrep](https://github.com/BurntSushi/ripgrep) is required for [Telescope](https://github.com/nvim-telescope/telescope.nvim) to work.

#### Active plugins

All active plugins are listed in the [plugins.lua](lua/user/plugins.lua).

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) extended with:
    - [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) extended with:
    - [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
    - [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) extended with:
    - [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
    - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
    - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
    - [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
    - [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
    - [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [hrsh7th/cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    - requires [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) 
    - extended with [nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
- [theprimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)
- [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    - requires: [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) and [patched fonts](https://www.nerdfonts.com/)
- [mbbill/undotree](https://github.com/mbbill/undotree)
- [olexsmir/gopher.nvim](https://github.com/olexsmir/gopher.nvim)
- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) extended with:
    - [leoluz/nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
    - [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
    - [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
- [folke/neodev.nvim](https://github.com/folke/neodev.nvim)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)

## Usage

The main key mappings are listed in the file [keymaps.lua](lua/user/keymaps.lua).

Plugin-specific key mappings can be found in the configuration file for the respective plugin at `after/plugin/plugin_name.lua`.

Here are a few of the most commonly used key mappings:

- `<leader>pf` — find file by name in the current project directory
- `<leader>pv` — open netrw directory listing
- `gd` — go to definition of the symbol under the cursor
- `Ctrl-o` — go to older position in jump list
- `Ctrl-i` — go to newer position in jump list
- `K` — open man page for word under the cursor
- `<leader>vrn` — rename the symbol under the cursor
- `<leader>vca` — list all available code actions (fill struct, organize imports, etc.)
- `<leader>imp` — list all the implementation of the word under the cursor 
- `<leader>ref` — list all the LSP references of the word under the cursor 
- `<leader>inc` — list all the LSP incoming calls of the word under the cursor 
- `<leader>fix` — list diagnostics for all open buffers
- `]m` — move cursor to the beginning of the next method definition
- `[m` — move cursor to the beginning of the previous method definition
- `;` — repeat previous movement
- `,` — repeat previous movement backwards
- `%` — move cursor to matching character (default supported pairs: '()', '{}', '[]')
- `Ctrl-p` — move to the previous item in the auto-completion menu
- `Ctrl-n` — move to the next item in the auto-completion menu
- `Ctrl-y` — select the current item in the auto-completion menu

## Learn more

- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [Mastering the Vim Language](https://youtu.be/wlR5gYd6um0?si=-ZFLkO2ZvqYdIiZI)
