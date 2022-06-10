# Minimal Neovim setup for LSP

## Installation

- Clone this directory to `~/.config/nvim`, i.e. you should have `~/.config/nvim/init.vim` and all the other files at `~/.config/nvim`

- Install Neovim with `brew install neovim`

  NOTES:

     - Run Neovim with `nvim` rather than `vim`. Alias it if you want to.
     - Neovim config is at `~/.config/nvim`
     - Neovim uses `~/.config/nvim/init.vim` rather than `~/.vimrc`
     - Neovim config can be a mix of Vimscript (`.vim`) and Lua (`.lua`) config files. Use what you prefer, but many LSP examples are written in Lua, so that's what I've used here
     - Neovim plugins are at `~/.local/share/nvim`

- Install 'Plug' for Neovim with

  ```sh
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  ```
  
- Start `nvim` and then `:PlugInstall`, and then restart

If you are still using Vim8, this will not clash with it, so you can run both side-by-side.

## LSP

Install whichever language servers you need. Usually you install these globally, since they are not part of the project itself.

You must do this for each Language you have configured in `lua/lsp/init.lua`. At minimum install:

```sh
npm install -g typescript-language-server
npm install -g vscode-langservers-extracted
```

If you are using `nodenv` or `nvm`, then you need to do this for each Node version installed that you want to use LSP with.

The actual Typescript version will be as per whatever is installed in the project `package.json`

## Linting

`eslint` and `prettier` are usually installed as part of the project, i.e. in `package.json`, so no need to install them separately

## Shortcuts

The following shortcuts are configured. You can change them if you like in `lua/lsp/init.lua`

- Goto definition `<C-]>`. Suggest you leave this one as-is, as that is the standard for Vim, i.e. works in vim-help etc
- Rename symbol under the cursor `<Space>rn`
- Show definition under cursor `K`
- Show possible code actions (fixes) `<Space>ca`
- Show signature help `<Space>sh`
- Find all references to symbol under cursor `<Space>*`

There are even more listed in there if you want to check. There are heaps of things you can do with LSP!
