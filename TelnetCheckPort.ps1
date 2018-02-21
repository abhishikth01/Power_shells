$servername = Import-Csv -Path "C:\temp\telnet_chk_dest_list.txt"
$sources = $servername.list
$sources = "SERVER-NAME"
Foreach ($source in $sources)
{
  $port = "24158"
  
  Write-Host "Connecting to $source on port $port"

  try
  {
    $socket = New-Object System.Net.Sockets.TcpClient($source, $port)
  }
  catch [Exception]
  {
    Write-Host $_.Exception.GetType().FullName
    Write-Host $_.Exception.Message
  }

  Write-Host "Connected`n"
}