<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chuyển đổi tiền tệ USD sang VNĐ</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            display: flex; 
            justify-content: center; 
            margin-top: 60px; 
            background-color: #f8fafc; 
        }
        .container { 
            background: white; 
            padding: 30px 40px; 
            border-radius: 8px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); 
            width: 380px; 
        }
        h2 { 
            color: #1b2a7a; 
            text-align: center; 
            margin-top: 0;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label { 
            display: block; 
            margin-bottom: 5px; 
            font-weight: bold; 
            color: #333; 
        }
        input[type="number"] { 
            width: 100%; 
            padding: 10px; 
            border: 1px solid #ccc; 
            border-radius: 4px; 
            box-sizing: border-box; 
        }
        button { 
            background-color: #1b2a7a; 
            color: white; 
            padding: 12px; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            width: 100%; 
            font-weight: bold; 
            font-size: 15px; 
            margin-top: 10px;
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
        }
        .error-box { 
            background-color: #ffebee; 
            padding: 15px; 
            border-radius: 6px; 
            margin-top: 20px; 
            border-left: 5px solid #c0392b;
            color: #c0392b;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>USD to VND Converter</h2>

    <!-- Form gửi dữ liệu về chính trang index.jsp -->
    <form action="index.jsp" method="POST">
        <div class="form-group">
            <label for="rate">Tỉ giá (VND/USD):</label>
            <input type="number" id="rate" name="rate" placeholder="Ví dụ: 25000" 
                   value="<%= request.getParameter("rate") != null ? request.getParameter("rate") : "25000" %>" 
                   required step="any"/>
        </div>

        <div class="form-group">
            <label for="usd">Lượng USD cần đổi:</label>
            <input type="number" id="usd" name="usd" placeholder="Nhập số USD" 
                   value="<%= request.getParameter("usd") != null ? request.getParameter("usd") : "" %>" 
                   required step="any"/>
        </div>

        <button type="submit">Tính toán</button>
    </form>

    <%-- Đoạn mã Java xử lý và in kết quả khi người dùng gửi form --%>
    <%
        String rateStr = request.getParameter("rate");
        String usdStr = request.getParameter("usd");

        // Chỉ tính toán và hiển thị khi đã có dữ liệu gửi lên
        if (rateStr != null && usdStr != null) {
            try {
                float rate = Float.parseFloat(rateStr);
                float usd = Float.parseFloat(usdStr);
                float vnd = rate * usd;
    %>
        <div class="result-box">
            <p style="margin: 5px 0;">Tỉ giá: <b><%= rate %></b> VND/USD</p>
            <p style="margin: 5px 0;">Số lượng: <b>$<%= usd %></b></p>
            <h3 style="color: #27ae60; margin: 10px 0 0 0;">Thành tiền: <%= vnd %> VNĐ</h3>
        </div>
    <%
            } catch (Exception e) {
    %>
        <div class="error-box">
            <b>Lỗi:</b> Dữ liệu nhập vào không hợp lệ. Vui lòng nhập số!
        </div>
    <%
            }
        }
    %>
</div>

</body>
</html>