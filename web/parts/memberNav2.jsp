<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">

<link rel="stylesheet" href="css/b1.css">
<%@page import="ict.bean.Account" %>
<%@ page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>

<style type="text/css">
    #bk a{
        color: black;
    }
    .correction{color:none; text-decoration: none;}
</style>
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

        $("#Search").click(function () {
            window.location.href = "ClientSearch.jsp"
        })

        $(document).scroll(function () {
            var st = $(this).scrollTop();
            var topNav = $("#topNav").height();
            if (st > topNav) {
                $("#topNav").css({position: "absolute"})
                if (close) {
                    $("#sideNav").css({left: "100%"})
                    close = false;
                }

            }


        })



    })

    function sliderEffect() {


    }
</script>
<%
    Account member = (Account) request.getSession().getAttribute("member");
    Account admin = (Account) request.getSession().getAttribute("admin");
    Account editor = (Account) request.getSession().getAttribute("editor");
    Account staff = (Account) request.getSession().getAttribute("staff");
    String user = "";
    String typeLink = "";
    if (member != null) {
        typeLink = "Member.jsp";
        user = member.geteAddress();
    } else if (admin != null) {
        typeLink = "AdminControl.jsp";
        user = admin.geteAddress();
    } else if (editor != null) {
        typeLink = "meetingRequest.jsp";
        user = editor.geteAddress();
    } else if (staff != null) {
        typeLink = "pointListManagement.jsp";
        user = staff.geteAddress();
    }
%>
<!--User Detail-->
<%
    String dburl = "jdbc:mysql://localhost:3306/fyp";
    String dbUser = "root";
    String dbPassword = "";
    int point = 0;
    try {
        if (user != null) {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
            PreparedStatement pstmt = null;
            //get user Detail
            String s = "select pointAmount from userinfo where eAddress = '" + user + "'";
            pstmt = con.prepareStatement(s);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                point = rs.getInt("pointAmount");
            }
            con.close();
        }
    } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
    } catch (SQLException ex) {
        while (ex != null) {
            ex.printStackTrace();
            ex = ex.getNextException();
        }

    }
%>

<body>
    <div id="topNav" >
        <div id="brand"><span onclick='window.location.href = "Main.jsp"'>Manga Collection</span></div>
        <div id="submenu">
            <div id="slideBar" style="width: 5%"><i id="side" class="bi bi-justify"></i></div>
            <div  id="Search" style="width: 5%"><i id="searchBtn" class="fas fa-search"></i></div>
            <div id="shoppingCart" style="width: 5%;"><a href="ShoppingCart?action=getList"><i class="bi bi-cart4" style="color:#646767"></i></a></div>

            <div id="readBook">Book Store</div>
            <div id="LanguageN" class="dropdown" onclick="window.open('pointList.jsp')">PointList</div>
            <div id="purchase" class="corr" ><a href="rhome.jsp" style='color:#646767;text-decoration: none' >Read Book</a></div>

            <%if (member != null || admin != null || editor != null || staff != null) {%>
            <div id="signIn"><a href="<%=typeLink%>" style='color:#646767;text-decoration: none'>My information</a></div>
            <div id="signIn"><a href="login2?action=logout" style='color:#646767;text-decoration: none'>Logout</a></div>
            <%} else {%>
            <div id="signIn"><a href="Login2.jsp" style='color:#646767;text-decoration: none' >Sign in</a></div>
            <%}%>
        </div>
    </div>
    <div id="sideNav">
        <!--    <div id="sk">-->
        <%if(member != null || admin != null || editor != null || staff != null){%>
        <div id="home"><i class="fas fa-user"><span><%=user%></span></i></div>
        <div id="history"><i class="fas fa-coins"><span><%=point%></span></i></div>
        <%}else{%>
        <div id="home"><i class="fas fa-user"><span></span></i></div>
        <div id="history"><i class="fas fa-coins"><span>0</span></i></div>
        <%}%>
        <%if (member != null || admin != null || editor != null || staff != null) {%>
        <%} else {%>
        <div id="bk"><a href="memberRegForm.jsp"><i class="fas fa-registered"> Register</i></a></div>
        <%}%>
        <div id="bk"><a href="videoList.jsp"><i class="fas fa-video"> Video List</i></a></div>
        <div id="bk"><a href="History.jsp"><i class="fas fa-history"> History</i></a></div>
        <div id="bk"><a href="ClientContribution.jsp"><i class="fas fa-heading"> Contribution List</i></a></div>

        <!--    </div>-->


    </div>


</body>
