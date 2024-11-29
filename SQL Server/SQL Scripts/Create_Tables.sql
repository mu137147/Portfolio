-- Create Location Table
CREATE TABLE Location (
    Location_ID INT PRIMARY KEY IDENTITY,
    Region NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255) NOT NULL
);

-- Create Client Table
CREATE TABLE Client (
    Client_ID INT PRIMARY KEY IDENTITY,
    Location_ID INT FOREIGN KEY REFERENCES Location(Location_ID),
    Client_Name NVARCHAR(255) NOT NULL,
    Designation NVARCHAR(255),
    Company NVARCHAR(255),
    LinkedIn_Profile NVARCHAR(255),
    Email NVARCHAR(255)
);

-- Create Project Table
CREATE TABLE Project (
    Project_ID INT PRIMARY KEY IDENTITY,
    Client_ID INT FOREIGN KEY REFERENCES Client(Client_ID),
    Location_ID INT FOREIGN KEY REFERENCES Location(Location_ID),
    Domain NVARCHAR(255),
    Name NVARCHAR(255) NOT NULL,
    Project_Summary NVARCHAR(MAX),
    Status NVARCHAR(255),
    Upselling_Opportunity NVARCHAR(255)
);

-- Create Project_Cost Table
CREATE TABLE Project_Cost (
    Project_Cost_ID INT PRIMARY KEY IDENTITY,
    Project_ID INT FOREIGN KEY REFERENCES Project(Project_ID),
    Original_Cost INT,
    Proposed_Cost INT,
    Total_Cost INT,
    Cost_Analysis NVARCHAR(255)
);

-- Create Client_Interaction Table
CREATE TABLE Client_Interaction (
    Interaction_ID INT PRIMARY KEY IDENTITY,
    Client_ID INT FOREIGN KEY REFERENCES Client(Client_ID),
    F1 NVARCHAR(255),
    F2 NVARCHAR(255)
);

-- Create MasterWorksheet Table
CREATE TABLE MasterWorksheet (
    Master_ID INT PRIMARY KEY IDENTITY,
    Region NVARCHAR(255),
    Location NVARCHAR(255),
    Name NVARCHAR(255),
    Designation NVARCHAR(255),
    Company NVARCHAR(255),
    LinkedInProfile NVARCHAR(255),
    Email NVARCHAR(255),
    Domain NVARCHAR(255),
    Project_Summary NVARCHAR(MAX),
    Response NVARCHAR(255),
    Duration INT,
    Status NVARCHAR(255),
    Upselling_Opportunity NVARCHAR(255),
    Original_Cost INT,
    Proposed_Cost INT,
    Total_Cost INT,
    Cost_Analysis NVARCHAR(255),
    F1 NVARCHAR(255),
    F2 NVARCHAR(255)
);
