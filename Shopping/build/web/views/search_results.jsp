<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/inc/header.jsp" />
<c:import url="/inc/navbar.jsp" />

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- CẤU HÌNH GIAO DIỆN --- */
    body {
        font-family: 'Quicksand', sans-serif;

        /* --- TONE MÀU SÁNG (GIỐNG LOGIN) --- */
        /* Gradient xanh nhạt pha chút xám bạc, rất sáng và sạch */
        background: linear-gradient(to bottom, #e0eafc, #cfdef3);

        min-height: 100vh;
        margin: 0;
        padding: 0;
    }

    /* Tiêu đề trang */
    .search-title {
        text-align: center;
        color: #2c3e50;
        margin: 40px 0;
        font-weight: 700;
        /* Bóng chữ nhẹ để tách biệt khỏi nền sáng */
        text-shadow: 0 1px 1px rgba(255,255,255,0.8);
    }

    .keyword-highlight {
        color: #d35400; /* Màu cam đậm */
        font-style: italic;
        background: rgba(255,255,255,0.5); /* Nền mờ nhẹ sau chữ */
        padding: 0 5px;
        border-radius: 5px;
    }

    /* Grid Layout */
    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
        gap: 30px;
        max-width: 1200px;
        margin: 0 auto 60px auto;
        padding: 0 20px;
    }

    /* --- CARD SẢN PHẨM --- */
    .product-item {
        background-color: #ffffff; /* Nền trắng tuyệt đối */
        border-radius: 15px;
        overflow: hidden;
        border: 1px solid rgba(255,255,255,0.6);
        /* Shadow mềm mại hơn để hợp với nền sáng */
        box-shadow: 0 10px 25px rgba(166, 171, 189, 0.5);
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
    }

    .product-item:hover {
        transform: translateY(-8px);
        /* Hover lên thì bóng đậm hơn và viền xanh */
        box-shadow: 0 15px 35px rgba(166, 171, 189, 0.7);
        border-color: #27ae60;
    }

    /* Link bao quanh */
    .product-link {
        text-decoration: none;
        color: inherit;
        flex-grow: 1;
    }

    /* Ảnh sản phẩm */
    .img-wrapper {
        width: 100%;
        height: 220px;
        overflow: hidden;
        position: relative;
        background: #fff; /* Đảm bảo nền ảnh trắng */
    }

    .product-item img {
        width: 100%;
        height: 100%;
        object-fit: cover; /* Hoặc 'contain' tùy ảnh của bạn */
        transition: transform 0.5s ease;
    }

    .product-item:hover img {
        transform: scale(1.08);
    }

    /* Nội dung card */
    .card-content {
        padding: 15px;
        text-align: center;
    }

    .product-item h3 {
        font-size: 1.15rem;
        color: #2c3e50;
        margin: 10px 0;
        font-weight: 700;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        height: 2.8rem;
    }

    .price {
        font-size: 1.25rem;
        color: #27ae60; /* Xanh lá */
        font-weight: 700;
        margin: 5px 0 15px 0;
    }

    /* Nút bấm */
    .action-buttons {
        padding: 0 15px 20px 15px;
        display: flex;
        justify-content: center;
        gap: 10px;
    }

    .btn-buy {
        background: linear-gradient(135deg, #f1c40f, #f39c12);
        color: white;
        padding: 8px 18px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9rem;
        transition: 0.3s;
        border: none;
        box-shadow: 0 4px 10px rgba(241, 196, 15, 0.3);
    }

    .btn-buy:hover {
        background: linear-gradient(135deg, #e67e22, #d35400);
        transform: translateY(-2px);
        color: white;
    }

    .btn-cart {
        background: #f8f9fa;
        color: #27ae60;
        padding: 8px 15px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9rem;
        border: 1px solid #27ae60;
        transition: 0.3s;
    }

    .btn-cart:hover {
        background: #27ae60;
        color: white;
        transform: translateY(-2px);
    }

    /* Thông báo không tìm thấy */
    .no-results {
        text-align: center;
        color: #7f8c8d;
        font-size: 1.2em;
        margin-top: 50px;
        /* Box trắng mờ để nổi trên nền sáng */
        background: rgba(255,255,255,0.6);
        padding: 40px;
        border-radius: 20px;
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
        border: 1px solid white;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    }

    .no-results i {
        font-size: 4rem;
        color: #bdc3c7; /* Màu xám nhạt */
        margin-bottom: 20px;
    }
</style>

<div class="container" style="min-height: 60vh;">

    <h2 class="search-title">
        <i class="fas fa-search me-2 text-success"></i>
        Kết quả tìm kiếm cho: <span class="keyword-highlight">"${keyword}"</span>
    </h2>

    <c:choose>
        <%-- CÓ KẾT QUẢ --%>
        <c:when test="${not empty searchResults}">
            <div class="product-grid">
                <c:forEach var="product" items="${searchResults}">
                    <div class="product-item">

                        <a class="product-link" href="ProductDetail?id=${product.id}">
                            <div class="img-wrapper">
                                <img src="assets/images/${product.getImage()}" alt="${product.getName()}">
                            </div>

                            <div class="card-content">
                                <h3>${product.name}</h3>
                                <p class="price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </p>
                            </div>
                        </a>

                        <div class="action-buttons">
                            <a class="btn-buy" href="AddToCart?id=${product.id}&quantity=1&action=buy">
                                Mua ngay
                            </a>
                            <a class="btn-cart" href="AddToCart?id=${product.id}&quantity=1" title="Thêm vào giỏ">
                                <i class="fas fa-cart-plus"></i>
                            </a>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:when>

        <%-- KHÔNG CÓ KẾT QUẢ --%>
        <c:otherwise>
            <div class="no-results">
                <i class="far fa-sad-tear"></i>
                <p>Rất tiếc, chúng tôi không tìm thấy sản phẩm nào phù hợp với từ khóa <strong>"${keyword}"</strong>.</p>
                <a href="shop" class="btn btn-success mt-3 rounded-pill px-4 fw-bold">Xem tất cả sản phẩm</a>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<c:import url="/inc/footer.jsp" />