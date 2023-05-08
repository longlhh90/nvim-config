vim.opt.laststatus = 3
vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

local status, kanagawa = pcall(require, "kanagawa")
if (not status) then return end


kanagawa.setup({
  globalStatus = true,
  transparent = true,
  dimInactive = true,
})
