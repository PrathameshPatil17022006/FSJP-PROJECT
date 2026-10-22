package in.smartcampus;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet(urlPatterns = { "/admin", "/admin/action" })
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest q, HttpServletResponse r) throws IOException, ServletException {
        if (!admin(q, r))
            return;
        try (Connection c = DB.get()) {
            q.setAttribute("bookings", c.createStatement().executeQuery(
                    "SELECT b.*,u.name AS student_name,r.name AS resource_name FROM bookings b JOIN users u ON b.user_id=u.id JOIN resources r ON b.resource_id=r.id ORDER BY b.created_at DESC"));
            q.setAttribute("events", c.createStatement().executeQuery("SELECT * FROM events ORDER BY event_date DESC"));
            q.setAttribute("resources", c.createStatement().executeQuery("SELECT * FROM resources ORDER BY name"));
            q.getRequestDispatcher("/admin.jsp").forward(q, r);
            return;
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest q, HttpServletResponse r) throws IOException, ServletException {
        if (!admin(q, r))
            return;
        String action = q.getParameter("action");
        try (Connection c = DB.get()) {
            if ("booking-status".equals(action)) {
                int id = Integer.parseInt(q.getParameter("bookingId"));
                String status = q.getParameter("status");
                if (!status.equals("APPROVED") && !status.equals("REJECTED"))
                    throw new IllegalArgumentException();
                if (status.equals("APPROVED")) {
                    try (PreparedStatement p = c.prepareStatement(
                            "SELECT resource_id,booking_date,start_time,end_time FROM bookings WHERE id=?")) {
                        p.setInt(1, id);
                        try (ResultSet b = p.executeQuery()) {
                            if (!b.next())
                                throw new IllegalArgumentException();
                            try (PreparedStatement x = c.prepareStatement(
                                    "SELECT COUNT(*) FROM bookings WHERE id<>? AND resource_id=? AND booking_date=? AND status='APPROVED' AND start_time < ? AND end_time > ?")) {
                                x.setInt(1, id);
                                x.setInt(2, b.getInt(1));
                                x.setDate(3, b.getDate(2));
                                x.setTime(4, b.getTime(4));
                                x.setTime(5, b.getTime(3));
                                try (ResultSet z = x.executeQuery()) {
                                    z.next();
                                    if (z.getInt(1) > 0) {
                                        r.sendRedirect(
                                                q.getContextPath() + "/admin?error=Cannot+approve+overlapping+booking");
                                        return;
                                    }
                                }
                            }
                        }
                    }
                }
                try (PreparedStatement p = c.prepareStatement("UPDATE bookings SET status=? WHERE id=?")) {
                    p.setString(1, status);
                    p.setInt(2, id);
                    p.executeUpdate();
                }
            } else if ("add-event".equals(action)) {
                try (PreparedStatement p = c.prepareStatement(
                        "INSERT INTO events(title,category,description,event_date,start_time,venue,capacity) VALUES(?,?,?,?,?,?,?)")) {
                    p.setString(1, q.getParameter("title"));
                    p.setString(2, q.getParameter("category"));
                    p.setString(3, q.getParameter("description"));
                    p.setDate(4, Date.valueOf(q.getParameter("eventDate")));
                    p.setTime(5, Time.valueOf(q.getParameter("startTime") + ":00"));
                    p.setString(6, q.getParameter("venue"));
                    p.setInt(7, Integer.parseInt(q.getParameter("capacity")));
                    p.executeUpdate();
                }
            } else if ("add-resource".equals(action)) {
                try (PreparedStatement p = c.prepareStatement(
                        "INSERT INTO resources(name,location,capacity,description,active) VALUES(?,?,?,?,1)")) {
                    p.setString(1, q.getParameter("name"));
                    p.setString(2, q.getParameter("location"));
                    p.setInt(3, Integer.parseInt(q.getParameter("capacity")));
                    p.setString(4, q.getParameter("description"));
                    p.executeUpdate();
                }
            } else if ("delete-event".equals(action)) {
                try (PreparedStatement p = c.prepareStatement("DELETE FROM events WHERE id=?")) {
                    p.setInt(1, Integer.parseInt(q.getParameter("id")));
                    p.executeUpdate();
                }
            } else if ("delete-resource".equals(action)) {
                try (PreparedStatement p = c.prepareStatement("UPDATE resources SET active=0 WHERE id=?")) {
                    p.setInt(1, Integer.parseInt(q.getParameter("id")));
                    p.executeUpdate();
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
        r.sendRedirect(q.getContextPath() + "/admin?msg=Changes+saved");
    }

    private boolean admin(HttpServletRequest q, HttpServletResponse r) throws IOException {
        HttpSession s = q.getSession(false);
        if (s == null || s.getAttribute("userId") == null) {
            r.sendRedirect(q.getContextPath() + "/login");
            return false;
        }
        if (!"ADMIN".equals(s.getAttribute("role"))) {
            r.sendRedirect(q.getContextPath() + "/dashboard?error=Admin+access+required");
            return false;
        }
        return true;
    }
}