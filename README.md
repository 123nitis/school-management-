# School Management System Using MySQL

A relational database project built with MySQL to manage students, student profiles, teachers, classes, subjects, enrollments, and examination marks. The project demonstrates core SQL operations and relational database design.

## Entity Relationship Diagram

![School Management System ER Diagram](docs/er_diagram.png)

## Project Objectives

- Create and manage a relational database.
- Design tables with appropriate data types.
- Use primary keys and foreign keys.
- Demonstrate one-to-one and one-to-many relationships.
- Maintain referential integrity between related tables.
- Insert, retrieve, filter, and analyze records using SQL.
- Use joins and aggregate functions to answer school-related questions.
- Apply constraints to improve data consistency.

## Technology Used

- **Database:** MySQL
- **SQL client:** MySQL Workbench or MySQL Shell
- **Language:** SQL

## Database Tables

| Table | Purpose |
|---|---|
| `students` | Stores student names, gender, date of birth, contact details, admission date, and status. |
| `student_profiles` | Stores student address, blood group, and guardian details. |
| `teachers` | Stores teacher contact details, hire date, and salary. |
| `classes` | Stores class, section, academic year, room, and assigned class teacher. |
| `subjects` | Stores subject names/codes and the assigned teacher. |
| `enrollments` | Connects students to classes for a specific academic year. |
| `marks` | Stores exam marks for each enrollment and subject. |

## Relationships

- **Students → Student Profiles (one-to-one):** `student_profiles.student_id` is both a primary key and a foreign key referencing `students.student_id`.
- **Students → Enrollments (one-to-many):** A student can have enrollment records across different academic years. The unique constraint on `(student_id, academic_year)` prevents duplicate enrollment records for the same student and year.
- **Classes → Enrollments (one-to-many):** A class can contain multiple enrolled students.
- **Teachers → Classes (one-to-many):** `classes.class_teacher_id` references `teachers.teacher_id`.
- **Teachers → Subjects (one-to-many):** `subjects.teacher_id` references `teachers.teacher_id`.
- **Enrollments → Marks (one-to-many):** An enrollment can have marks for multiple subjects or exam types.
- **Subjects → Marks (one-to-many):** A subject can appear in many mark records.

## SQL Concepts Covered

- `CREATE DATABASE` and `CREATE TABLE`
- `PRIMARY KEY` and `FOREIGN KEY`
- Referential integrity and foreign-key delete actions
- One-to-one and one-to-many relationships
- Data types such as `INT`, `VARCHAR`, `CHAR`, `DATE`, `ENUM`, and `DECIMAL`
- Constraints: `NOT NULL`, `UNIQUE`, `DEFAULT`, and `CHECK`
- `INSERT`, `SELECT`, `UPDATE`, and `DELETE`
- Filtering with `WHERE`, `LIKE`, `BETWEEN`, and `IN`
- Sorting with `ORDER BY`
- `INNER JOIN` and `LEFT JOIN`
- Aggregation with `COUNT`, `AVG`, and `MAX`
- `GROUP BY`, `HAVING`, and `LIMIT`

## How to Run

1. Install MySQL and open MySQL Workbench or MySQL Shell.
2. Review `school_management.sql` before executing it.
3. Run the SQL script to create the database and tables, insert sample data, and execute example queries.
4. If you only want to inspect the database, run the table creation and data insertion sections first, then run the example queries as needed.
5. Refresh the Schemas panel and expand `school_management` to inspect the tables.

### Important safety note

The provided SQL script starts by dropping `school_management` before recreating it. **This permanently removes the existing database and its data if it already exists.** Back up any important data first, or remove/comment out the `DROP DATABASE` statement if you want to preserve the current database.

## Example Analysis Questions

- Which students are enrolled in each class?
- What marks did students receive in each subject?
- Which students scored above 80 or below 60?
- What is the average mark for each subject?
- What is the highest mark in each subject?
- How many students are enrolled in each class?
- Which teachers are assigned to each subject?

## Constraints and Data Integrity

The schema uses primary keys to uniquely identify rows and foreign keys to link related tables. Unique constraints prevent duplicate emails, subject codes, class/section/year combinations, student/year enrollments, and marks for the same enrollment/subject/exam type. Check constraints restrict values such as student status, enrollment status, nonnegative salary, and valid mark ranges.

## Possible Future Enhancements

- Add attendance and leave management.
- Add fee payments and invoices.
- Add exam schedules and report-card generation.
- Add a dedicated teacher-subject mapping table if subjects can be taught by multiple teachers.
- Connect the database to a Power BI dashboard or a web application.

## Project Files

- `school_management.sql` — database schema, sample records, and example SQL queries.
- `docs/er_diagram.png` — entity relationship diagram.

## Author

**Name:** Add your name here  
**GitHub:** Add your GitHub repository URL here  
**LinkedIn:** Add your LinkedIn profile URL here
