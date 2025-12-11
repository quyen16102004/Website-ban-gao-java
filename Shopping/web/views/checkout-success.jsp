<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Cart" %>

<%-- Lấy dữ liệu từ Servlet và đẩy vào pageContext để dùng JSTL --%>
<%
    List<Cart> cartList = (List<Cart>) request.getAttribute("cartList");
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    
    // Đẩy biến ra scope để dùng thẻ <c:forEach> và <fmt:>
    pageContext.setAttribute("cartList", cartList);
    pageContext.setAttribute("totalAmount", totalAmount);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Đặt hàng thành công - Phúc Rice</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* --- CẤU HÌNH GIAO DIỆN CHUNG --- */
        body {
            font-family: 'Quicksand', sans-serif;
            /* Gradient sáng (Winter Sky) để hợp với tuyết rơi từ Navbar */
            background: linear-gradient(to bottom, #e0eafc, #cfdef3);
            min-height: 100vh;
        }

        /* --- SUCCESS CARD --- */
        .success-section {
            padding: 50px 0;
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            padding: 40px;
            width: 100%;
            max-width: 800px;
            border: 1px solid rgba(255,255,255,0.8);
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Dải màu trang trí phía trên card */
        .success-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(to right, #2ecc71, #27ae60);
        }

        /* --- ICON SUCCESS --- */
        .icon-circle {
            width: 80px;
            height: 80px;
            background: #e8f5e9;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
        }

        .success-icon {
            font-size: 40px;
            color: #27ae60;
        }

        .success-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .order-id {
            background: #f8f9fa;
            display: inline-block;
            padding: 5px 15px;
            border-radius: 50px;
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 30px;
            border: 1px solid #eee;
        }

        /* --- TABLE --- */
        .table-custom {
            margin-top: 20px;
            border: 1px solid #f1f1f1;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .table-custom thead th {
            background: #f9f9f9;
            color: #555;
            font-weight: 600;
            border-bottom: 2px solid #eee;
        }
        
        .price {
            color: #27ae60;
            font-weight: 700;
        }
        
        .total-row {
            background: #fef9e7; /* Màu vàng nhạt */
        }
        
        .total-amount {
            font-size: 1.3rem;
            color: #d35400;
            font-weight: 800;
        }

        /* --- BUTTONS --- */
        .btn-home {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            padding: 10px 30px;
            border-radius: 50px;
            font-weight: 700;
            border: none;
            transition: 0.3s;
            text-decoration: none;
            box-shadow: 0 4px 10px rgba(39, 174, 96, 0.3);
        }

        .btn-home:hover {
            background: linear-gradient(135deg, #219150, #27ae60);
            transform: translateY(-2px);
            color: white;
        }

        .btn-print {
            background: #fff;
            color: #7f8c8d;
            border: 1px solid #ddd;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            margin-right: 10px;
            transition: 0.3s;
        }

        .btn-print:hover {
            background: #f8f9fa;
            color: #2c3e50;
        }
    </style>
</head>
<body>

    <c:import url="/inc/header.jsp" />
    <c:import url="/inc/navbar.jsp" />

    <div class="success-section">
        <div class="container d-flex justify-content-center">
            
            <div class="success-card">
                <div class="icon-circle animate__animated animate__bounceIn">
                    <i class="fas fa-check success-icon"></i>
                </div>

                <h2 class="success-title">Thanh toán thành công!</h2>
                <p class="text-secondary mb-2">Cảm ơn bạn đã tin tưởng và ủng hộ <strong>Phúc Rice</strong>.</p>
                <p class="text-secondary mb-3">Đơn hàng của bạn đang được xử lý và sẽ sớm được giao đi.</p>
                
                <div class="order-id">
                    Mã đơn hàng: <strong>#ORD<%= System.currentTimeMillis() % 10000 %></strong>
                </div>

                <div class="table-responsive table-custom">
                    <table class="table table-borderless text-center align-middle mb-0">
                        <thead>
                            <tr>
                                <th class="text-start ps-4">Sản phẩm</th>
                                <th>Giá</th>
                                <th>SL</th>
                                <th class="text-end pe-4">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${cartList}">
                                <tr style="border-bottom: 1px solid #f9f9f9;">
                                    <td class="text-start ps-4 fw-bold text-dark">
                                        ${c.product.name}
                                    </td>
                                    <td class="text-secondary">
                                        <fmt:formatNumber value="${c.product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">x${c.quantity}</span>
                                    </td>
                                    <td class="price text-end pe-4">
                                        <fmt:formatNumber value="${c.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="total-row">
                                <td colspan="3" class="text-end fw-bold pt-3 pb-3">Tổng thanh toán:</td>
                                <td class="total-amount text-end pe-4 pt-3 pb-3">
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="mt-4 pt-2">
                    <a href="${pageContext.request.contextPath}/home" class="btn-home">
                        <i class="fas fa-arrow-left me-2"></i> Tiếp tục mua sắm
                    </a>
                </div>

            </div>
        </div>
    </div>

    <c:import url="/inc/footer.jsp" />

</body>
</html>