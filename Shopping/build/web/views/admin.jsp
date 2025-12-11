<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - Gạo Ngon</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

        <style>
            /* --- 1. Cấu hình chung --- */
            body {
                font-family: 'Quicksand', sans-serif;
                background: linear-gradient(180deg, #b8c6db 0%, #f5f7fa 90%); /* Nền mùa đông */
                margin: 0;
                padding: 0;
                min-height: 100vh;
                overflow-x: hidden;
            }

            /* --- 3. Sidebar (Menu bên trái) --- */
            .sidebar {
                height: 100vh;
                width: 250px;
                position: fixed;
                top: 0;
                left: 0;
                /* Gradient xanh lá đậm sang trọng */
                background: linear-gradient(180deg, #198754 0%, #0f5132 100%);
                padding-top: 30px;
                z-index: 100; /* Nổi trên tuyết */
                box-shadow: 4px 0 15px rgba(0,0,0,0.1);
            }

            .sidebar-brand {
                text-align: center;
                color: #fff;
                margin-bottom: 2rem;
                font-weight: 700;
                font-size: 1.5rem;
            }
            .sidebar-brand i {
                color: #f1c40f;
                font-size: 1.8rem;
                margin-right: 5px;
            }

            .sidebar a {
                display: flex;
                align-items: center;
                color: rgba(255,255,255,0.8);
                padding: 15px 25px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
                border-left: 4px solid transparent;
            }

            .sidebar a i {
                margin-right: 15px;
                font-size: 1.2rem;
            }

            .sidebar a:hover, .sidebar a.active {
                background: rgba(255,255,255,0.1);
                color: #fff;
                border-left-color: #f1c40f; /* Vàng lúa */
            }

            /* --- 4. Main Content (Nội dung chính) --- */
            .content {
                margin-left: 250px;
                padding: 30px;
                position: relative;
                z-index: 10; /* Nổi trên tuyết */
            }

            /* Header kính mờ */
            .header-card {
                background: rgba(255, 255, 255, 0.85); /* Trong suốt nhẹ */
                backdrop-filter: blur(10px);
                padding: 20px 30px;
                border-radius: 15px;
                border: 1px solid #fff;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .header-title h1 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 700;
                color: #198754;
            }
            .header-title span {
                font-size: 0.9rem;
                color: #6c757d;
            }

            /* Dashboard Cards */
            .stat-card {
                background: #fff;
                border-radius: 15px;
                padding: 20px;
                border: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                transition: transform 0.3s;
                height: 100%;
            }
            .stat-card:hover {
                transform: translateY(-5px);
            }
            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 15px;
            }
            .bg-green-soft {
                background: #d1e7dd;
                color: #198754;
            }
            .bg-blue-soft {
                background: #cfe2ff;
                color: #0d6efd;
            }
            .bg-yellow-soft {
                background: #fff3cd;
                color: #ffc107;
            }

            /* Alert Custom */
            .alert-custom {
                background: rgba(255, 255, 255, 0.9);
                border-left: 5px solid #198754;
                border-radius: 10px;
                color: #2c3e50;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }
        </style>
    </head>
    <body>


        <div class="sidebar">
            <div class="sidebar-brand">
                <i class="bi bi-flower1"></i> Admin Panel
            </div>

            <a href="${pageContext.request.contextPath}/admin" class="active">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/product">
                <i class="bi bi-box-seam"></i> Quản lý sản phẩm
            </a>
            <a href="#">
                <i class="bi bi-people"></i> Quản lý người dùng
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="mt-5 text-warning">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </div>

        <div class="content">

            <div class="header-card">
                <div class="header-title">
                    <h1>Xin chào, Quản trị viên!</h1>
                    <span>Chúc một ngày làm việc hiệu quả.</span>
                </div>
                <div>
                    <button class="btn btn-outline-success rounded-pill px-4">
                        <i class="bi bi-person-circle"></i> Profile
                    </button>
                </div>
            </div>

            <div class="alert alert-custom p-4 mb-4">
                <div class="d-flex align-items-center">
                    <i class="bi bi-check-circle-fill text-success fs-3 me-3"></i>
                    <div>
                        <h5 class="mb-1 fw-bold">Trạng thái đăng nhập</h5>
                        <p class="mb-0">Bạn đang truy cập với quyền hạn cao nhất (Admin).</p>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon bg-green-soft">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <h3 class="fw-bold">120</h3>
                        <p class="text-secondary mb-0">Sản phẩm tồn kho</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon bg-blue-soft">
                            <i class="bi bi-cart-check"></i>
                        </div>
                        <h3 class="fw-bold">45</h3>
                        <p class="text-secondary mb-0">Đơn hàng hôm nay</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon bg-yellow-soft">
                            <i class="bi bi-people"></i>
                        </div>
                        <h3 class="fw-bold">1,250</h3>
                        <p class="text-secondary mb-0">Thành viên</p>
                    </div>
                </div>
            </div>

        </div>

    </body>
</html>