# SmartCampus — Event and Resource Booking Portal

A second-year FSJP Java web application using HTML, CSS, Java Servlets/JSP, JDBC and MySQL.

## Features
- Student registration and sign-in with salted PBKDF2 password hashing
- Event listing, search and event registration
- Resource listing and booking requests
- Admin approval/rejection for booking requests
- Overlap checks for booking requests and again when approving a request
- Admin can add events/resources and delete events/deactivate resources
- Responsive UI and seeded demo events/resources

## Requirements
- Java JDK 17
- Maven 3.9+
- MySQL 8+
- Apache Tomcat 10.1 (Jakarta Servlet 6)

## Run locally (Windows)
1. Install the requirements above.
2. Open MySQL Workbench or MySQL command line and execute `database/schema.sql`.
3. If your MySQL root account has a password, set it for the terminal before starting Tomcat. Recommended: configure environment variables `SC_DB_URL`, `SC_DB_USER`, `SC_DB_PASSWORD`. Default URL is `jdbc:mysql://localhost:3306/smart_campus?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true`.
4. In a terminal, open this project folder and run `mvn clean package`.
5. Copy `target/SmartCampusPortal.war` into Tomcat 10.1's `webapps` folder.
6. Start Tomcat (`bin\startup.bat`) and open `http://localhost:8080/SmartCampusPortal/`.
7. Register a student account from the website.
8. To make an account an administrator, execute this in MySQL after registering: `UPDATE users SET role='ADMIN' WHERE email='your-email@example.com';` Then sign out and sign back in. Use your own email in the query.

## GitHub upload from an existing local clone
If your repository is already cloned, extract/copy this project's files into that repository folder. Do not overwrite unrelated work without making a backup. Then run:

```bash
git status
git add .
git commit -m "Build SmartCampus event and resource booking portal"
git push origin HEAD
```

If Git reports conflicts or rejected pushes, do not use `--force`; inspect `git status` and sync the branch first.

## Important implementation notes
- This project targets Tomcat 10.1 and Jakarta packages (`jakarta.servlet.*`). Tomcat 9 will not run it without conversion.
- Database credentials are read from environment variables, not committed to GitHub.
- Booking conflict detection in the app is appropriate for a student demo. For a production deployment, add stronger transaction isolation/locking and tests to guarantee conflict-free concurrent requests.
- Before submission, test registration, login, event registration, booking conflicts, admin approval/rejection, and mobile layout.

## Project modules
- `AuthServlet`: register/login/logout
- `PortalServlet`: home, student dashboard, events, resources, personal bookings
- `BookingServlet`: booking request and overlap check
- `EventRegisterServlet`: event registration
- `AdminServlet`: event/resource management and booking approval
- `DB`: MySQL connection helper
- `Security`: PBKDF2 password hashing/verification
