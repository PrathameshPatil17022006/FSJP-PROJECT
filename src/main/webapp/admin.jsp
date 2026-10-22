```jsp
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin | SmartCampus</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css">
</head>
<body>

<%@ include file="/includes/header.jspf" %>

<main class="page-shell">
    <div class="page-title">
        <div>
            <span class="eyebrow">CAMPUS OPERATIONS</span>
            <h1>Admin <span class="gradient-text">workspace.</span></h1>
            <p class="muted">Manage requests, events and shared campus resources.</p>
        </div>
        <span class="admin-badge">✦ ADMIN ACCESS</span>
    </div>

    <% if ("saved".equals(request.getParameter("msg"))) { %>
        <p class="success-message">Changes saved successfully.</p>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <p class="error-message">
            <%= request.getParameter("error") %>
        </p>
    <% } %>

    <!-- BOOKING REQUESTS -->
    <section class="admin-section">
        <div class="panel-heading">
            <div>
                <span class="eyebrow">REVIEW QUEUE</span>
                <h2>Booking requests</h2>
            </div>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>STUDENT</th>
                        <th>RESOURCE</th>
                        <th>DATE / TIME</th>
                        <th>PURPOSE</th>
                        <th>STATUS</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    ResultSet bookings =
                        (ResultSet) request.getAttribute("bookings");
                    boolean hasBookings = false;

                    if (bookings != null) {
                        while (bookings.next()) {
                            hasBookings = true;
                            String status = bookings.getString("status");
                            if (status == null) status = "PENDING";
                %>
                    <tr>
                        <td>
                            <b><%= bookings.getString("student_name") %></b>
                        </td>
                        <td><%= bookings.getString("resource_name") %></td>
                        <td>
                            <%= bookings.getDate("booking_date") %><br>
                            <small>
                                <%= bookings.getTime("start_time") %> -
                                <%= bookings.getTime("end_time") %>
                            </small>
                        </td>
                        <td><%= bookings.getString("purpose") %></td>
                        <td>
                            <span class="status <%= status.toLowerCase() %>">
                                <%= status %>
                            </span>
                        </td>
                        <td>
                            <% if ("PENDING".equals(status)) { %>
                                <form class="inline-actions" method="post"
                                      action="<%= request.getContextPath() %>/admin/action">
                                    <input type="hidden" name="action" value="booking-status">
                                    <input type="hidden" name="bookingId"
                                           value="<%= bookings.getInt("id") %>">
                                    <button class="btn small primary"
                                            type="submit" name="status"
                                            value="APPROVED">Approve</button>
                                    <button class="btn small danger"
                                            type="submit" name="status"
                                            value="REJECTED">Reject</button>
                                </form>
                            <% } else { %>
                                -
                            <% } %>
                        </td>
                    </tr>
                <%
                        }
                    }

                    if (!hasBookings) {
                %>
                    <tr>
                        <td colspan="6" class="empty-state">
                            No booking requests found.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <div class="admin-grid">

        <!-- ADD AND VIEW EVENTS -->
        <section class="content-panel">
            <div class="panel-heading">
                <div>
                    <span class="eyebrow">PUBLISH SOMETHING</span>
                    <h2>Add an event</h2>
                </div>
            </div>

            <form class="stack-form" method="post"
                  action="<%= request.getContextPath() %>/admin/action">
                <input type="hidden" name="action" value="add-event">

                <label>Event title
                    <input type="text" name="title" maxlength="150" required>
                </label>

                <div class="form-two">
                    <label>Category
                        <select name="category">
                            <option>Technical</option>
                            <option>Cultural</option>
                            <option>Academic</option>
                            <option>Sports</option>
                            <option>Workshop</option>
                        </select>
                    </label>

                    <label>Capacity
                        <input type="number" name="capacity" min="1" required>
                    </label>
                </div>

                <label>Description
                    <textarea name="description" rows="3" required></textarea>
                </label>

                <div class="form-two">
                    <label>Date
                        <input type="date" name="eventDate"
                               min="<%= LocalDate.now() %>" required>
                    </label>

                    <label>Start time
                        <input type="time" name="startTime" required>
                    </label>
                </div>

                <label>Venue
                    <input type="text" name="venue" required>
                </label>

                <button class="btn primary" type="submit">Publish event</button>
            </form>

            <div class="mini-admin-list">
                <h3>Existing events</h3>
                <%
                    ResultSet events =
                        (ResultSet) request.getAttribute("events");
                    boolean hasEvents = false;

                    if (events != null) {
                        while (events.next()) {
                            hasEvents = true;
                %>
                    <div class="mini-row">
                        <span>
                            <b><%= events.getString("title") %></b>
                            <small>
                                <%= events.getDate("event_date") %> ·
                                <%= events.getString("venue") %>
                            </small>
                        </span>

                        <form method="post"
                              action="<%= request.getContextPath() %>/admin/action"
                              onsubmit="return confirm('Delete this event?');">
                            <input type="hidden" name="action" value="delete-event">
                            <input type="hidden" name="id"
                                   value="<%= events.getInt("id") %>">
                            <button class="text-button danger-text"
                                    type="submit">Delete</button>
                        </form>
                    </div>
                <%
                        }
                    }

                    if (!hasEvents) {
                %>
                    <p class="muted">No events found.</p>
                <% } %>
            </div>
        </section>

        <!-- ADD AND VIEW RESOURCES -->
        <section class="content-panel">
            <div class="panel-heading">
                <div>
                    <span class="eyebrow">MAKE SPACE</span>
                    <h2>Add a resource</h2>
                </div>
            </div>

            <form class="stack-form" method="post"
                  action="<%= request.getContextPath() %>/admin/action">
                <input type="hidden" name="action" value="add-resource">

                <label>Resource name
                    <input type="text" name="name" maxlength="120"
                           placeholder="e.g. Seminar Hall B" required>
                </label>

                <label>Location
                    <input type="text" name="location" maxlength="150"
                           placeholder="e.g. Main building, 2nd floor" required>
                </label>

                <label>Capacity
                    <input type="number" name="capacity" min="1" required>
                </label>

                <label>Description
                    <textarea name="description" rows="3" required></textarea>
                </label>

                <button class="btn primary" type="submit">Add resource</button>
            </form>

            <div class="mini-admin-list">
                <h3>Current resources</h3>
                <%
                    ResultSet resources =
                        (ResultSet) request.getAttribute("resources");
                    boolean hasResources = false;

                    if (resources != null) {
                        while (resources.next()) {
                            hasResources = true;
                %>
                    <div class="mini-row">
                        <span>
                            <b><%= resources.getString("name") %></b>
                            <small>
                                <%= resources.getString("location") %> ·
                                Capacity <%= resources.getInt("capacity") %>
                            </small>
                        </span>

                        <form method="post"
                              action="<%= request.getContextPath() %>/admin/action">
                            <input type="hidden" name="action" value="delete-resource">
                            <input type="hidden" name="id"
                                   value="<%= resources.getInt("id") %>">
                            <button class="text-button danger-text"
                                    type="submit">Deactivate</button>
                        </form>
                    </div>
                <%
                        }
                    }

                    if (!hasResources) {
                %>
                    <p class="muted">No resources found.</p>
                <% } %>
            </div>
        </section>

    </div>
</main>

<footer>
    <span>SmartCampus · Admin workspace</span>
    <span>Good operations make great campus days.</span>
</footer>

</body>
</html>
```