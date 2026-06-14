$ErrorActionPreference = 'SilentlyContinue'
[Console]::CursorVisible = $false
Clear-Host

$width  = [Console]::WindowWidth
$height = [Console]::WindowHeight

$eyes = @()

function New-Eye {
    return [PSCustomObject]@{
        X = Get-Random -Minimum 0 -Maximum $width
        Y = Get-Random -Minimum 0 -Maximum $height
        Life = Get-Random -Minimum 20 -Maximum 80
        Blink = Get-Random -Minimum 3 -Maximum 10
        State = "open"
    }
}

function Draw($x, $y, $text, $color = "White") {
    try {
        [Console]::SetCursorPosition($x, $y)
        Write-Host $text -NoNewline -ForegroundColor $color
    } catch {}
}

# seed eyes
1..25 | ForEach-Object { $eyes += New-Eye }

while ($true) {

    $width  = [Console]::WindowWidth
    $height = [Console]::WindowHeight

    # occasionally spawn new eyes
    if ($eyes.Count -lt 40 -and (Get-Random -Minimum 0 -Maximum 100) -gt 85) {
        $eyes += New-Eye
    }

    foreach ($e in $eyes) {

        # erase old
        Draw $e.X $e.Y "   "

        # lifecycle
        $e.Life--

        if ($e.Life -le 0) {
            $e.X = Get-Random -Minimum 0 -Maximum $width
            $e.Y = Get-Random -Minimum 0 -Maximum $height
            $e.Life = Get-Random -Minimum 20 -Maximum 80
        }

        # slight drift (feels like “watching movement”)
        if ((Get-Random -Minimum 0 -Maximum 10) -gt 7) {
            $e.X += (Get-Random -Minimum -1 -Maximum 2)
            $e.Y += (Get-Random -Minimum -1 -Maximum 2)
        }

        # clamp
        if ($e.X -lt 0) { $e.X = 0 }
        if ($e.Y -lt 0) { $e.Y = 0 }
        if ($e.X -ge $width - 2) { $e.X = $width - 3 }
        if ($e.Y -ge $height) { $e.Y = $height - 1 }

        # blinking logic
        $e.Blink--

        if ($e.Blink -le 0) {
            $e.State = if ($e.State -eq "open") { "closed" } else { "open" }
            $e.Blink = Get-Random -Minimum 3 -Maximum 12
        }

        # render eyes
        if ($e.State -eq "open") {
            Draw $e.X $e.Y "o o" "White"
        }
        else {
            Draw $e.X $e.Y "- -" "DarkGray"
        }
    }

    Start-Sleep -Milliseconds 80
}
