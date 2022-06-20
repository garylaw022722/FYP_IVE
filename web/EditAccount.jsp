<%-- 
    Document   : EditAccount
    Created on : 05-May-2021, 11:24:28
    Author     : 85266
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="ict.bean.UserBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.10.2/Sortable.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <head>
        <title>Title</title>
        <style type="text/css">
            #reultListItem {
                width: 80%;
                border: 1px solid gainsboro;
                height: 280px;
                overflow: hidden;
                display: flex;
                padding: 20px;
                font-family: "Apple Braille";
                background-color: #18202f;
                color: white;
            }

            img {
                width: 100%;
                height: 100%;
            }

            #coverPage {
                height: 100%;
                display: flex;
                width: 20%;
                border: 1px solid #6CD0DE;
            }

            #resultContent {
                margin-top: 10px;
                width: 70%;
                height: 100%;
                line-height: 30px;
                margin-left: 100px;
            }

            #resultContent h1 {
                color: #414f6c;
                font-size: 35px;

                margin-top: -2px;
            }

            #subtitle {
                color: #9ea2a4;
                font-family: "Apple LiGothic";
                font-size: 20px;
                font: bold;
            }
            body{
                background: #eef1f6;
            }
            #stype {
                display: inline-block;
            }

            #desc{

                text-wrap:  normal;
                width: 80%;
                padding: 5px;
                font-family: "Apple Braille";
                text-align:justify;
            }
        </style>

    </head>
    <body>
    <html>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <form class="form-horizontal" role="form" action="Account">
                        <input hidden name="action" value="updata"/>
                        <fieldset>
                            <%UserBean u = (UserBean)request.getAttribute("userInfo");
                            %>
                            <!-- Form Name -->
                            <legend>Edit Account</legend>
                            
                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">subEmail</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="subEmail" class="form-control" name="subEmail" value="yylam@gmail.com" >
                                </div>
                            </div>

                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">contact No</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="contactNum" class="form-control" name="contactNum" value="64234233">
                                </div>
                            </div>

                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">BankAc</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="BankAccount" class="form-control" name="bankAccount" value="4371 5133 4233 2311">
                                </div>
                            </div>

                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">FistName</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="KA PANG" class="form-control"name="fistName" value="law">
                                </div>

                                <label class="col-sm-2 control-label" for="textinput">LastName</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="LAM" class="form-control" name="lastName" value="ks wai">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">iden No</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="BankAccount" class="form-control" name="idenNo" value="12">
                                </div>
                            </div>
                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="Address" class="form-control" name="address" value="Cheung Fung Industrial Buildin,Floor 124 / Flat E">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="textinput">Password</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="*********" class="form-control" name="password" >
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <div class="pull-right">
                                        <button type="submit" class="btn btn-default">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </div>
                                </div>
                            </div>

                        </fieldset>
                    </form>
                </div><!-- /.col-lg-12 -->
            </div><!-- /.row -->
    </body>
</html>

</body>
</html>
