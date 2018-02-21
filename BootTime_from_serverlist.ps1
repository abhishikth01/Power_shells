$NameList = Import-Csv -Path "D:\Scripts\ServerList.csv"
$computername = $NameList.Name
$file1 = "C:\temp\output.csv"
Function get-uptime {
foreach ($computer in $computername) {

#$computer = "Server-Name"
$Now=Get-Date
Try{
   $lastBoot = [System.Management.ManagementDateTimeconverter]::ToDateTime((gwmi  Win32_OperatingSystem -computername $($computer)).LastBootUpTime)
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
}
$serverarray = $NameList.Name
$serverarray | get-uptime | Export-Csv $file1 -force -NoTypeInformation