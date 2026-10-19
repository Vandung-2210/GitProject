<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Từ điển Anh - Việt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            margin-top: 80px;
            background-color: #f8fafc;
        }
        .dictionary-container {
            background: white;
            padding: 35px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
            width: 380px;
        }
        h2 {
            color: #1b2a7a;
            margin-top: 0;
        }
        input[type="text"] {
            padding: 12px;
            margin: 15px 0;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 15px;
        }
        button {
            background-color: #1b2a7a;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
            font-size: 16px;
        }
        button:hover {
            background-color: #121c54;
        }
        .result-box {
            background-color: #e8f5e9;
            padding: 15px;
            border-radius: 6px;
            margin-top: 20px;
            border-left: 5px solid #27ae60;
            text-align: left;
        }
        .notfound-box {
            background-color: #ffebee;
            padding: 15px;
            border-radius: 6px;
            margin-top: 20px;
            border-left: 5px solid #c0392b;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="dictionary-container">
        <h2>Từ Điển Anh - Việt</h2>
        
        <!-- Form gửi dữ liệu trực tiếp về trang index.jsp bằng phương thức POST -->
        <form action="index.jsp" method="POST">
            <input type="text" name="search" placeholder="Nhập từ tiếng Anh (hello, book, computer...)" 
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" 
                   required autofocus />
            <button type="submit">Tìm kiếm</button>
        </form>

        <%-- Xử lý tra cứu trực tiếp bằng Scriptlet --%>
        <%
            request.setCharacterEncoding("UTF-8");
            String searchWord = request.getParameter("search");
            
            if (searchWord != null && !searchWord.trim().isEmpty()) {
                // Khởi tạo Map dữ liệu từ điển
                Map<String, String> dic = new HashMap<>();
                dic.put("hello", "Xin chào");
                dic.put("how", "Thế nào");
                dic.put("book", "Quyển sách");
                dic.put("computer", "Máy tính");
                dic.put("student", "Sinh viên");
                dic.put("teacher", "Giáo viên");
                dic.put("school", "Trường học");
                
                String result = dic.get(searchWord.trim().toLowerCase());
                
                if (result != null) {
        %>
            <div class="result-box">
                <p style="font-size: 15px; color: #555; margin: 0 0 5px 0;">Từ cần tra: <b style="color: #1b2a7a;"><%= searchWord %></b></p>
                <h3 style="color: #27ae60; font-size: 20px; margin: 0;">Nghĩa là: <%= result %></h3>
            </div>
        <%
                } else {
        %>
            <div class="notfound-box">
                <h4 style="color: #c0392b; margin: 0 0 5px 0;">Không tìm thấy!</h4>
                <p style="color: #555; margin: 0;">Từ khóa <b style="color: #c0392b;"><%= searchWord %></b> không có trong từ điển.</p>
            </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>