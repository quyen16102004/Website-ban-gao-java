<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - Gạo Ngon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        /* --- 1. Cấu hình chung --- */
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(180deg, #b8c6db 0%, #f5f7fa 90%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* --- 3. Sidebar --- */
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background: linear-gradient(180deg, #198754 0%, #0f5132 100%);
            padding-top: 30px;
            z-index: 100;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }
        .sidebar-brand {
            text-align: center;
            color: #fff;
            margin-bottom: 2rem;
            font-weight: 700;
            font-size: 1.5rem;
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
        .sidebar a:hover, .sidebar a.active {
            background: rgba(255,255,255,0.1);
            color: #fff;
            border-left-color: #f1c40f;
        }
        .sidebar a i { margin-right: 15px; font-size: 1.2rem; }

        /* --- 4. Main Content --- */
        .content {
            margin-left: 250px;
            padding: 40px;
            position: relative;
            z-index: 10;
        }

        /* --- 5. Table Card Style --- */
        .table-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid #f0e68c;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
        }

        .page-title {
            color: #198754;
            font-weight: 700;
            margin: 0;
            font-size: 1.8rem;
        }

        /* Table Styling */
        .table thead th {
            background-color: #198754;
            color: white;
            border: none;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
        }
        .table tbody td {
            vertical-align: middle;
            text-align: center;
            color: #2c3e50;
        }
        /* Bo tròn góc bảng */
        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .product-img {
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #dee2e6;
            transition: transform 0.2s;
        }
        .product-img:hover {
            transform: scale(1.1);
        }

        /* Buttons */
        .btn-add {
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            color: white;
            border: none;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 20px;
            transition: 0.3s;
            text-decoration: none;
        }
        .btn-add:hover {
            background: linear-gradient(135deg, #27ae60 0%, #219150 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
            color: white;
        }

        .action-btn {
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: 0.2s;
            margin: 0 3px;
        }
        .btn-edit { background-color: #ffc107; color: #fff; }
        .btn-edit:hover { background-color: #e0a800; color: white; }
        
        .btn-delete { background-color: #dc3545; color: #fff; }
        .btn-delete:hover { background-color: #c82333; color: white; }

    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-brand">
            <i class="bi bi-flower1"></i> Admin Panel
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-speedometer2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/product" class="active">
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
        <div class="table-card">
            
            <div class="page-header">
                <h2 class="page-title">
                    <i class="bi bi-list-ul me-2"></i>Danh sách sản phẩm
                </h2>
                <a href="product?action=new" class="btn-add">
                    <i class="bi bi-plus-lg me-1"></i> Thêm gạo mới
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Hình ảnh</th>
                            <th class="text-start">Tên sản phẩm</th> <th>Giá (VNĐ/kg)</th>
                            <th>Số lượng</th>
                            <th>Mã DM</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${list}">
                            <tr>
                                <td class="fw-bold text-secondary">#${p.id}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/views/admin/product/images/${p.image}" 
                                         class="product-img" width="60" height="60" alt="Gạo"/>
                                </td>
                                <td class="text-start fw-bold" style="color: #2e7d32;">
                                    ${p.name}
                                </td>
                                <td>${p.price}</td>
                                <td>
                                    <span class="badge bg-success rounded-pill">${p.quantity} tấn</span>
                                </td>
                                <td>${p.id_category}</td>
                                <td>
                                    <a href="product?action=edit&id=${p.id}" class="btn action-btn btn-edit" title="Sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="product?action=delete&id=${p.id}" 
                                       class="btn action-btn btn-delete" 
                                       title="Xóa"
                                       onclick="return confirm('Bạn có chắc muốn xóa loại gạo này không?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty list}">
                <div class="text-center py-5">
                    <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                    <p class="text-muted mt-2">Chưa có sản phẩm nào trong kho.</p>
                </div>
            </c:if>

        </div>
    </div>

</body>
</html>