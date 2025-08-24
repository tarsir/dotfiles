local Utils = {}

Utils.set_mapping = function(mapping)
  vim.schedule(function()
    for mode, mode_values in pairs(mapping) do
      local default_opts = vim.tbl_extend("force", { mode = mode }, {})
      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local opts = vim.tbl_extend("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end)
end

Utils.set_lsp_mapping = function(mapping, event)
  vim.schedule(function()
    for mode, mode_values in pairs(mapping) do
      local default_opts = vim.tbl_extend("force", { mode = mode, buffer = event.buf }, {})
      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local opts = vim.tbl_extend("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end)
end

return Utils
