$computername = "SERVER-NAME"
#$lastBoot = [System.Management.ManagementDateTimeconverter]::ToDateTime((Get-WmiObject  Win32_OperatingSystem -computername $computer).LastBootUpTime)

foreach ($computer in $computername) {

$Now=Get-Date
Try{
   $lastBoot = [System.Management.ManagementDateTimeconverter]::ToDateTime((Get-WmiObject  Win32_OperatingSystem -computername $computer).LastBootUpTime)
   }
   catch{
    $lastBoot=$null
   }
if ($lastboot -ne $null) {
    $Result=@{ “Server”=$($Computer);
    “Last Reboot”=$LastBoot;
    “Time Since Reboot”=”{0} Days {1} Hours {2} Minutes {3} Seconds” -f ($Now – $LastBoot).days, `
    ($Now – $LastBoot).hours,($Now – $LastBoot).minutes,($Now – $LastBoot).seconds}
    }
    else {
        $Result=@{ “Server”=$($Computer);“Last Reboot”="N/A";“Time Since Reboot”="N/A"}
    }

    Write-Output (New-Object psobject -Property $Result|select Server, “Last Reboot”, “Time Since Reboot”)
    $Lastboot=$null

}
