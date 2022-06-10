call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align


" These are two common dependencies other Neovim plugins use
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'


" Configurations for the Neovim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion plugin, which can use LSP as a completion source
Plug 'hrsh7th/cmp-nvim-lsp'

" Use LSP as a completion source
Plug 'hrsh7th/nvim-cmp'

" Other sources if you want them
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'


" Utilities to improve the TypeScript development experience for Neovim's built-in LSP client
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'


" General purpose language server, useful for hooking up prettier/eslint as
" LSP servers
Plug 'jose-elias-alvarez/null-ls.nvim'

call plug#end()


" Load configurations written in Lua, i.e. for LSP
lua require('config')


" OTHER Vimscript CONFIGS CAN GO HERE



" Once all configuration is complete, start LSP

lua require('lsp').setup_lsp_servers()
