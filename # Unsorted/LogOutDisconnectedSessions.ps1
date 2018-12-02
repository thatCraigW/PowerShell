# Loop through all server names and log out and "disconnected" sessions
$servers = "server1", "server2", "server3"

foreach ($server in $servers){     
    $x = qwinsta /SERVER:$server | select-string "Disc" | select-string -notmatch "services"     
    $x |%{logoff ($_.tostring() -split ' +')[2] /SERVER:$server /V}     
}