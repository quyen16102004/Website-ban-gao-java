<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Cart" %>
<%@ page import="model.User" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- --- LOGIC CŨ CỦA BẠN (GIỮ NGUYÊN) --- --%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String cartKey = "cart_" + user.getId();
    List<Cart> cartList = (List<Cart>) session.getAttribute(cartKey);
    if (cartList == null) {
        cartList = new java.util.ArrayList<>();
    }
    
    // Helper để format tiền tệ cho đẹp (Ví dụ: 100,000 ₫)
    DecimalFormat formatter = new DecimalFormat("###,###,###");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Phúc Rice</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background-color: #f8f9fa;
        }
        
        /* Chỉnh ảnh sản phẩm vuông vức, đẹp */
        .cart-item-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }

        /* Nút số lượng nhỏ gọn */
        .btn-qty {
            width: 30px;
            height: 30px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 12px;
            transition: all 0.2s;
        }
        
        .btn-qty:hover {
            background-color: #0d6efd;
            color: white;
            border-color: #0d6efd;
        }

        /* Phần tổng tiền bên phải sticky khi cuộn trang */
        .summary-card {
            position: sticky;
            top: 20px;
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
        }

        .payment-icon {
            height: 30px;
            margin-right: 5px;
            margin-bottom: 5px;
            opacity: 0.8;
        }
    </style>
</head>

<body class="bg-light">

<div class="container py-5">
    
    <%-- Message thông báo (Logic cũ) --%>
    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
        <div class="alert alert-warning alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="fas fa-info-circle me-2"></i> <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <%-- CHECK GIỎ HÀNG TRỐNG --%>
    <% if (cartList.isEmpty()) { %>
        <div class="text-center py-5 bg-white rounded-3 shadow-sm">
            <img src="https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-2130356-1800917.png" alt="Empty Cart" style="width: 200px; opacity: 0.8;">
            <h4 class="mt-3 fw-bold text-muted">Giỏ hàng của bạn đang trống</h4>
            <p class="text-secondary">Hãy thêm vài món ngon vào giỏ nhé!</p>
            <a href="<%=request.getContextPath()%>/home" class="btn btn-primary rounded-pill px-4 mt-2">
                <i class="fas fa-arrow-left me-2"></i> Quay lại mua sắm
            </a>
        </div>
    <% } else { %>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-dark">
                            <i class="fas fa-shopping-bag me-2 text-primary"></i> Giỏ hàng 
                            <span class="badge bg-light text-dark border ms-1"><%= cartList.size() %> món</span>
                        </h5>
                    </div>

                    <div class="card-body p-0">
                        <%-- VÒNG LẶP SẢN PHẨM --%>
                        <%
                            double total = 0;
                            for (Cart c : cartList) {
                                total += c.getTotalPrice();
                        %>
                        
                        <div class="p-3 border-bottom position-relative">
                            <div class="row align-items-center">
                                <div class="col-3 col-md-2">
                                    <img src="<%=request.getContextPath()%>/assets/images/<%=c.getProduct().getImage()%>" 
                                         class="cart-item-img" alt="<%= c.getProduct().getName() %>">
                                </div>

                                <div class="col-9 col-md-4">
                                    <h6 class="mb-1 fw-bold text-dark"><%= c.getProduct().getName() %></h6>
                                    <small class="text-muted d-block mb-1">Mã SP: #<%= c.getProduct().getId() %></small>
                                    <div class="fw-bold text-success d-md-none"><%= formatter.format(c.getProduct().getPrice()) %> ₫</div>
                                </div>

                                <div class="col-6 col-md-3 mt-3 mt-md-0 d-flex justify-content-start justify-content-md-center">
                                    <div class="input-group input-group-sm" style="width: 110px;">
                                        <a href="<%=request.getContextPath()%>/cart?action=updateQuantity&type=decrease&id=<%=c.getProduct().getId()%>" 
                                           class="btn btn-outline-secondary btn-qty text-decoration-none fw-bold">-</a>
                                        
                                        <input type="text" class="form-control text-center border-secondary border-start-0 border-end-0 bg-white" 
                                               value="<%= c.getQuantity() %>" readonly style="font-weight: 600;">
                                        
                                        <a href="<%=request.getContextPath()%>/cart?action=updateQuantity&type=increase&id=<%=c.getProduct().getId()%>" 
                                           class="btn btn-outline-secondary btn-qty text-decoration-none fw-bold">+</a>
                                    </div>
                                </div>

                                <div class="col-6 col-md-3 mt-3 mt-md-0 text-end">
                                    <div class="fw-bold text-dark mb-2 d-none d-md-block">
                                        <%= formatter.format(c.getTotalPrice()) %> ₫
                                    </div>
                                    <a href="<%=request.getContextPath()%>/cart?action=remove&id=<%=c.getProduct().getId()%>" 
                                       class="text-danger small text-decoration-none"
                                       onclick="return confirm('Xóa sản phẩm này?')">
                                        <i class="fas fa-trash-alt me-1"></i> Xóa
                                    </a>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    
                    <div class="card-footer bg-white py-3">
                        <a href="<%=request.getContextPath()%>/home" class="text-decoration-none fw-bold text-primary">
                            <i class="fas fa-long-arrow-alt-left me-2"></i> Tiếp tục mua hàng
                        </a>
                    </div>
                </div>
                
                <div class="mt-4 text-muted small">
                    <i class="fas fa-lock me-1"></i> Thông tin thanh toán được bảo mật an toàn.
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card summary-card bg-white">
                    <div class="card-header bg-primary text-white py-3">
                        <h5 class="mb-0 fw-bold">Tóm tắt đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
                                Tạm tính
                                <span><%= formatter.format(total) %> ₫</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0 text-success">
                                Phí vận chuyển
                                <span>Miễn phí</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pt-3 mt-3 border-top">
                                <span class="fw-bold">Tổng cộng</span>
                                <span class="fw-bold text-primary fs-4"><%= formatter.format(total) %> ₫</span>
                            </li>
                            <li class="list-group-item border-0 px-0 pb-0 text-end text-muted small">
                                (Đã bao gồm VAT)
                            </li>
                        </ul>

                        <form action="<%=request.getContextPath()%>/checkout" method="post">
                            <button type="submit" class="btn btn-warning w-100 py-2 fw-bold shadow-sm text-dark text-uppercase">
                                Thanh toán ngay
                            </button>
                        </form>

                        <div class="mt-4 pt-3 border-top text-center">
                            <p class="small text-muted mb-2">Chấp nhận thanh toán</p>
                            <div>
                                <i class="fab fa-cc-visa fa-2x text-primary me-2"></i>
                                <i class="fab fa-cc-mastercard fa-2x text-danger me-2"></i>
                                <i class="fab fa-cc-paypal fa-2x text-primary me-2"></i>
                                <i class="fas fa-money-bill-wave fa-2x text-success"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>