param (
    [Parameter(Mandatory=$true)]
    [string]$FilePath,

    [Parameter(Mandatory=$true)]
    [string]$SearchString
)

# Read the file content
$content = Get-Content -Path $FilePath

# Filter out the lines containing the search string
$filteredContent = $content | Where-Object { $_ -notlike "*$SearchString*" }

# Overwrite the file with the filtered content
$filteredContent | Set-Content -Path $FilePath