return {
  -- https://github.com/chrisgrieser/nvim-lsp-endhints
  {
    'chrisgrieser/nvim-lsp-endhints',
    event = 'LspAttach',
    opts = {}, -- required, even if empty
  },
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_view_forward_search_on_start = 0

      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        out_dir = 'build',
        options = { '-pdf', '-interaction=nonstopmode', '-synctex=1' },
      }

      vim.g.vimtex_doc_enabled = 0
      vim.g.vimtex_complete_enabled = 0
      vim.g.vimtex_imaps_enabled = 0

      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal_disable = 1
      -- Configure concealment (replaces LaTeX commands with symbols like α)
      -- vim.g.vimtex_syntax_conceal = {
      --   additions = 1,
      --   bibtex = 1,
      --   greek = 1,
      --   math_bounds = 1,
      --   sections = 1,
      --   styles = 1,
      -- }
      -- vim.g.vimtex_view_method = 'general'
      -- vim.g.vimtex_view_general_options = 'okular'
      -- vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
    end,
  },
}
