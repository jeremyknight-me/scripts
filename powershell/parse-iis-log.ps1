# must be run in the correct folder for now
$files = Get-ChildItem -Filter 'u_ex*.log' 
foreach($file in $files) {
    # skip the 3 header lines and remove the #Fields: part to be able to use the first line as headers
    $content = Get-Content $file.FullName | Select-Object -Skip 3 | ForEach-Object { $_ -replace '#Fields: ', '' } | ConvertFrom-Csv -Delimiter ' ' 
    $content | Export-Csv -Path "$($file.BaseName).csv" -NoTypeInformation
    #$content | ConvertTo-Json | Out-File "$($file.BaseName).json"
    Write-Host "Exported $($file.BaseName)"
}