CREATE VIEW Dim_Project AS
SELECT 
    Project_ID,
    Client_ID,
    Domain,
    Name AS Project_Name,
    Project_Summary,
    Status,
    Upselling_Opportunity
FROM 
    project;
