require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- NvimTree mappings para mostrar/ocultar arquivos
map("n", "<leader>th", "<cmd>lua require('nvim-tree.api').tree.toggle_hidden_filter()<cr>", { desc = "Toggle hidden files" })
map("n", "<leader>ti", "<cmd>lua require('nvim-tree.api').tree.toggle_gitignore_filter()<cr>", { desc = "Toggle git ignored files" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
