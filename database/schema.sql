CREATE DATABASE IF NOT EXISTS smart_campus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_campus;
CREATE TABLE IF NOT EXISTS users (
 id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL, email VARCHAR(150) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL, role ENUM('STUDENT','ADMIN') NOT NULL DEFAULT 'STUDENT', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS events (
 id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(150) NOT NULL, category VARCHAR(50) NOT NULL DEFAULT 'Academic',
 description TEXT NOT NULL, event_date DATE NOT NULL, start_time TIME NOT NULL, venue VARCHAR(150) NOT NULL,
 capacity INT NOT NULL DEFAULT 50, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS registrations (
 id INT PRIMARY KEY AUTO_INCREMENT, user_id INT NOT NULL, event_id INT NOT NULL, registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_registration(user_id,event_id), FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY(event_id) REFERENCES events(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS resources (
 id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(120) NOT NULL, location VARCHAR(150) NOT NULL,
 capacity INT NOT NULL DEFAULT 1, description TEXT NOT NULL, active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS bookings (
 id INT PRIMARY KEY AUTO_INCREMENT, user_id INT NOT NULL, resource_id INT NOT NULL, booking_date DATE NOT NULL,
 start_time TIME NOT NULL, end_time TIME NOT NULL, purpose VARCHAR(500) NOT NULL,
 status ENUM('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE, FOREIGN KEY(resource_id) REFERENCES resources(id)
);
CREATE INDEX idx_booking_conflicts ON bookings(resource_id, booking_date, status, start_time, end_time);
INSERT INTO events(title,category,description,event_date,start_time,venue,capacity) VALUES
('Build the Future with AI','Technical','A hands-on introduction to practical AI tools, responsible innovation and rapid prototyping.',DATE_ADD(CURDATE(),INTERVAL 5 DAY),'10:00:00','Innovation Lab',60),
('Campus Culture Night','Cultural','An evening of music, dance, creative performances and student community.',DATE_ADD(CURDATE(),INTERVAL 9 DAY),'17:30:00','Main Auditorium',250),
('Career Launchpad','Academic','Resume reviews, interview tips and career planning with industry mentors.',DATE_ADD(CURDATE(),INTERVAL 14 DAY),'11:00:00','Seminar Hall A',100);
INSERT INTO resources(name,location,capacity,description) VALUES
('Seminar Hall A','Main Building · 2nd Floor',100,'A presentation-ready hall with projector, audio system and flexible seating.'),
('Computer Lab 2','Technology Block · 1st Floor',40,'A computer lab for workshops, coding sessions and practical demonstrations.'),
('Projector Kit','Central Equipment Desk',1,'Portable projector kit for classroom presentations and student meetings.'),
('Discussion Room','Library · 3rd Floor',10,'A quiet collaboration room for project meetings and group study.');
