return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          -- typos-lsp must be on your PATH, or otherwise change this to an absolute path to typos-lsp
          -- defaults to typos-lsp if unspecified
          -- cmd = { "/Users/oliver.mannion/code/typos-lsp/target/debug/typos-lsp" },
          -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
          cmd_env = { RUST_LOG = "debug" },
          init_options = {
              -- Custom config. Used together with a config file found in the workspace or its parents,
              -- taking precedence for settings declared in both.
              -- Equivalent to the typos `--config` cli argument.
              -- config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
              -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
              -- Defaults to Info.
              diagnosticSeverity = "Info"
          },
          root_dir = function(bufnr, on_dir)
            -- 1. Try to find a project marker (typos.toml, pyproject.toml, etc.)
            local root = vim.fs.root(bufnr, { "typos.toml", "_typos.toml", ".typos.toml", "pyproject.toml", "Cargo.toml", "go.mod" })

            -- 2. Fallback to the directory argument if nvim was started with one
            if not root then
              local arg = vim.fn.argv(0)
              if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
                root = vim.fn.fnamemodify(arg, ":p")
              end
            end

            on_dir(root)
          end,
        },
      },
    },
  }
}
