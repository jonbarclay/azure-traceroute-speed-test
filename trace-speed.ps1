$FileName = ".\trace_routeold.txt"
if (Test-Path $FileName) {
  Remove-Item $FileName
}
mv ".\trace_route.txt" ".\trace_routeold.txt"

$List = "1.1.1.1","161.28.51.199","dfs.core.windows.net"

$output = ForEach ($Destination in $List){
    Test-NetConnection -ComputerName $Destination -TraceRoute
    }
$output | Out-File -FilePath ".\trace_route.txt"

.\iperf3.exe -c 161.28.51.199 -p 50001

diff (cat .\trace_route.txt) (cat .\trace_routeold.txt)