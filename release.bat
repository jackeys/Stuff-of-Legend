IF "%~1" == "" (set VERSION="%date%") ELSE (set VERSION="%1")

powershell Compress-Archive -Path 'fomod', 'Content' -DestinationPath 'Releases/Stuff of Legend-%VERSION%.zip' -Force