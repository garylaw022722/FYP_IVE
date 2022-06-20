<%-- 
    Document   : memberRegForm
    Created on : Jan 28, 2021, 11:37:36 PM
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Member Registration</title>
        <link rel="stylesheet" href="css/reg.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <script src="js/registerEffect.js"></script>
    </head>
    <body style="background-color:  #eef1f6;">
        <% String user_name = (String) request.getParameter("user_name");
           String em =request.getParameter("user_email");
          String Email_Value= (em== null)?"": em;

        %>
        <script>

            $(function () {

                var monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];


                for (var s = 0; s < monthList.length; s++)
                    $("#month").append("<option value='" + s + "'>" + monthList[s] + "</option>");

                for (var w = 1900; w < new Date().getFullYear(); w++)
                    $("#year").append("<option value='" + w + "'>" + w + "</option>");

                for (var b = 1; b < 31; b++) {
                    $("#day").append("<option value='" + b + "'>" + b + "</option>")
                }


                $('.Submition').click(function () {
                    var uty = "Member";
                    var fn = $("#FirstName").val();
                    var ln = $("#LastName").val();
                    var pw = $("#password").val();
                    var email = $("#Email").val();
                    var conNum = $("#CNum").val();
                    var SEmail = $("#SubEmail").val();
                    var building = $("#Building").val();
                    var floor = $("#Floor").val();
                    var street = $("#Street").val();
                    var gender = $('input[name=gender]:radio:checked').val()
                    var date = $('#day').val();
                    var year = $('#year').val();
                    var month = $('#month').val();


                    var ads = building + "," + floor + "," + street;
                    var dob = year + "-" + month + "-" + date;
                    $.ajax({
                        url: "AccountController",
                        type: "get",
                        data: {
                            operation: "createMemberAc",
                            userType: uty,
                            firstName: fn,
                            lastName: ln,
                            password: pw,
                            emailAddress: email,
                            contactNum: conNum,
                            subEmail: SEmail,
                            address: ads,
                            Gender: gender,
                            DOB: dob
                        }, success: function (res) {
                            sessionStorage.setItem("activation", res);
                            window.location.href = "email_Fragment.jsp"

                        }
                    })


                })
            })
        </script>

        <div style="background-color: #414f6c;width: 100%;height:47vh" id="bgrd">
            <jsp:include page="parts/memberNav2.jsp"/>
        </div>
        <div id="mainboard">

            <h1 style="text-align: center;margin-bottom:6vh; color:#9f9c9c;font-family: 'Ubuntu', sans-serif">Account &nbsp;Registration</h1>
            <div id="sa">
                <span class="FirstName form-control-sm">
                    <span>First Name</span><br>
                    <input type="text" id="FirstName" maxlength="10" >
                </span>

                <span class="LastName">
                    <span>Last Name</span><br>
                    <input type="text" id="LastName" maxlength="7" >
                </span>


                <div class="Email" style="margin-top: 21px">
                    <span>Email Address</span><br>
                    <input type="text" class="is-invalid " id="Email" placeholder="example@gmail.com" maxlength="25" value="<%=Email_Value%>"> 
                </div>

                <div class="Password" style="margin-bottom:30px">
                    <span>Password</span><br>
                    <input type="password" id="password" placeholder="eg.A-21313" maxlength="9" >
                </div>
                <br>
                <p style="color: #3f599d;font-size:18px">Gender : &nbsp;&nbsp;&nbsp;&nbsp;</p>
                M <input type="radio" value="Male" name="gender">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                F <input type="radio" value="Female" name="gender">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


                <div class="Month">
                    <select class="form-control form-control-lg" id="month">
                        <option selected>Month</option>
                    </select>
                </div>

                <div class="day">
                    <select class="form-control form-control-lg" id="day">
                        <option selected>Date</option>
                    </select>
                </div>

                <div class="year">
                    <select class="form-control form-control-lg" id="year">
                        <option selected>Year</option>
                    </select>
                </div>


            </div>
            <hr style="width: 85%;border-color: #d3d9d9;margin-top:50px ;padding-bottom: 10px">
            <!--    <b style="color: red;padding-left:38%;"><b>* Unnecessary filled information *</b></p>-->
            <div id="sa">
                <h4 style="margin-bottom: 12px;color: #414f6c">[Skipable]</h4>

                <div class="SubEmail" style="margin-top: 21px" maxlength="25">
                    <span>Replacable Email Address</span><br>
                    <input type="text" class="is-invalid " id="SubEmail" placeholder="example@gmail.com">
                </div>

                <p style="width: 76%;color: #cac7c7;text-align: justify">*Be sure to enter a validation you can always access.
                    It will be used to verify your identity your identify during password reset and receive information
                    e.g booking , delivery property sales status .
                </p>
                <div class="CNum">
                    <span>Contact Number</span><br>
                    <input type="text" id="CNum" placeholder="2131 1331" maxlength="8">
                </div>


            </div>
            <hr style="width: 85%;margin-top:60px ;border-color: #daeaf6;padding-bottom: 10px">
            <div id="sa">
                <h4 style="margin-bottom: 12px;color: #414f6c">Product Receiver Address [Skipable]</h4>
                <div class="Building">
                    <span>Building</span><br>
                    <input type="text" id="Building" placeholder="MYSuper Building">
                </div>

                <div class="Floor">
                    <span>Floor</span><br>
                    <input type="text" id="Floor" placeholder="8F/E">
                </div>
                <div class="Street">
                    <span>Street</span><br>
                    <input type="text" id="Street" placeholder="Sham Shui Po Castle Peak Road 31">
                </div>

            </div>


            <button class="Submition">Submission</button>

        </div>


    </body>
</html>
