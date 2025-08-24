-- easy movement
local keyset = vim.keymap.set
keyset("n", "<C-j>", "<C-w>j")
keyset("n", "<C-h>", "<C-w>h")
keyset("n", "<C-k>", "<C-w>k")
keyset("n", "<C-l>", "<C-w>l")
keyset("n", "<C-a>", vim.cmd("tabnext"))
keyset("n", "<C-d>", vim.cmd("tabprev"))

-- custom remappings
-- Ctrl-S to save
keyset({ "!", "n", "v" }, "<C-s>", "<ESC>:w<CR>")

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local mappings = {
      n = {
        ["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
        ["gd"] = { vim.lsp.buf.definition, "Go to definition" },
        ["K"] = { vim.lsp.buf.hover, "Hover" },
        ["gi"] = { vim.lsp.buf.implementation, "Go to implementation" },
        ["<C-m>"] = { vim.lsp.buf.signature_help, "Show signature" },
        ["<leader>D"] = { vim.lsp.buf.type_definition, "Show type definition" },
        ["<leader>rn"] = { vim.lsp.buf.rename, "Rename item" },
        ["<leader>ga"] = { vim.lsp.buf.code_action, "Show LSP code actions" },
        ["<leader>f"] = {
          function()
            vim.lsp.buf.format({ async = true })
          end,
          "Format document",
        },
        ["gR"] = { vim.lsp.buf.references, "Show references" },
      },
    }
    require("utils").set_lsp_mapping(mappings, ev)
  end,
})

-- Show diagnostic popup on cursor hover
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
  end,
  group = diag_float_grp,
})

-- Goto previous/next diagnostic warning/error
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
