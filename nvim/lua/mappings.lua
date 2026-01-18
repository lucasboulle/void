require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- NvimTree mappings para mostrar/ocultar arquivos
map("n", "<leader>th", "<cmd>lua require('nvim-tree.api').tree.toggle_hidden_filter()<cr>", { desc = "Toggle hidden files" })
map("n", "<leader>ti", "<cmd>lua require('nvim-tree.api').tree.toggle_gitignore_filter()<cr>", { desc = "Toggle git ignored files" })

-- Go mappings (disponíveis apenas em arquivos .go)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    map("n", "<leader>gr", "<cmd>!go run %<cr>", { desc = "Go run current file", buffer = true })
    map("n", "<leader>gt", "<cmd>!go test<cr>", { desc = "Go test", buffer = true })
    map("n", "<leader>gb", "<cmd>!go build<cr>", { desc = "Go build", buffer = true })
    map("n", "<leader>gm", "<cmd>!go mod tidy<cr>", { desc = "Go mod tidy", buffer = true })
    map("n", "<leader>gf", "<cmd>!gofmt -w %<cr>", { desc = "Format Go file", buffer = true })
  end,
})

-- GitSigns (Added per request)
map("n", "]c", function() require("gitsigns").next_hunk() end, { desc = "Next git hunk" })
map("n", "[c", function() require("gitsigns").prev_hunk() end, { desc = "Prev git hunk" })
map("n", "<leader>ph", function() require("gitsigns").preview_hunk() end, { desc = "Preview git hunk" })
map("n", "<leader>sh", function() require("gitsigns").stage_hunk() end, { desc = "Stage git hunk" })
