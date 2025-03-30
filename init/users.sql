CREATE LOGIN tester WITH PASSWORD = 'R8j_xL2_zMpQ4_vW';

-- USE TestForDarcy;
GO

CREATE USER tester_user for LOGIN tester;
GO

ALTER SERVER ROLE dbcreator ADD MEMBER tester;
GO