<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/inc/header.jsp" />

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">

<style>
    /* --- Cấu hình chung --- */
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
    /* Giúp tách biệt hiệu ứng khỏi bố cục trang, chống giật */
    #snow-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none; /* Để chuột bấm xuyên qua tuyết */
        z-index: 1; /* Nằm dưới form đăng nhập */
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

    /* Animation rơi */
    @keyframes fall {
        to {
            transform: translateY(105vh); /* Rơi quá chiều cao màn hình */
        }
    }

    /* --- Card Login --- */
    .login-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 0;
        position: relative;
        z-index: 10; /* FIX: Đưa form nổi lên trên tuyết */
    }

    .login-form {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        padding: 2.5rem;
        border: 1px solid #f0e68c;
        max-width: 450px;
        width: 100%;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        animation: fadeInUp 0.8s ease-out;
    }

    /* --- Title & Form Elements --- */
    .login-title {
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

    .login-title i {
        color: #f1c40f;
        font-size: 1.6rem;
    }
    .error-message {
        color: #e74c3c;
        font-weight: 600;
        text-align: center;
        margin-bottom: 1rem;
        min-height: 20px;
        font-size: 0.9rem;
    }

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

    .password-toggle {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: #95a5a6;
        transition: color 0.2s ease;
    }
    .password-toggle:hover {
        color: #27ae60;
    }

    .remember-forgot {
        display: flex;
        justify-content: space-between;
        margin-bottom: 1.2rem;
        font-size: 0.95rem;
    }
    .form-check-input:checked {
        background-color: #2ecc71;
        border-color: #2ecc71;
    }
    .forgot-link {
        color: #f39c12;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
    }
    .forgot-link:hover {
        color: #d35400;
        text-decoration: underline;
    }

    .login-btn {
        background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
        border: none;
        border-radius: 12px;
        padding: 0.8rem;
        font-size: 1.1rem;
        font-weight: 700;
        color: #ffffff;
        width: 100%;
        transition: all 0.3s;
        box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
    }
    .login-btn:hover {
        background: linear-gradient(135deg, #f1c40f 0%, #f39c12 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
    }

    .register-link {
        text-align: center;
        margin-top: 1.5rem;
        color: #7f8c8d;
        font-weight: 500;
    }
    .register-link a {
        color: #27ae60;
        font-weight: 700;
        text-decoration: none;
    }
    .register-link a:hover {
        color: #f1c40f;
        text-decoration: underline;
    }

    /* Animation layout */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(25px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>

<div id="snow-container"></div>

<section class="login-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <form action="login" method="post" class="login-form">

                    <h2 class="login-title">
                        <i class="bi bi-flower1"></i>
                        Đăng nhập
                    </h2>

                    <div class="error-message">${error_login}</div>

                    <div class="mb-3">
                        <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Tài khoản</label>
                        <input type="text" name="emailphone" class="form-control" placeholder="Email hoặc số điện thoại" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold text-secondary" style="font-size:0.9rem">Mật khẩu</label>
                        <div class="position-relative">
                            <input type="password" name="password" id="password" class="form-control" placeholder="Nhập mật khẩu" required />
                            <span onclick="togglePassword()" class="password-toggle">
                                <i class="bi bi-eye" id="toggleIcon"></i>
                            </span>
                        </div>
                    </div>

                    <div class="remember-forgot">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe" />
                            <label class="form-check-label text-secondary" for="rememberMe">
                                Ghi nhớ đăng nhập
                            </label>
                        </div>
                        <a href="#" class="forgot-link">Quên mật khẩu?</a>
                    </div>

                    <button type="submit" class="login-btn">
                        Đăng Nhập Ngay
                    </button>

                    <p class="register-link">
                        Chưa có tài khoản? 
                        <a href="register">Đăng ký thành viên</a>
                    </p>

                </form>
            </div>
        </div>
    </div>
</section>

<script>
    function togglePassword() {
        const input = document.getElementById("password");
        const icon = document.getElementById("toggleIcon");
        if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("bi-eye", "bi-eye-slash");
        } else {
            input.type = "password";
            icon.classList.replace("bi-eye-slash", "bi-eye");
        }
    }

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
        if (container) {
            container.appendChild(snowflake);
        }

        // Xóa tuyết sau khi rơi xong
        setTimeout(() => {
            snowflake.remove();
        }, parseFloat(duration) * 1000);
    }

    setInterval(createSnowflake, 100);
</script>