$ErrorActionPreference = 'SilentlyContinue'

[Console]::CursorVisible = $false
Clear-Host

function Draw-At {
    param($X, $Y, $Char, $Color = 'DarkCyan')

    try {
        [Console]::SetCursorPosition($X, $Y)
        Write-Host $Char -ForegroundColor $Color -NoNewline
    }
    catch {}
}

$w = [Console]::WindowWidth
$h = [Console]::WindowHeight - 1

$drops = @()

1..200 | ForEach-Object {
    $drops += [PSCustomObject]@{
        X = Get-Random $w
        Y = Get-Random $h
    }
}

while ($true) {

    $w = [Console]::WindowWidth
    $h = [Console]::WindowHeight - 1

    foreach ($d in $drops) {

        Draw-At $d.X $d.Y " "

        $d.Y++

        if ($d.Y -ge $h) {
            $d.Y = 0
            $d.X = Get-Random $w
        }

        # Clamp positions after resize
        if ($d.X -ge $w) { $d.X = Get-Random $w }
        if ($d.Y -ge $h) { $d.Y = 0 }

        Draw-At $d.X $d.Y "|"
    }

    Start-Sleep -Milliseconds 20
}
