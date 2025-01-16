# https://stackoverflow.com/questions/755382/i-want-to-delete-all-bin-and-obj-folders-to-force-all-projects-to-rebuild-everyt
# Get-ChildItem .\ -include bin,obj -Recurse | ForEach-Object ($_) { Remove-Item $_.FullName -Force -Recurse }
gci -include bin,obj -recurse | remove-item -force -recurse

# get rid of "hidden" folders
# gci -include bin,obj,".vs",".vscode" -recurse -force | remove-item -force -recurse
