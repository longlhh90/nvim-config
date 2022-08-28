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

----- Dap Python -----
local python_path
if vim.loop.os_uname().sysname == "Darwin" then
	python_path = "/usr/local/bin/python3"
elseif vim.loop.os_uname().sysname == "Linux" then
	python_path = "/usr/bin/python3"
else
	python_path = ""
end

dap_client.adapters.python = {
	type = "executable",
	command = python_path,
	args = { "-m", "debugpy.adapter" },
}

-- Custom config for python

-- In most of the case we should load config from vscode launch.json
require("dap.ext.vscode").load_launchjs()

-- If we cannot get the launchjs, then load the default config
-- TODO: detect project with file to run the appropriate config for django and flask project if needed
if dap_client.configurations.python == nil then
	dap_client.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				local venv = os.getenv("CONDA_DEFAULT_ENV")
				if venv then
					return venv .. "/bin/python"
				end
				venv = os.getenv("VIRTUAL_ENV")
				if venv then
					return venv .. "/bin/python"
				end
				return python_path
			end,
		},
	}
elseif dap_client.configurations.python[1].module == "flask" then
	dap_client.configurations.python[1].pythonPath = function()
		local venv = os.getenv("CONDA_DEFAULT_ENV")
		if venv then
			return venv .. "/bin/python"
		end
		venv = os.getenv("VIRTUAL_ENV")
		if venv then
			return venv .. "/bin/python"
		end
		return python_path
	end
	dap_client.configurations.python[1].env.FLASK_DEBUG = "False"
end

----- Dap NodeJs -----
-- dap_client.adapters.node2 = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/vscode-node-debug2/out/src/nodeDebug.js" },
-- }
--
-- if dap_client.configurations.javascript == nil then
-- 	dap_client.configurations.javascript = {
-- 		{
-- 			name = "Launch",
-- 			type = "node2",
-- 			request = "launch",
-- 			program = "${workspaceFolder}/server.js",
-- 			cwd = vim.fn.getcwd(),
-- 			sourceMaps = true,
-- 			protocol = "inspector",
-- 		},
-- 		{
-- 			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
-- 			name = "Attach to process",
-- 			type = "node2",
-- 			request = "attach",
-- 			processId = require("dap.utils").pick_process,
-- 		},
-- 	}
-- end
