# phosmon.nvim
> `phosmon.nvim` is a lightweight, monotone colorscheme designed for Neovim, inspired by [photon.vim](https://github.com/axvr/photon.vim). 
> Over time, it has evolved to include *local AI-powered features* using [Ollama](https://ollama.com), allowing users to interact with AI models directly inside Neovim.

### 📦 Installation 
Using lazy.nvim:
```
{
    "downzed/phosmon.nvim",
    opts = {
        -- Leave empty for default options
        mode = "dark", -- "dark" | "light" | "photon"
        transparent = false,
        ai = {
            enable = true, -- Enable AI features (requires Ollama)
            model = "codellama:latest" -- Default AI model
        }
    },
}
```


### 🎨 Colorscheme Usage 
```
vim.cmd("colorscheme phosmon")
-- or --
colorscheme phosmon
```


### ⚙️ Configuration 
| Option | Default | Description |
| --- | --- | --- |
| `mode` | `dark` | Select between `light`, `dark`, `photon` |
| `transparent` | `false` | Enable transparent background |
| `ai.enable` | `false` | Enable AI features |
| `ai.model` | `"codellama:latest"` | Default AI model |

### 🤖 AI Features (Ollama Integration)
To enable AI-powered features, Ollama must be installed:
- Download from [Ollama/download](https://ollama.com/download) (macOS, win) or [Github](https://github.com/ollama/ollama) (linux, macOS)
- Set the OLLAMA_HOST environment variable (e.g., in `.zshrc` or `.bashrc`):
<br /> `export OLLAMA_HOST="http://localhost:11434"`

### 📝 Command Reference
Once phosmon.nvim is enabled, it provides the following commands:
- All commands are prefixed with `Phosmon` (e.g., `:Phosmon toggle opacity`)

| Command | Description |
| --- | --- |
| `toggle opacity` | Toggles background opacity |
| `select mode` | Selects between dark, light, or photon mode |
| `toggle ai` | Enables/disables AI features |
| `ai select_model` | Lists available AI models |
| `ai pull_model` | Pulls the specified AI model from Ollama |

### 🔥 AI-Powered Code Generation & LSP Enhancements
`phosmon.nvim` extends Neovim’s capabilities with AI-powered code generation and LSP utilities, using Ollama models.

##### LSP
| Keybinding | Mode |	Action |
| --- | --- | --- |
| `<leader>Pl` | Normal | Run AI-assisted LSP operation |

##### Code Generation
| Keybinding | Mode |	Action |
| --- | --- | --- |
| `<leader>Pr` | Visual | AI-assisted refactor |
| `<leader>Ps` | Visual | Generate TypeScript interface |
| `<leader>Pt` | Visual | Generate test suite |
| `<leader>Pd` | Visual | Generate docstrings |
> Select the relevant code in visual mode (v), then use the shortcut to trigger AI-generated content


### 📸 Screenshots
| dark                            | light                           | photon  |
| ----------------------------------- | ----------------------------------- |----------------------------------- |
| [![dark](./screenshots/dark.png)](./screenshots/dark.png) | [![light](./screenshots/light.png)](./screenshots/light.png) | [![photon](./screenshots/photon.png)](./screenshots/photon.png) |
| transparent dark                            |                            | transparent photon  |
| [![transparent dark](./screenshots/dark-trans.png)](./screenshots/dark-trans.png) |  | [![transparent photon](./screenshots/photon-trans.png)](./screenshots/photon-trans.png) |



### 🤝 Contributing
Contributions are welcome! If you spot issues or have improvements, feel free to submit an issue or a pull request. <br />
I probably missed something, and I’m color-blind, so be gentle.
