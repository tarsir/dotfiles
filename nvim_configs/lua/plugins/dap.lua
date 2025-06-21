return {
  'mfussenegger/nvim-dap',
  keys = {
    { "<leader>db", "<cmd> DapToggleBreakpoint <CR>", desc = "Toggle breakpoint", mode = "n" },
    {
      "<leader>dus",
      function()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      mode = "n",
      desc = "Open debugging sidebar"
    }
  }
}
