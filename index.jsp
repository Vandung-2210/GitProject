<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Khách Hàng (MVC All-in-One)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f8fafc; }
        .container { max-width: 900px; margin: auto; background: white; padding: 25px 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.08); }
        h1, h2 { color: #1b2a7a; }
        table { border-collapse: collapse; width: 100%; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #1b2a7a; color: white; }
        tr:hover { background-color: #f1f5f9; }
        .btn { display: inline-block; padding: 8px 14px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px; cursor: pointer; border: none; }
        .btn-create { background-color: #27ae60; color: white; margin-bottom: 15px; }
        .btn-edit { background-color: #2980b9; color: white; margin-right: 5px; }
        .btn-delete { background-color: #c0392b; color: white; margin-right: 5px; }
        .btn-view { background-color: #f39c12; color: white; }
        .form-group { margin-bottom: 15px; text-align: left; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="email"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .alert { background-color: #e8f5e9; color: #27ae60; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-weight: bold; }
        .back-link { display: inline-block; margin-top: 15px; color: #1b2a7a; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<%!
    // 1. TẦNG MODEL: Lớp Customer
    public static class Customer {
        private int id;
        private String name;
        private String email;
        private String address;

        public Customer(int id, String name, String email, String address) {
            this.id = id;
            this.name = name;
            this.email = email;
            this.address = address;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
    }

    // 2. TẦNG SERVICE / DATABASE GIẢ LẬP: Dùng Map tĩnh để duy trì dữ liệu
    private static Map<Integer, Customer> customers = new HashMap<>();

    static {
        customers.put(1, new Customer(1, "John", "john@codegym.vn", "Hà Nội"));
        customers.put(2, new Customer(2, "Bill", "bill@codegym.vn", "Đà Nẵng"));
        customers.put(3, new Customer(3, "Alex", "alex@codegym.vn", "Sài Gòn"));
        customers.put(4, new Customer(4, "Adam", "adam@codegym.vn", "Bắc Giang"));
        customers.put(5, new Customer(5, "Sophia", "sophia@codegym.vn", "Thái Nguyên"));
    }
%>

<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    if (action == null) action = "list";
    String method = request.getMethod();
    String message = "";

    // 3. TẦNG CONTROLLER: Xử lý thao tác POST
    if ("POST".equalsIgnoreCase(method)) {
        if ("create".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            int id = (int)(System.currentTimeMillis() % 10000);
            customers.put(id, new Customer(id, name, email, address));
            message = "Thêm mới khách hàng thành công!";
            action = "list";
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Customer c = customers.get(id);
            if (c != null) {
                c.setName(request.getParameter("name"));
                c.setEmail(request.getParameter("email"));
                c.setAddress(request.getParameter("address"));
                message = "Cập nhật thông tin khách hàng thành công!";
            }
            action = "list";
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            customers.remove(id);
            message = "Đã xóa khách hàng khỏi danh sách!";
            action = "list";
        }
    }
%>

<div class="container">
    <% if (!message.isEmpty()) { %>
        <div class="alert"><%= message %></div>
    <% } %>

    <%-- 4. TẦNG VIEW: Hiển thị form Thêm mới --%>
    <% if ("create".equals(action)) { %>
        <h2>Tạo Khách Hàng Mới</h2>
        <form action="index.jsp?action=create" method="POST">
            <div class="form-group">
                <label>Họ và Tên:</label>
                <input type="text" name="name" required placeholder="Nhập tên khách hàng" />
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required placeholder="Nhập email" />
            </div>
            <div class="form-group">
                <label>Địa chỉ:</label>
                <input type="text" name="address" required placeholder="Nhập địa chỉ" />
            </div>
            <button type="submit" class="btn btn-create">Lưu khách hàng</button>
        </form>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- Hiển thị form Cập nhật (Edit) --%>
    <% } else if ("edit".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        Customer c = customers.get(id);
    %>
        <h2>Cập Nhật Khách Hàng</h2>
        <form action="index.jsp?action=edit" method="POST">
            <input type="hidden" name="id" value="<%= c.getId() %>" />
            <div class="form-group">
                <label>Họ và Tên:</label>
                <input type="text" name="name" value="<%= c.getName() %>" required />
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" value="<%= c.getEmail() %>" required />
            </div>
            <div class="form-group">
                <label>Địa chỉ:</label>
                <input type="text" name="address" value="<%= c.getAddress() %>" required />
            </div>
            <button type="submit" class="btn btn-edit">Cập nhật</button>
        </form>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- Hiển thị Chi tiết (View) --%>
    <% } else if ("view".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        Customer c = customers.get(id);
    %>
        <h2>Chi Tiết Khách Hàng</h2>
        <p><strong>Mã khách hàng:</strong> <%= c.getId() %></p>
        <p><strong>Họ và tên:</strong> <%= c.getName() %></p>
        <p><strong>Email:</strong> <%= c.getEmail() %></p>
        <p><strong>Địa chỉ:</strong> <%= c.getAddress() %></p>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- Hiển thị Xác nhận Xóa (Delete) --%>
    <% } else if ("confirm_delete".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        Customer c = customers.get(id);
    %>
        <h2>Xác Nhận Xóa</h2>
        <p>Bạn có chắc chắn muốn xóa khách hàng <b><%= c.getName() %></b> (Email: <%= c.getEmail() %>)?</p>
        <form action="index.jsp?action=delete" method="POST">
            <input type="hidden" name="id" value="<%= c.getId() %>" />
            <button type="submit" class="btn btn-delete">Đồng ý xóa</button>
            <a href="index.jsp" class="btn" style="background:#ccc; color:#333;">Hủy bỏ</a>
        </form>

    <%-- Mặc định: Hiển thị Danh sách (List) --%>
    <% } else { %>
        <h1>Danh Sách Khách Hàng</h1>
        <a href="index.jsp?action=create" class="btn btn-create">+ Thêm khách hàng mới</a>
        <table>
            <thead>
                <tr>
                    <th>Mã</th>
                    <th>Họ và Tên</th>
                    <th>Email</th>
                    <th>Địa chỉ</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% for (Customer c : customers.values()) { %>
                    <tr>
                        <td><%= c.getId() %></td>
                        <td><strong><%= c.getName() %></strong></td>
                        <td><%= c.getEmail() %></td>
                        <td><%= c.getAddress() %></td>
                        <td>
                            <a href="index.jsp?action=view&id=<%= c.getId() %>" class="btn btn-view">Xem</a>
                            <a href="index.jsp?action=edit&id=<%= c.getId() %>" class="btn btn-edit">Sửa</a>
                            <a href="index.jsp?action=confirm_delete&id=<%= c.getId() %>" class="btn btn-delete">Xóa</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>

</body>
</html>