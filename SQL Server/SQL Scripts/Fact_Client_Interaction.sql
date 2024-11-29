CREATE VIEW Fact_Client_Interaction AS
SELECT 
    ci.Interaction_ID,
    ci.Client_ID,
    ci.F1 AS First_Follow_Up,
    ci.F2 AS Second_Follow_Up,
    c.Location_ID
FROM 
    client_interaction ci
JOIN 
    client c ON ci.Client_ID = c.Client_ID;
