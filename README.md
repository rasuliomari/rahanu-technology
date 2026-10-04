# RAHANU TECHNOLOGY

A professional company website and management system developed for **RAHANU TECHNOLOGY** using Java Servlet/JSP, Bootstrap, PostgreSQL, Maven, and Apache Tomcat.

The system presents the company's services, projects, team members, and contact information. It also provides an administrator dashboard for managing website content.

---

## 1. Project Overview

**RAHANU TECHNOLOGY** provides technology and cybersecurity services including:

* Website Development
* Mobile Application Development
* Penetration Testing
* Cybersecurity Services
* Digital Forensics
* Network and Technology Solutions

The application allows visitors to view company information and allows administrators to manage website content through a secure administration panel.

---

## 2. Technologies Used

### Backend

* Java
* Jakarta Servlet
* JSP
* JSTL
* JDBC
* PostgreSQL

### Frontend

* HTML5
* CSS3
* JavaScript
* Bootstrap 5.3.3
* Bootstrap Icons

### Development Tools

* Apache Maven
* Apache Tomcat 10.1.59
* PostgreSQL
* Visual Studio Code
* Git

### Operating System

The application was developed and tested on Linux/Kali Linux.

---

## 3. System Requirements

Before running the project, install:

* Java JDK 17 or later
* Apache Maven
* PostgreSQL
* Apache Tomcat 10+
* Git
* Web browser

Check the installed versions:

```bash
java -version
```

```bash
mvn -version
```

```bash
psql --version
```

```bash
/opt/tomcat/bin/version.sh
```

---

## 4. Project Location

The default project location is:

```text
~/Documents/rahanu-technology
```

Move into the project:

```bash
cd ~/Documents/rahanu-technology
```

---

## 5. Project Structure

```text
rahanu-technology/
│
├── database/
│   ├── schema.sql
│   └── seed.sql
│
├── docs/
│
├── config/
│   └── .env.example
│
├── scripts/
│   └── setup.sh
│
├── storage/
│   └── .gitkeep
│
├── src/
│   └── main/
│       ├── java/
│       │   └── tz/
│       │       └── rahanu/
│       │           └── technology/
│       │               ├── controller/
│       │               ├── dao/
│       │               ├── model/
│       │               └── util/
│       │
│       └── webapp/
│           ├── admin/
│           ├── css/
│           ├── includes/
│           ├── js/
│           ├── index.jsp
│           ├── services.jsp
│           ├── projects.jsp
│           ├── team.jsp
│           └── contact.jsp
│
├── pom.xml
├── README.md
└── .gitignore
```

---

# 6. Database Configuration

The application uses PostgreSQL.

### Database name

```text
rahanu_technology
```

### Database user

```text
rahanu_admin
```

### JDBC URL

```text
jdbc:postgresql://localhost:5432/rahanu_technology
```

---

## 7. Create the Database

If the database does not already exist, create it using:

```bash
sudo -u postgres psql
```

Then:

```sql
CREATE DATABASE rahanu_technology;
```

Create the application user:

```sql
CREATE USER rahanu_admin WITH PASSWORD 'ChangeThisPassword123!';
```

Grant access:

```sql
GRANT ALL PRIVILEGES ON DATABASE rahanu_technology TO rahanu_admin;
```

Exit PostgreSQL:

```sql
\q
```

---

## 8. Database Tables

The application uses the following main tables:

```text
team_members
services
projects
contact_messages
admin_users
```

### team_members

Stores company team members.

Important fields include:

```text
id
full_name
position
role_type
biography
skills
photo
linkedin_url
github_url
display_order
is_active
created_at
```

### services

Stores company services.

```text
id
title
slug
short_description
description
icon
image
display_order
is_featured
is_active
created_at
```

### projects

Stores company projects.

```text
id
title
slug
short_description
description
technologies
image
github_url
live_url
project_date
status
is_featured
created_at
```

### contact_messages

Stores messages submitted through the contact form.

```text
id
full_name
email
phone
subject
message
is_read
created_at
```

### admin_users

Stores administrator accounts.

```text
id
username
password_hash
full_name
is_active
created_at
```

---

# 9. Initial Database Setup

For a **new installation only**, the database schema can be created using:

```bash
cd ~/Documents/rahanu-technology
```

```bash
sudo -u postgres psql -d rahanu_technology \
-f database/schema.sql
```

Initial data can then be inserted using:

```bash
sudo -u postgres psql -d rahanu_technology \
-f database/seed.sql
```

