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
  command = os.getenv('HOME') .. '/projects/venvs/smartcookie-api/bin/python',
  --command = '/usr/bin/python3',
  args = { '-m', 'debugpy.adapter' };
}

-- Custom config for python

--dap_client.configurations.python = {
--  {
    -- The first three options are required by nvim-dap
--    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--    request = 'launch';
--    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    --program = "${workspaceFolder}/main.py"; -- This configuration will launch the current file if used.

--  pythonPath= os.getenv('HOME') .. '/projects/venvs/smartcookie-api/bin/python'
--  }
--}

-- In most of the case we should load config from vscode launch.json
require('dap.ext.vscode').load_launchjs()
