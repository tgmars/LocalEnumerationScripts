function Get-DNSClientCacheHCM {
    <#
    .SYNOPSIS
        Returns a custom ps object containing DNS client cache information.
        The information is equivalent running "ipconfig /displaydns". The
        function uses regex to grab the key-values present in the output. 
        Uses the "Record Name" key as the marker to indicate a new entry 
        in the cache has been reached, and that the current object should
        be copied (via a simple deep copy method) and appended to the array.
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $DNSCache=@()
        $DNSOutput= ipconfig /displaydns

        $CacheEntryTemplate=@{
            "Record Name"="";
            "Record Type"="";
            "Time To Live"="";
            Section="";
            "Data Length"="";
            "A (Host) Record"="";
            "PTR Record"="";
            "CNAME Record"="";
            "AAAA Record"="";
        }

        $CacheEntry = New-Object PsObject -Property $CacheEntryTemplate

        $FirstRun=$true
        foreach($line in $DNSOutput){
            $RegexOut=[regex]::Matches($line,"\s+([A-Za-z\s\(\)]+)[\.\s]+\:\s([0-9A-Za-z\.\-]+)")

            if($RegexOut.Success -eq $true){
                $CurrentKey=($RegexOut.Captures.Groups[1].Value).Trim()
                $CurrentVal=($RegexOut.Captures.Groups[2].Value).Trim()

                if($CurrentKey -match "Record\sName" -and $FirstRun -eq $false){
                    # Do a 'deep copy' here otherwise our knowledge of $CacheEntry is having its reference
                    # passed to DNSCache rather that its value
                    $TempObj=$CacheEntry | ConvertTo-Csv -NoTypeInformation | ConvertFrom-Csv
                    $DNSCache+=$TempObj
                    # Reset each field back to nil
                    $CacheEntry = New-Object PsObject -Property $CacheEntryTemplate
                }
                $CacheEntry.$CurrentKey = $CurrentVal
                $FirstRun=$false
            }
        }
        # Return the last object that doesn't get assigned in the main loop. 
        $DNSCache+=$CacheEntry
        return $DNSCache
    }
}

Export-ModuleMember -Function Get-DNSClientCacheHCM

