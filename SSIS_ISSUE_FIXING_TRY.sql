USE SSISDB;
SELECT dp.name AS UserName, rp.role_principal_id AS RoleID, r.name AS RoleName
FROM sys.database_principals dp
JOIN sys.database_role_members rp ON dp.principal_id = rp.member_principal_id
JOIN sys.database_principals r ON rp.role_principal_id = r.principal_id
WHERE dp.name = 'DIR\karishma.k.krishnan';

SELECT SERVERPROPERTY('ProductVersion'), SERVERPROPERTY('Edition');

--Manual folder creation
USE SSISDB;
EXEC catalog.create_folder 
    @folder_name = N'Test', 
    @folder_description = N'Test SSIS Package';

	USE master;
GO
ALTER DATABASE SSISDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE SSISDB;
GO

SELECT 
    SERVERPROPERTY('InstanceDefaultDataPath') AS DataPath,
    SERVERPROPERTY('InstanceDefaultLogPath')  AS LogPath;



