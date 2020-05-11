 <###############
    .SYNOPSIS
    Gets Software Updates Status Per Machine

    .DESCRIPTION
    
       
    .EXAMPLE
    

    .NOTES
    Author:   Steven Culp
    Created:  5-06-2020
 
    ###############>
 
 
 
 
 [CmdletBinding()]
    Param(
        [parameter(mandatory=$true, position=0)]
        [string]$ComputerName
        )

$Updates = (Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_SoftwareUpdate -ComputerName $ComputerName | Where-Object {$_.ComplianceState -eq "0" })


ForEach($update in $Updates) { 

  If ($Update.EvaluationState -eq '23') {

    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitForOrchestration'
    }
  
  }
 
  If ($Update.EvaluationState -eq '22') {

    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitPresModeOff'
    }
  
  }
  
  If ($Update.EvaluationState -eq '21') {
  
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitingRetry'
    }
 
  }

  If ($Update.EvaluationState -eq '20') {
  
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'PendingUpdate'
    }

  }

  If ($Update.EvaluationState -eq '19') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'PendingUserLogoff'
    }

  }
 
  If ($Update.EvaluationState -eq '18') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitUserReconnect'
    }

  }

  If ($Update.EvaluationState -eq '17') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitJobUserLogon'
    }

  }
 
  If ($Update.EvaluationState -eq '16') {
    W[PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitUserLogoff'
    }

  } 

  If ($Update.EvaluationState -eq '15') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitUserLogon'
    }

  }

  If ($Update.EvaluationState -eq '14') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitServiceWindow'
    }

  }

  If ($Update.EvaluationState -eq '13') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Error'
    }

  }

  If ($Update.EvaluationState -eq '12') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'InstallComplete'
    }

  }

  If ($Update.EvaluationState -eq '11') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Verifying'
    }

  }

  If ($Update.EvaluationState -eq '10') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitReboot'
    }
 
  }

  If ($Update.EvaluationState -eq '9') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'PendingHardReboot'
    }

  }

  If ($Update.EvaluationState -eq '8') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'PendingSoftReboot'
    }

  }

  If ($Update.EvaluationState -eq '7') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Installing'
    }

  }

  If ($Update.EvaluationState -eq '6') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'WaitInstall'
    }

  }

  If ($Update.EvaluationState -eq '5') {
     [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Downloading'
      }

  }

  If ($Update.EvaluationState -eq '4') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'PreDownload'
    }
 
  }

  If ($Update.EvaluationState -eq '3') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Detecting'
    }

  }
 
  If ($Update.EvaluationState -eq '2') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Submitted'
    }

  }

  If ($Update.EvaluationState -eq '1') {
    [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'Available'
    }

  }

  If ($Updates.EvaluationState -eq '0') {
     [PSCustomObject] @{
    
      UpdateName = $Update.Name

      Status = 'None'
    }

  }

}
