# raidcheck
Pulls reports from Dell open manage on virtual and physical disk health. It will send out an email if it determines the raid is degraded or it if predicts a failure on one of the physical disks.  

Copy raidcheck folder to C drive  

Run the CreateRaidCheckTast.ps1 file first. It will check if a RaidCheck task exists, if it doesn't then it will create one.

-Task runs at 8am.
-If issues creating task, run RUNFIRSTifcreatetaskdoesntwork.bat first. Then check task scheduler to confirm task was created.

Edit within RaidCheck.ps1 script email body with the appropriate server name.  

Task Info: 

-The task will trigger the raidchecktrigger bat file to start RaidCheck.ps1  

-RaidCheck is going to write the current status of the physical drives and raid to PhysicalDiskStatus.txt and RaidStatus.txt.  
-It will check for any predicted failures on the physical disks and send email with logs if anything is found  
-It will then determine whether or not the current status of the raid is degraded. If it determines that the raid is degraded it will send out an email notification with the PhysicalDiskStatus.txt and RaidStatus.txt logs attached.
