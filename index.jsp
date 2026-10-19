<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Từ điển Anh - Việt</title>
        <style>
            body { font-family: 'Arial', sans-serif; display: flex; justify-content: center; margin-top: 50px; background-color: #f8fafc; }
            .dictionary-container { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); text-align: center; width: 380px; }
            input { padding: 12px; margin: 15px 0; width: 90%; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 16px;}
            button { background-color: #1b2a7a; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 90%; font-weight: bold; font-size: 16px;}
            button:hover { background-color: #121c54; }
            .result { margin-top: 20px; padding: 15px; border-radius: 6px; background-color: #eef9f2; border: 1px solid #27ae60; }
            .error { margin-top: 20px; padding: 15px; border-radius: 6px; background-color: #fde8e8; border: 1px solid #e74c3c; color: #c0392b; }
        </style>
    </head>
    <body>
        <div class="dictionary-container">
            <h2 style="color: #1b2a7a;">Từ Điển Anh - Việt</h2>
            
            <form action="index.jsp" method="POST">
                <input type="text" name="word" placeholder="Nhập từ tiếng Anh..." required autofocus />
                <button type="submit">Tìm kiếm</button>
            </form>

            <%-- Xử lý Logic tra cứu trực tiếp trong file JSP --%>
            <%
                request.setCharacterEncoding("UTF-8");
                String searchWord = request.getParameter("word");

                if (searchWord != null && !searchWord.trim().isEmpty()) {
                    Map<String, String> dictionary = new HashMap<>();
                    dictionary.put("hello", "Xin chào");
                    dictionary.put("how", "Thế nào");
                    dictionary.put("book", "Quyển sách");
                    dictionary.put("computer", "Máy tính");
                    dictionary.put("student", "Sinh viên");

                    String result = dictionary.get(searchWord.trim().toLowerCase());

                    if (result != null) {
            %>
                        <div class="result">
                            <h3 style="color: #1b2a7a; margin: 0 0 5px 0;">Từ khóa: <%= searchWord %></h3>
                            <h4 style="color: #27ae60; margin: 5px 0 0 0;">Nghĩa tiếng Việt: <%= result %></h4>
                        </div>
            <%
                    } else {
            %>
                        <div class="error">
                            <strong>Không tìm thấy từ:</strong> <%= searchWord %>
                        </div>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>