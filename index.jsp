<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!
    // Định nghĩa class Customer bên trong thẻ Declaration của JSP
    public static class Customer {
        private String name;
        private String dob;
        private String address;
        private String image;

        public Customer(String name, String dob, String address, String image) {
            this.name = name;
            this.dob = dob;
            this.address = address;
            this.image = image;
        }

        public String getName() { return name; }
        public String getDob() { return dob; }
        public String getAddress() { return address; }
        public String getImage() { return image; }
    }
%>

<%
    // Khởi tạo danh sách khách hàng mẫu
    List<Customer> customerList = new ArrayList<>();
    customerList.add(new Customer("Mai Văn Hoàn", "1983-08-20", "Hà Nội", "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&h=100&fit=crop&crop=faces"));
    customerList.add(new Customer("Nguyễn Văn Nam", "1983-08-21", "Bắc Giang", "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=100&h=100&fit=crop&crop=faces"));
    customerList.add(new Customer("Nguyễn Thái Hòa", "1983-08-22", "Nam Định", "https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=100&h=100&fit=crop&crop=faces"));
    customerList.add(new Customer("Trần Đăng Khoa", "1983-08-17", "Hà Tây", "https://images.unsplash.com/photo-1580489944761-15a19d654956?w=100&h=100&fit=crop&crop=faces"));
    customerList.add(new Customer("Nguyễn Đình Thi", "1983-08-19", "Hà Nội", "https://images.unsplash.com/photo-1628157582853-a796fa650a6a?w=100&h=100&fit=crop&crop=faces"));

    // Đưa danh sách vào scope request để JSTL và EL truy xuất
    request.setAttribute("customerList", customerList);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh Sách Khách Hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8fafc;
            margin: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h2 {
            color: #1b2a7a;
            margin-bottom: 20px;
        }
        table {
            border-collapse: collapse;
            width: 80%;
            background-color: #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            border-radius: 6px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #e2e8f0;
            padding: 12px 16px;
            text-align: left;
        }
        th {
            background-color: #1b2a7a;
            color: white;
            font-size: 15px;
        }
        tr:nth-child(even) {
            background-color: #f8fafc;
        }
        tr:hover {
            background-color: #edf2f7;
        }
        .avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #ccc;
        }
        .center-col {
            text-align: center;
        }
    </style>
</head>
<body>

    <h2>DANH SÁCH KHÁCH HÀNG</h2>

    <table>
        <thead>
            <tr>
                <th class="center-col">STT</th>
                <th>Tên</th>
                <th>Ngày sinh</th>
                <th>Địa chỉ</th>
                <th class="center-col">Ảnh</th>
            </tr>
        </thead>
        <tbody>
            <%-- Sử dụng thẻ JSTL c:forEach để duyệt danh sách và in ra các dòng --%>
            <c:forEach var="customer" items="${customerList}" varStatus="status">
                <tr>
                    <td class="center-col">${status.count}</td>
                    <td><strong>${customer.name}</strong></td>
                    <td>${customer.dob}</td>
                    <td>${customer.address}</td>
                    <td class="center-col">
                        <img class="avatar" src="${customer.image}" alt="${customer.name}" />
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>