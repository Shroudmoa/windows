
function Start-Matrix {
    
    [CmdletBinding(DefaultParameterSetName='Time')]
    param(
        
        [Parameter(ParameterSetName='Time', Position=0)]
        
        [Parameter(ParameterSetName='Color', Position=1)]
        [Alias('Sleep','S')]
            [int]$SleepTime = 50, 
        [Parameter(ParameterSetName='Time', Position=1)]
        [Parameter(ParameterSetName='Color', Position=2)]
        [Alias('Drop','DC')]
            [int]$DropChance = 2, 
        [Parameter(ParameterSetName='Time', Position=2)]
        [Parameter(ParameterSetName='Color', Position=3)]
        [Alias('Stick','SC')]
            [int]$StickChance = 55, 
        [Parameter(ParameterSetName='Time', Position=3)]
        [Parameter(ParameterSetName='Color', Position=0, Mandatory)]
        [Alias('Colour','C')]
            [string]$Color = 'Green', 
        [Parameter(Position=4)]
        [Alias('LeaveUntouched','Leave','Untouched','LUC','L')]
            [int]$LeaveUntouchedChance = 30, 
        
        
        [Alias('Full','FS','F')]
            [switch]$FullScreen, 
        [Alias('NCB')]
            [switch]$NoClearBefore, 
        [Alias('NCA')]
            [switch]$NoClearAfter, 
        [Alias('NoAdaptive','NoAdaptative','NoAdapt','NoResize')]
            [switch]$NoAdaptiveSize, 
        [Alias('Rainbow','M')]
            [switch]$Multicolor 
    )

    

    Add-Type -AssemblyName System.Windows.Forms
    if ($FullScreen) {
        [System.Windows.Forms.SendKeys]::SendWait("{F11}")
        
        [Threading.Thread]::Sleep(100) 
    }

    
    $WS = $Host.UI.RawUI.WindowSize
    $windowWidth, $windowHeight = $WS.Width, $WS.Height
    $maxHoriz = $windowWidth - 1
    $maxVertic = $windowHeight - 1

    
    $MINUNICODE = 21
    $MAXUNICODE = 7610
    
    if ($Multicolor) {
        $colors = 16, 231
        $randomColors = $colors[0]..$colors[1] | Sort-Object {Get-Random}
    }

    
    $randomGen = [Random]::New() 

    
    $supportedChars = ($MINUNICODE,126),(161,1299),(7425,$MAXUNICODE) 
    
    
    
    $oldCursorVisible = [Console]::CursorVisible

    
    $matrix = [Collections.Generic.List[Object]]::New($maxVertic)
    for ($i = 0; $i -lt $maxVertic; ++$i) {
        $matrix.Add([Collections.Generic.List[Char]]::New(' '*$maxHoriz))
    }

    
    $currentLine = 0
    $prevLine = $matrix[0] 

    
    if (!($NoClearBefore)) { Clear-Host }

    
    :mainLoop while ($true) {
        

        if ([Console]::KeyAvailable) {
            $keyInfo = [Console]::ReadKey($true) 

            
            if ($keyInfo.Key -eq 'P') {
                [Console]::SetCursorPosition($0,$maxVertic)
                [Console]::Write('[Paused]')
                
                while ($true)
                {
                    [Threading.Thread]::Sleep(100) 
                    if ([Console]::KeyAvailable) {
                        $keyInfo = [Console]::ReadKey($true) 

                        
                        if ($keyInfo.Key -eq 'P') {
                            [Console]::SetCursorPosition(0,$maxVertic)
                            [Console]::Write(' '*8) 
                            
                            break
                        }
                        else { if ($FullScreen) { [System.Windows.Forms.SendKeys]::SendWait("{F11}") } ; break mainLoop }
                    }
                }
            }
            
            
            
            else { if ($FullScreen) { [System.Windows.Forms.SendKeys]::SendWait("{F11}") } ; break mainLoop }
        }

        

        
        for ($j = 0; $j -lt $matrix[$currentLine].Count; $j++) {
            
            if ($matrix[$currentLine][$j] -ne ' ') {
                
                if ($randomGen.Next(100) -ge $LeaveUntouchedChance) {
                
                
                    $matrix[$currentLine][$j] = ' '
                    if ($Multicolor) {
                        
                        try {
                            [Console]::SetCursorPosition($j, $currentLine)
                        }
                        catch [System.Management.Automation.MethodInvocationException] {
                            break
                        }
                        [Console]::CursorVisible = $false
                        
                        [Console]::Write(' ')
                    }
                }
            }
            else {
                
                
                
                if (($prevLine[$j] -ne ' ' -and $randomGen.Next(100) -lt $StickChance) -or
                    $randomGen.Next(100) -lt $DropChance)
                {
                    $charIsGood = $false
                    do {
                        $uni = $randomGen.Next($MINUNICODE, $MAXUNICODE)
                        foreach ($interval in $supportedChars)
                        {
                            if ($uni -ge $interval[0] -and
                                $uni -le $interval[1])
                            {
                                $charIsGood = $true
                                break 
                            }
                        }
                    } until ($charIsGood)

                    $matrix[$currentLine][$j] = [char]$uni
                    if ($Multicolor) {
                        
                        try {
                            [Console]::SetCursorPosition($j, $currentLine)
                        }
                        catch [System.Management.Automation.MethodInvocationException] {
                            break
                        }
                        [Console]::CursorVisible = $false
                        

                        
                        $randomColor = $randomColors[($j -bxor $currentLine -bor $uni) -band $randomColors.Count] 

                        
                        
                        Write-Host "`e[38;5;${randomColor}m$($matrix[$currentLine][$j])`e[0m" -NoNewLine 
                    }
                    
                }
            }
        }

        if (!$Multicolor) {
            
            try {
                [Console]::SetCursorPosition(0, $currentLine)
                [Console]::CursorVisible = $false
                Write-Host "$($matrix[$currentLine] -join '')" -Foreground $Color -NoNewLine 
            }
            catch [System.Management.Automation.MethodInvocationException] {
                
            }
        }

        
        $prevLine = $matrix[$currentLine]

        
        if ($currentLine -ne ($maxVertic - 1)) {
            $currentLine++
        }
        
        else {
            $currentLine = 0
            
            
            if (!$NoAdaptiveSize -and $WS -ne $Host.UI.RawUI.WindowSize) {
                $WS = $Host.UI.RawUI.WindowSize 

                $diffHeight = $WS.Height - $windowHeight
                $diffWidth = $WS.Width - $windowWidth

                
                if ($diffHeight -gt 0) {
                    
                    for ($i = 0; $i -lt $diffHeight; $i++) {
                        $matrix.Add([Collections.Generic.List[Char]]::New(' '*$maxHoriz))
                        
                    }
                }
                
                else {
                    $newHeight = $matrix.Count + $diffHeight 
                    $end = [Math]::Abs($diffHeight)
                    
                    $matrix.RemoveRange($newHeight, $end) 
                }

                
                if ($diffWidth -gt 0) {
                    
                    for ($i = 0; $i -lt $matrix.Count; $i++) {
                        $matrix[$i].AddRange(' '*$diffWidth)
                    }
                }
                
                else {
                    $newWidth = $matrix[0].Count + $diffWidth 
                    $end = [Math]::Abs($diffWidth)

                    
                    for ($i = 0; $i -lt $matrix.Count; $i++) {
                        $matrix[$i].RemoveRange($newWidth, $end) 
                    }
                }                
                $prevLine = $matrix[0]

                $windowHeight, $windowWidth = $WS.Height, $WS.Width
                $maxVertic = $windowHeight - 1
                $maxHoriz = $windowWidth - 1
            }
        }

        [Threading.Thread]::Sleep($SleepTime)
    }
    
    

    if (!($NoClearAfter)) { Clear-Host }
    
    [Console]::CursorVisible = $oldCursorVisible
}

Start-Matrix
