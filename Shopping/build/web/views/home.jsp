<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:import url="/inc/header.jsp" />
<c:import url="/inc/navbar.jsp" />

<style>
    /* Đặt nền gradient để thấy được tuyết trắng */
    body {
        /* Màu trời mùa đông: Xám xanh nhạt */
        background: linear-gradient(180deg, #b8c6db 0%, #f5f7fa 90%);
        min-height: 100vh;
        overflow-x: hidden; /* Ẩn thanh cuộn ngang */
        position: relative;
    }

    /* Style cho bông tuyết */
    .snowflake {
        position: fixed; /* Dùng fixed để tuyết rơi phủ toàn màn hình kể cả khi cuộn */
        top: -10px;
        background: #fff;
        border-radius: 50%;
        pointer-events: none; /* Quan trọng: Để chuột click xuyên qua tuyết (không bị chặn click vào search) */
        z-index: 9999; /* Nổi lên trên cùng */
        animation: fall linear forwards;
        box-shadow: 0 0 5px rgba(255,255,255,0.8); /* Hiệu ứng phát sáng nhẹ */
    }

    /* Animation rơi */
    @keyframes fall {
        to {
            transform: translateY(105vh); /* Rơi quá chiều cao màn hình */
        }
    }

    /* Chỉnh lại khung search một chút cho đẹp trên nền này */
    .search-container-wrapper {
        display: flex;
        justify-content: center;
        padding: 20px 0;
    }
</style>

<c:import url="/inc/jumbotron.jsp" />

<div class="search-container-wrapper">
    <div style="position: relative; width: 300px;">
        <input type="text" id="searchBox" placeholder="Tìm sản phẩm..." class="form-control shadow-sm" style="border-radius: 20px;"/>
        
        <div id="suggestions" style="position: absolute; top: 100%; left: 0; right: 0; background: #fff; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); z-index: 1000; max-height:200px; overflow-y:auto; margin-top: 5px;"></div>
    </div>
</div>

<c:import url="/inc/body.jsp" />

<script>
    /* --- SCRIPT 1: XỬ LÝ TÌM KIẾM (Của bạn) --- */
    const searchBox = document.getElementById("searchBox");
    const suggestions = document.getElementById("suggestions");
    const contextPath = '<%= request.getContextPath()%>';

    searchBox.addEventListener("input", function () {
        const query = this.value.trim();
        if (!query) {
            suggestions.innerHTML = "";
            return;
        }

        fetch(contextPath + "/search-suggestion?q=" + encodeURIComponent(query))
            .then(response => response.json())
            .then(data => {
                let html = "";
                if(data.length === 0){
                     html = `<div style="padding:10px; color:#999; text-align:center;">Không tìm thấy sản phẩm</div>`;
                } else {
                    data.forEach(p => {
                        // Format giá tiền đẹp hơn
                        let price = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(p.price);
                        
                        html += `<div style="padding:10px; cursor:pointer; border-bottom:1px solid #eee;" 
                                      onmouseover="this.style.background='#f8f9fa'" 
                                      onmouseout="this.style.background='white'"
                                      onclick="window.location.href='${contextPath}/ProductDetail?id=${p.id}'">
                                    <span style="font-weight:bold; color:#2c3e50;">${p.name}</span> <br>
                                    <span style="color:#27ae60; font-size:0.9em;">${price}</span>
                                 </div>`;
                    });
                }
                suggestions.innerHTML = html;
            });
    });

    document.addEventListener("click", function (e) {
        if (!searchBox.contains(e.target) && !suggestions.contains(e.target)) {
            suggestions.innerHTML = "";
        }
    });

    /* --- SCRIPT 2: HIỆU ỨNG TUYẾT RƠI (Thêm mới) --- */
    function createSnowflake() {
        const snowflake = document.createElement('div');
        snowflake.classList.add('snowflake');
        
        // Kích thước ngẫu nhiên (nhỏ từ 2px đến 6px)
        const size = Math.random() * 4 + 2 + 'px';
        snowflake.style.width = size;
        snowflake.style.height = size;
        
        // Vị trí ngang ngẫu nhiên
        snowflake.style.left = Math.random() * 100 + 'vw';
        
        // Thời gian rơi ngẫu nhiên (chậm rãi: 5s - 10s)
        const duration = Math.random() * 5 + 5 + 's';
        snowflake.style.animationDuration = duration;
        
        // Độ mờ ngẫu nhiên (tạo chiều sâu)
        snowflake.style.opacity = Math.random() * 0.5 + 0.3;

        document.body.appendChild(snowflake);

        // Xóa tuyết sau khi rơi xong để tránh nặng máy
        setTimeout(() => {
            snowflake.remove();
        }, parseFloat(duration) * 1000);
    }

    // Tạo tuyết liên tục (100ms một bông)
    setInterval(createSnowflake, 100);
</script>

<c:import url="/inc/footer.jsp" />