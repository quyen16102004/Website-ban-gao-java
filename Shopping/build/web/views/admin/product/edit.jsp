<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Cập nhật sản phẩm</title>
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

        /* --- 3. Sidebar (Menu trái) --- */
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

        /* --- 5. Form Card Style --- */
        .form-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 2.5rem;
            border: 1px solid #f0e68c;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            max-width: 900px;
            margin: 0 auto;
        }

        .page-title {
            color: #198754;
            font-weight: 700;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 15px;
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.95rem;
        }

        .form-control {
            border: 2px solid #ecf0f1;
            border-radius: 10px;
            padding: 0.7rem;
            transition: 0.3s;
        }
        .form-control:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 8px rgba(46, 204, 113, 0.2);
        }

        /* Image Preview Style */
        .img-preview-container {
            margin-top: 10px;
            padding: 10px;
            border: 1px dashed #ced4da;
            border-radius: 10px;
            display: inline-block;
            background: #f8f9fa;
        }
        .img-preview {
            max-width: 150px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* Buttons */
        .btn-update {
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            border: none;
            padding: 10px 25px;
            font-weight: 600;
            border-radius: 10px;
            transition: 0.3s;
            color: white;
        }
        .btn-update:hover {
            background: linear-gradient(135deg, #27ae60 0%, #219150 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
            color: white;
        }

        .btn-back {
            background: #f8f9fa;
            border: 1px solid #ced4da;
            color: #6c757d;
            padding: 10px 25px;
            font-weight: 600;
            border-radius: 10px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-back:hover {
            background: #e2e6ea;
            color: #2c3e50;
        }
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
        <div class="form-card">
            
            <h2 class="page-title">
                <i class="bi bi-pencil-square me-2"></i>Cập nhật thông tin
            </h2>

            <form action="product" method="post">
                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="id" value="${product.id}"/>

                <div class="row">
                    <div class="col-md-7">
                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control" value="${product.name}" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Hình ảnh (URL)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0"><i class="bi bi-image"></i></span>
                                <input type="text" name="image" class="form-control border-start-0" value="${product.image}"/>
                            </div>
                            
                            <c:if test="${not empty product.image}">
                                <div class="img-preview-container">
                                    <small class="d-block text-muted mb-1">Ảnh hiện tại:</small>
                                    <img src="${pageContext.request.contextPath}/views/admin/product/images/${product.image}" 
                                         class="img-preview" alt="Product Image"/>
                                </div>
                            </c:if>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá bán (VNĐ)</label>
                                <input type="number" step="0.01" name="price" class="form-control" value="${product.price}" required/>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số lượng (Kg)</label>
                                <input type="number" name="quantity" class="form-control" value="${product.quantity}" required/>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="mb-3">
                            <label class="form-label">Danh mục ID</label>
                            <input type="number" name="id_category" class="form-control" value="${product.id_category}" required/>
                            <div class="form-text text-muted">Mã số danh mục của loại gạo này.</div>
                        </div>

                        <div class="alert alert-warning border mt-4">
                            <div class="d-flex">
                                <i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>
                                <div>
                                    <strong>Lưu ý:</strong>
                                    <p class="mb-0 small">Việc cập nhật giá hoặc số lượng sẽ ảnh hưởng trực tiếp đến hiển thị trên trang chủ.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                    <a href="product" class="btn btn-back">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-update">
                        <i class="bi bi-check-circle me-1"></i> Lưu thay đổi
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>
</html>