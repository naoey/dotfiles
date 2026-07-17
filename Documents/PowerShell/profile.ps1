$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
$env:Path += ";$HOME\.rbenv\shims"

# Set-PoshPrompt -Theme iterm2
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\iterm2.omp.json" | Invoke-Expression

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

$Env:KOMOREBI_CONFIG_HOME = 'C:\Users\naoey\.config\komorebi'
$Env:XDG_CONFIG_HOME = '$HOME/.config'

Import-Module PSReadLine

Set-PSReadlineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -predictionsource history

New-Alias lg lazygit.exe

Remove-Item Alias:\rm
Remove-Item Alias:\ls
# Remove-Item Alias:\curl

function ll { ls -la }

# function sudo {
#    Start-Process @args -verb runas
# }

