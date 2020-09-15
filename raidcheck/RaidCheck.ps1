$state = omreport storage vdisk controller=0 | Select-String “Status” | Out-String
$pstate = omreport storage pdisk controller=0 | Select-String “Failure Predicted” | Out-String

#Creating raidcheck directory if not found
if (!(test-path -path “C:\raidcheck”)) {
    New-Item -Path "c:\" -Name "raidcheck" -ItemType "directory"
    Write-Host "No raidcheck directory found, creating one now."
}

#Testing path for Physical Disk and Virtual Disk logs. If logs not found then it will create them.
if (!(test-path -path “C:\raidcheck\PhysicalDiskStatus.txt”)) {
    omreport storage pdisk controller=0 | Select-String “Failure Predicted”, “Name” | Out-String | out-file C:\raidcheck\PhysicalDiskStatus.txt
}
if (!(test-path -path “C:\raidcheck\RaidStatus.txt”)) {
    omreport storage vdisk controller=0 | Select-String "Status", "Name" | Out-String |out-file C:\raidcheck\RaidStatus.txt
}

omreport storage pdisk controller=0 | Select-String “Failure Predicted”, “Name” | Out-String | out-file C:\raidcheck\PhysicalDiskStatus.txt
omreport storage vdisk controller=0 | Select-String "Status", "Name" | Out-String |out-file C:\raidcheck\RaidStatus.txt

if ($state -like '*degraded*') {
    Write-Host "Degraded! Sending email with logs..."
    #Send Email
    $secpasswd = ConvertTo-SecureString “PASSWORD” -AsPlainText -Force
    $mycreds = New-Object System.Management.Automation.PSCredential (“EMAIL@EMAIL.com”, $secpasswd)

    Send-MailMessage -from "frank@osi-networks.com" `
        -To "notify@orionsupport.net" `
        -Attachments "C:\RaidCheck\PhysicalDiskStatus.txt", "C:\RaidCheck\RaidStatus.txt" `
        -Subject "SERVER ALERT RAID DEGRADED" `
        -SmtpServer "mail.smtp2go.com" `
        -Credential $mycreds `
        -UseSsl `
        -Port "2525" `
        -Body "Dentist at Market Square server RAID DEGRADED - Check attached logs."

    Write-Host "Email sent."
}
if ($pstate -like '*Yes*') {
    Write-Host "Disk Failure Predicted! Sending email with logs..."
    #Send Email
    $secpasswd = ConvertTo-SecureString “PASSWORD” -AsPlainText -Force
    $mycreds = New-Object System.Management.Automation.PSCredential (“EMAIL@EMAIL.com”, $secpasswd)

    Send-MailMessage -from "frank@osi-networks.com" `
        -To "notify@orionsupport.net" `
        -Attachments "C:\RaidCheck\PhysicalDiskStatus.txt", "C:\RaidCheck\RaidStatus.txt" `
        -Subject "SERVER ALERT RAID DEGRADED" `
        -SmtpServer "mail.smtp2go.com" `
        -Credential $mycreds `
        -UseSsl `
        -Port "2525" `
        -Body "BOCAEXPB server Physical disk failure predicted - Check attached logs."

    Write-Host "Email sent."
}
if ($state -like '*Ok*') {
    Write-Host "Not degraded."
}
