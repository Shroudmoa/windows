$ErrorActionPreference = 'SilentlyContinue'

[Console]::CursorVisible = $false
Clear-Host

function Draw-At {
    param($X, $Y, $Char, $Color = 'DarkCyan')

    try {
        [Console]::SetCursorPosition($X, $Y)
        Write-Host $Char -ForegroundColor $Color -NoNewline
    } catch {}
}

function Flash-Lightning {
    param($w, $h)

    # Bright flash
    $colors = @('White', 'Gray', 'Yellow')

    for ($i = 0; $i -lt 3; $i++) {
        Clear-Host
        for ($y = 0; $y -lt $h; $y += 2) {
            for ($x = 0; $x -lt $w; $x += 4) {
                if ((Get-Random -Minimum 0 -Maximum 10) -gt 8) {
                    Draw-At $x $y "⚡" ($colors | Get-Random)
                }
            }
        }
        Start-Sleep -Milliseconds 80
    }

    Clear-Host
}

$w = [Console]::WindowWidth
$h = [Console]::WindowHeight - 1

$drops = @()

1..250 | ForEach-Object {
    $drops += [PSCustomObject]@{
        X = Get-Random $w
        Y = Get-Random $h
        Speed = (Get-Random -Minimum 1 -Maximum 3)
    }
}

$lastLightning = Get-Date

while ($true) {

    $w = [Console]::WindowWidth
    $h = [Console]::WindowHeight - 1

    # Lightning every ~60 seconds
    if ((Get-Date) - $lastLightning -gt [TimeSpan]::FromSeconds(60)) {
        Flash-Lightning $w $h
        $lastLightning = Get-Date
    }

    foreach ($d in $drops) {

        Draw-At $d.X $d.Y " "

        # storm drift (wind)
        if ((Get-Random -Minimum 0 -Maximum 10) -gt 7) {
            $d.X += (Get-Random -Minimum -1 -Maximum 2)
        }

        $d.Y += $d.Speed

        if ($d.Y -ge $h) {
            $d.Y = 0
            $d.X = Get-Random $w
        }

        # wrap horizontal movement
        if ($d.X -lt 0) { $d.X = $w - 1 }
        if ($d.X -ge $w) { $d.X = 0 }

        Draw-At $d.X $d.Y "|" 'DarkGray'
    }

    Start-Sleep -Milliseconds 30
}
