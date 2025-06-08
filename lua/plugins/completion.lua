return {
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule '`'
    end,
  },

  { -- new completion plugin
    'saghen/blink.cmp',
    enabled = true,
    version = '*',
    dev = false,
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    lazy = false,
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      { 'moyiz/blink-emoji.nvim' },
      { 'Kaiser-Yang/blink-cmp-git' },
      {
        'saghen/blink.compat',
        dev = false,
        opts = { impersonate_nvim_cmp = true, enable_events = true, debug = true },
      },
      {
        'jmbuhr/cmp-pandoc-references',
        dev = false,
        ft = { 'quarto', 'markdown', 'rmarkdown' },
      },
      { 'kdheepak/cmp-latex-symbols' },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<c-y>'] = { 'show_documentation', 'hide_documentation' },
        ['<c-k>'] = {},
      },
      cmdline = {
        enabled = false,
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'references', 'git', 'snippets', 'buffer', 'emoji' },
        providers = {
          emoji = {
            module = 'blink-emoji',
            name = 'Emoji',
            score_offset = -1,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority ()
            score_offset = 100,
          },
          git = {
            module = 'blink-cmp-git',
            name = 'Git',
            opts = {},
            enabled = function()
              return vim.tbl_contains({ 'octo', 'gitcommit', 'git' }, vim.bo.filetype)
            end,
          },
          references = {
            name = 'pandoc_references',
            module = 'cmp-pandoc-references.blink',
            score_offset = 2,
          },
          symbols = { name = 'symbols', module = 'blink.compat.source' },
        },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
        },
        menu = {
          auto_show = true,
        },
      },
      signature = { enabled = true },
    },
  },

  { -- gh copilot
    'zbirenbaum/copilot.lua',
    enabled = false,
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<c-a>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      }
    end,
  },

  { -- LLMs
    'olimorris/codecompanion.nvim',
    version = '*',
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>ac', ':CodeCompanionChat Toggle<cr>', desc = '[a]i [c]hat' },
      { '<leader>aa', ':CodeCompanionActions<cr>', desc = '[a]i [a]actions' },
    },
    config = function()
      require('codecompanion').setup {
        display = {
          diff = {
            enabled = true,
          },
        },
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'llama3.1',
              env = {
                url = (os.getenv 'OLLAMA_HOST' or '127.0.0.1') .. ':' .. tonumber(os.getenv 'OLLAMA_PORT' or 11434),
                -- api_key = "OLLAMA_API_KEY",
              },
              headers = {
                ['Content-Type'] = 'application/json',
                -- ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = {
                sync = true,
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'ollama',
            -- adapter = 'copilot',
          },
          inline = {
            adapter = 'ollama',
            -- adapter = 'copilot',
          },
          agent = {
            adapter = 'ollama',
            -- adapter = 'copilot',
          },
        },
      }
    end,
  },
}
