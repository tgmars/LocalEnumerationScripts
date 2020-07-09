function Get-Recentfiles {
    <#
    .SYNOPSIS
        # Parse an lnk file and grab the path out of them as an ms_path object to get the path back to the actual file.
        # Envar under special folders that points to recents - appdata/roaming/microsoft/windows/recent
    .REFERENCES
        https://powershell.org/2013/04/powershell-popup/
        https://docs.microsoft.com/en-us/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishelllinka?redirectedfrom=MSDN
        https://stackoverflow.com/questions/3425969/general-approach-to-reading-lnk-files
    #>
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $RecentFiles=@()
        $WShell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
        Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Windows\Recent\*" -File | ForEach-Object {
            # Write-Host($_.FullName)
            $LNKTarget=$WShell.CreateShortcut($_.FullName)
            # Write-Host($LNKTarget.TargetPath)

            $LnkMeta=Get-Item $_.FullName -ErrorAction SilentlyContinue | Select-Object CreationTimeUtc,LastWriteTimeUtc,LastAccessTimeUtc


            if ([string]::IsNullOrWhiteSpace($LNKTarget.TargetPath) -eq $false) {
                $TargetMeta=Get-Item $LNKTarget.TargetPath -ErrorAction SilentlyContinue | Select-Object CreationTimeUtc,LastWriteTimeUtc,LastAccessTimeUtc
            }

            $RecentFiles+=[PSCustomObject]@{
                Type="GUIRecentItems"
                FileName=$_.Name
                UserProfile=$_.FullName.Split('\')[2]
                TargetPath=$LNKTarget.TargetPath
                TargetCreatedUTC=$TargetMeta.CreationTimeUtc
                TargetLastWriteUTC=$TargetMeta.LastWriteTimeUtc
                TargetLastAccessUTC=$TargetMeta.LastAccessTimeUtc
                LnkCreatedUTC=$LnkMeta.CreationTimeUtc
                LnkLastWriteUTC=$LnkMeta.LastWriteTimeUtc
                LnkLastAccessUTC=$LnkMeta.LastAccessTimeUtc
            }
        }

        # Recurse over all drives in the future
        Get-ChildItem "C:\" -Recurse -File -Force -Attributes Hidden, !Hidden -ErrorAction SilentlyContinue | ForEach-Object {
            if ($_.LastWriteTime -gt (Get-Date).AddHours(-24)){
            Write-Host "File modified within 24 hours "$_.FullName
            $RecentFiles+=$_
            }
        }
        return $RecentFiles
    }
}

Export-ModuleMember -Function Get-Recentfiles


