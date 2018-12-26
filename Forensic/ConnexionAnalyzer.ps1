Get-NetTCPConnection | 
    ?{$_.State -match "Established" -and $_.LocalAddress -notmatch "::|127.0.0.1" -and $_.RemoteAddress -notlike "172.*"} | 
    Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, @{l="ProcessName";e={(Get-Process -Id $_.OwningProcess).Name}}, @{l="RemoteDnsName";e={(Resolve-DnsName -Name $_.RemoteAddress -Type PTR -DnsOnly).NameHost}} | 
    Out-GridView