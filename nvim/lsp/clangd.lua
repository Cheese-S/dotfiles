return {
	filetypes = { "c", "cpp" },
	root_marksers = { "compile_commands.json", ".git" },
	cmd = { "clangd", "--header-insertion=never", "--clang-tidy", "--background-index" },
	settings = {},
}
