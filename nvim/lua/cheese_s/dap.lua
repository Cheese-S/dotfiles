local dap = require("dap")

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "\\mason\\bin\\codelldb.cmd",
		args = { "--port", "${port}" },
		-- On windows you may have to uncomment this:
		detached = false,
	},
}

-- dap.adapters.codelldb = {
-- 	type = "executable",
-- 	command = vim.fn.stdpath("data") .. "\\mason\\bin\\codelldb.cmd",
-- 	-- command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
--
-- 	-- On windows you may have to uncomment this:
-- 	detached = false,
-- }

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			-- Asks you to select the executable to debug
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.c = dap.configurations.cpp
