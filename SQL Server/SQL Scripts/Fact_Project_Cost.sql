CREATE VIEW Fact_Project_Cost AS
SELECT 
    pc.Project_ID,
    pc.Original_Cost,
    pc.Proposed_Cost,
    pc.Total_Cost,
    pc.Cost_Analysis,
    p.Client_ID,
    p.Location_ID
FROM 
    project_cost pc
JOIN 
    project p ON p.Project_ID = pc.Project_ID;
