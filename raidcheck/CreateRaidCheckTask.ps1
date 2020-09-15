if (!(schtasks /query /TN Raidcheck)){
    schtasks /Create /SC DAILY /TR “C:\RaidCheck\raidchecktrigger.bat” /TN RaidCheck /ST “08:00:00” /NP /RU “NT authority\local service” /RL HIGHEST
}