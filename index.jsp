<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Product Discount Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f7f9fa;
        }
        .container {
            width: 380px;
            padding: 24px;
            background: #ffffff;
            border: 1px solid #dcdfe6;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        h2 {
            margin-top: 0;
            font-size: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            font-weight: bold;
            color: #495057;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Product Discount Calculator</h2>
    <form action="display-discount" method="POST">
        <div class="form-group">
            <label for="description">Product Description:</label>
            <input type="text" id="description" name="description" placeholder="Mô tả sản phẩm" required>
        </div>

        <div class="form-group">
            <label for="price">List Price ($):</label>
            <input type="number" step="0.01" min="0" id="price" name="price" placeholder="Giá niêm yết" required>
        </div>

        <div class="form-group">
            <label for="discount">Discount Percent (%):</label>
            <input type="number" step="0.1" min="0" max="100" id="discount" name="discount" placeholder="Tỷ lệ chiết khấu" required>
        </div>

        <button type="submit">Calculate Discount</button>
    </form>
</div>

</body>
</html>