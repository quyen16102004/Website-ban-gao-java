<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- CẤU HÌNH GIAO DIỆN GẠO --- */
    body {
        font-family: 'Quicksand', 'Segoe UI', sans-serif;
        background-color: #f8fdf6; /* Nền xanh rất nhạt */
    }

    /* Tiêu đề category */
    h3 {
        font-weight: 700;
        color: #2c3e50;
        border-left: 5px solid #f1c40f; /* Vàng lúa */
        padding-left: 15px;
        margin-bottom: 20px;
        text-transform: uppercase;
        font-size: 1.5rem;
    }

    /* Card sản phẩm */
    .card {
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        transition: all 0.3s ease;
        background: #fff;
        overflow: hidden;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        border-color: #27ae60; /* Viền xanh khi hover */
    }

    /* Ảnh sản phẩm */
    .card-img-container {
        position: relative;
        overflow: hidden;
        aspect-ratio: 1/1;
    }

    .card img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }

    .card:hover img {
        transform: scale(1.08); /* Zoom nhẹ ảnh khi hover */
    }

    /* Body card */
    .card-body {
        padding: 1rem;
        text-align: center;
    }

    /* Tên sản phẩm */
    .card-type {
        font-size: 1.1rem;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 8px;
        display: -webkit-box;
        -webkit-line-clamp: 2; /* Giới hạn 2 dòng tên */
        -webkit-box-orient: vertical;
        overflow: hidden;
        height: 2.8rem; /* Cố định chiều cao tên */
    }

    /* Giá sản phẩm */
    .card-price {
        font-size: 1.2rem;
        font-weight: 700;
        color: #27ae60; /* Màu xanh lá chủ đạo */
        margin-bottom: 10px;
    }

    /* Nút bấm */
    .btn-buy-now {
        background-color: #f1c40f; /* Vàng */
        color: #fff;
        font-weight: 600;
        border: none;
        border-radius: 50px;
        padding: 6px 15px;
        font-size: 0.9rem;
    }

    .btn-buy-now:hover {
        background-color: #d4ac0d;
        color: #fff;
    }

    .btn-add-cart {
        background-color: #fff;
        color: #27ae60;
        border: 1px solid #27ae60;
        font-weight: 600;
        border-radius: 50px;
        padding: 6px 15px;
        font-size: 0.9rem;
    }

    .btn-add-cart:hover {
        background-color: #27ae60;
        color: #fff;
    }

    /* Phân trang (Pagination) */
    .pagination .page-link {
        color: #27ae60;
        border: none;
        margin: 0 5px;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
    }

    .pagination .page-item.active .page-link {
        background-color: #27ae60;
        color: #fff;
    }

    .pagination .page-link:hover {
        background-color: #e8f5e9;
    }
</style>

<c:if test="${id_category == null}">
    <c:forEach var="c" items="${listCategory}">
        <section class="py-4">
            <div class="container">
                <header class="d-flex justify-content-between align-items-center mb-4">
                    <h3>${c.getName()}</h3>
                
                </header>

                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                    <c:forEach var="p" items="${listProduct}">
                        <c:if test ="${c.getId() == p.getId_category() && p.isStatus() == true}">
                            <div class="col">
                                <div class="card h-100 shadow-sm">
                                    <div class="card-img-container" style="cursor:pointer;" onclick="window.location.href = 'ProductDetail?id=${p.getId()}'">
                                        <img src="assets/images/${p.getImage()}" alt="${p.getName()}"/>
                                    </div>

                                    <div class="card-body">
                                        <a href="ProductDetail?id=${p.getId()}" class="text-decoration-none">
                                            <div class="card-type" title="${p.getName()}">${p.getName()}</div>
                                        </a>

                                        <div class="card-price">
                                            <fmt:formatNumber value="${p.getPrice()}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </div>

                                        <form action="AddToCart" method="get" class="d-flex justify-content-center gap-2 mt-2">
                                            <input type="hidden" name="id" value="${p.getId()}" />
                                            <input type="hidden" name="quantity" value="1" />

                                            <button type="submit" name="action" value="buy" class="btn btn-buy-now shadow-0">
                                                Mua ngay
                                            </button>
                                            <button type="submit" class="btn btn-add-cart shadow-0" title="Thêm vào giỏ">
                                                <i class="fas fa-cart-plus"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:forEach>
</c:if>

<c:if test="${id_category != null}">
    <c:forEach var="c" items="${listCategory}">
        <c:if test="${c.getId() == id_category}">
            <section class="py-5">
                <div class="container">
                    <header class="mb-4">
                        <h3>${c.getName()}</h3>
                    </header>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${listProduct}">
                            <c:if test ="${c.getId() == p.getId_category()}">
                                <div class="col">
                                    <div class="card h-100 shadow-sm">
                                        <div class="card-img-container" style="cursor:pointer;" onclick="window.location.href = 'ProductDetail?id=${p.getId()}'">
                                            <img src="assets/images/${p.getImage()}" alt="${p.getName()}"/>
                                        </div>
                                        <div class="card-body">
                                            <a href="ProductDetail?id=${p.getId()}" class="text-decoration-none">
                                                <div class="card-type">${p.getName()}</div>
                                            </a>
                                            <div class="card-text card-price">
                                                <fmt:formatNumber value="${p.getPrice()}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </div>

                                            <form action="AddToCart" method="get" class="d-flex justify-content-center gap-2 mt-2">
                                                <input type="hidden" name="id" value="${p.getId()}" />
                                                <input type="hidden" name="quantity" value="1" />
                                                <button type="submit" name="action" value="buy" class="btn btn-buy-now shadow-0">Mua ngay</button>
                                                <button type="submit" class="btn btn-add-cart shadow-0"><i class="fas fa-cart-plus"></i></button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>
    </c:forEach>
</c:if>

<div class="container my-4">
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${tag > 1}">
                <li class="page-item">
                    <a class="page-link" href="shop?index=${tag-1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>

            <c:forEach begin="1" end="${endP}" var="i">
                <li class="page-item ${tag == i ? 'active' : ''}">
                    <a class="page-link" href="shop?index=${i}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${tag < endP}">
                <li class="page-item">
                    <a class="page-link" href="shop?index=${tag+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
