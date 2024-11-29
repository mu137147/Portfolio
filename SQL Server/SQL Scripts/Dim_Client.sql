CREATE VIEW Dim_Client AS
SELECT 
    Client_ID,
    Client_Name,
    Designation,
    Company,
    LinkedIn_Profile,
    Email
FROM 
    client;
