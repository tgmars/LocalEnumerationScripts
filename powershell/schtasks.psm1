function Get-SchedTasks {
    <#
    .SYNOPSIS
        Retrieve scheduled tasks for all users from systemroot\tasks and systemroot\system32\tasks.
        Returns an array of XML objects, these need to be looped through to access them.
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

        Get-ChildItem -Path $System32TaskPath -Recurse -File -Force  | Select-Object FullName,Name,BaseName | ForEach-Object {
            if($_.Name -eq $_.BaseName){
                $CurrentPath=$_.FullName
                # Write-Host($CurrentPath)
                [XML]$tempvar=Get-Content $CurrentPath -ErrorAction SilentlyContinue
                $Tasks+=$tempvar
                # Write-Object($tempvar.Task.RegistrationInfo)
            }
        } 

        Get-ChildItem -Path $SystemRootTaskPath -Recurse -File -Force  | Select-Object FullName,Name,BaseName | ForEach-Object {
            if($_.Name -eq $_.BaseName){
                $CurrentPath=$_.FullName
                # Write-Host($CurrentPath)
                [XML]$tempvar=Get-Content $CurrentPath -ErrorAction SilentlyContinue
                $Tasks+=$tempvar
                # Write-Object($tempvar.Task.RegistrationInfo)
            }
        } 
        return $Tasks
        }
}

Export-ModuleMember -Function Get-SchedTasks
