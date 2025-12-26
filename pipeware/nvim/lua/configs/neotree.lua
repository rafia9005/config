require("neo-tree").setup {
  renderers = {
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      {
        "container",
        content = {
          { "name", zindex = 10 },
          { "clipboard", zindex = 10 },
          { "diagnostics", errors_only = true, zindex = 20, align = "right" },
        },
      },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "container",
        content = {
          {
            "name",
            zindex = 10,
          },
          { "clipboard", zindex = 10 },
          { "bufnr", zindex = 10 },
          { "modified", zindex = 20, align = "right" },
          { "diagnostics", zindex = 20, align = "right" },
        },
      },
    },
  },
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = "󰈙", hl = "Tag" },
      Namespace = { icon = "󰌗", hl = "Include" },
      Package = { icon = "󰏗", hl = "Label" },
      Class = { icon = "󰌗", hl = "Include" },
      Method = { icon = "󰆧", hl = "Function" },
      Property = { icon = "󰜢", hl = "@property" },
      Field = { icon = "󰜢", hl = "@field" },
      Constructor = { icon = "", hl = "@constructor" },
      Enum = { icon = "󰕘", hl = "@number" },
      Interface = { icon = "󰕘", hl = "Type" },
      Function = { icon = "󰊕", hl = "Function" },
      Variable = { icon = "󰀫", hl = "@variable" },
      Constant = { icon = "󰏿", hl = "Constant" },
      String = { icon = "󰀬", hl = "String" },
      Number = { icon = "󰎠", hl = "Number" },
      Boolean = { icon = "", hl = "Boolean" },
      Array = { icon = "󰅪", hl = "Type" },
      Object = { icon = "󰅩", hl = "Type" },
      Key = { icon = "󰌋", hl = "" },
      Null = { icon = "󰟢", hl = "Constant" },
      EnumMember = { icon = "", hl = "Number" },
      Struct = { icon = "󰌗", hl = "Type" },
      Event = { icon = "", hl = "Constant" },
      Operator = { icon = "󰆕", hl = "Operator" },
      TypeParameter = { icon = "󰊄", hl = "Type" },
      Component = { icon = "󰅴", hl = "Function" },
      Fragment = { icon = "󰅴", hl = "Constant" },
    }
  },
 diagnostics = {
    enable = false,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
  },
}
