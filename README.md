# Aussie Property Lakehouse

This project implements an end-to-end data engineering pipeline for analysing Australian property prices and population density. The pipeline ingests raw datasets, processes them through multiple transformation stages, and loads the final analytical dataset into a PostgreSQL data warehouse.

The purpose of this project is to demonstrate a simplified lakehouse-style data architecture and show how raw data can be transformed into analytics-ready datasets using Python, SQL, and containerised databases.

---

## Project Overview

Housing affordability is a major economic and social issue in Australia, particularly in large metropolitan areas such as Sydney and Melbourne. Understanding how housing prices relate to population density can provide insights into urban development patterns and property market dynamics.

This project combines two datasets:

- Property price data by suburb
- Population density data by suburb

After cleaning and transformation, the datasets are joined to produce an analytical dataset that enables exploration of how property prices relate to urban density.

---

## Architecture

The pipeline follows a layered architecture inspired by the modern lakehouse approach.

Raw Data → Bronze Layer → Silver Layer → Gold Layer → PostgreSQL Analytics Table

Layer responsibilities:

Bronze Layer  
Raw ingestion of source datasets without modification.

Silver Layer  
Data cleaning, formatting, and schema standardisation.

Gold Layer  
Creation of an analytics-ready dataset combining property prices and population density.

The final dataset is loaded into PostgreSQL for SQL-based analysis.

---

## Technology Stack

Python  
Pandas  
PostgreSQL  
Docker  
Git  

Python is used to implement the ETL pipeline and transformation logic.  
Pandas is used for data processing and dataset manipulation.  
PostgreSQL acts as the analytics database.  
Docker runs the database locally in a containerised environment.

---

## Project Structure

```
aussie-property-lakehouse

data
 ├─ raw
 │   ├─ property_prices.csv
 │   └─ population_density.csv
 │
 └─ gold
     └─ suburb_property_density_analysis.csv

src
 ├─ etl
 │   ├─ bronze_layer.py
 │   └─ silver_layer.py
 │
 ├─ transform
 │   └─ build_gold_table.py
 │
 └─ pipeline
     └─ run_pipeline.py

docker-compose.yml
requirements.txt
README.md
```

---

## Running the Project

Start the PostgreSQL container:

```
docker compose up -d
```

Run the data pipeline:

```
python3 -m src.pipeline.run_pipeline
```

The pipeline performs the following steps:

1. Load raw property and population datasets  
2. Clean and standardise the datasets  
3. Merge the datasets into a unified analytical dataset  
4. Generate derived metrics  
5. Load the final dataset into PostgreSQL

---

## Database Output

The final analytical dataset is stored in the PostgreSQL table:

```
suburb_property_analysis
```

Table schema:

city  
suburb  
median_price  
month  
population_density  
price_per_density  

The `price_per_density` column represents a derived metric that compares housing prices relative to local population density.

---

## Example SQL Query

Retrieve all records from the analytical table:

```
SELECT *
FROM suburb_property_analysis;
```

Example analytical query:

```
SELECT suburb, price_per_density
FROM suburb_property_analysis
ORDER BY price_per_density DESC;
```

This query highlights suburbs where housing prices are high relative to population density.

---

## Example Output

city        suburb      median_price    population_density    price_per_density

Sydney      Parramatta      1200000             3200               375  
Sydney      Chatswood       1800000             4100               439  
Melbourne   Box Hill        1350000             2900               465  
Melbourne   Clayton          980000             2500               392  

---

## Future Improvements

Potential improvements for a production-level pipeline include:

- Integrating Airflow for pipeline orchestration  
- Storing raw data in cloud storage such as AWS S3  
- Using dbt for transformation management  
- Adding automated data validation and quality checks  
- Building dashboards for downstream analytics

---

## Author

Leo Zhang  
Master of Data Science  
Monash University

GitHub  
https://github.com/leo-zhang101
