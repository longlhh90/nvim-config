local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "all",                            -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false,                                -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,                                     -- false will disable the whole extension
    disable = { "" },                                  -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = false,
    disable = { "html" }, -- list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#FEB326",
      "#E84D8A",
      "#64C5EB",
      "#7F58AF",
      "Coral",
      "Teal",
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
