# DMDD_THE_LINE

## Objective

The objective of this project is to develop a database system capable of tracking and analyzing the number of passengers on trains throughout the Boston train network. This system will focus on identifying peak hours during which trains experience the highest population densities. The insights gained will aid in strategic decision-making related to train schedules, fleet management, and infrastructure development

## Setup Instructions

- Clone or Download the Project Repository
- Run `0_Grants.sql` to set up initial user permissions and grants. This script configures the necessary access for users to interact with the database.

### Schema Creation and Data Preparation

- Execute `1_Data_Scrubbing_Tables.sql` and `2_Data_Scrubbing_Sequances.sql` to prepare the database schema with tables and sequences needed for data scrubbing.
- Use `3_Table_Creation.sql` to create the main tables in the database schema.

### Data Insertion

Sequentially run the insertion scripts to populate the database with initial data:

- `4_Insertion_Holiday.sql`
- `5_Insertion_Train.sql`
- `6_Insertion_Passenger.sql`
- `7_Insertion_Station.sql`
- `8_Insertion_Schedule.sql`
- `9_Insertion_Transaction.sql`

### Creating Views

- Finally, `10_Views.sql` should be executed to create views that simplify data access and reporting.


Testing --Prajwal new mac