### IMPORTANT

The `schema.sql` and `seed.sql` files are intended for **initial database setup**.

Do **NOT** repeatedly execute them on an existing installation unless you have confirmed that they are safe for the existing data.

Do not run them after every Maven build or Tomcat restart.

Normal application operations should never require recreating the database.

---

# 10. Database Persistence

PostgreSQL stores the application data independently from the Java WAR file.

The following operations should NOT delete application data:

```bash
mvn clean package
```

```bash
sudo /opt/tomcat/bin/shutdown.sh
```

```bash
sudo /opt/tomcat/bin/startup.sh
```

Replacing the application WAR should also not delete PostgreSQL data.

The database should remain persistent across application deployments.

---

# 11. Database Environment Variables

The application supports environment variables for database configuration.

Tomcat configuration:

```text
/opt/tomcat/bin/setenv.sh
```

Current configuration:

```bash
#!/bin/sh

export RAHANU_APP_NAME="rahanu-technology"

export RAHANU_DB_NAME="rahanu_technology"
export RAHANU_DB_USER="rahanu_admin"
export RAHANU_DB_PASSWORD="ChangeThisPassword123!"
export RAHANU_DB_URL="jdbc:postgresql://localhost:5432/rahanu_technology"

export RAHANU_TEAM_UPLOAD_DIR="/opt/rahanu-technology-data/team"
```

Set appropriate permissions:

```bash
sudo chmod 750 /opt/tomcat/bin/setenv.sh
```

Restart Tomcat after changing the environment:

```bash
sudo /opt/tomcat/bin/shutdown.sh
sleep 5
sudo /opt/tomcat/bin/startup.sh
```

---

# 12. Database Connection

The Java application uses:

```text
src/main/java/tz/rahanu/technology/util/DBConnection.java
```

The application first checks environment variables.

For example:

```text
RAHANU_DB_URL
RAHANU_DB_USER
RAHANU_DB_PASSWORD
```

If the variables are unavailable, the application can use its configured default values.

For production, environment variables should be preferred.

---

# 13. Verify Database Connection

Test PostgreSQL directly:

```bash
PGPASSWORD='ChangeThisPassword123!' psql \
-h 127.0.0.1 \
-U rahanu_admin \
-d rahanu_technology \
-c "SELECT current_user, current_database();"
```

Expected result:

```text
 current_user | current_database
--------------+------------------
 rahanu_admin | rahanu_technology
```

Check the tables:

```bash
sudo -u postgres psql -d rahanu_technology -c "\dt"
```

---

# 14. Build the Application

Go to the project directory:

```bash
cd ~/Documents/rahanu-technology
```

Clean and build:

```bash
mvn clean package
```

The generated WAR file should be:

```text
target/rahanu-technology.war
```

---

# 15. Deploy to Apache Tomcat

Tomcat is installed at:

```text
/opt/tomcat
```

Stop Tomcat:

```bash
sudo /opt/tomcat/bin/shutdown.sh
```

Wait:

```bash
sleep 5
```

Remove the old exploded application:

```bash
sudo rm -rf /opt/tomcat/webapps/rahanu-technology
```

Remove the old WAR:

```bash
sudo rm -f /opt/tomcat/webapps/rahanu-technology.war
```

Copy the new WAR:

```bash
sudo cp target/rahanu-technology.war \
/opt/tomcat/webapps/
```

Start Tomcat:

```bash
sudo /opt/tomcat/bin/startup.sh
```

Wait for deployment:

```bash
sleep 10
```

---

# 16. Application URL

The main application is available at:

```text
http://localhost:8080/rahanu-technology/
```

Main pages include:

```text
/
 /services
 /projects
 /team
 /contact
```

---

# 17. Administrator Login

Administrator login:

```text
http://localhost:8080/rahanu-technology/admin/login
```

After successful authentication, the administrator is redirected to:

```text
/admin/dashboard
```

The administrator dashboard provides access to:

```text
Dashboard
Team
Projects
Services
Messages
Settings
Logout
```

---

# 18. Administrator Security

Administrator passwords are not stored as plain text.

The application uses:

```text
PBKDF2WithHmacSHA256
```

The password storage format contains:

```text
iterations:salt:hash
```

The application verifies the password using `PasswordUtil`.

The password should never be stored directly in the database.

---

# 19. Team Management

Team members are stored in:

```text
team_members
```

The administrator can manage:

