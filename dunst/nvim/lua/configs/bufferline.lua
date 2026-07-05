require("bufferline").setup {
  options = {
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    show_buffer_close_icons = false,
    separator_style = "none",
  },
}
