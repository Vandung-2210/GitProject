<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Người Dùng - JSP JDBC MySQL</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8fafc; }
        .container { max-width: 900px; margin: auto; background: white; padding: 25px 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.08); }
        h2 { color: #1b2a7a; text-align: center; }
        table { width: 100%; margin-top: 15px; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #1b2a7a; color: white; }
        tr:hover { background-color: #f1f5f9; }
        .btn { display: inline-block; padding: 8px 14px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px; cursor: pointer; border: none; color: white; }
        .btn-add { background-color: #27ae60; margin-bottom: 15px; }
        .btn-edit { background-color: #2980b9; margin-right: 5px; }
        .btn-delete { background-color: #c0392b; }
        .form-group { margin-bottom: 15px; text-align: left; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input[type="text"], input[type="email"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .alert { background-color: #e8f5e9; color: #27ae60; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-weight: bold; }
        .error-alert { background-color: #ffebee; color: #c0392b; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-weight: bold; }
        .back-link { display: inline-block; margin-top: 15px; color: #1b2a7a; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<%!
    // Cấu hình kết nối MySQL JDBC
    private String jdbcURL = "jdbc:mysql://localhost:3306/demo?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private String jdbcUsername = "root";
    private String jdbcPassword = "password"; // Đổi thành mật khẩu MySQL của bạn

    private Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // Model User
    public static class UserItem {
        private int id;
        private String name;
        private String email;
        private String country;

        public UserItem(int id, String name, String email, String country) {
            this.id = id;
            this.name = name;
            this.email = email;
            this.country = country;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public String getEmail() { return email; }
        public String getCountry() { return country; }
    }
%>

<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    if (action == null) action = "list";
    String method = request.getMethod();
    String message = "";
    String errorMessage = "";

    // Xử lý POST (Thêm, Sửa, Xóa vào MySQL)
    if ("POST".equalsIgnoreCase(method)) {
        if ("create".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String country = request.getParameter("country");
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement("INSERT INTO users (name, email, country) VALUES (?, ?, ?);")) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, country);
                ps.executeUpdate();
                message = "Thêm người dùng mới thành công!";
            } catch (Exception e) {
                errorMessage = "Lỗi thêm người dùng: " + e.getMessage();
            }
            action = "list";
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String country = request.getParameter("country");
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement("UPDATE users SET name = ?, email = ?, country = ? WHERE id = ?;")) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, country);
                ps.setInt(4, id);
                ps.executeUpdate();
                message = "Cập nhật thông tin thành công!";
            } catch (Exception e) {
                errorMessage = "Lỗi cập nhật: " + e.getMessage();
            }
            action = "list";
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id = ?;")) {
                ps.setInt(1, id);
                ps.executeUpdate();
                message = "Đã xóa người dùng khỏi cơ sở dữ liệu!";
            } catch (Exception e) {
                errorMessage = "Lỗi khi xóa: " + e.getMessage();
            }
            action = "list";
        }
    }
%>

<div class="container">
    <% if (!message.isEmpty()) { %>
        <div class="alert"><%= message %></div>
    <% } %>
    <% if (!errorMessage.isEmpty()) { %>
        <div class="error-alert"><%= errorMessage %></div>
    <% } %>

    <%-- Form Thêm mới User --%>
    <% if ("create".equals(action)) { %>
        <h2>Thêm Mới Người Dùng</h2>
        <form action="index.jsp?action=create" method="POST">
            <div class="form-group">
                <label>Tên đầy đủ:</label>
                <input type="text" name="name" required placeholder="Nhập họ và tên" />
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required placeholder="Nhập địa chỉ email" />
            </div>
            <div class="form-group">
                <label>Quốc gia:</label>
                <input type="text" name="country" required placeholder="Nhập quốc gia" />
            </div>
            <button type="submit" class="btn btn-add">Lưu thông tin</button>
        </form>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- Form Chỉnh sửa User --%>
    <% } else if ("edit".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        String name = "", email = "", country = "";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT name, email, country FROM users WHERE id = ?;")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
                country = rs.getString("country");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
        <h2>Cập Nhật Thông Tin User</h2>
        <form action="index.jsp?action=edit" method="POST">
            <input type="hidden" name="id" value="<%= id %>" />
            <div class="form-group">
                <label>Tên đầy đủ:</label>
                <input type="text" name="name" value="<%= name %>" required />
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" value="<%= email %>" required />
            </div>
            <div class="form-group">
                <label>Quốc gia:</label>
                <input type="text" name="country" value="<%= country %>" required />
            </div>
            <button type="submit" class="btn btn-edit">Cập nhật ngay</button>
        </form>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- Form Xác nhận Xóa User --%>
    <% } else if ("confirm_delete".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
    %>
        <h2 style="color: #c0392b;">Xác Nhận Xóa User</h2>
        <p>Bạn có chắc chắn muốn xóa vĩnh viễn User có mã <b>#<%= id %></b> khỏi hệ thống?</p>
        <form action="index.jsp?action=delete" method="POST">
            <input type="hidden" name="id" value="<%= id %>" />
            <button type="submit" class="btn btn-delete">Đồng ý Xóa</button>
            <a href="index.jsp" class="btn" style="background:#95a5a6;">Hủy bỏ</a>
        </form>

    <%-- Mặc định: Hiển thị danh sách User từ MySQL --%>
    <% } else { 
        List<UserItem> userList = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name, email, country FROM users ORDER BY id DESC;")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                userList.add(new UserItem(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("country")
                ));
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Không thể kết nối CSDL MySQL. Vui lòng kiểm tra lại dịch vụ MySQL và cấu hình kết nối.</p>");
        }
    %>
        <h2>Danh Sách Người Dùng (Users)</h2>
        <a href="index.jsp?action=create" class="btn btn-add">+ Thêm mới User</a>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên User</th>
                    <th>Email</th>
                    <th>Quốc gia</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% if (userList.isEmpty()) { %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #888;">Chưa có dữ liệu người dùng.</td>
                    </tr>
                <% } else {
                    for (UserItem u : userList) { %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><strong><%= u.getName() %></strong></td>
                        <td><%= u.getEmail() %></td>
                        <td><%= u.getCountry() %></td>
                        <td>
                            <a href="index.jsp?action=edit&id=<%= u.getId() %>" class="btn btn-edit">Sửa</a>
                            <a href="index.jsp?action=confirm_delete&id=<%= u.getId() %>" class="btn btn-delete">Xóa</a>
                        </td>
                    </tr>
                <%  } 
                } %>
            </tbody>
        </table>
    <% } %>
</div>

</body>
</html>