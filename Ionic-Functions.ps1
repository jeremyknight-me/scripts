function Repair-Ionic
{
    Param([string]$path)
    $path = Ensure-Path -path $path
    Write-Output "Beginning Ionic Repair"
    Remove-IonicNodeModules -path $path
    Remove-IonicPlatforms -path $path
    Remove-IonicPlugins -path $path
    Remove-IonicWww -path $path
    Remove-IonicPackageLock -path $path
    Write-Output "Completed Ionic Repair"
}

function Remove-IonicNodeModules
{
    Param([string]$path)
    Remove-IonicItem -basePath $path -subPath "node_modules"
}

function Remove-IonicPlatforms
{
    Param([string]$path)
    Remove-IonicItem -basePath $path -subPath "platforms"
}

function Remove-IonicPlugins
{
    Param([string]$path)
    Remove-IonicItem -basePath $path -subPath "plugins"
}

function Remove-IonicWww
{
    Param([string]$path)
    Remove-IonicItem -basePath $path -subPath "www"
}

function Remove-IonicPackageLock
{
    Param([string]$path)
    Remove-IonicItem -basePath $path -subPath "package-lock.json"
}

function Remove-IonicItem 
{
    Param([string]$basePath, [string]$subPath) 
    $basePath = Ensure-Path -path $basePath
    $fullPath = Join-Path $basePath $subPath
    Remove-ItemSafe $fullPath -Force -Recurse
}

function Ensure-Path 
{
    Param([string]$path)
    if ([string]::IsNullOrWhiteSpace($path)) {
        $path = Get-Location
    }

    return $path
}

function Remove-ItemSafe 
{
    Param([string]$path)
    if ([string]::IsNullOrWhiteSpace($path)) {
        Write-Output "Required parameter -path not found."
    } 
    else 
    {
        if (Test-Path -Path $path)
        {
            Write-Output ("Removing " + $path)
            Remove-Item $path -Force -Recurse
        }
        else 
        {
            Write-Output ("Path " + $path + " not found. Skipping Remove-Item command.")
        }
    }
}
