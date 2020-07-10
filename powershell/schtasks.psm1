function Get-SchedTasks {
    <#
    .SYNOPSIS
        Retrieve scheduled tasks for all users from systemroot\tasks and systemroot\system32\tasks.
    .REFERENCES
    #>        
    [CmdletBinding()]
    param()
    begin {
        Write-Host($PSCmdlet.MyInvocation.MyCommand.Name)
    }
    process {
    }
    end {
        $Tasks=@()
        $System32TaskPath="$env:SystemRoot\System32\Tasks\"
        $SystemRootTaskPath="$env:SystemRoot\Tasks\"

        Get-ChildItem -Path $System32TaskPath -Recurse -File -Force  | Select-Object FullName | ForEach-Object {
            $CurrentPath=$_.FullName
            # Write-Host($CurrentPath)
            [XML]$tempvar=Get-Content $CurrentPath
            $Tasks+=$tempvar
            # Write-Object($tempvar.Task.RegistrationInfo)
        } 

        Get-ChildItem -Path $SystemRootTaskPath -Recurse -File -Force  | Select-Object FullName | ForEach-Object {
            $CurrentPath=$_.FullName
            # Write-Host($CurrentPath)
            [XML]$tempvar=Get-Content $CurrentPath
            $Tasks+=$tempvar
            # Write-Object($tempvar.Task.RegistrationInfo)
        } 
        return $Tasks
        }
}

Export-ModuleMember -Function Get-SchedTasks
