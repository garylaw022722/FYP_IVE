<%-- 
    Document   : internalRegForm
    Created on : 11-Feb-2021, 17:25:27
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="barCss/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/assets.css">
        <link rel="stylesheet" type="text/css" href="css/dashboard.css">
        <link href="barCss/css/bootstrap.min.css" rel="stylesheet">
        <link href="barCss/css/simple-sidebar.css" rel="stylesheet">
        <link href="barCss/css/dashboard.css" rel="stylesheet">
        <link href="mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="css/theme.css" rel="stylesheet">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
        <style type="text/css">
            .button {
                background-color: #4CAF50; /* Green */
                border: none;
                color: white;
                padding: 16px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                transition-duration: 0.4s;
                cursor: pointer;
            }
            .button5 {
                background-color: white;
                color: black;
                border: 2px solid #555555;
            }

            .button5:hover {
                background-color: #555555;
                color: white;
                box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            }

            .button5:active {
                background-color: #3e8e41;
                box-shadow: 0 5px #666;
                transform: translateY(4px);
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="well-block">
                    <div class="row">
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Create Form</h4>
                                </div>
                                <div class="widget-inner">
                                    <form class="edit-profile m-b30" action="createAccount"  method="POST">
                                        <div class="row">

                                            <div class="form-group col-6">
                                                <label class="col-form-label">EmailAdress</label>
                                                <div>
                                                    <input class="form-control" type="text" value="" name="username" required="">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Password</label>
                                                <div>
                                                    <input class="form-control" type="password" value="" name="password" required="">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">First Name</label>
                                                <div>
                                                    <input class="form-control" type="text"  name='firstName' required="">
                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Last Name</label>
                                                <div>
                                                    <input class="form-control" type="text" value="" name='lastName' required="">

                                                </div>
                                            </div>

                                            <div class="form-group col-6">
                                                <label class="col-form-label">Phone No.</label>
                                                <div>
                                                    <input class="form-control" type="text" value="" name='phone' min="8" max="8">

                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Date of birth</label>
                                                <div>
                                                    <input class="form-control" type="date" value="" name='dob'>

                                                </div>
                                            </div>
                                            <div class="form-group col-6">
                                                <label class="col-form-label">Gender</label>
                                                <div>
                                                    <select class="form-control" name="gender" required="">
                                                        <option value="Male">Male</option>
                                                        <option value="Female">Female</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group col-6">
                                                <label class="col-form-label">User Type</label>
                                                <div>
                                                    <select class="form-control" name="userType">
                                                        <option value="Author">Author</option>
                                                        <option value="Staff">Staff</option>
                                                        <option value="Member">Member</option>
                                                    </select>

                                                </div>
                                            </div>

                                            <div class="seperator"></div>

                                            <div class="form-group col-12">
                                                <label class="col-form-label">Address</label>
                                                <div>
                                                    <textarea class="form-control" name="address"> </textarea>
                                                </div>
                                            </div>



                                            <div class="col-12">
                                                <input type="submit" class="button button5" value='Create'>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
