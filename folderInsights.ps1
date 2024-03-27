function folderInfo(){
    $typesoffiles = @{}
    $path = Read-Host "Write a path you want us to scan for info concerning files"
    # Collecting info for types 
    Get-ChildItem -Path $path -Recurse -File | ForEach-Object {
        $extension = $_.Extension.ToLower()

        if (-not $typesoffiles.ContainsKey($extension)){
            $typesoffiles[$extension] = 1
        } else {
            $typesoffiles[$extension]++
        }
    }
    
    $folderCount = (Get-ChildItem -Path $path -Recurse -Directory).Count
    $fileCounter = (Get-ChildItem -Path $path -Recurse -File).Count
    $filesizeMB = [math]::Round($((Get-ChildItem -Path $path -Recurse -File) | Measure-Object -Property Length -Sum).Sum /1MB, 2)

    Write-Host "We have checked the $path filepath. The results are in:
                - There are $folderCount folders in total.
                - There are $fileCounter files in total.
                - The summed up size of all files is $filesizeMB MB."

    Write-Host "Here are some more detailed statistics for you:"
    $sortedKeys = $typesoffiles.Keys | Sort-Object
    foreach ($filetype in $sortedKeys){
        if ($filetype) {
        Write-Host "$filetype - $($typesoffiles[$filetype])"
        }
    }
}
