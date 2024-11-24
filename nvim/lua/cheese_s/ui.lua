local components = {}
local icons = require("nvim-web-devicons")
local gitsigns = require("gitsigns")
local hi_pattern = "%%#%s#%s%%*"

function _G._statusline_components(name)
	return components[name]()
end

function components.icon()
	local icon, color = icons.get_icon_color(vim.fs.basename(), vim.bo.filetype)
	vim.api.nvim_set_hl(0, "StatusLineIcon", { fg = color })
	return hi_pattern:format("StatusLineIcon", icon)
end

function components.branch()
	local status = vim.b.gitsigns_status_dict
	return status
end

local statusline = {
	">> %f",
	'%{%v:lua._statusline_components("branch")%}',
	"%r",
	"%m",
	"%=",
	'%{%v:lua._statusline_components("icon")%}',
	" %2p%%",
}

vim.o.statusline = table.concat(statusline, "")
