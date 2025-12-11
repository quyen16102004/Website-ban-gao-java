<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/inc/header.jsp" />

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

<style>
    /* --- Cấu hình chung (Đồng bộ với Login) --- */
    body {
        font-family: 'Quicksand', sans-serif;
        /* Màu trời mùa đông: Xám xanh nhạt */
        background: linear-gradient(180deg, #b8c6db 0%, #f5f7fa 90%);
        color: #2c3e50;
        /* FIX QUAN TRỌNG: Reset margin/padding */
        margin: 0;
        padding: 0;
        min-height: 100vh;
        overflow-x: hidden; /* Ẩn thanh cuộn ngang */
        position: relative;
    }

    /* --- FIX: Container chứa tuyết riêng biệt --- */
    #snow-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none; /* Để chuột bấm xuyên qua tuyết */
        z-index: 1; /* Nằm dưới form */
        overflow: hidden;
    }

    /* Style cho bông tuyết */
    .snowflake {
        position: absolute;
        top: -10px;
        background: #fff;
        border-radius: 50%;
        pointer-events: none;
        animation: fall linear forwards;
        box-shadow: 0 0 5px rgba(255,255,255,0.8);
    }

    @keyframes fall {
        to { transform: translateY(105vh); }
    }

    /* --- Card Register (Layout giống Login) --- */
    .register-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 0;
        position: relative;
        z-index: 10; /* FIX: Đưa form nổi lên trên tuyết */
    }

    .register-form {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        padding: 2.5rem;
        border: 1px solid #f0e68c; /* Viền vàng lúa */
        max-width: 500px; /* Rộng hơn login một chút do nhiều trường */
        width: 100%;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        animation: fadeInUp 0.8s ease-out;
    }

    /* --- Title & Form Elements --- */
    .register-title {
        color: #2c3e50;
        font-weight: 700;
        text-align: center;
        margin-bottom: 1.5rem;
        font-size: 1.8rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .register-title i { color: #f1c40f; font-size: 1.6rem; }
    
    .text-danger { font-size: 0.85rem; font-weight: 600; margin-top: 5px; display: block; }

    .form-control {
        border: 2px solid #ecf0f1;
        border-radius: 12px;
        padding: 0.75rem;
        transition: 0.3s;
        font-size: 1rem;
        background-color: #fdfdfd;
    }

    .form-control:focus {
        border-color: #2ecc71;
        box-shadow: 0 0 8px rgba(46, 204, 113, 0.2);
        background-color: #fff;
    }

    /* --- Button Register --- */
    .btn-register {
        background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
        border: none;
        border-radius: 12px;
        padding: 0.8rem;
        font-size: 1.1rem;
        font-weight: 700;
        color: #ffffff;
        width: 100%;
        transition: all 0.3s;
        margin-top: 10px;
        box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
    }
    
    .btn-register:hover {
        background: linear-gradient(135deg, #f1c40f 0%, #f39c12 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
    }

    /* --- Links --- */
    .link-green { color: #27ae60; font-weight: 700; text-decoration: none; transition: 0.2s; }
    .link-green:hover { color: #d35400; text-decoration: underline; }
    
    .login-link { text-align: center; margin-top: 1.5rem; color: #7f8c8d; font-weight: 500; }

    /* Checkbox */
    .form-check-input:checked { background-color: #2ecc71; border-color: #2ecc71; }

    /* Animation layout */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(25px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div id="snow-container"></div>

<section class="register-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-8">

                <div class="register-form">

                    <h2 class="register-title">
                        <i class="bi bi-flower1"></i>
                        Đăng Ký Tài Khoản
                    </h2>

                    <c:if test="${not empty sessionScope.exist_user}">
                        <div class="alert alert-danger text-center shadow-sm" style="border-radius: 10px; font-size: 0.9rem;">
                            ${sessionScope.exist_user}
                        </div>
                        <c:remove var="exist_user" scope="session"/>
                    </c:if>

                    <form action="register" method="post">

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Họ và tên</label>
                            <input type="text" name="name" class="form-control" placeholder="Ví dụ: Nguyễn Văn A" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Email</label>
                            <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
                            <span class="text-danger">${err_email}</span>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" placeholder="09xx..." required>
                            <span class="text-danger">${err_phone}</span>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Nhập lại mật khẩu</label>
                            <input type="password" name="repassword" class="form-control" required>
                            <span class="text-danger">${err_repassword}</span>
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" id="agree" required>
                            <label class="form-check-label text-muted" style="font-size: 0.9rem;" for="agree">
                                Tôi đồng ý với <a href="#" class="link-green">Điều khoản & Chính sách</a>
                            </label>
                        </div>

                        <button type="submit" class="btn-register">
                            Đăng Ký Ngay
                        </button>

                    </form>

                    <div class="login-link">
                        <p class="mb-0">Bạn đã có tài khoản?
                            <a href="login" class="link-green ms-1">Đăng nhập</a>
                        </p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<script>
    /* --- SCRIPT FIX: HIỆU ỨNG TUYẾT RƠI KHÔNG GIẬT --- */
    function createSnowflake() {
        const snowflake = document.createElement('div');
        snowflake.classList.add('snowflake');

        // Kích thước ngẫu nhiên
        const size = Math.random() * 4 + 2 + 'px';
        snowflake.style.width = size;
        snowflake.style.height = size;

        // FIX: Dùng % thay vì vw để không bị vượt quá container
        snowflake.style.left = Math.random() * 100 + '%';

        const duration = Math.random() * 5 + 5 + 's';
        snowflake.style.animationDuration = duration;
        snowflake.style.opacity = Math.random() * 0.5 + 0.3;

        // FIX: Append vào container cố định thay vì body
        const container = document.getElementById('snow-container');
        if(container) {
            container.appendChild(snowflake);
        }

        // Xóa tuyết sau khi rơi xong
        setTimeout(() => {
            snowflake.remove();
        }, parseFloat(duration) * 1000);
    }

    setInterval(createSnowflake, 100);
</script>