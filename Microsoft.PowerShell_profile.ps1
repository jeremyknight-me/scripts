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

Clear-Host 

## Chocolatey profile
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
#}

. C:\src\gh\jk\powershell\Ionic-Functions.ps1