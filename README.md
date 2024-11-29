# Data Analysis and ETL Pipeline for Business insights

## Table of Contents

- [Project Overview](#project-overview)
- [Tools](#Tools)
- [Data Sources](#data-sources)
- [ETL Process](#etl-process)
- [Data Cleaning & Transformation](#data-cleaning-transformation)
- [SQL Server Database Design](#sql-server-database-design)
- [Power BI Reporting](#power-bi-reporting)
- [Results and Insights](#results-and-insights)
- [Recommendations](#recommendations)
- [Challenges & Limitations](#challenges-and-limitations)
- [References](#references)

---

### Project Overview

This project demonstrates an **end-to-end data pipeline** that integrates data from multiple sources, cleans and transforms it, and then visualizes the insights using Power BI. The aim is to analyze sales and client interaction data, derive actionable insights, and assist with making business decisions.

The steps involved include:

1. **Data Integration**: Merging data from multiple sources like Upwork, LinkedIn, and Email into a master worksheet.
2. **ETL Process**: Extracting data from the Excel master sheet, transforming it into a more structured format, and loading it into SQL Server.
3. **SQL Server Database Design**: Creating smaller, normalized tables and relationships for optimized analysis.
4. **Power BI Reporting**: Visualizing data insights through Power BI dashboards and reports.

---

## Tools

This project leverages the following tools and technologies to extract, transform, load, and analyze data for business insights:

1. **Excel**  
   - **Purpose**: Data extraction, merging, and initial cleaning. Used for combining data from various sources (Upwork, LinkedIn, Email) into a master worksheet.  
   - **Key Features**: Formulas, data validation, and VBA macros for automating data updates.

2. **SQL Server**  
   - **Purpose**: Data storage, transformation, and normalization. The SQL Server database was designed to optimize data queries and enhance performance.  
   - **Key Features**: SQL Server Management Studio (SSMS) for database design and query execution, as well as automated data loading using SSIS.

3. **SQL Server Integration Services (SSIS)**  
   - **Purpose**: Automates the ETL process by transferring data from Excel to SQL Server on a scheduled basis.  
   - **Key Features**: Data flow tasks for efficient data import, transformation, and error handling.

4. **VBA (Visual Basic for Applications)**  
   - **Purpose**: Used to automate the process of updating the master worksheet whenever changes occur in the original data sources (Upwork, LinkedIn, Email).  
   - **Key Features**: Macros for real-time data synchronization across multiple sheets.

5. **Power BI**  
   - **Purpose**: Data visualization and reporting. Power BI was used to create interactive dashboards and reports to visualize business insights.  
   - **Key Features**: Importing data from SQL Server, creating interactive charts, and real-time dashboard updates.

6. **Visual Studio**  
   - **Purpose**: Used for creating and scheduling automated tasks. Visual Studio was used to create SQL Server jobs for running ETL processes at scheduled intervals.  
   - **Key Features**: Job creation, scheduling, and management using SQL Server Agent. Integration of custom scripts and tasks to automate data loading and processing.

7. **GitHub**  
   - **Purpose**: Version control and collaboration. GitHub was used to store and manage project code, documentation, and facilitate collaboration.  
   - **Key Features**: Branching, commits, pull requests, and version history for managing project development.
     
---

### Data Sources

The data sources for this project include:

1. **Upwork Data** (`upwork_worksheet.xlsx`): Contains project details such as domain, project summary, costs, and status.
2. **LinkedIn & Email Data** (`linkedin_email_worksheet.xlsx`): Includes client and project interaction details like designation, company, location, and responses.
3. **Master Dataset** (`master_worksheet.xlsx`): A merged dataset from Upwork, LinkedIn, and Email, with additional columns like project duration, client details, and cost analysis.

---

### ETL Process

1. **Extracting Data**:
 - The data is first loaded into the master worksheet where Upwork, LinkedIn, and Email sheets are merged.
 - Each row in the master sheet contains information about the project, client, and the corresponding interactions.

2. **Transformation**:
 - **VBA Macros**: Code was written in VBA to automatically update the master worksheet whenever there is a change in the Upwork, LinkedIn, or Email sheets.
 - The VBA code ensures that the latest changes in any of these sheets are reflected in the master worksheet.

3. **Loading Data**:
 - **SSIS (SQL Server Integration Services)** is used to automate the ETL process, transferring the data from the Excel master worksheet to SQL Server on a scheduled basis (every midnight).
 - SSIS ensures that the data in SQL Server is always up-to-date.


* * * * *

### Data Cleaning & Transformation

The data cleaning and transformation process involved several tasks:

1.  **Handling Missing Values**: Identified and handled missing or incomplete data entries across all datasets.
2.  **Data Formatting**: Ensured consistent formatting for dates, cost values, and email addresses.
3.  **Normalization**: Transformed the large master worksheet into smaller, normalized tables in SQL Server to improve data management and performance.

* * * * *

### SQL Server Database Design

Once the data was loaded into SQL Server, the following tables were created to store the data:

1.  **Client**: Stores client details such as Name, Email, Location, and Designation.
2.  **Client_Interaction**: Stores information related to client interactions such as responses and follow-up actions.
3.  **Project**: Stores project-related data including domain, project summary, duration, and status.
4.  **Project_Cost**: Stores financial details for each project, including original cost, proposed cost, and total cost.
5.  **Location**: Stores region/location details relevant to the projects.

### Relationships & Foreign Keys

Created foreign keys between the tables (e.g., `Client_Interaction` references `Client`, `Project_Cost` references `Project`). Defined relationships to ensure referential integrity and optimize data queries.

* * * * *

## Power BI Reporting

After transforming the data into SQL Server, it was imported into **Power BI** to generate meaningful visualizations.

1.  **Data Import**: Data was imported into Power BI via SQL Server views, allowing for dynamic querying.
2.  **Report Design**: Dashboards were created to present business insights such as:
    -   Revenue by Region
    -   Project Cost Analysis
    -   Client Interaction Overview

Power BI reports were designed to enable real-time updates as new data was loaded into SQL Server daily via SSIS.

* * * * *

## Results and Insights

The Power BI dashboards provided key insights into project costs, client distribution, project statuses, and responses. Below are the main findings:

### Total Cost by Region
- **Asia**: $0.22M
- **South America**: $0.20M
- **Europe**: $0.19M
- **North America**: $0.19M
- **Australia**: $0.02M

**Key Insight**: Focus on expanding in Asia-Pacific, as it has the highest project costs.

### Total Clients by Region
- **North America**: 26 clients
- **Asia**: 23 clients
- **Europe**: 20 clients
- **South America**: 18 clients
- **Australia**: 2 clients

**Key Insight**: Opportunity to grow in Australia, which has the lowest client count.

### Clients by Location in the USA
- **California** (San Francisco & Los Angeles) and **Florida** (Miami) have the highest concentrations of clients.

**Key Insight**: Use location-based data to target marketing efforts in high-density areas.

### Domain with Highest Cost
- **Digital**: $24K
- **Blockchain**: $21K
- **Data**: $20K

**Key Insight**: Focus on high-cost domains like Digital and Blockchain for future investments.

### Status of Projects
- **Negotiating**: 25.56% of projects
- **Declined**: 17.78% of projects

**Key Insight**: A large portion of projects is still in the negotiating phase, and there is room for improvement in project conversion rates.

### Count of Responses
- **Yes**: 27.78%
- **No**: 71.11%

**Key Insight**: A high number of negative responses indicates a need to improve proposals and engagement strategies.

### Highest Revenue by Client
- **Robert Martinez**: $72K
- **Sarah Miller**: $62K
- **Rachel Adams**: $53K

**Key Insight**: Clients with high lifetime value, like Robert Martinez, should be prioritized for retention.

### Cost Efficiency
- **Fluctuating Total Costs**: The sum of total costs fluctuates significantly across different projects.

**Key Insight**: Monitor cost efficiency regularly to ensure better budget management.

---

## Key Insights and Strategic Actions

1. **Focus on High-Performing Regions**: Prioritize expansion in **Asia** and **North America**, with **Australia** as a potential growth market.
2. **Target High-Value Clients for Retention**: Engage high-revenue clients like **Robert Martinez** and **Sarah Miller** for long-term business.
3. **Optimize Project Pipeline**: Convert projects in the **Negotiating** and **Interview** stages to active projects. Investigate reasons for declines.
4. **Improve Response Rates**: Refine project proposals to increase the "Yes" response rate.
5. **Cost Efficiency Monitoring**: Regularly track cost fluctuations to maintain profitability.
6. **Prioritize High-Cost Domains**: Invest further in **Digital** and **Blockchain** domains, which drive the highest costs and revenue.

These insights provide actionable recommendations to improve business performance, enhance client engagement, and optimize project management.


* * * * *

### Challenges & Limitations

1.  **Data Quality**: Some missing and inconsistent data required manual cleaning, and outliers were removed to maintain the integrity of the analysis.
2.  **ETL Process Complexity**: Automating the ETL pipeline with SSIS had a learning curve, especially when dealing with scheduling and error handling.
3.  **Performance Issues**: Handling large datasets and creating efficient views in SQL Server required optimizing queries and ensuring performance was not impacted.

* * * * *

### References

1.  [Stack Overflow](https://stackoverflow.com/)
2.  [SQL Server Documentation](https://docs.microsoft.com/en-us/sql/sql-server/)
3.  [Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)
