local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }

  print "Installing Packer"
  print "At the finish, restart Neovim"
  vim.fn.input "Press to continue... "

  vim.cmd [[ hi link NormalFloat Normal ]]
  vim.cmd [[ hi link FloatBorder Normal ]]

  vim.cmd [[packadd packer.nvim]]
end
