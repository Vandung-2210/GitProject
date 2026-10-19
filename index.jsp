<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Discount Calculator</title>
        <style>
            body { font-family: Arial, sans-serif; display: flex; justify-content: center; margin-top: 50px; background-color: #f8fafc; }
            .calculator-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 400px; }
            h2 { color: #1b2a7a; text-align: center; }
            .form-group { margin-bottom: 15px; }
            label { display: block; font-weight: bold; margin-bottom: 5px; color: #333; }
            input[type="text"], input[type="number"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
            button { background-color: #1b2a7a; color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-size: 16px; font-weight: bold; margin-top: 10px; }
            button:hover { background-color: #121c54; }
        </style>
    </head>
    <body>
        <div class="calculator-container">
            <h2>Product Discount Calculator</h2>
            <form action="display-discount" method="POST">
                <div class="form-group">
                    <label>Product Description:</label>
                    <input type="text" name="description" placeholder="Nhập mô tả sản phẩm..." required />
                </div>
                
                <div class="form-group">
                    <label>List Price ($):</label>
                    <input type="number" name="price" step="0.01" placeholder="Nhập giá niêm yết..." required />
                </div>
                
                <div class="form-group">
                    <label>Discount Percent (%):</label>
                    <input type="number" name="discount" step="0.01" placeholder="Nhập tỷ lệ chiết khấu..." required />
                </div>
                
                <button type="submit">Calculate Discount</button>
            </form>
        </div>
    </body>
</html>