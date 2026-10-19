<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Sản Phẩm - MVC</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f4f6f9; }
        .container { max-width: 1000px; margin: auto; background: white; padding: 25px 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        h1, h2 { color: #1e293b; }
        table { border-collapse: collapse; width: 100%; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #e2e8f0; }
        th { background-color: #2563eb; color: white; }
        tr:hover { background-color: #f8fafc; }
        .btn { display: inline-block; padding: 8px 14px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px; cursor: pointer; border: none; }
        .btn-create { background-color: #16a34a; color: white; margin-bottom: 15px; }
        .btn-edit { background-color: #0284c7; color: white; margin-right: 4px; }
        .btn-delete { background-color: #dc2626; color: white; margin-right: 4px; }
        .btn-view { background-color: #d97706; color: white; }
        .btn-search { background-color: #4b5563; color: white; padding: 9px 16px; }
        .form-group { margin-bottom: 15px; text-align: left; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #334155; }
        input[type="text"], input[type="number"], textarea { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 4px; box-sizing: border-box; }
        .search-box { display: flex; gap: 10px; margin-bottom: 20px; }
        .search-box input { width: 300px; }
        .alert { background-color: #dcfce7; color: #15803d; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-weight: bold; }
        .back-link { display: inline-block; margin-top: 15px; color: #2563eb; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<%!
    // 1. TẦNG MODEL: Class Product
    public static class Product {
        private int id;
        private String name;
        private double price;
        private String description;
        private String manufacturer;

        public Product(int id, String name, double price, String description, String manufacturer) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.description = description;
            this.manufacturer = manufacturer;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public double getPrice() { return price; }
        public void setPrice(double price) { this.price = price; }
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        public String getManufacturer() { return manufacturer; }
        public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }
    }

    // 2. TẦNG SERVICE / DATABASE GIẢ LẬP: Dùng Map tĩnh
    private static Map<Integer, Product> products = new LinkedHashMap<>();

    static {
        products.put(1, new Product(1, "iPhone 15 Pro", 999.0, "Titanium design, A17 Pro chip", "Apple"));
        products.put(2, new Product(2, "Galaxy S24 Ultra", 1199.0, "Galaxy AI, 200MP camera", "Samsung"));
        products.put(3, new Product(3, "MacBook Air M3", 1099.0, "Thin and light, Liquid Retina display", "Apple"));
        products.put(4, new Product(4, "Dell XPS 13", 899.0, "InfinityEdge screen, Intel Core Ultra", "Dell"));
        products.put(5, new Product(5, "Sony WH-1000XM5", 399.0, "Noise cancelling headphones", "Sony"));
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
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            String manufacturer = request.getParameter("manufacturer");
            int id = (int)(System.currentTimeMillis() % 100000);

            products.put(id, new Product(id, name, price, description, manufacturer));
            message = "Tạo mới sản phẩm thành công!";
            action = "list";
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = products.get(id);
            if (p != null) {
                p.setName(request.getParameter("name"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setDescription(request.getParameter("description"));
                p.setManufacturer(request.getParameter("manufacturer"));
                message = "Cập nhật sản phẩm thành công!";
            }
            action = "list";
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            products.remove(id);
            message = "Đã xóa sản phẩm khỏi hệ thống!";
            action = "list";
        }
    }
%>

<div class="container">
    <% if (!message.isEmpty()) { %>
        <div class="alert"><%= message %></div>
    <% } %>

    <%-- VIEW: Tạo sản phẩm mới --%>
    <% if ("create".equals(action)) { %>
        <h2>Tạo Sản Phẩm Mới</h2>
        <form action="index.jsp?action=create" method="POST">
            <div class="form-group">
                <label>Tên sản phẩm:</label>
                <input type="text" name="name" required placeholder="Nhập tên sản phẩm" />
            </div>
            <div class="form-group">
                <label>Giá sản phẩm ($):</label>
                <input type="number" step="0.01" name="price" required placeholder="Nhập giá" />
            </div>
            <div class="form-group">
                <label>Mô tả:</label>
                <textarea name="description" rows="3" placeholder="Nhập mô tả sản phẩm"></textarea>
            </div>
            <div class="form-group">
                <label>Nhà sản xuất:</label>
                <input type="text" name="manufacturer" required placeholder="Nhập nhà sản xuất" />
            </div>
            <button type="submit" class="btn btn-create">Lưu sản phẩm</button>
        </form>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- VIEW: Cập nhật thông tin sản phẩm --%>
    <% } else if ("edit".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        Product p = products.get(id);
    %>
        <h2>Cập Nhật Sản Phẩm</h2>
        <form action="index.jsp?action=edit" method="POST">
            <input type="hidden" name="id" value="<%= p.getId() %>" />
            <div class="form-group">
                <label>Tên sản phẩm:</label>
                <input type="text" name="name" value="<%= p.getName() %>" required />
            </div>
            <div class="form-group">
                <label>Giá sản phẩm ($):</label>
                <input type="number" step="0.01" name="price" value="<%= p.getPrice() %>" required />
            </div>
            <div class="form-group">
                <label>Mô tả:</label>
                <textarea name="description" rows="3"><%= p.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label>Nhà sản xuất:</label>
                <input type="text" name="manufacturer" value="<%= p.getManufacturer() %>" required />
            </div>
            <button type="submit" class="btn btn-edit">Cập nhật</button>
        </form>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- VIEW: Xem chi tiết sản phẩm --%>
    <% } else if ("view".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        Product p = products.get(id);
    %>
        <h2>Chi Tiết Sản Phẩm</h2>
        <p><strong>Mã sản phẩm:</strong> <%= p.getId() %></p>
        <p><strong>Tên sản phẩm:</strong> <%= p.getName() %></p>
        <p><strong>Giá:</strong> $<%= p.getPrice() %></p>
        <p><strong>Mô tả:</strong> <%= p.getDescription() %></p>
        <p><strong>Nhà sản xuất:</strong> <%= p.getManufacturer() %></p>
        <a href="index.jsp" class="back-link">← Quay lại danh sách</a>

    <%-- VIEW: Xác nhận xóa sản phẩm --%>
    <% } else if ("confirm_delete".equals(action)) { 
        int id = Integer.parseInt(request.getParameter("id"));
        Product p = products.get(id);
    %>
        <h2 style="color: #dc2626;">Xác Nhận Xóa</h2>
        <p>Bạn có chắc chắn muốn xóa sản phẩm <b><%= p.getName() %></b> (Mã: <%= p.getId() %>) không?</p>
        <form action="index.jsp?action=delete" method="POST">
            <input type="hidden" name="id" value="<%= p.getId() %>" />
            <button type="submit" class="btn btn-delete">Đồng ý xóa</button>
            <a href="index.jsp" class="btn" style="background:#cbd5e1; color:#333;">Hủy bỏ</a>
        </form>

    <%-- VIEW: Hiển thị danh sách sản phẩm + Tìm kiếm theo tên --%>
    <% } else { 
        String searchKeyword = request.getParameter("search");
        List<Product> displayList = new ArrayList<>();
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            for (Product p : products.values()) {
                if (p.getName().toLowerCase().contains(searchKeyword.trim().toLowerCase())) {
                    displayList.add(p);
                }
            }
        } else {
            displayList.addAll(products.values());
        }
    %>
        <h1>Danh Sách Sản Phẩm</h1>

        <!-- Form tìm kiếm sản phẩm theo tên -->
        <form action="index.jsp" method="GET" class="search-box">
            <input type="text" name="search" placeholder="Nhập tên sản phẩm để tìm kiếm..." 
                   value="<%= searchKeyword != null ? searchKeyword : "" %>" />
            <button type="submit" class="btn btn-search">Tìm kiếm</button>
            <% if (searchKeyword != null && !searchKeyword.trim().isEmpty()) { %>
                <a href="index.jsp" class="btn" style="background:#e2e8f0; color:#334155; line-height:22px;">Bỏ lọc</a>
            <% } %>
        </form>

        <a href="index.jsp?action=create" class="btn btn-create">+ Thêm sản phẩm mới</a>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Giá ($)</th>
                    <th>Nhà Sản Xuất</th>
                    <th>Mô Tả</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <% if (displayList.isEmpty()) { %>
                    <tr>
                        <td colspan="6" style="text-align: center; color: #64748b; padding: 20px;">
                            Không tìm thấy sản phẩm nào phù hợp.
                        </td>
                    </tr>
                <% } else {
                    for (Product p : displayList) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><strong><%= p.getName() %></strong></td>
                        <td>$<%= p.getPrice() %></td>
                        <td><%= p.getManufacturer() %></td>
                        <td><%= p.getDescription() %></td>
                        <td>
                            <a href="index.jsp?action=view&id=<%= p.getId() %>" class="btn btn-view">Xem</a>
                            <a href="index.jsp?action=edit&id=<%= p.getId() %>" class="btn btn-edit">Sửa</a>
                            <a href="index.jsp?action=confirm_delete&id=<%= p.getId() %>" class="btn btn-delete">Xóa</a>
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