NOTE: This only works for DELL servers with OpenManage installed. IF OpenManage is not installed, use the following command to obtain the server serial number: 

wmic bios get serialnumber

Visit https://www.dell.com/support/home/en-us?app=drivers and copy serial number into search. After hitting search use OMSA as a keyword to search for the appropriate openmanage version and download.




Copy raidcheck folder to C drive

Run the CreateRaidCheckTast.ps1 file first. It will check if a RaidCheck task exists, if it doesn't then it will create one.
	-Task runs at 8am.
	-If issues creating task, run RUNFIRSTifcreatetaskdoesntwork.bat first. Then check task scheduler to confirm task was created.

Edit RaidCheck.ps1 email body with the appropriate server name.


Task Info:
-The task will trigger the raidchecktrigger bat file to start RaidCheck.ps1

-RaidCheck is going to write the current status of the physical drives and raid to PhysicalDiskStatus.txt
 and RaidStatus.txt. 

-It will check for any predicted failures on the physical disks and send email with logs if anything is found

-It will then determine whether or not the current status of the raid is degraded.
 If it determines that the raid is degraded it will send out an email notification with the PhysicalDiskStatus.txt
 and RaidStatus.txt logs attached.