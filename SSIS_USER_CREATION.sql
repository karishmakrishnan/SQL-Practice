USE master;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '@$ghrET%1234';

SELECT * FROM SSISDB.catalog.catalog_properties;

SELECT name FROM SSISDB.sys.databases;

USE SSISDB;

-- To grant full admin access:
ALTER ROLE ssis_admin ADD MEMBER [DIR\karishma.k.krishnan];

-- Or, to grant limited user access:
-- ALTER ROLE ssis_user ADD MEMBER [YourLoginName];

USE SSISDB;
CREATE USER [DIR\karishma.k.krishnan] FOR LOGIN [DIR\karishma.k.krishnan];

ALTER ROLE ssis_admin ADD MEMBER [DIR\karishma.k.krishnan];

USE SSISDB;
SELECT dp.name AS UserName, rp.role_principal_id AS RoleID, r.name AS RoleName
FROM sys.database_principals dp
JOIN sys.database_role_members rp ON dp.principal_id = rp.member_principal_id
JOIN sys.database_principals r ON rp.role_principal_id = r.principal_id
WHERE dp.name = 'DIR\karishma.k.krishnan';