* Name
* Position
* Role
* Biography
* Skills
* Photograph
* LinkedIn URL
* GitHub URL
* Display order
* Active/inactive status

The public team page displays active members according to their display order.

The current team includes:

1. Eng. Rasuli Omari — Founder
2. Eng. Nuru Mohamed — Co-Founder
3. Eng. Hashim Idd — Full-Stack Developer
4. Eng. Nuhu Nicholous — Full-Stack Developer & Network Engineer

---

# 20. Team Image Storage

Team photographs are stored outside the WAR application.

Default directory:

```text
/opt/rahanu-technology-data/team
```

Environment variable:

```text
RAHANU_TEAM_UPLOAD_DIR
```

This approach prevents uploaded images from being lost when the application WAR is replaced.

---

# 21. Services

The application currently supports:

```text
Website Development
Mobile App Development
Penetration Testing
Cybersecurity Services
Digital Forensics
Network & Technology Solutions
```

Services are stored in PostgreSQL and loaded dynamically by the Java application.

---

# 22. Projects

Projects are stored in the PostgreSQL `projects` table.

Current projects include:

### RAHANU Technology Website

Slug:

```text
rahanu-technology-website
```

Status:

```text
In Development
```

### UDOM Online Quiz System

Slug:

```text
udom-online-quiz-system
```

Status:

```text
In Development
```

### aGIZA Parcel Delivery System

Slug:

```text
agiza-parcel-delivery
```

Status:

```text
Completed
```

Project links should open the appropriate project details page.

---

# 23. Contact Messages

Visitors can submit messages through the contact form.

Messages are stored in:

```text
contact_messages
```

Administrators can view messages through:

```text
/admin/messages
```

Messages contain:

* Full name
* Email
* Phone
* Subject
* Message
* Read/unread status
* Creation date

---

# 24. Useful Tomcat Commands

Start Tomcat:

```bash
sudo /opt/tomcat/bin/startup.sh
```

Stop Tomcat:

```bash
sudo /opt/tomcat/bin/shutdown.sh
```

Restart Tomcat:

```bash
sudo /opt/tomcat/bin/shutdown.sh
sleep 5
sudo /opt/tomcat/bin/startup.sh
```

Check Tomcat processes:

```bash
ps aux | grep tomcat
```

Check port 8080:

```bash
sudo ss -lntp | grep 8080
```

View Tomcat logs:

```bash
sudo tail -f /opt/tomcat/logs/catalina.out
```

Search for RAHANU errors:

```bash
sudo grep -i "RAHANU TECHNOLOGY" \
/opt/tomcat/logs/catalina.out | tail -50
```

---

# 25. Useful Maven Commands

Clean the project:

```bash
mvn clean
```

Compile:

```bash
mvn compile
```

Package:

```bash
mvn package
```

Clean and package:

```bash
mvn clean package
```

Skip tests:

```bash
mvn clean package -DskipTests
```

---

# 26. Troubleshooting

## Database authentication failure

If you see:

```text
FATAL: password authentication failed for user "rahanu_admin"
```

Check the PostgreSQL password:

```bash
sudo -u postgres psql -c \
"ALTER ROLE rahanu_admin WITH LOGIN PASSWORD 'ChangeThisPassword123!';"
```

Then test:

```bash
PGPASSWORD='ChangeThisPassword123!' psql \
-h 127.0.0.1 \
-U rahanu_admin \
-d rahanu_technology \
-c "SELECT current_user, current_database();"
```

Restart Tomcat:

```bash
sudo /opt/tomcat/bin/shutdown.sh
sleep 5
sudo /opt/tomcat/bin/startup.sh
```

---

## Application does not load

Check Tomcat:

```bash
sudo ss -lntp | grep 8080
```

Check deployment:

```bash
ls -lh /opt/tomcat/webapps/
```

Check logs:

```bash
sudo tail -100 /opt/tomcat/logs/catalina.out
```

---

## CSS is not loading

Make sure the application is deployed correctly:

```bash
ls -la /opt/tomcat/webapps/rahanu-technology/
```

Then check the CSS directory:

```bash
find /opt/tomcat/webapps/rahanu-technology \
-type f -name "*.css"
```

Clear the browser cache and reload the page.

---

## Database data appears missing

First check PostgreSQL directly:

```bash
sudo -u postgres psql -d rahanu_technology -c "
SELECT
    (SELECT COUNT(*) FROM team_members) AS team_members,
    (SELECT COUNT(*) FROM services) AS services,
    (SELECT COUNT(*) FROM projects) AS projects,
    (SELECT COUNT(*) FROM contact_messages) AS messages,
    (SELECT COUNT(*) FROM admin_users) AS admins;
"
```

