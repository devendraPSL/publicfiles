
# Install iis

#Install-WindowsFeature web-server -IncludeManagementTools


# Folders
New-Item -ItemType Directory c:\temp
New-Item -ItemType Directory C:\inetpub\wwwroot\student

# Firewall
netsh advfirewall firewall add rule name="http" dir=in action=allow protocol=TCP localport=80
netsh advfirewall firewall add rule name="https" dir=in action=allow protocol=TCP localport=443

# Download  app
Invoke-WebRequest  \\10.14.8.4\ServerBuild\Learner\Website\swayam_student.zip -OutFile c:\temp\swayam_student.zip
Expand-Archive C:\temp\swayam_student.zip C:\inetpub\wwwroot\

#configure IIS
Remove-WebSite -Name "Default Web Site"
Set-ItemProperty IIS:\AppPools\DefaultAppPool\ managedRuntimeVersion ""
New-Website -Name "student" -Port 80 -PhysicalPath C:\inetpub\wwwroot\swayam_student -ApplicationPool DefaultAppPool
