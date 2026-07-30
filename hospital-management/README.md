# Digital Hospital and Patient Management System

A Java web application (JSP + Servlets + JDBC + MySQL, built with Maven) implementing
patient registration, doctor-doctor appointment booking with conflict prevention,
electronic medical records, auto-generated billing, and an admin analytics dashboard.

## Tech Stack
- Java 25 LTS
- Jakarta Servlets & JSP
- JDBC (MySQL Connector/J)
- MySQL 8
- Maven
- Apache Tomcat 10+ (Jakarta EE 9+ namespace — `jakarta.servlet.*`)
- jBCrypt (password hashing)

## Project Structure
```
hospital-management/
├── pom.xml
├── database/
│   └── schema.sql              -- run this first to create the database
└── src/main/
    ├── java/com/hospital/
    │   ├── model/               -- Patient, Doctor, Appointment, MedicalRecord, Prescription, Bill
    │   ├── dao/                 -- database access classes (one per entity)
    │   ├── servlet/             -- request handlers
    │   └── util/                -- DBConnection, PasswordUtil
    ├── resources/
    └── webapp/
        ├── WEB-INF/web.xml
        ├── css/style.css
        └── *.jsp                -- all pages
```

## Setup Instructions

### 1. Create the database
```bash
mysql -u root -p < database/schema.sql
```
This creates the `hospital_db` database, all tables, and seeds 3 sample doctors + 1 admin
(username: `admin`, password: `admin123` — **change this before any real deployment**).

### 2. Configure the database connection
Edit `src/main/java/com/hospital/util/DBConnection.java` and update:
```java
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_mysql_password";
```

### 3. Build the WAR file
```bash
mvn clean package
```
This produces `target/hospital-management.war`.

### 4. Deploy to Tomcat
Copy the WAR file into Tomcat's `webapps/` folder, or deploy it through your IDE's
Tomcat integration. Then visit:
```
http://localhost:8080/hospital-management/
```

### 5. Run locally with embedded Tomcat
If you do not have a standalone Tomcat installation, use the embedded server
included in the project for local development.

```bash
mvn clean package dependency:copy-dependencies -DoutputDirectory=target/dependency
java -cp "target/classes;target/dependency/*" com.hospital.embedded.EmbeddedTomcatServer --war target/hospital-management.war --port 8080
```

Then open:
```
http://localhost:8080/hospital-management/
```

## Default Login Accounts (from seed data)
| Role | Email/Username | Password |
|---|---|---|
| Admin | admin | admin123 |
| Doctor | aman.sharma@hospital.com | admin123 |
| Doctor | neha.verma@hospital.com | admin123 |
| Doctor | rohit.singh@hospital.com | admin123 |

New patients register themselves via the "Register" page.

## What's implemented (matches the report's proposed system)
- Patient registration & login (password hashed with bcrypt)
- Doctor & admin login
- Doctor search (by specialization) and appointment booking
- **Slot-conflict prevention**: a database UNIQUE KEY on (doctor_id, visit_date, visit_time)
  guarantees two patients can never book the same doctor at the same time, even under
  concurrent requests — this is enforced at the database level, not just in application code.
- Doctor consultation completion: diagnosis + prescriptions, saved together with an
  **auto-generated bill** in a single database transaction (see `MedicalRecordDAO.completeConsultation`)
  — if any part fails, nothing is saved, so bills can never exist without a matching medical record.
- Patient dashboard: appointment history, medical history, and bills
- Admin dashboard: total patients, total doctors, today's appointments, total revenue

## What you'll likely want to add for a fuller submission
- Input validation feedback shown more prominently (client-side JS validation)
- Doctor availability/schedule management (currently fixed 9am-5pm in the schema, not enforced in booking)
- Edit/cancel appointment functionality
- Pagination for large record lists
- A proper "pay bill" action (currently `BillDAO.markAsPaid` exists but has no UI button wired up — easy to add)
- Unit tests (JUnit) for the DAO layer — this is exactly what Chapter 4's "Testing Techniques" section asks for
