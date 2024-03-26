# EAE Trabajo Final - [link](marketing.md)

The final project focused on designing a normalized relational database with two connected tables on a marketing theme. It includes exercises to create the SQL tables, define relationships, insert sample data, update records with cascading changes, join the tables in different ways, and explain the types of data returned from inner and outer joins. 

# Marketing Database

This repository contains a relational database schema for managing marketing campaigns and customer interactions. The database consists of two tables: `Campaigns` and `Interactions`.

## Table Descriptions

### Campaigns

The `Campaigns` table stores information about marketing campaigns, including details such as campaign name, type, start and end dates, budget, objective, channels used, target audience, status, results, and notes.

| Column Name      | Data Type      | Description                                                  |
|-------------------|-----------------|--------------------------------------------------------------|
| `Campaign_ID`     | `INT`           | Primary key, unique identifier for each campaign             |
| `Campaign_Name`   | `NVARCHAR(100)` | Name of the marketing campaign                               |
| `Campaign_Type`   | `NVARCHAR(50)`  | Type of the campaign (e.g., promotion, product launch, etc.)|
| `Start_Date`      | `DATETIME`      | Start date of the campaign                                   |
| `End_Date`        | `DATETIME`      | End date of the campaign                                     |
| `Budget`          | `DECIMAL(18,2)` | Budget allocated for the campaign                            |
| `Objective`       | `NVARCHAR(100)` | Primary objective of the campaign                            |
| `Channels_Used`   | `NVARCHAR(200)` | Marketing channels used for the campaign                     |
| `Target_Audience` | `NVARCHAR(200)` | Target audience for the campaign                             |
| `Status`          | `NVARCHAR(50)`  | Current status of the campaign (e.g., active, completed)    |
| `Results`         | `NVARCHAR(200)` | Summary of the campaign results                              |
| `Notes`           | `NVARCHAR(MAX)` | Additional notes or comments about the campaign             |

### Interactions

The `Interactions` table stores details about individual customer interactions with marketing campaigns, such as interaction type, timestamp, channel, response action, outcome, engagement duration, device used, and location.

| Column Name          | Data Type       | Description                                                  |
|-----------------------|------------------|--------------------------------------------------------------|
| `Interaction_ID`      | `INT`            | Primary key, unique identifier for each interaction         |
| `Customer_ID`         | `INT`            | Identifier for the customer involved in the interaction     |
| `Campaign_ID`         | `INT`            | Foreign key referencing the `Campaign_ID` in `Campaigns` table, with `ON UPDATE CASCADE` constraint |
| `Interaction_Type`    | `NVARCHAR(50)`   | Type of interaction (e.g., click, open, purchase)           |
| `Interaction_Timestamp` | `DATETIME`     | Timestamp of when the interaction occurred                  |
| `Channel`             | `NVARCHAR(50)`   | Marketing channel through which the interaction took place   |
| `Response_Action`     | `NVARCHAR(100)`  | Action taken by the customer in response to the interaction |
| `Outcome`             | `NVARCHAR(100)`  | Outcome of the interaction (e.g., engaged, successful purchase) |
| `Engagement_Duration` | `INT`            | Duration of the customer's engagement (in seconds)          |
| `Device_Used`         | `NVARCHAR(50)`   | Device used by the customer during the interaction          |
| `Location`            | `NVARCHAR(100)`  | Location of the customer during the interaction             |

## Relationship

The relationship between the `Campaigns` and `Interactions` tables is one-to-many. A single campaign can have multiple interactions, but each interaction is associated with only one campaign. The `Campaign_ID` column in the `Interactions` table is a foreign key that references the `Campaign_ID` primary key in the `Campaigns` table. The `ON UPDATE CASCADE` constraint ensures that if a `Campaign_ID` value is updated in the `Campaigns` table, the corresponding `Campaign_ID` values in the `Interactions` table are automatically updated.