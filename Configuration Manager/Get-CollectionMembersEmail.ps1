<###############
    .SYNOPSIS
    Gets Primary User's Email Address from Device Collection
    Exports Computer Name, Primary User, and Primary User Email Address to .CSV File

    .DESCRIPTION
    File Name is $CollectionName Email.csv
       
    .EXAMPLE
    SiteServer SCCMCM01 SiteCode CM1 CollectionName Windows 10 ExportPath C:\Temp

    .NOTES
    Author:   Steven Culp
    Created:  4-17-2020
 
    ###############>
    
  
  [CmdletBinding()]
    Param(
        [parameter(mandatory=$true, position=0)]
        [string]$SiteServer,
        [parameter(mandatory=$true, position=0)]
        [string]$SiteCode,
        [parameter(mandatory=$true, position=0)]
        [string]$CollectionName,
        [parameter(mandatory=$true, position=0)]
        [string]$ExportPath
        )
        
    $ErrorActionPreference = 'Stop'
  
    $NameSpace = "ROOT\sms\site_$SiteCode"

    $ClassName = 'SMS_Collection'

      Write-Host  "Getting CollectionID for $CollectionName"

    $CollectionID = (Get-WmiObject -Class $ClassName -ComputerName $SiteServer -NameSpace $NameSpace | Where-Object {$_.Name -eq "$CollectionName"}).CollectionID

    $CollectionClassName = "SMS_CM_RES_COLL_$CollectionID"
        
      Write-Host  "Getting Primary User for each Workstion in $CollectionName"

    $CollectionMember = (Get-WmiObject -Class $CollectionClassName -ComputerName $SiteServer -Namespace $NameSpace)

    ForEach ($Member in $CollectionMember) {   

          If ($Member.UserName -eq $Null) { 
                   
             }

          Else { 

             $MemberEmail = (Get-ADUser -Identity $Member.UserName -Properties * -ErrorAction SilentlyContinue).EmailAddress
          }

    [PSCustomObject] @{

        ComputerName = $Member.Name

        User = $Member.UserName

        UserEmail = $MemberEmail
    
    } | Export-Csv -Path "$ExportPath\$CollectionName Email.csv" -Append -Force 
    
}
