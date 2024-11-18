return 
{
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-ree/nvim-web-devicons" },
  config = function()
	  require("fzf-lua").setup({
          keymap = {
              builtin = {
                  ["<S-j>"] = "preview-down",
                  ["<S-k>"] = "preview-up",
                  ["<S-down>"]    = "preview-page-down",
                  ["<S-up>"]      = "preview-page-up",
              }
          }
      })
  end
}
