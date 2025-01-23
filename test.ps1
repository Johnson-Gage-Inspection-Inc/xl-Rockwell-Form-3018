$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("__utmz", "147229740.1698033068.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)", "/", ".jgiquality.qualer.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_fuid", "MGFjMDRkZTktNTU4NC00MWNmLTkxN2YtNjlmNWE3ZjlkNTQ0", "/", ".qualer.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("Qualer.Employee.Login.SessionId", "56651914673c46e49e7fa7d5b81873e3", "/", "jgiquality.qualer.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("Qualer.auth", "E9E1126CA8951A5D039F6ED291685A3C3C9F9F40D5A4E713175BCB9BC0DF71369688F40F878AA2B41E2DCAE7EAA166FA3FF7B5D4A1BA9B1D578F61B76D31EA34A9474D18DC58844456083BB795B830310D7CE7B32C966A10948513D676E0BA20F4B99DF328997F92375CA75208E281DFA473F81B9BA70581A96573BF172574E3F6BB31D744C04FA1C8EA75AB095B65A1AE96969A", "/", "jgiquality.qualer.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ASP.NET_SessionId", "kvptlpbjz0i3nuirdelu3lr5", "/", "jgiquality.qualer.com")))

$filePath = "C:\Users\rhyth\Downloads\Form 3018, Rockwell 12-19-2024.xlsm"
$fileContent = [System.IO.File]::ReadAllBytes($filePath)
$boundary = "----WebKitFormBoundaryV4ulsHnCbbfTgntz"
$body = "--$boundary`r`n"
$body += "Content-Disposition: form-data; name=`"file`"; filename=`"$(Split-Path -Leaf $filePath)`"`r`n"
$body += "Content-Type: application/octet-stream`r`n`r`n"
$body += [System.Text.Encoding]::ASCII.GetString($fileContent)
$body += "`r`n--$boundary--`r`n"

Invoke-WebRequest -UseBasicParsing -Uri "https://jgiquality.qualer.com/Sop/SaveSopFile" `
-Method "POST" `
-WebSession $session `
-Headers @{
"authority"="jgiquality.qualer.com"
  "method"="POST"
  "path"="/Sop/SaveSopFile"
  "scheme"="https"
  "accept"="*/*"
  "accept-encoding"="gzip, deflate, br, zstd"
  "accept-language"="en-US,en;q=0.9"
  "clientrequesttime"="2025-01-23T03:51:20"
  "origin"="https://jgiquality.qualer.com"
  "priority"="u=1, i"
  "referer"="https://jgiquality.qualer.com/Sop/Sop?sopId=2351"
  "sec-ch-ua"="`"Google Chrome`";v=`"131`", `"Chromium`";v=`"131`", `"Not_A Brand`";v=`"24`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
  "sec-fetch-dest"="empty"
  "sec-fetch-mode"="cors"
  "sec-fetch-site"="same-origin"
  "x-requested-with"="XMLHttpRequest"
} `
-ContentType "multipart/form-data; boundary=$boundary" `
-Body $body