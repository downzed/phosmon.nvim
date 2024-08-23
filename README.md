# phosmon.nvim
> A simple attempt to port [`photon.vim`](https://github.com/axvr/photon.vim) to `phosmon.nvim`

`phosmon.nvim` is a minimal, monotone (as possible) colorscheme designed for Neovim, trying to preserve the aesthetics of the original `photon.vim` theme while using the benefits of Lua.

### Installation
##### Using lazy.nvim:

If you want to use it as a plugin: 
```
{
    'downzed/phosmon.nvim',
    -- leave empty for default options and default colorscheme set up
    opts = {
        -- default options
        mode = "dark", -- or "light"
        transparent = false,
        enable = {
            fzf_lua = true,
            ministarter = true,
        }
    }
}
```
Which will set `phosmon` as the default colorscheme and will load some perks:<br />
- [x] `Phosmon toggle opacity`
- [ ] `Phosmon toggle dark_mode`

If you want to do it yourself:
```
{ 'downzed/phosmon.nvim' }
```
Then somewhere in your code `vim.cmd('colorscheme phosmon')`.

### Integrations
- [ ] light theme
- [x] lualine
- [x] tree-sitter (might be off)
- [x] mini.starter
- [ ] more to come
- [ ] suggestions?


### Contributing
Contributions are welcome! Feel free to submit issues or pull requests to enhance this port.
I probably missed something, and I'm color-blind, so be gentle.

