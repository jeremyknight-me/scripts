# . ~\source\repos\gh\jk\scripts\powershell\Ionic-Functions.ps1
oh-my-posh --init --shell pwsh --config "<PATH_TO_THEME_HERE>" | Invoke-Expression

Set-Alias d docker
Set-Alias dc docker-compose
Set-Alias dn dotnet
Set-Alias g git
Set-Alias k kubectl

Clear-Host
