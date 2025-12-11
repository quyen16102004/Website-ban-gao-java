<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    footer {
        font-family: 'Quicksand', sans-serif;
        /* Màu xanh lá đậm dần xuống dưới tạo chiều sâu */
        background: linear-gradient(180deg, #27ae60 0%, #196f3d 100%);
        color: white;
        position: relative;
        z-index: 10; /* Nổi lên trên background tuyết */
        box-shadow: 0 -4px 20px rgba(0,0,0,0.1);
    }

    /* Thanh mạng xã hội phía trên */
    .social-bar {
        background-color: rgba(0, 0, 0, 0.1); /* Làm tối nhẹ so với nền chính */
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    /* Link liên kết */
    footer a {
        text-decoration: none;
        transition: all 0.3s;
        color: #e8f5e9 !important; /* Màu trắng hơi xanh nhẹ */
    }

    footer a:hover {
        color: #f1c40f !important; /* Hover chuyển màu Vàng lúa chín */
        transform: translateX(5px); /* Hiệu ứng dịch chuyển nhẹ */
        display: inline-block;
    }

    /* Icon mạng xã hội */
    .social-icons a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background: rgba(255,255,255,0.1);
        margin-right: 10px;
        transition: 0.3s;
    }

    .social-icons a:hover {
        background: #f1c40f;
        color: #196f3d !important;
        transform: translateY(-3px);
    }

    /* Đường gạch chân tiêu đề */
    .footer-divider {
        width: 60px;
        height: 3px;
        background-color: #f1c40f; /* Vàng */
        margin-bottom: 1.5rem;
        display: inline-block;
        border-radius: 2px;
    }

    /* Icon liên hệ */
    .contact-icon {
        width: 25px;
        color: #f1c40f;
    }
</style>

<footer class="text-white">
    <section class="py-2">
        <div class="container text-center text-md-start mt-5">
            <div class="row mt-3">

                <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-2">
                        <i class="fas fa-seedling me-2 text-warning"></i> Phúc Rice
                    </h6>
                    <div class="footer-divider"></div>
                    <p style="text-align: justify;">
                        Tự hào mang đến những hạt gạo sạch, thơm ngon từ những cánh đồng phù sa màu mỡ. 
                        Chúng tôi cam kết chất lượng an toàn vệ sinh thực phẩm vì sức khỏe gia đình bạn.
                    </p>
                </div>

                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-2">Sản phẩm nổi bật</h6>
                    <div class="footer-divider"></div>
                    <p><a href="#" class="text-white">Gạo ST25 Thượng Hạng</a></p>
                    <p><a href="#" class="text-white">Gạo Nàng Hương</a></p>
                    <p><a href="#" class="text-white">Gạo Lứt Huyết Rồng</a></p>
                    <p><a href="#" class="text-white">Gạo Nếp Cái Hoa Vàng</a></p>
                </div>

                <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                    <h6 class="text-uppercase fw-bold mb-2">Hỗ trợ khách hàng</h6>
                    <div class="footer-divider"></div>
                    <p><a href="#" class="text-white">Hướng dẫn mua hàng</a></p>
                    <p><a href="#" class="text-white">Chính sách vận chuyển</a></p>
                    <p><a href="#" class="text-white">Đổi trả & Hoàn tiền</a></p>
                    <p><a href="#" class="text-white">Câu hỏi thường gặp</a></p>
                </div>

                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                    <h6 class="text-uppercase fw-bold mb-2">Liên hệ</h6>
                    <div class="footer-divider"></div>
                    <p><i class="fas fa-home contact-icon"></i> Quảng Điền, Thành Phố Huế</p>
                    <p><i class="fas fa-envelope contact-icon"></i> phanquyen1610204@gmail.com</p>
                    <p><i class="fas fa-phone contact-icon"></i> +84 383 204 770</p>
                    <p><i class="fas fa-clock contact-icon"></i> 7:00 - 21:00 (Hàng ngày)</p>
                </div>
            </div>
        </div>
    </section>
    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2); border-top: 1px solid rgba(255,255,255,0.1);">
        © 2025 Bản quyền thuộc về:
        <a class="text-warning fw-bold" href="#">PhucRice.com</a>
    </div>
</footer>