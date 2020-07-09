function Get-Autoruns {
    <#
    .SYNOPSIS
        Gets commands executed on startup using Win32_StartupCommand & enumerating profiles
    #>
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        return (Get-CimInstance -ClassName Win32_StartupCommand)
    }
}
Export-ModuleMember -Function Get-Autoruns
