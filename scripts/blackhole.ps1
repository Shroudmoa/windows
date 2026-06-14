$ErrorActionPreference = 'SilentlyContinue'
[Console]::CursorVisible = $false
Clear-Host

$width  = [Console]::WindowWidth
$height = [Console]::WindowHeight

$centerX = [int]($width / 2)
$centerY = [int]($height / 2)

$particles = @()

function New-Particle {
    return [PSCustomObject]@{
        X = Get-Random -Minimum 0 -Maximum $width
        Y = Get-Random -Minimum 0 -Maximum $height
        VX = (Get-Random -Minimum -2 -Maximum 3)
        VY = (Get-Random -Minimum -2 -Maximum 3)
        Life = Get-Random -Minimum 50 -Maximum 200
    }
}

function Draw($x, $y, $c, $color = "White") {
    try {
        [Console]::SetCursorPosition($x, $y)
        Write-Host $c -NoNewline -ForegroundColor $color
    } catch {}
}

# seed particles
1..200 | ForEach-Object { $particles += New-Particle }

while ($true) {

    $width  = [Console]::WindowWidth
    $height = [Console]::WindowHeight

    $centerX = [int]($width / 2)
    $centerY = [int]($height / 2)

    foreach ($p in $particles) {

        # erase old position
        Draw $p.X $p.Y " "

        # direction to center
        $dx = $centerX - $p.X
        $dy = $centerY - $p.Y

        # gravity strength
        $p.VX += [math]::Sign($dx)
        $p.VY += [math]::Sign($dy)

        # damping (prevents infinite speed)
        $p.VX = [int]($p.VX * 0.85)
        $p.VY = [int]($p.VY * 0.85)

        # spiral effect (tangential force)
        $p.VX += (Get-Random -Minimum -1 -Maximum 2)
        $p.VY += (Get-Random -Minimum -1 -Maximum 2)

        # move
        $p.X += $p.VX
        $p.Y += $p.VY

        $p.Life--

        # respawn if swallowed or dead
        if ($p.Life -le 0 -or $p.X -lt 0 -or $p.X -ge $width -or $p.Y -lt 0 -or $p.Y -ge $height) {
            $p.X = Get-Random $width
            $p.Y = Get-Random $height
            $p.VX = 0
            $p.VY = 0
            $p.Life = Get-Random -Minimum 80 -Maximum 200
        }

        # event horizon zone
        $dist = [math]::Sqrt(($dx*$dx) + ($dy*$dy))

        if ($dist -lt 6) {
            Draw $p.X $p.Y "@" "Black"
        }
        elseif ($dist -lt 12) {
            Draw $p.X $p.Y "O" "DarkRed"
        }
        elseif ($dist -lt 25) {
            Draw $p.X $p.Y "o" "Red"
        }
        else {
            Draw $p.X $p.Y "." "DarkGray"
        }
    }

    # singularity marker
    Draw $centerX $centerY "@" "White"

    Start-Sleep -Milliseconds 40
}
