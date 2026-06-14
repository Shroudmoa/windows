$ErrorActionPreference = 'SilentlyContinue'
[Console]::CursorVisible = $false

$w = [Console]::WindowWidth
$h = [Console]::WindowHeight

$cx = [int]($w / 2)
$cy = [int]($h / 2)

$particles = @()

function Spawn {
    $side = Get-Random 4


    switch ($side) {
        0 { return [PSCustomObject]@{ X=0; Y=Get-Random $h; VX=1; VY=0 } }
        1 { return [PSCustomObject]@{ X=$w-1; Y=Get-Random $h; VX=-1; VY=0 } }
        2 { return [PSCustomObject]@{ X=Get-Random $w; Y=0; VX=0; VY=1 } }
        3 { return [PSCustomObject]@{ X=Get-Random $w; Y=$h-1; VX=0; VY=-1 } }
    }
}

function Draw($x,$y,$c) {
    try {
        [Console]::SetCursorPosition($x,$y)
        Write-Host $c -NoNewline -ForegroundColor Red
    } catch {}
}

# initial flow
1..200 | ForEach-Object { $particles += Spawn }

while ($true) {

    $w = [Console]::WindowWidth
    $h = [Console]::WindowHeight

    $cx = [int]($w / 2)
    $cy = [int]($h / 2)

    # CONSTANT INFLOW (this is what makes it never die)
    $particles += (Spawn)
    $particles += (Spawn)

    if ($particles.Count -gt 300) {
        $particles = $particles[($particles.Count-300)..($particles.Count-1)]
    }

    foreach ($p in $particles) {

        Draw ([int]$p.X) ([int]$p.Y) " "

        $dx = $cx - $p.X
        $dy = $cy - $p.Y

        # distance
        $dist = [math]::Sqrt($dx*$dx + $dy*$dy) + 0.1

        # normalize
        $dx = $dx / $dist
        $dy = $dy / $dist

        # gravity strength (simple but visible)
        $force = 2 / $dist

        # apply movement (THIS is the whole simulation)
        $p.VX += $dx * $force
        $p.VY += $dy * $force

        # damping (stability)
        $p.VX *= 0.95
        $p.VY *= 0.95

        $p.X += $p.VX
        $p.Y += $p.VY

        $ix = [int]$p.X
        $iy = [int]$p.Y

        # black hole absorb → instant respawn (keeps flow alive)
        if ($dist -lt 2) {
            $np = Spawn
            $p.X = $np.X
            $p.Y = $np.Y
            $p.VX = $np.VX
            $p.VY = $np.VY
            continue
        }

        # visible traffic
        $char =
        if ($dist -lt 5) { "@" }
        elseif ($dist -lt 15) { "O" }
        else { "." }

        Draw $ix $iy $char
    }

    # center
    Draw $cx $cy "@"

    Start-Sleep -Milliseconds 20
}
