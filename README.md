# Healthcare Analytics and Patient Risk Indicator System

**Educational demonstration only.** Use synthetic data only. The project does not diagnose, predict clinically valid risk, or recommend treatment. Do not use its outputs for real patient-care decisions.

## Features
- Flask REST APIs for synthetic patients, visits, and measurements
- MySQL relational schema with foreign keys
- Basic validation for the invented `demo_score` measure (0–100 points)
- Department-wise visit summaries and operational counts
- Pandas data cleaning/grouping, NumPy statistics, Matplotlib charts
- Transparent illustrative indicator: `demo_score >= 80 points`
- JSON summary of indicator counts and distributions

## 1. Requirements
- Python 3.10+
- MySQL Server
- A terminal/command prompt

## 2. Create the database
Open MySQL Workbench or a MySQL terminal and run `schema.sql`.
The script creates the database, tables, departments, and a small synthetic sample dataset.

## 3. Install packages
In this project folder, create and activate a virtual environment if possible, then run:

```bash
python -m pip install -r requirements.txt
```

On Windows, a virtual environment can be created with:
```bash
python -m venv .venv
.venv\Scripts\activate
```

## 4. Configure the MySQL connection
Set environment variables to match your local MySQL account.

Windows Command Prompt:
```bat
set MYSQL_HOST=localhost
set MYSQL_USER=root
set MYSQL_PASSWORD=your_mysql_password
set MYSQL_DB=healthcare_analytics
```

PowerShell:
```powershell
$env:MYSQL_HOST="localhost"
$env:MYSQL_USER="root"
$env:MYSQL_PASSWORD="your_mysql_password"
$env:MYSQL_DB="healthcare_analytics"
```

Do not put a real password into source control. For a classroom demo, use a local database account with only the permissions needed by this project.

## 5. Run the app
```bash
python app.py
```
Open `http://127.0.0.1:5000/` in a browser. The server binds to localhost for local testing.

## 6. Test endpoints
Use Postman or curl.

- `GET http://127.0.0.1:5000/api/patients`
- `GET http://127.0.0.1:5000/api/visits`
- `GET http://127.0.0.1:5000/api/measurements`
- `GET http://127.0.0.1:5000/api/analytics/overview`
- `GET http://127.0.0.1:5000/api/analytics/departments`
- `GET http://127.0.0.1:5000/api/analytics/trends`
- `GET http://127.0.0.1:5000/api/analytics/report`
- `GET http://127.0.0.1:5000/api/indicators/summary`
- `POST http://127.0.0.1:5000/api/indicators/run`

Example POST body for a new patient:
```json
{
  "age_band": "18-39",
  "demographic_group": "sample_group_a"
}
```

Example POST body for a measurement:
```json
{
  "patient_id": 1,
  "measurement_date": "2026-10-15",
  "measure_type": "demo_score",
  "value": 72,
  "unit": "points"
}
```

The indicator runner inserts a flag for every matching measurement each time it runs. Repeated calls can create duplicate flags; this is explicitly disclosed for demonstration purposes.

## 7. Generated charts
Calling `GET /api/analytics/report` generates these files in the current working directory when corresponding data exists:
- `department_visits.png`
- `measurement_trend.png`

## Rule documentation
- Measurement type: `demo_score`
- Unit: points
- Allowed values: 0 through 100 inclusive
- Illustrative indicator: value greater than or equal to 80
- Purpose: demonstrate transparent rule evaluation and indicator aggregation only
- Clinical validity: none established; this is not a medical score

## Limitations and security
- All example rows are synthetic. Do not insert identifiable or real patient data.
- This starter project does not implement user login, role-based access control, audit logging, rate limiting, or production-grade security.
- Do not expose it to the internet as-is. A real deployment would require security review, authentication, authorization, encryption, audit controls, and privacy/legal review.
- The arbitrary demo score and threshold have no medical interpretation.
- Counts and charts describe only the sample data; they are not representative of a real hospital.
