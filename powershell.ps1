# start-up
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# fzf-configs
$env:FZF_MOVEMENT="
--bind 'alt-j:down'
--bind 'alt-k:up'
"
$env:FZF_DEFAULT_OPTS="$env:FZF_MOVEMENT"

# custom shortcut
Set-Alias -Name open -Value explorer.exe
#Set-Alias -Name gs -Value git status
# del alias:diff -Force

function fmt {
     python3 .\Tools\clang-tools\run-clang-format.py
}

function gs {
    git status
}

function lg {
    lazygit
}

function regen {
    python scripts/cc.py regen 
}

function clswitch {
    param (
        [string]$Config
    )
    python scripts/cc.py switch -c $Config
}

function cc {
    python scripts/cc.py @args
}
