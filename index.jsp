<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Simple Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 60px auto;
            display: flex;
            justify-content: center;
        }
        .calculator-card {
            background: #ffffff;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            padding: 30px;
            width: 380px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
        }
        h2 {
            margin-top: 0;
            color: #1f2937;
            text-align: center;
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #374151;
            font-size: 14px;
        }
        input[type="number"], select {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            padding: 10px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background-color: #1d4ed8;
        }
        .result-box {
            margin-top: 20px;
            padding: 15px;
            background-color: #ecfdf5;
            border-left: 5px solid #10b981;
            border-radius: 4px;
        }
        .error-box {
            margin-top: 20px;
            padding: 15px;
            background-color: #fef2f2;
            border-left: 5px solid #ef4444;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<%!
    public static class Calculator {
        public static float calculate(float firstOperand, float secondOperand, char operator) {
            switch (operator) {
                case '+':
                    return firstOperand + secondOperand;
                case '-':
                    return firstOperand - secondOperand;
                case '*':
                    return firstOperand * secondOperand;
                case '/':
                    if (secondOperand != 0) {
                        return firstOperand / secondOperand;
                    } else {
                        throw new RuntimeException("Can't divide by zero");
                    }
                default:
                    throw new RuntimeException("Invalid operation");
            }
        }
    }
%>

<div class="calculator-card">
    <h2>Simple Calculator</h2>
    
    <form action="index.jsp" method="POST">
        <div class="form-group">
            <label for="firstOperand">First operand:</label>
            <input type="number" step="any" id="firstOperand" name="firstOperand" 
                   value="<%= request.getParameter("firstOperand") != null ? request.getParameter("firstOperand") : "" %>" required />
        </div>

        <div class="form-group">
            <label for="operator">Operator:</label>
            <select id="operator" name="operator">
                <option value="+" <%= "+".equals(request.getParameter("operator")) ? "selected" : "" %>>Addition (+)</option>
                <option value="-" <%= "-".equals(request.getParameter("operator")) ? "selected" : "" %>>Subtraction (-)</option>
                <option value="*" <%= "*".equals(request.getParameter("operator")) ? "selected" : "" %>>Multiplication (*)</option>
                <option value="/" <%= "/".equals(request.getParameter("operator")) ? "selected" : "" %>>Division (/)</option>
            </select>
        </div>

        <div class="form-group">
            <label for="secondOperand">Second operand:</label>
            <input type="number" step="any" id="secondOperand" name="secondOperand" 
                   value="<%= request.getParameter("secondOperand") != null ? request.getParameter("secondOperand") : "" %>" required />
        </div>

        <button type="submit">Calculate</button>
    </form>

    <%
        String firstOpStr = request.getParameter("firstOperand");
        String secondOpStr = request.getParameter("secondOperand");
        String operatorStr = request.getParameter("operator");

        if (firstOpStr != null && secondOpStr != null && operatorStr != null) {
            try {
                float firstOperand = Float.parseFloat(firstOpStr);
                float secondOperand = Float.parseFloat(secondOpStr);
                char operator = operatorStr.charAt(0);

                float result = Calculator.calculate(firstOperand, secondOperand, operator);
    %>
        <div class="result-box">
            <h3 style="margin: 0; color: #065f46;">Result:</h3>
            <p style="margin: 6px 0 0 0; font-size: 16px;">
                <%= firstOperand %> <%= operator %> <%= secondOperand %> = <b><%= result %></b>
            </p>
        </div>
    <%
            } catch (Exception ex) {
    %>
        <div class="error-box">
            <h3 style="margin: 0; color: #991b1b;">Error:</h3>
            <p style="margin: 6px 0 0 0; font-size: 15px; color: #b91c1c;"><%= ex.getMessage() %></p>
        </div>
    <%
            }
        }
    %>
</div>

</body>
</html>