# Install iis

#Install-WindowsFeature web-server -IncludeManagementTools


# Folders
New-Item -ItemType Directory c:\temp
New-Item -ItemType Directory C:\inetpub\wwwroot\swayam_student

# Firewall
netsh advfirewall firewall add rule name="http" dir=in action=allow protocol=TCP localport=80
netsh advfirewall firewall add rule name="https" dir=in action=allow protocol=TCP localport=443
