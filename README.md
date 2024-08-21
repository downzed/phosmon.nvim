# phosmon.nvim
> A simple attempt to port [`photon.vim`](https://github.com/axvr/photon.vim) to `phosmon.nvim`

`phosmon.nvim` is a minimal, monotone (as possible) colorscheme designed for Neovim, trying to preserve the aesthetics of the original `photon.vim` theme while using the benefits of Lua.

### Installation
Using lazy.nvim:

* if you want to use it as a plugin: 
```
{
    'downzed/phosmon.nvim',
    opts = {}
}
```
Which will set `phosmon` as the default colorscheme and will load some *functionality:<br />
- [x] `Phosmon toggle opacity`
- [ ] `Phosmon toggle light/dark`

- or, if you want to use it as a colorscheme: 
```
{ 'downzed/phosmon.nvim' }
```
Then somewhere in your code `vim.cmd('colorscheme phosmon')`.

You can _obviously_ call:
- `require('phosmon').setup()` - to load the plugin
- or `require('phosmon').toggle_opacity("#bgcolorofyourchoise")`


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

