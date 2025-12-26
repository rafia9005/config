require("telescope").setup {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "bottom" },
    sorting_strategy = "ascending",
    winblend = 0,
  },
  pickers = {
    find_files = {
      previewer = true,
      hidden = false,
    },
    live_grep = {},
    buffers = {
      sort_lastused = false,
    },
    help_tags = {},
  },
}
