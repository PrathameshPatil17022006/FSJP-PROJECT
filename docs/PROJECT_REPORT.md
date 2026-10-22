# Smart Campus: Event and Resource Booking Portal

## Abstract
SmartCampus is a web-based campus coordination system that centralizes event discovery, event registration and shared resource booking. Students can explore upcoming campus events, register for activities and submit requests for resources such as seminar halls, computer labs and projectors. Administrators can publish events, maintain resource availability and approve or reject requests. Booking overlap checks help reduce scheduling conflicts.

## Problem statement
Campus events and shared facilities are often coordinated using separate notices, messages or manual registers. This makes it difficult for students to discover activities and can result in duplicate resource requests, slow approvals and unclear booking status.

## Objectives
1. Provide a single portal for campus events and resources.
2. Digitize event registration and resource booking requests.
3. Provide administrators with a simple management interface.
4. Detect overlapping booking times for the same resource.
5. Store application data persistently in a relational database.

## Scope
The current prototype supports student accounts, event discovery/registration, resource requests, request status tracking, and administrator management of events/resources/requests. Email/SMS notifications, SSO, payment processing and deployment to a public cloud are outside the current scope.

## Technology
HTML5, CSS3, JavaScript, Java 17, Jakarta Servlets/JSP, JDBC, MySQL 8, Maven and Apache Tomcat 10.1.

## Main modules
- Authentication: student registration, sign-in and sign-out; passwords are stored as PBKDF2 hashes.
- Event management: view upcoming events, search client-side and register for events.
- Resource booking: choose a resource, date, start/end time and purpose.
- Approval workflow: requests begin as PENDING and an admin can approve or reject them.
- Admin management: add events/resources, delete events and deactivate resources.

## Database tables
`users`, `events`, `registrations`, `resources`, `bookings`. Foreign keys maintain relationships. A unique key prevents duplicate registration by the same user for the same event.

## Booking conflict rule
Two time ranges overlap when `existing.start_time < requested.end_time AND existing.end_time > requested.start_time` for the same resource and date. The portal checks requests on submission and checks approved bookings again before approval.

## Test plan
1. Register a new student with valid details.
2. Attempt duplicate registration with the same email; verify the duplicate is rejected.
3. Sign in with correct and incorrect credentials.
4. Register for an upcoming event and verify a registration row exists in MySQL.
5. Submit a booking request and verify status is PENDING.
6. Submit a second overlapping request for the same resource/date; verify the portal flags the conflict.
7. Promote a test account to ADMIN using the documented SQL statement and sign in again.
8. Approve a booking and verify status changes to APPROVED.
9. Try to approve an overlapping booking; verify the portal blocks it.
10. Add an event and resource through the admin panel and verify they appear for students.

## Future enhancements
Email notifications, event capacity enforcement, calendar integration, equipment inventory, booking cancellation, audit logs, campus single sign-on and deployment with HTTPS.

## Conclusion
SmartCampus demonstrates how a web application can streamline event participation and shared-resource scheduling using Java and a relational database. It combines role-based functionality, persistent storage, input validation and a basic booking conflict workflow in one campus portal.
