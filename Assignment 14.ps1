#Requires –RunAsAdministrator

$stoppedautoservices = Get-Service | Where-Object {$_.Status -eq "Stopped" -and $_.StartType -eq "Automatic"}
$stoppedautoservices
if ($stoppedautoservices.status -eq "Stopped") {
    start-service $stoppedautoservices 
}
write-host "Would you like to stop all manually loaded services other than automatic? Y or N."
$x = read-host 

if(($x -eq "Y") -or ($x -eq "y*")){
    get-service | where-object {$_.StartType -eq "Manual"} | start-service

  
}
else {write-output "Ok."
        
}

if((get-process "outlook" -ea SilentlyContinue) -eq $Null){ 
    "Not Running" 
    start-process OUTLOOK
}

get-eventlog security -newest 50 | Where-Object {$_.EventID -eq 4624}

#Start any service that has a startup type of automatic, but not running. Prompt the user to stop any service that is not set to automatic.
#Checks to see if Outlook.exe is running, if not, start it
#Access the Security log in the Event Log. Return interactive logon events. These have an event id of 4624.