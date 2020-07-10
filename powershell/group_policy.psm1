function Get-GroupPolicy {
    <#
    .SYNOPSIS
        Get group policy - nasty code, not even looping
        Computer policy enumeration requires elevated privs
    .REFERENCES
        https://www.sapien.com/blog/2014/11/18/removing-objects-from-arrays-in-powershell/
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $GPEntries=@()
        $GPUserOutput=gpresult /SCOPE:USER /v
        $GPUserOutput=$GPUserOutput[7..$GPUserOutput.Length]
        
        $PreviousLine="invalidprevline"
        $PrePreviousLine="invalidprevprevline"
        $Header=""
        $Values=@()
        [System.Collections.ArrayList]$Values=@()
        foreach ($Line in $GPUserOutput) {
            # Write-Host($Line)
            if ($Line -match "--------" -and [string]::IsNullOrWhiteSpace($PrePreviousLine)) {
                if($Values.Count -gt 0){
                    $Values=$Values[0..($Values.Count-2)]
                }
                if ([string]::IsNullOrWhiteSpace($Header) -eq $false) {
                    $GPEntries+=[PSCustomObject]@{
                        Scope="User"
                        Header=$Header
                        Entries=$Values
                    }
                }
                $Values=@()
                $Header = $PreviousLine
            } else {
                $Values+=$Line
            }
            $PrePreviousLine=$PreviousLine
            $PreviousLine=$Line
        }

        # Feels bad but gpresult output is trash and cbf doing this nicely
        # Requires admin privs
        $GPCompOutput=gpresult /SCOPE:COMPUTER /v
        $GPCompOutput=$GPCompOutput[7..$GPCompOutput.Length]
        
        $PreviousLine="invalidprevline"
        $PrePreviousLine="invalidprevprevline"
        $Header=""
        $Values=@()
        [System.Collections.ArrayList]$Values=@()
        foreach ($Line in $GPCompOutput) {
            # Write-Host($Line)
            if ($Line -match "--------" -and [string]::IsNullOrWhiteSpace($PrePreviousLine)) {
                if($Values.Count -gt 0){
                    $Values=$Values[0..($Values.Count-2)]
                }
                if ([string]::IsNullOrWhiteSpace($Header) -eq $false) {
                    $GPEntries+=[PSCustomObject]@{
                        Scope="Computer"
                        Header=$Header
                        Entries=$Values
                    }
                }
                $Values=@()
                $Header = $PreviousLine
            } else {
                $Values+=$Line
            }
            $PrePreviousLine=$PreviousLine
            $PreviousLine=$Line
        }
        return $GPEntries
    }
}

Export-ModuleMember -Function Get-GroupPolicy
