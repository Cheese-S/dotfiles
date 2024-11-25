if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"  `"$($MyInvocation.MyCommand.UnboundArguments)`""
    Exit
}

if (Test-Path $PROFILE) {
	# Remove-Item $PROFILE -verbose
}

New-Item -Path $PROFILE -ItemType SymbolicLink -Value ~/.config/powershell.ps1
New-Item -Path ~/AppData/Local/nvim -ItemType SymbolicLink -Value ~/.config/nvim

winget install --id=LLVM.LLVM  -e -i 
winget install --id=Neovim.Neovim  -e
winget install --id=junegunn.fzf  -e
	
winget install --id=ajeetdsouza.zoxide  -e

winget install --id=Starship.Starship  -e
# Need to add to env 
winget install --id=GnuWin32.DiffUtils  -e

winget install -e --id=JesseDuffield.lazygit