If the data exists in PostgreSQL but does not appear on the website, the problem is probably in the Java application or database connection.

If the data is actually missing from PostgreSQL, **do not immediately run `seed.sql`**. First determine what deleted or recreated the data.

---

# 27. Important Deployment Rule

Normal development should follow this process:

```text
Edit Java/JSP/CSS
       ↓
mvn clean package
       ↓
Deploy WAR
       ↓
Restart Tomcat
       ↓
Test website
```

It should **NOT** follow:

```text
Edit code
   ↓
Delete database
   ↓
Create database again
   ↓
Run schema.sql
   ↓
Run seed.sql
```

The PostgreSQL database is persistent and independent of the WAR deployment.

---

# 28. Backup the Database

A database backup should be created before major changes.

Create a backup directory:

```bash
mkdir -p ~/rahanu-backups
```

Create a backup:

```bash
sudo -u postgres pg_dump \
-d rahanu_technology \
-F c \
-f ~/rahanu-backups/rahanu_technology_$(date +%Y%m%d_%H%M%S).dump
```

List backups:

```bash
ls -lh ~/rahanu-backups/
```

---

# 29. Restore a Database Backup

To restore a backup into a database, use:

```bash
sudo -u postgres pg_restore \
-d rahanu_technology \
~/rahanu-backups/backup-file.dump
```

For production or important data, always make a backup before restoring.

---

# 30. Git Usage

Check the project status:

```bash
git status
```

Add changes:

```bash
git add .
```

Commit:

```bash
git commit -m "Update RAHANU Technology application"
```

Push:

```bash
git push
```

Do not commit passwords or private credentials to Git.

---

# 31. Security Recommendations

For production deployment:

1. Change the default PostgreSQL password.
2. Do not store production passwords in Git.
3. Use environment variables for secrets.
4. Use HTTPS.
5. Validate all user input.
6. Use prepared statements.
7. Keep administrator authentication protected.
8. Use strong administrator passwords.
9. Restrict PostgreSQL network access.
10. Keep regular database backups.
11. Protect uploaded files.
12. Keep Tomcat and Java updated.
13. Do not expose database credentials in application logs.
14. Do not expose password hashes to normal users.
15. Use appropriate file permissions on configuration files.

---

# 32. Development Workflow

The recommended development workflow is:

```text
1. Start PostgreSQL
        ↓
2. Start Tomcat
        ↓
3. Open the application
        ↓
4. Modify source code
        ↓
5. Run Maven build
        ↓
6. Deploy WAR
        ↓
7. Restart Tomcat
        ↓
8. Test the feature
        ↓
9. Check logs if necessary
        ↓
10. Backup database before major changes
```

---

# 33. Application Architecture

The project follows a layered Java web architecture:

```text
Browser
   │
   ▼
JSP / Bootstrap
   │
   ▼
Servlet Controllers
   │
   ▼
DAO Layer
   │
   ▼
DBConnection
   │
   ▼
PostgreSQL
```

### JSP

Responsible for displaying the user interface.

### Servlet

Responsible for handling HTTP requests and controlling application flow.

### DAO

Responsible for communicating with PostgreSQL.

### Model

Represents application data.

### Utility

Contains reusable components such as:

* Database connection
* Password hashing
* Storage configuration

---

# 34. Current Deployment Environment

```text
Operating System: Kali Linux
Java: Oracle JDK 26.0.1
Maven: 3.9.12
PostgreSQL: 18
Tomcat: 10.1.59
Application Port: 8080
Application Context: rahanu-technology
```

Tomcat directory:

```text
/opt/tomcat
```

Application WAR:

```text
/opt/tomcat/webapps/rahanu-technology.war
```

Application URL:

```text
http://localhost:8080/rahanu-technology/
```

---

# 35. Future Development

Planned improvements include:

* Admin Settings
* Improved project management
* Improved service management
* Team member management
* Image management
* Contact message management
* Dashboard statistics
* Search functionality
* Better validation
* Audit logging
* HTTPS deployment
* Automated database backups
* Production deployment configuration

---

# 36. Author

**RAHANU TECHNOLOGY**

Technology, Software Development and Cybersecurity Solutions.

---

## License

This project is intended for RAHANU TECHNOLOGY and its authorized development and deployment purposes.
