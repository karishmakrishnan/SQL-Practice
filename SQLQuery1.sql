SELECT 
    SUSER_SNAME() AS LoginName,
    IS_SRVROLEMEMBER('sysadmin') AS IsSysAdmin;
