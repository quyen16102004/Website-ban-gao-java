<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>

<%-- Kiểm tra session (Giữ nguyên logic của bạn) --%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<c:import url="/inc/header.jsp" />
<c:import url="/inc/navbar.jsp" />

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- CẤU HÌNH GIAO DIỆN CHUNG --- */
    body {
        font-family: 'Quicksand', sans-serif;
        /* Gradient sáng giống trang Login */
        background: linear-gradient(to bottom, #e0eafc, #cfdef3);
        min-height: 100vh;
    }

    /* --- PROFILE CARD STYLE --- */
    .profile-section {
        padding: 50px 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 80vh;
    }

    .profile-card {
        background: #ffffff;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 800px;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        border: 1px solid rgba(255,255,255,0.8);
        animation: fadeInUp 0.8s ease-out;
    }

    /* Animation xuất hiện */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Phần Header của Card (Chứa Avatar) */
    .profile-header {
        background: linear-gradient(135deg, #f1c40f 0%, #f39c12 100%); /* Nền vàng lúa */
        padding: 40px 20px;
        text-align: center;
        position: relative;
    }

    .avatar-container {
        position: relative;
        width: 120px;
        height: 120px;
        margin: 0 auto 15px auto;
    }

    .profile-avatar {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: 4px solid #fff;
        object-fit: cover;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        background: #fff;
    }

    .user-name {
        color: #fff;
        font-size: 1.8rem;
        font-weight: 700;
        margin-bottom: 5px;
        text-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .user-role {
        background: rgba(255,255,255,0.2);
        color: #fff;
        padding: 5px 15px;
        border-radius: 50px;
        font-size: 0.9rem;
        font-weight: 600;
        display: inline-block;
    }

    /* Phần Body của Card (Thông tin) */
    .profile-body {
        padding: 40px;
    }

    .info-group {
        margin-bottom: 20px;
    }

    .info-label {
        font-weight: 700;
        color: #27ae60; /* Xanh lá */
        margin-bottom: 8px;
        display: block;
        font-size: 0.95rem;
    }

    .info-value {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e0e0e0;
        border-radius: 10px;
        background-color: #f9f9f9;
        font-size: 1rem;
        color: #2c3e50;
        font-weight: 500;
        transition: 0.3s;
    }

    .info-value:focus {
        outline: none;
        border-color: #f1c40f;
        background-color: #fff;
    }

    /* Mật khẩu */
    .password-wrapper {
        position: relative;
    }

    .toggle-password {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: #95a5a6;
        transition: 0.2s;
    }

    .toggle-password:hover {
        color: #27ae60;
    }

    /* Nút bấm */
    .action-buttons {
        margin-top: 30px;
        display: flex;
        justify-content: center;
        gap: 15px;
    }

    .btn-custom {
        padding: 10px 25px;
        border-radius: 50px;
        font-weight: 700;
        text-decoration: none;
        transition: 0.3s;
        display: inline-flex;
        align-items: center;
        border: none;
        cursor: pointer;
    }

    .btn-home {
        background: #fff;
        color: #27ae60;
        border: 2px solid #27ae60;
    }

    .btn-home:hover {
        background: #27ae60;
        color: #fff;
        transform: translateY(-2px);
    }

    .btn-logout {
        background: linear-gradient(135deg, #e74c3c, #c0392b);
        color: #fff;
        box-shadow: 0 4px 10px rgba(231, 76, 60, 0.3);
    }

    .btn-logout:hover {
        background: linear-gradient(135deg, #c0392b, #a93226);
        transform: translateY(-2px);
    }
    
    /* Responsive cho mobile */
    @media (max-width: 768px) {
        .profile-card {
            margin: 0 15px;
        }
        .profile-body {
            padding: 25px;
        }
        .action-buttons {
            flex-direction: column;
        }
        .btn-custom {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<div class="profile-section">
    <div class="profile-card">
        
        <div class="profile-header">
            <div class="avatar-container">
                <img src="assets/images/avatar.png" 
                     onerror="this.src='https://ui-avatars.com/api/?name=<%= user.getName() %>&background=fff&color=f1c40f&size=128'" 
                     alt="Avatar" class="profile-avatar">
            </div>
            <h2 class="user-name"><%= user.getName() %></h2>
            <span class="user-role">
                <i class="fas fa-user-tag me-1"></i> <%= user.getRole() %>
            </span>
        </div>

        <div class="profile-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="info-group">
                        <label class="info-label"><i class="fas fa-id-card me-2"></i> ID Tài khoản</label>
                        <input type="text" class="info-value" value="#<%= user.getId() %>" readonly>
                    </div>

                    <div class="info-group">
                        <label class="info-label"><i class="fas fa-envelope me-2"></i> Email</label>
                        <input type="email" class="info-value" value="<%= user.getEmail() %>" readonly>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="info-group">
                        <label class="info-label"><i class="fas fa-phone me-2"></i> Số điện thoại</label>
                        <input type="text" class="info-value" value="<%= user.getPhone() %>" readonly>
                    </div>

                    <div class="info-group">
                        <label class="info-label"><i class="fas fa-lock me-2"></i> Mật khẩu</label>
                        <div class="password-wrapper">
                            <input type="password" id="passwordField" class="info-value" value="<%= user.getPassword() %>" readonly>
                            <i class="fas fa-eye toggle-password" id="toggleIcon" onclick="togglePassword()"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="action-buttons">
                <a href="home" class="btn-custom btn-home">
                    <i class="fas fa-home me-2"></i> Về trang chủ
                </a>
                <a href="logout" class="btn-custom btn-logout">
                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                </a>
            </div>
        </div>

    </div>
</div>

<c:import url="/inc/footer.jsp" />

<script>
    function togglePassword() {
        const input = document.getElementById("passwordField");
        const icon = document.getElementById("toggleIcon");

        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>