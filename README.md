# University Academic Dashboard Pipeline

## 📋 Project Overview

This project demonstrates an end-to-end data engineering pipeline that takes relational database concepts from a laboratory environment and scales them into a dynamic data visualization asset. The core focus is translating SQL data definitions, primary/foreign key integrity, and relational multi-table join operations into an optimized semantic data model inside Power BI Desktop.

The dataset models a university academic environment tracking relationships between students, their course selections, and assigned faculty members.

---

## 🛠️ Tech Stack & Architecture

* **Database Engine:** Microsoft SQL Server 2022 (Express Edition)
* **Database Interface:** SQL Server Management Studio (SSMS)
* **Business Intelligence Tool:** Microsoft Power BI Desktop
* **Language:** T-SQL (Transact-SQL)

---

## 💾 Database Schema & Implementation (The Backend)

The schema is built on a relational architecture leveraging explicit primary keys (`PK`) and foreign keys (`FK`) to maintain strict referential integrity.

### Entity Relationship Structure

* **`Teacher` Table:** Stores unique faculty member records.
* **`Student` Table:** Stores student profiles.
* **`Course` Table:** Contains individual subjects. Links to the `Teacher` table via a 1-to-Many relationship using `teacher_id` as a foreign key.
* **`Student_course` Table:** A bridge/junction table resolving the Many-to-Many relationship between `Student` and `Course`.

```sql
-- 1. Setup the Database Environment
CREATE DATABASE UniversityDashboard;
GO
USE UniversityDashboard;
GO

-- 2. Create Relational Tables
CREATE TABLE Teacher (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Student (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE Course (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id)
);

CREATE TABLE Student_course (
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id)
);

```

### Relational Join Verification

To ensure data maps perfectly across the database schema, complex multi-table join queries (matching the relational concepts from the lab coursework) were validated to extract clean rows across multiple tables:

```sql
SELECT 
    s.first_name, 
    s.last_name, 
    c.name AS course_name,
    t.name AS teacher_name
FROM Student s
JOIN Student_course sc ON s.id = sc.student_id
JOIN Course c ON sc.course_id = c.id
JOIN Teacher t ON c.teacher_id = t.id;

```

---

## 📊 Semantic Modeling & Dashboard (The Frontend)

### 1. Data Connection Pipeline

Power BI Desktop connects directly to the local relational engine via an active SQL database connection link pointing to the default local instance (`.\SQLEXPRESS`). The data is pulled using **Import Mode** into memory for performance optimization.

### 2. The Data Model

Power BI automatically detects the foundational database metadata schema because foreign key tracking constraints were defined explicitly during the SQL DDL creation phase. The resulting structure creates an optimized **Snowflake/Star Schema** map inside the engine:

* `Teacher` (1) ➡️ `Course` (*)
* `Course` (1) ➡️ `Student_course` (*)
* `Student` (1) ➡️ `Student_course` (*)

### 3. Integrated Dashboard Visuals

* **Student Enrollment Distribution (Bar Chart):** A Stacked Column Chart combining data dynamically from the `Course` dimensions and counting cross-referenced rows from the `Student_course` facts table to rank class size.
* **Faculty Load Allocations (Data Grid):** A clean tabular visualization linking `Teacher[name]` directly with their correlated `Course[name]` values via automated relational schema mapping.
* **Global Course Filter Slicer:** An interactive control filtering every metric tile across the report page synchronously by exploiting row-level relationships across the connected tables.

---

## 🚀 Key Learning Takeaways

* **Referential Enforcement:** Demonstrated how defining foreign keys at the database layer prevents orphaned records and allows business intelligence systems to instantly infer data logic schemas.
* **Granular Normalization:** Utilized junction tables (`Student_course`) to break down complex transactional relationships into clean, bi-directional 1-to-Many logical maps.
* **End-to-End Delivery:** Completed the entire life cycle of data, migrating flat SQL data scripts smoothly into a production-grade, highly visual analytics workspace.

