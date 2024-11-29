CREATE PROCEDURE dbo.ProcessMasterWorksheet
AS
BEGIN
    DECLARE @loc_id INT;
    DECLARE @cli_id INT;
    DECLARE @proj_id INT;

    -- Loop through each inserted row
    DECLARE InsertedCursor CURSOR FOR
    SELECT Region, Location, Name, Designation, Company, LinkedInProfile, Email,
           Domain, Project_Summary, Response, Duration, Status, Upselling_Opportunity,
           Original_Cost, Proposed_Cost, Total_Cost, Cost_Analysis, F1, F2
    FROM masterworksheet;

    OPEN InsertedCursor;

    DECLARE @Region NVARCHAR(255), @Location NVARCHAR(255), @Name NVARCHAR(255),
            @Designation NVARCHAR(255), @Company NVARCHAR(255), @LinkedInProfile NVARCHAR(255),
            @Email NVARCHAR(255), @Domain NVARCHAR(255), @Project_Summary NVARCHAR(MAX),
            @Response NVARCHAR(255), @Duration INT, @Status NVARCHAR(255),
            @Upselling_Opportunity NVARCHAR(255), @Original_Cost INT,
            @Proposed_Cost INT, @Total_Cost INT, @Cost_Analysis NVARCHAR(255),
            @F1 NVARCHAR(255), @F2 NVARCHAR(255);

    FETCH NEXT FROM InsertedCursor INTO @Region, @Location, @Name, @Designation, @Company,
                                         @LinkedInProfile, @Email, @Domain, @Project_Summary,
                                         @Response, @Duration, @Status, @Upselling_Opportunity,
                                         @Original_Cost, @Proposed_Cost, @Total_Cost,
                                         @Cost_Analysis, @F1, @F2;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insert or Update Location
        IF EXISTS (SELECT 1 FROM Location WHERE Region = @Region AND Location = @Location)
        BEGIN
            SELECT @loc_id = Location_ID FROM Location WHERE Region = @Region AND Location = @Location;
        END
        ELSE
        BEGIN
            INSERT INTO Location (Region, Location) VALUES (@Region, @Location);
            SELECT @loc_id = SCOPE_IDENTITY();
        END

        -- Insert or Update Client
        IF EXISTS (SELECT 1 FROM Client WHERE Client_Name = @Name AND Email = @Email)
        BEGIN
            SELECT @cli_id = Client_ID FROM Client WHERE Client_Name = @Name AND Email = @Email;
        END
        ELSE
        BEGIN
            INSERT INTO Client (Location_ID, Client_Name, Designation, Company, LinkedIn_Profile, Email)
            VALUES (@loc_id, @Name, @Designation, @Company, @LinkedInProfile, @Email);
            SELECT @cli_id = SCOPE_IDENTITY();
        END

        -- Insert or Update Project
        IF EXISTS (SELECT 1 FROM Project WHERE Client_ID = @cli_id AND Name = @Name)
        BEGIN
            SELECT @proj_id = Project_ID FROM Project WHERE Client_ID = @cli_id AND Name = @Name;
        END
        ELSE
        BEGIN
            INSERT INTO Project (Client_ID, Location_ID, Domain, Name, Project_Summary, Response, Duration, Status, Upselling_Opportunity)
            VALUES (@cli_id, @loc_id, @Domain, @Name, @Project_Summary, @Response, @Duration, @Status, @Upselling_Opportunity);
            SELECT @proj_id = SCOPE_IDENTITY();
        END

        -- Insert or Update Project_Cost
        IF EXISTS (SELECT 1 FROM Project_Cost WHERE Project_ID = @proj_id)
        BEGIN
            UPDATE Project_Cost
            SET Original_Cost = @Original_Cost,
                Proposed_Cost = @Proposed_Cost,
                Total_Cost = @Total_Cost,
                Cost_Analysis = @Cost_Analysis
            WHERE Project_ID = @proj_id;
        END
        ELSE
        BEGIN
            INSERT INTO Project_Cost (Project_ID, Original_Cost, Proposed_Cost, Total_Cost, Cost_Analysis)
            VALUES (@proj_id, @Original_Cost, @Proposed_Cost, @Total_Cost, @Cost_Analysis);
        END

        -- Insert Client_Interaction (assumes new interaction per load)
        INSERT INTO Client_Interaction (Client_ID, F1, F2)
        VALUES (@cli_id, @F1, @F2);

        -- Fetch next row
        FETCH NEXT FROM InsertedCursor INTO @Region, @Location, @Name, @Designation, @Company,
                                             @LinkedInProfile, @Email, @Domain, @Project_Summary,
                                             @Response, @Duration, @Status, @Upselling_Opportunity,
                                             @Original_Cost, @Proposed_Cost, @Total_Cost,
                                             @Cost_Analysis, @F1, @F2;
    END

    CLOSE InsertedCursor;
    DEALLOCATE InsertedCursor;
END;
