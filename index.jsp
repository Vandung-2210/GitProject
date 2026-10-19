<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Currency Converter</title>
        <style>
            body { font-family: 'Arial', sans-serif; display: flex; justify-content: center; margin-top: 50px; background-color: #f8fafc; }
            .converter-container { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); text-align: center; width: 380px; }
            input { padding: 10px; margin: 10px 0; width: 90%; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
            button { background-color: #1b2a7a; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 90%; font-weight: bold; margin-top: 15px;}
            button:hover { background-color: #121c54; }
            .result { margin-top: 20px; padding: 15px; border-radius: 6px; background-color: #eef9f2; border: 1px solid #27ae60; }
            .error { margin-top: 20px; padding: 15px; border-radius: 6px; background-color: #fde8e8; border: 1px solid #e74c3c; color: #c0392b; }
        </style>
    </head>
    <body>
        <div class="converter-container">
            <h2 style="color: #1b2a7a;">Chuyển đổi USD sang VNĐ</h2>
            
            <!-- Form tự gửi dữ liệu về lại chính trang index.jsp -->
            <form action="index.jsp" method="POST">
                <div style="text-align: left; margin-left: 5%;">
                    <label style="font-weight: bold; color: #333;">Tỉ giá (VND/USD):</label>
                </div>
                <input type="number" name="rate" placeholder="Ví dụ: 25000" value="25000" required step="any"/>
                
                <div style="text-align: left; margin-left: 5%; margin-top: 10px;">
                    <label style="font-weight: bold; color: #333;">Lượng USD cần đổi:</label>
                </div>
                <input type="number" name="usd" placeholder="Nhập số USD" required step="any"/>
                
                <button type="submit">Chuyển đổi</button>
            </form>

            <%-- Xử lý Logic tính toán trực tiếp trong file JSP --%>
            <%
                String rateParam = request.getParameter("rate");
                String usdParam = request.getParameter("usd");

                if (rateParam != null && usdParam != null) {
                    try {
                        float rate = Float.parseFloat(rateParam);
                        float usd = Float.parseFloat(usdParam);
                        float vnd = rate * usd;
            %>
                        <div class="result">
                            <h3 style="color: #27ae60; margin: 0 0 10px 0;">KẾT QUẢ CHUYỂN ĐỔI</h3>
                            <p style="margin: 5px 0;">Tỉ giá: <%= rate %> VND/USD</p>
                            <p style="margin: 5px 0;">Lượng USD: $<%= usd %></p>
                            <h4 style="color: #1b2a7a; margin: 10px 0 0 0;">Thành tiền: <%= vnd %> VNĐ</h4>
                        </div>
            <%
                    } catch (NumberFormatException e) {
            %>
                        <div class="error">
                            <strong>Lỗi:</strong> Vui lòng nhập số hợp lệ!
                        </div>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>