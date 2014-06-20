Write-Host "Hi Johan, welcome back!"

#############
# Functions #
#############

## Figure out where I got these profile .ps1 file from
## 

## Web Server
## http://technet.microsoft.com/en-us/library/ee692685.aspx
function server{python -m http.server}

## Function to retrieve external IP address.
## the external address is retrieved from the
## title header of the webpage "www.myip.dk"
## http://tfl09.blogspot.de/2008/07/finding-your-external-ip-address-with.html
function Get-ExternalIP {
    $source = "http://checkip.dyndns.org"
    $client = new-object System.Net.WebClient
    $webpage = $client.downloadString($source)
    $lines = $webpage.split("`n")
    foreach ($line in $lines) {
        if ($line.contains("Current IP Address:")) {
            $ip = $line.replace("<html><head><title>Current IP Check</title></head><body>Current IP Address: ", "").replace("</body></html>","")
        }
    }
    $obj = New-Object Object
    $obj | Add-Member Noteproperty externalIP -value $ip
    $obj
}

## Quick Evernote note creation
## http://dev.evernote.com/documentation/local/chapters/windows.php
function newnote{evernote /NewNote}
function screenshot{evernote /Task:ClipScreen}

#################
# Handy Aliases #
#################

Set-Alias ip Get-ExternalIP

# Setting sublime text as text editor which can be easily accessed
Set-Alias notepad++ "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias edit notepad++