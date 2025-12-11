<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- HERO BANNER STYLE --- */
    .jumbotron-custom {
        /* --- THAY ĐỔI CHÍNH Ở ĐÂY --- */
        /* Đã xóa ảnh nền. Sử dụng Gradient Xanh Chàm đậm để tạo điểm nhấn và làm nổi tuyết trắng */
        /* Màu đi từ Xanh đậm hơi ngả xám (#3a6073) sang Xanh xám nhạt hơn (#8e9eab) */
        background: linear-gradient(135deg, #3a6073 0%, #8e9eab 100%);
        
        /* Chiều cao banner (có thể điều chỉnh) */
        height: 550px; 
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-align: center;
        position: relative;
        overflow: hidden;
        /* Viền vàng dưới đáy tạo sự liên kết với các phần khác */
        border-bottom: 4px solid #f1c40f; 
        box-shadow: 0 4px 20px rgba(0,0,0,0.1); /* Bóng nhẹ tạo chiều sâu */
    }

    .banner-content {
        font-family: 'Quicksand', sans-serif;
        max-width: 800px;
        padding: 30px;
        z-index: 2; /* Nổi lên trên lớp nền */
        animation: fadeInUp 0.8s ease-out;
    }

    /* Icon trang trí */
    .banner-icon {
        color: #f1c40f; /* Vàng lúa */
        filter: drop-shadow(0 2px 3px rgba(0,0,0,0.2));
        margin-bottom: 1.5rem;
    }

    /* Tiêu đề lớn */
    .display-4 {
        font-weight: 800;
        font-size: 3.8rem;
        margin-bottom: 1.2rem;
        /* Bóng chữ nhẹ hơn vì nền không còn quá tối như màu đen */
        text-shadow: 0 3px 6px rgba(0,0,0,0.2); 
        letter-spacing: 1px;
        line-height: 1.2;
    }
    
    .text-highlight {
        color: #f1c40f; /* Màu vàng lúa nhấn mạnh */
        position: relative;
        display: inline-block;
    }
    
    /* Gạch chân trang trí nhẹ dưới chữ Gạo Việt */
    .text-highlight::after {
        content: '';
        position: absolute;
        bottom: 5px;
        left: 0;
        width: 100%;
        height: 8px;
        background-color: rgba(241, 196, 15, 0.3); /* Vàng mờ */
        z-index: -1;
        border-radius: 4px;
    }

    /* Dòng mô tả */
    .lead {
        font-size: 1.4rem;
        font-weight: 500;
        margin-bottom: 2.8rem;
        text-shadow: 0 1px 3px rgba(0,0,0,0.2);
        opacity: 0.95;
        max-width: 700px;
        margin-left: auto;
        margin-right: auto;
    }

    /* --- Nút bấm --- */
    .btn-lg {
        padding: 14px 38px;
        font-size: 1.15rem;
        font-weight: 700;
        border-radius: 50px;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    /* Nút Mua Ngay (Gradient Vàng Cam) */
    .btn-warning-custom {
        background: linear-gradient(to right, #f1c40f, #f39c12);
        border: none;
        color: #fff;
        box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);
        margin-right: 15px;
    }

    .btn-warning-custom:hover {
        background: linear-gradient(to right, #f39c12, #e67e22);
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(243, 156, 18, 0.5);
    }

    /* Nút Tìm Hiểu (Trong suốt viền trắng) */
    .btn-outline-custom {
        background: rgba(255, 255, 255, 0.1); /* Nền trắng mờ nhẹ */
        border: 2px solid rgba(255,255,255,0.6);
        color: white;
        backdrop-filter: blur(5px); /* Hiệu ứng kính mờ nhẹ */
    }

    .btn-outline-custom:hover {
        background: white;
        border-color: white;
        color: #3a6073; /* Chữ chuyển sang màu xanh của nền */
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.2);
    }

    /* Animation */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Responsive */
    @media (max-width: 768px) {
        .jumbotron-custom { height: auto; padding: 80px 0; }
        .display-4 { font-size: 2.5rem; }
        .lead { font-size: 1.1rem; }
        .btn-lg { padding: 12px 25px; font-size: 1rem; width: 100%; margin: 5px 0; }
        .btn-warning-custom { margin-right: 0; }
    }
</style>

<div class="jumbotron-custom">
    <div class="banner-content">
        <i class="fas fa-seedling fa-4x banner-icon"></i>

        <h1 class="display-4">
            Gạo Ngon – <span class="text-highlight">Nông Sản Sạch</span>
        </h1>
        
        <p class="lead">
            Mang tinh túy hạt ngọc trời ban đến từng bữa cơm gia đình Việt. 
            Cam kết chất lượng, an toàn và trọn vị yêu thương.
        </p>
        
        <div class="mt-4 d-flex justify-content-center flex-wrap">
            <a href="shop" class="btn btn-warning-custom btn-lg mb-2 mb-md-0">
                <i class="fas fa-shopping-basket me-2"></i> Mua Ngay
            </a>
            <a href="#about" class="btn btn-outline-custom btn-lg">
                <i class="fas fa-leaf me-2"></i> Tìm Hiểu Thêm
            </a>
        </div>
    </div>
</div>