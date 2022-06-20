<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
<!--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!--    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">


</head>
<style type="text/css">
    #footer {
        width: 100%;
        height: 260px;
        background: #3f4a56;
        color: #6e7e8c;
    }

    #footer a {
        color: #808fa0;
        padding: 10px;
        /*border-right: 1px solid;*/
        font-family: "Apple SD Gothic Neo";
        text-align: left;
        line-height: 10px;
        display: inline-block;
        width: 100%;
        font-size: 14px;
    }



    #footer  a:hover {
        color: #aabdd0;
        text-decoration: none;
    }

    #RBox, #EBox, #Others {
        /*border: 1px solid red;*/
        flex-direction: column;
        width: 30%;
        margin-top: 20px;
        height: 170px;

        margin-right: 40px;
    }

    #EBox {
        margin-left: 30px;

    }

    #footer {
        display: flex;

    }

    #footer span {
        padding-left: 4px;
        font-size: 14px;
    }

    #companyN {
        width: 100%;
        background: #3f4a56;
        height: 50px;
        text-align: center;
    }
    #BrandF{
        font-family: "Al Nile";
        color: white;
        text-align: center;
        margin: auto;
        font-size: 14px;
    }


</style>
<body>
<div id="footer">
    <div id="EBox">
        <a href="">Electric Book Store</a>
        <div style="margin-left: 10px;border-bottom:1px solid #dcd9ec ;width: 80%"></div>
        <a href=""><i class="bi bi-caret-right-fill"><span>Searching</span> </i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>Serialize List</span></i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>Point Incremental</span></i></a>
    </div>
    <div id="RBox">
        <a href="">Online Book Store</a>
        <div style="margin-left: 10px;border-bottom:1px solid #dcd9ec ;width: 80%"></div>
        <a href=""><i class="bi bi-caret-right-fill"><span>Bundle Set</span></i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>Managazine</span></i></a>
    </div>
    <div id="Others">
        <a onclick="false">Other Applications</a>
        <div style="margin-left: 10px;border-bottom:1px solid #dcd9ec ;width: 80%"></div>
        <a href=""><i class="bi bi-caret-right-fill"><span>Contribution</span></i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>User  Control Panel</span></i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>Main Pages</span></i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>Login Panel</span></i></a>
        <a href=""><i class="bi bi-caret-right-fill"><span>History</span></i></a>
    </div>
</div>
<div id="companyN">
    <span id="BrandF">Manga Collection 2021 @ Copy Right</span>
</div>

</div>

</body>
</html>