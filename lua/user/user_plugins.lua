local M = {}
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })
local capabilities = require("lvim.lsp").common_capabilities()
capabilities.offsetEncoding = { "utf-16" }
local opts = { capabilities = capabilities }
require("lvim.lsp.manager").setup("clangd", opts)

M.config = function()
  -- local configs = require("user.plugin-configs")
  lvim.plugins = {
    {
      "abecodes/tabout.nvim",
      config = function()
        require("user.tabout").config()
      end,
    },
    { "f-person/git-blame.nvim" },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffViewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
      -- config = configs.diffview,
      { 'rebelot/kanagawa.nvim' },
      { 'martinsione/darkplus.nvim' },
      { 'easymotion/vim-easymotion' },
      { "Mofiqul/vscode.nvim" },
      -- {
      --   "folke/trouble.nvim",
      --   cmd = "TroubleToggle",
      -- },
      {
        'uloco/bluloco.nvim',
        dependencies = { 'rktjmp/lush.nvim' }
      },
      {
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
          vim.defer_fn(function()
            require("copilot").setup {
              suggestion = { enabled = false },
              panel = { enabled = false },
              plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
            }
          end, 100)
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
      },
      {
        "max397574/better-escape.nvim",
        config = function()
          require("better_escape").setup()
        end,
      },
      {
        "p00f/clangd_extensions.nvim",  -- install lsp plugin
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("clangd_extensions").setup {
            server = {
              capabilities = capabilities,
              filetypes = { "c", "cpp" },
              on_attach = require("lvim.lsp").common_on_attach,
              on_init = require("lvim.lsp").common_on_init,
            }
          }
        end,
      },
      { 'sainnhe/edge' },
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
          require("copilot_cmp").setup()
        end
      },
      { "tpope/vim-surround" },
      {
        "danymat/neogen",
        config = function()
          -- adding some keybindings
          local opts = { noremap = true, silent = true }
          local map = vim.api.nvim_set_keymap
          map("n", "<leader>nf", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
          map("n", "<leader>nf", ":lua require('neogen').generate({type = 'func' })<CR>", opts)
          map("n", "<leader>nl", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)

          require("neogen").setup {
            enabled = true,
            input_after_comment = true,
            languages = {
              lua = {
                template = {
                  annotation_convention = "emmylua",
                },
              },
              python = {
                template = {
                  annotation_convention = "numpydoc",
                },
              },
              cpp = {
                template = {
                  annotation_convention = "doxygen",
                },
              },
              rust = {
                template = {
                  annotation_convention = "rustdoc",
                },
              },
              sh = {
                template = {
                  annotation_convention = "google_bash",
                },
              },
            },
          }
        end,
        -- requires = "nvim-treesitter/nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter",
      },
    },
  }
  lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
  table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
end

return M
