local conf = {
    active = false,
    on_config_done = nil,
    breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

local dap_client = require("dap")
-- Get debug value in the virtual text
require("nvim-dap-virtual-text").setup()

-- Get debug with UI
require("dapui").setup()


vim.fn.sign_define("DapBreakpoint", conf.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", conf.breakpoint_rejected)
vim.fn.sign_define("DapStopped", conf.stopped)

dap_client.defaults.fallback.terminal_win_cmd = "50vsplit new"

dap_client.adapters.python = {
  type = 'executable';
  command = "/usr/bin/python3";
  args = { '-m', 'debugpy.adapter' };
}

-- Custom config for python

-- In most of the case we should load config from vscode launch.json
require('dap.ext.vscode').load_launchjs()

-- If we cannot get the launchjs, then load the default config
-- TODO: detect project with file to run the appropriate config for django and flask project if needed
if dap_client.configurations.python == nil then
  dap_client.configurations.python= {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          local venv = os.getenv "CONDA_DEFAULT_ENV"
          if venv then
            return venv .. "/bin/python"
          end
          venv = os.getenv "VIRTUAL_ENV"
          if venv then
            return venv .. "/bin/python"
          end
          return "/usr/bin/python3"
        end;
      },
  }

end
