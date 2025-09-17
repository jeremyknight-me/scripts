### Custom Functions --------------------------------------

function Update-GitRepos {
    param(
        [string]$RootDirectory = (Get-Location)
    )

    $originalLocation = Get-Location

    # Get all directories in the root directory
    Get-ChildItem -Path $RootDirectory -Directory | ForEach-Object {
        $folderPath = $_.FullName
        $gitFolder = Join-Path $folderPath ".git"
        if (!(Test-Path $gitFolder)) {
            Write-Host "No git repository found in: $folderPath" -ForegroundColor Yellow
            return
        }

        Write-Host "Updating git repo in: $folderPath" -ForegroundColor Cyan
        Set-Location $folderPath

        # Get list of branches
        $branches = git branch --list | ForEach-Object { $_.Trim().TrimStart('*').Trim() }

        $targetBranch = $null
        if ($branches -contains "main") {
            $targetBranch = "main"
        } elseif ($branches -contains "master") {
            $targetBranch = "master"
        }

        if ($null -eq $targetBranch) {
            Write-Host "Neither 'main' nor 'master' branch found in: $folderPath" -ForegroundColor Yellow
            return
        }

        $currentBranch = (git branch --show-current).Trim()
        if ($currentBranch -ne $targetBranch) {
            Write-Host "Switching to branch: $targetBranch"
            git switch $targetBranch
        }

        git fetch
        git pull
    }

    # Restore the original location
    Set-Location $originalLocation
}

### Profile Settings and Configuration --------------------

# . ~\source\repos\gh\jk\scripts\powershell\Ionic-Functions.ps1
oh-my-posh --init --shell pwsh --config "<PATH_TO_THEME_HERE>" | Invoke-Expression

Set-Alias d docker
Set-Alias dc docker-compose
Set-Alias dn dotnet
Set-Alias g git
Set-Alias k kubectl

Clear-Host
