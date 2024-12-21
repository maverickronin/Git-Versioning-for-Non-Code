$MessageLimit = 100

$GitFolders = @(
    "$env:AppData\3Dconnexion\3DxWare\Cfg"
    "$env:AppData\ROCCAT\SWARM"
)

$ErrorActionPreference = 'Inquire'

function Add-Comma {
    param([string]$string)
    if ($string.Length -lt 1) {
        return
    } else {
        $string += ", "
        $string
    }
}

$g = git -v
if ($g -notlike "git version*") {throw "Git not found!"}

foreach ($GitFolder in $GitFolders) {
    $Message = ""
    $Changes = ""
    $b = ""
    $c = ""
    if (Test-Path $GitFolder) {
        cd $GitFolder
    } else {
        throw "Folder $GitFolder not found!"
        continue
    }
    write-host $GitFolder
    $b = git status --porcelain -z
    if ($b -in "",$null) {
        write-host "No changes"
        write-host ""
        continue
    }
    $c = $b.Split(0)
    $Changes = $c[0..($c.count - 2)]
    foreach ($Change in $Changes) {
        switch ($Change.SubString(0,2)) {
            "??" {
                $Message = Add-Comma $Message
                $Message += "Added $($Change.SubString(3))"
            }
            " M" {
                $Message = Add-Comma $Message
                $Message += "Changed $($Change.SubString(3))"
            }
            " D" {
                $Message = Add-Comma $Message
                $Message += "Deleted $($Change.SubString(3))"
            }
            default {
                $Message = Add-Comma $Message
                $Message += "Other Modification to $($Change.SubString(3))"
            }
        }
    }
    if ($Message.Length -gt $MessageLimit) {$Message = "$($Changes.Count) changes"}
    $Message
    git add .
    git commit -m `"$Message`"
    write-host ""
}
pause