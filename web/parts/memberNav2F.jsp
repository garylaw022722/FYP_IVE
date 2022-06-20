<link rel="stylesheet" href="css/b1.css">
<script>
    var close = false;
    var time = 600;
    $(document).ready(function () {
        var side = $("#sideNav");
        $("#slideBar").click(function () {
            if (!close) {
                $("#sideNav").animate({left: "-=20%"}, time)
                // $("#bk *").css({color:"red"})
                close = true;
            } else {
                $("#sideNav").animate({left: "+=20%"}, time)
                close = false;
            }
        })
     
    })

    function sliderEffect() {


    }
</script>
<body>
    <div id="topNav" style="position: absolute">
    <div id="brand"><span onclick='window.location.href="Main.jsp"'>Manga Collection</span></div>
    <div id="submenu">
        <div id="slideBar" style="width: 5%"><i  id="side" class="bi bi-justify"></i></div>
        <div style="width: 5%"><i id="searchBtn" class="fas fa-search" onclick='window.location.href="ClientSearch.jsp"'></i></div>
        <div id="shoppingCart" style="width: 5%;"><i class="bi bi-cart4"></i></div>
        <div id="readBook">Book Store</div>
        <div id="purchase">Read Book</div>
        <div id="LanguageN" class="dropdown">Language</div>
        <div id="signIn">Sign in</div>
    </div>
</div>
<div id="sideNav">
<!--    <div id="sk">-->
        <div id="home"><i  class="fas fa-home"><span>Home</span></i></div>
        <div id="history"><i class="fas fa-history"><span>History</span></i></div>
        <div id="seLogo"><i class="fas fa-search"><span>Search</span></i></div>
        <div id="bk"><a href="Main.jsp"><i  class="bi bi-book">sss</i></a></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div id="bk"><i  class="bi bi-book">sss</i></div>
        <div>skaksakas</div>
        <div>skaksakas</div>
        <div>skaksakas</div>
        <div>skaksakas</div>
        <div>skaksakas</div>
<!--    </div>-->


</div>
