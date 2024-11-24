local components = {}
local icons = require("nvim-web-devicons")
local gitsigns = require("gitsigns")
local hi_pattern = "%%#%s#%s%%*"

function components.fmt(hl, str)
	return hi_pattern:format(hl, str)
end

function _G._statusline_components(name)
	return components[name]()
end

function components.icon()
	local icon, color = icons.get_icon_color(vim.fs.basename(), vim.bo.filetype)
	vim.api.nvim_set_hl(0, "StatusLineIcon", { fg = color })
	return components.fmt("StatusLineIcon", icon)
end

function components.branch()
	return components.fmt("PurpleBold", " " .. vim.g.gitsigns_head)
end

function components.status()
	local status = vim.b.gitsigns_status_dict
	local added
	local changed
	local deleted

	if status == nil then
		return ""
	end

	if status.added then
		added = status.added
	else
		added = 0
	end
	added = components.fmt("GreenBold", "+" .. added)

	if status.changed then
		changed = status.changed
	else
		changed = 0
	end
	changed = components.fmt("BlueBold", "~" .. changed)
	if status.deleted then
		deleted = status.deleted
	else
		deleted = 0
	end
	deleted = components.fmt("RedBold", "-" .. deleted)

	return string.format("%5s | %5s | %5s ", added, changed, deleted)
end

local separators = {
	default = { left = "", right = "" },
	rev_default = { left = "", right = "" },
}

local last_mode
function components.mode()
	local sep_hl
	local name_hl
	local mode = vim.fn.mode()
	local mode_name = mode

	if mode == "n" then
		sep_hl = "OctoPurple"
		name_hl = "OctoBubblePurple"
		mode_name = " NORMAL "
	elseif mode == "v" then
		sep_hl = "OctoGreen"
		name_hl = "OctoBubbleGreen"
		mode_name = " VISUAL "
	elseif mode == "i" then
		sep_hl = "OctoBlue"
		name_hl = "OctoBubbleBlue"
		mode_name = " INSERT "
	elseif mode == "c" then
		sep_hl = "OctoYellow"
		name_hl = "OctoBubbleYellow"
		mode_name = " COMMAND "
	else
		return last_mode
	end

	last_mode = components.fmt(sep_hl, separators.default.left)
		.. components.fmt(name_hl, mode_name)
		.. components.fmt(sep_hl, separators.default.right)

	return last_mode
end

function components.modified()
	local buf_modified = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified")
	if buf_modified then
		return "[]"
	end
	return ""
end

function components.percentage()
	return components.fmt("OctoRed", separators.rev_default.left)
		.. components.fmt("OctoBubbleRed", "  ")
		.. components.fmt("OctoBubbleRed", "%3p%%")
		.. components.fmt("OctoRed", separators.rev_default.right)
end

function components.lsp()
	local levels = vim.diagnostic.severity
	local errors = #vim.diagnostic.get(0, { severity = levels.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = levels.WARN })
	local infos = #vim.diagnostic.get(0, { severity = levels.INFO })

	return components.fmt("RedBold", string.format("  %-3d", errors))
		.. components.fmt("YellowBold", string.format("  %-3d", warnings))
		.. components.fmt("BlueBold", string.format("  %-3d", infos))
end

function components.file()
	local file = vim.fn.expand("%")
	return components.fmt("Title", string.gsub(file, "/", " > "))
end

local statusline = {
	' %7{%v:lua._statusline_components("mode")%}',
	' %{%v:lua._statusline_components("status")%}',
	"%=",
	"%{&fileencoding?&fileencoding:&encoding}  ",
	'%{%v:lua._statusline_components("lsp")%}  ',
	'%{%v:lua._statusline_components("branch")%}  ',
	'%{%v:lua._statusline_components("icon")%}',
	' %{%v:lua._statusline_components("percentage")%}',
}

-- winbar
vim.o.statusline = table.concat(statusline, "")

local winbar = {
	' %{%v:lua._statusline_components("file")%}',
	' %{%v:lua._statusline_components("modified")%}',
}

vim.o.winbar = table.concat(winbar, "")
