<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="data.utils.API" %>

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- CẤU HÌNH CHUNG CHO TOÀN TRANG KHI DÙNG NAVBAR NÀY --- */
    body {
        font-family: 'Quicksand', sans-serif;
        overflow-x: hidden; /* Ngăn thanh cuộn ngang do tuyết rơi sát mép */
        position: relative; /* Để tuyết rơi đè lên background */
        min-height: 100vh;
    }

    /* --- HIỆU ỨNG TUYẾT RƠI (CSS) --- */
    .snowflake {
        position: absolute;
        top: -10px;
        /* Màu tuyết: Trắng hơi xanh nhẹ để hợp tone */
        background: #f0f8ff; 
        border-radius: 50%;
        pointer-events: none; /* Quan trọng: để chuột click xuyên qua tuyết */
        z-index: 1; /* Nằm dưới Navbar (z-index 1000) nhưng trên nền web */
        animation: fall linear forwards;
        filter: drop-shadow(0 0 1px rgba(255,255,255,0.9));
    }

    @keyframes fall {
        to {
            transform: translateY(105vh) rotate(360deg); /* Rơi xuống quá màn hình và xoay nhẹ */
        }
    }

    /* --- NAVBAR STYLE --- */
    .navbar {
        /* Nền trắng mờ (Glassmorphism) - Tuyết sẽ bay mờ ảo phía sau */
        background: rgba(255, 255, 255, 0.85);
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        padding: 12px 0;
        /* Sticky để menu luôn chạy theo khi cuộn trang */
        position: sticky;
        top: 0;
        z-index: 1000; /* Đảm bảo navbar luôn nổi trên tuyết */
        backdrop-filter: blur(12px); /* Hiệu ứng làm mờ hậu cảnh */
        border-bottom: 1px solid rgba(255,255,255,0.3);
    }

    /* Logo */
    .navbar-brand img {
        width: 50px;
        height: 50px;
        border-radius: 50%; 
        border: 2px solid #f1c40f; /* Viền vàng lúa */
        object-fit: cover;
    }
    .brand-text {
        color: #27ae60;
        font-weight: 700;
        font-size: 1.2rem;
        margin-left: 8px;
    }

    /* Links */
    .navbar-nav .nav-link {
        font-weight: 600;
        color: #2c3e50 !important;
        padding: 8px 16px;
        transition: all 0.3s;
        border-radius: 20px;
    }

    .navbar-nav .nav-link:hover, 
    .navbar-nav .nav-link.active {
        color: #27ae60 !important; /* Hover ra màu xanh lá */
        background-color: rgba(39, 174, 96, 0.1); /* Nền xanh rất nhạt khi hover */
    }

    /* Dropdown Menu */
    .dropdown-menu {
        border: none;
        border-radius: 12px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        margin-top: 10px;
        overflow: hidden;
        background: rgba(255, 255, 255, 0.95); /* Dropdown cũng hơi trong suốt */
    }
    
    .dropdown-item {
        font-weight: 500;
        padding: 10px 20px;
        color: #555;
        transition: 0.2s;
    }
    
    .dropdown-item:hover {
        background-color: #27ae60;
        color: #fff;
    }

    /* Search Box */
    .search-box {
        position: relative;
    }
    
    .search-box input {
        border-radius: 50px;
        border: 2px solid #e0e0e0;
        padding-left: 20px;
        padding-right: 45px;
        transition: 0.3s;
        width: 250px;
        background: rgba(255,255,255,0.9);
    }
    
    .search-box input:focus {
        border-color: #f1c40f; /* Focus màu vàng */
        box-shadow: 0 0 0 3px rgba(241, 196, 15, 0.2);
        background: #fff;
    }
    
    .search-box button {
        position: absolute;
        right: 5px;
        top: 50%;
        transform: translateY(-50%);
        border-radius: 50%;
        width: 32px;
        height: 32px;
        background: linear-gradient(135deg, #f1c40f, #f39c12);
        border: none;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: 0.3s;
        box-shadow: 0 2px 5px rgba(241, 196, 15, 0.3);
    }
    
    .search-box button:hover {
        transform: translateY(-50%) scale(1.05);
        background: linear-gradient(135deg, #e67e22, #d35400);
    }

    /* Icon Cart & User */
    .nav-icon-btn {
        position: relative;
        font-size: 1.3rem;
        color: #2c3e50;
        margin-left: 12px;
        transition: 0.3s;
        display: flex;
        align-items: center;
    }
    
    .nav-icon-btn:hover {
        color: #27ae60;
        transform: translateY(-2px);
    }

    /* Badge Cart */
    .cart-count {
        position: absolute;
        top: -8px;
        right: -10px;
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: white;
        font-size: 0.75rem;
        font-weight: bold;
        min-width: 20px;
        height: 20px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 2px solid #fff;
        padding: 0 4px;
    }
</style>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        
        <a class="navbar-brand d-flex align-items-center" href="home">
            <img src="assets/icon/logo.jpg" alt="Logo Rice" />
            <span class="brand-text">Phúc Rice</span>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <i class="fas fa-bars text-success" style="font-size: 1.5rem;"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0 align-items-center">
                
                <li class="nav-item">
                    <a class="nav-link active" href="home">Trang chủ</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        Sản phẩm
                    </a>
                    <ul class="dropdown-menu animate__animated animate__fadeIn">
                        
                        
                        <c:forEach var="c" items="${listCategory}">
                            <li>
                                <a class="dropdown-item" href="home?id_category=${c.id}">
                                    <i class="fas fa-seedling me-2 text-success" style="font-size: 0.9rem;"></i> ${c.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">Giới thiệu</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="#">Liên hệ</a>
                </li>

            </ul>

            <div class="d-flex align-items-center gap-2">

                <form class="search-box d-none d-lg-block me-2" action="search" method="get">
                    <input type="search" placeholder="Tìm loại gạo ngon..." name="keyword">
                    <button type="submit"><i class="fas fa-search" style="font-size: 0.9rem;"></i></button>
                </form>

                <a href="cart" class="nav-icon-btn" title="Giỏ hàng">
                    <i class="fas fa-shopping-basket"></i>
                    <span class="cart-count animate__animated animate__bounceIn">
                        <c:choose>
                            <c:when test="${not empty sessionScope.cart}">
                                ${fn:length(sessionScope.cart)}
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </span>
                </a>

                <c:if test="${user == null}">
                    <a href="login" class="btn btn-sm btn-success rounded-pill px-4 fw-bold ms-3 shadow-sm" 
                       style="background: linear-gradient(135deg, #27ae60, #2ecc71); border: none;">
                        Đăng nhập
                    </a>
                </c:if>

                <c:if test="${user != null}">
                    <div class="dropdown ms-2">
                        <a href="#" class="nav-icon-btn dropdown-toggle text-decoration-none d-flex align-items-center" data-bs-toggle="dropdown">
                           <div style="width: 35px; height: 35px; background: #f1c40f; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; border: 2px solid white; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                                ${fn:substring(API.getName(user.name), 0, 1)}
                           </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0">
                            <li><h6 class="dropdown-header fw-bold" style="color: #27ae60;">Xin chào, ${API.getName(user.name)}!</h6></li>
                            <li><a class="dropdown-item" href="profile"><i class="far fa-id-badge me-2 text-secondary"></i> Hồ sơ cá nhân</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger fw-semibold" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:if>

            </div>
        </div>
    </div>
</nav>

<div class="container d-lg-none py-3 bg-white shadow-sm" style="position: relative; z-index: 999;">
    <form class="d-flex w-100 position-relative" action="search" method="get">
        <input class="form-control rounded-pill ps-4 pe-5 border-1" type="search" placeholder="Bạn muốn tìm gạo gì..." name="keyword" style="background: #f8f9fa;">
        <button class="btn position-absolute end-0 top-50 translate-middle-y rounded-circle text-white me-1" 
                style="width: 38px; height: 38px; background: linear-gradient(135deg, #f1c40f, #f39c12); border: none; display: flex; align-items: center; justify-content: center;"
                type="submit">
            <i class="fas fa-search" style="font-size: 0.9rem;"></i>
        </button>
    </form>
</div>

<script>
    // Hàm tạo một bông tuyết
    function createSnowflake() {
        const snowflake = document.createElement('div');
        snowflake.classList.add('snowflake');
        
        // Random kích thước (nhỏ và tinh tế: 2px - 6px)
        const size = Math.random() * 4 + 2 + 'px';
        snowflake.style.width = size;
        snowflake.style.height = size;
        
        // Random vị trí xuất hiện theo chiều ngang (0% - 100% màn hình)
        snowflake.style.left = Math.random() * 100 + 'vw';
        
        // Random thời gian rơi (từ 5s đến 12s - rơi chậm cho nhẹ nhàng)
        const duration = Math.random() * 7 + 5 + 's';
        snowflake.style.animationDuration = duration;
        
        // Random độ mờ (0.3 - 0.8)
        snowflake.style.opacity = Math.random() * 0.5 + 0.3;

        // Thêm vào body
        document.body.appendChild(snowflake);

        // Xóa bông tuyết sau khi nó rơi xong để tránh nặng máy
        setTimeout(() => {
            snowflake.remove();
        }, parseFloat(duration) * 1000);
    }

    // Gọi hàm tạo tuyết liên tục (Cứ 150ms tạo 1 bông - mật độ vừa phải)
    // Sử dụng requestAnimationFrame hoặc setInterval. SetInterval dễ kiểm soát mật độ hơn.
    let snowInterval;

    // Chỉ bắt đầu rơi khi trang đã tải xong để tránh lag lúc đầu
    window.addEventListener('load', () => {
         // Kiểm tra nếu chưa có interval nào thì mới tạo (đề phòng import nhiều lần)
        if (!snowInterval) {
            snowInterval = setInterval(createSnowflake, 150);
        }
    });

    // (Tùy chọn) Dừng tuyết khi tab không hoạt động để tiết kiệm tài nguyên
    document.addEventListener("visibilitychange", function() {
        if (document.hidden) {
            clearInterval(snowInterval);
            snowInterval = null;
        } else {
            if (!snowInterval) {
                snowInterval = setInterval(createSnowflake, 150);
            }
        }
    });
</script>