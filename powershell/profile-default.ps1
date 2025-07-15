function Prompt
{
    $isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
    $title = ""
    if ($isAdmin)
    {
        $title = "PowerShell Admin"
    } else { 
	    $title = "PowerShell"
    }

    $cwd = $executionContext.SessionState.Path.CurrentLocation
    $host.UI.RawUI.WindowTitle = $title + " [" + (Get-Item -Path $cwd | Select-Object -ExpandProperty Name) + "]";
    return "PS $($cwd)$('>' * ($nestedPromptLevel + 1)) "
}

#. C:\src\gh\jk\powershell\Ionic-Functions.ps1

Set-Alias d docker
Set-Alias dc docker-compose
Set-Alias dn dotnet
Set-Alias g git
Set-Alias k kubectl

Clear-Host 
