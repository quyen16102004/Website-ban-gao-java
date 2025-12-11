<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Product" %>

<%-- Lấy đối tượng Product từ request --%>
<%
    Product p = (Product) request.getAttribute("product");
    // Lưu vào pageScope để dùng JSTL cho tiện
    pageContext.setAttribute("p", p);
%>

<c:import url="/inc/header.jsp" />
<c:import url="/inc/navbar.jsp" />

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- CẤU HÌNH CHUNG --- */
    body {
        font-family: 'Quicksand', sans-serif;
        /* Gradient nền sáng giống Login/Search để thấy tuyết */
        background: linear-gradient(to bottom, #e0eafc, #cfdef3);
        min-height: 100vh;
    }

    /* --- BREADCRUMB --- */
    .breadcrumb-nav {
        margin: 20px 0;
        font-size: 0.9rem;
        color: #555;
    }
    .breadcrumb-nav a {
        color: #27ae60;
        text-decoration: none;
        font-weight: 600;
    }
    .breadcrumb-nav a:hover {
        text-decoration: underline;
    }

    /* --- PRODUCT CARD CONTAINER --- */
    .product-detail-card {
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        padding: 40px;
        margin-bottom: 40px;
        animation: fadeInUp 0.8s ease-out;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* --- ẢNH SẢN PHẨM --- */
    .product-image-box {
        border-radius: 15px;
        overflow: hidden;
        border: 1px solid #eee;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        background: #fff;
    }
    
    .product-image-box img {
        width: 100%;
        height: auto;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .product-image-box:hover img {
        transform: scale(1.05);
    }

    /* --- THÔNG TIN SẢN PHẨM --- */
    .product-title {
        color: #2c3e50;
        font-weight: 700;
        font-size: 2rem;
        margin-bottom: 10px;
    }

    .product-meta {
        font-size: 0.9rem;
        color: #7f8c8d;
        margin-bottom: 20px;
    }
    
    .rating i {
        color: #f1c40f;
    }

    .product-price {
        font-size: 2rem;
        color: #27ae60; /* Màu xanh lá chủ đạo */
        font-weight: 700;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
    }

    .status-badge {
        font-size: 0.9rem;
        padding: 5px 12px;
        border-radius: 50px;
        font-weight: 600;
        margin-left: 15px;
    }
    
    .status-in-stock {
        background: #e8f5e9;
        color: #27ae60;
    }
    
    .status-out-stock {
        background: #fdecea;
        color: #e74c3c;
    }

    .short-desc {
        color: #555;
        line-height: 1.6;
        margin-bottom: 30px;
        border-top: 1px solid #eee;
        border-bottom: 1px solid #eee;
        padding: 20px 0;
    }

    /* --- BỘ CHỌN SỐ LƯỢNG --- */
    .quantity-selector {
        display: flex;
        align-items: center;
        margin-bottom: 25px;
    }
    
    .qty-btn {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        border: 1px solid #ddd;
        background: #fff;
        font-weight: bold;
        cursor: pointer;
        transition: 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .qty-btn:hover {
        background: #f1c40f;
        color: white;
        border-color: #f1c40f;
    }
    
    .qty-input {
        width: 50px;
        text-align: center;
        border: none;
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 10px;
    }
    
    .qty-input:focus {
        outline: none;
    }

    /* --- NÚT BẤM --- */
    .btn-buy-now {
        background: linear-gradient(135deg, #f1c40f, #f39c12);
        color: white;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 700;
        font-size: 1.1rem;
        border: none;
        transition: 0.3s;
        width: 100%;
        box-shadow: 0 5px 15px rgba(241, 196, 15, 0.4);
    }
    
    .btn-buy-now:hover {
        background: linear-gradient(135deg, #e67e22, #d35400);
        transform: translateY(-2px);
        color: white;
    }

    .btn-add-cart {
        background: white;
        color: #27ae60;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 700;
        font-size: 1.1rem;
        border: 2px solid #27ae60;
        transition: 0.3s;
        width: 100%;
        margin-left: 10px;
    }
    
    .btn-add-cart:hover {
        background: #27ae60;
        color: white;
        transform: translateY(-2px);
    }

</style>

<div class="container py-4">

    <div class="product-detail-card">
        <div class="row">
            
            <div class="col-md-5 mb-4 mb-md-0">
                <div class="product-image-box">
                    <img src="assets/images/${p.image}" alt="${p.name}" class="img-fluid">
                </div>
            </div>

            <div class="col-md-7 ps-md-5">
                <h1 class="product-title">${p.name}</h1>
                
                <div class="product-meta d-flex align-items-center">
                    <div class="rating me-3">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <span class="text-secondary ms-1">(4.5)</span>
                    </div>
                    <span class="text-secondary">| &nbsp; Mã SP: #PR<%= p.getId() %></span>
                </div>

                <div class="product-price">
                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    
                    <span class="status-badge ${p.status ? 'status-in-stock' : 'status-out-stock'}">
                        <i class="fas ${p.status ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                        ${p.status ? 'Còn hàng' : 'Hết hàng'}
                    </span>
                </div>


                <form action="AddToCart" method="get">
                    <input type="hidden" name="id" value="${p.id}">
                    
                    <div class="quantity-selector">
                        <span class="fw-bold me-3">Số lượng:</span>
                        <div class="d-flex align-items-center border rounded-pill px-2 py-1">
                            <button type="button" class="qty-btn" onclick="decreaseQty()">-</button>
                            <input type="number" name="quantity" id="quantity" value="1" min="1" max="${p.quantity}" class="qty-input">
                            <button type="button" class="qty-btn" onclick="increaseQty()">+</button>
                        </div>
                        <span class="text-secondary ms-3" style="font-size: 0.9rem;">(${p.quantity} sản phẩm có sẵn)</span>
                    </div>

                    <div class="d-flex mt-4">
                        <button type="submit" name="action" value="buy" class="btn-buy-now">
                            <i class="fas fa-shopping-basket me-2"></i> Mua Ngay
                        </button>
                        <button type="submit" class="btn-add-cart">
                            <i class="fas fa-cart-plus me-2"></i> Thêm vào giỏ
                        </button>
                    </div>
                </form>

            </div>
        </div>

    </div>
</div>

<c:import url="/inc/footer.jsp" />

<script>
    function increaseQty() {
        var qtyInput = document.getElementById('quantity');
        var currentVal = parseInt(qtyInput.value);
        var maxVal = parseInt(qtyInput.getAttribute('max'));
        
        if (!isNaN(currentVal) && currentVal < maxVal) {
            qtyInput.value = currentVal + 1;
        }
    }

    function decreaseQty() {
        var qtyInput = document.getElementById('quantity');
        var currentVal = parseInt(qtyInput.value);
        
        if (!isNaN(currentVal) && currentVal > 1) {
            qtyInput.value = currentVal - 1;
        }
    }
</script>