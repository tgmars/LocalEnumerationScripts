# Write-Object(PSObject) ... writes the specified object to STDOUT in
# PowerShell's list format as a string.
function Write-Object{
    [CmdletBinding()]
    param (
        [Parameter()]
        [PSObject]
        $objOutput
    )
    Write-Host( $objOutput | Format-List | Out-String)
}

# Write-NestedObject(PSObject) ... writes the specified object to STDOUT in
# truncated, expanded JSON as a string.
function Write-NestedObject{
    [CmdletBinding()]
    param (
        [Parameter()]
        [PSObject]
        $objOutput
    )
    
    Write-Host( $objOutput | Format-Custom | Out-String)
}

# -----------------------------------------------------------------------------  
# Script: Get-NTUSERDAT.ps1 
# Author: Paul Brown 
# Date: 12/17/2015 10:57:47  
# Keywords:  
# comments:  
#  
# ----------------------------------------------------------------------------- 
 
Function Get-NTUSERDAT { 
    <#  
       .Synopsis  
        Mounts the NTUSER.DAT file as a PSDrive using the registry provider.  
    .Description 
        Without any arguments the current users file is loaded, but a single  
        profile can be specified or the -All switch can be given to load all  
        profiles on the machine. If the -Dismount command is given it will  
        unload the drive and registry hive; also, if given in conjuntion with 
        -All, then all profiles on the machine will be dismounted. If the  
        username contains a period it will be stripped. The [gc]::collect()  
        command is also given to clean up the registry after dismount. 
       .Example  
        Get-NTUSERDAT 
    .Example 
        Get-NTUSERDAT -User <username> 
    .Example 
        Get-NTUSERDAT -All 
    .Example  
        Get-NTUSERDAT -User <username> -Dismount 
    .Example  
        Get-NTUSERDAT -Dismount -All  
       .Notes  
        NAME: Get-NTUSERDAT.ps1  
        AUTHOR: Paul Brown  
        LASTEDIT: 12/17/2015 10:57:41  
        KEYWORDS:  
       .Link  
        https://gallery.technet.microsoft.com/scriptcenter/site/search?f%5B0%5D.Type=User&f%5B0%5D.Value=PaulBrown4 
    #Requires -Version 2.0  
    #>  
    [cmdletbinding()] 
    Param( 
    [Parameter( 
         Mandatory=$false, 
         Position=0, 
         ValueFromPipeline=$true, 
            ValueFromPipelineByPropertyName=$true)] 
        [array]$User = $Env:USERNAME, 
        [switch]$All, 
        [switch]$Dismount 
    )     
    If ($All) { 
        $User = $(Get-ChildItem "$($env:systemdrive)\Users\").Name 
    } 
    If (-not $Dismount) { 
        Foreach ($name in $User) { 
            Try { 
                $newname = $($name.replace(".","")) 
                $hive = "HKLM\$newname" 
                $path = "$($env:systemdrive)\Users\$name\ntuser.dat" 
                reg load  $hive $path 
                New-PSDrive -Name $newname -PSProvider Registry -Root $hive -Scope Global 
            } Catch { 
            } 
        } 
    } Else { 
        Foreach ($name in $User) { 
            Try { 
                $newname = $($name.replace(".","")) 
                Remove-PSDrive -Name $newname 
                reg unload "HKLM\$newname" 
                 
                [GC]::Collect() 
            } Catch { 
            } 
        } 
    } 
}


Export-ModuleMember -Function Write-NestedObject
Export-ModuleMember -Function Write-Object
Export-ModuleMember -Function Get-NTUSERDAT