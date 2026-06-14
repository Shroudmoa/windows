Add-Type -AssemblyName System.Windows.Forms

# --- FILE PICKER (ALL FILES) ---
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.Filter = "All files (*.*)|*.*"
$dialog.Title = "Select any file to type out"

if ($dialog.ShowDialog() -ne "OK") {
    exit
}

$filePath = $dialog.FileName

# --- READ FILE (RAW) ---
try {
    $text = Get-Content $filePath -Raw -ErrorAction Stop
} catch {
    $text = [System.IO.File]::ReadAllText($filePath)
}

[Console]::CursorVisible = $false
Clear-Host

$cursor = "|"

function Type-Char {
    param($line)

    foreach ($char in $line.ToCharArray()) {

        Write-Host "$char$cursor" -NoNewline

        Start-Sleep -Milliseconds (Get-Random -Minimum 15 -Maximum 70)

        Write-Host "`b `b" -NoNewline
    }

    Write-Host ""
}

# --- NORMALIZE INPUT ---
$lines = $text -split "`r?`n"

foreach ($line in $lines) {

    # different “feel” depending on file type
    $ext = [System.IO.Path]::GetExtension($filePath).ToLower()

    switch ($ext) {

        ".ps1" { Start-Sleep -Milliseconds 300 }   # slower, “code thinking”
        ".json" { Start-Sleep -Milliseconds 150 }  # structured parsing feel
        ".log"  { Start-Sleep -Milliseconds 80 }   # fast journal vibe
        default { Start-Sleep -Milliseconds 120 }
    }

    Type-Char $line
}
