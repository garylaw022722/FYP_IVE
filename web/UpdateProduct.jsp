<%-- 
    Document   : UpdateProduct
    Created on : 05-May-2021, 12:22:21
    Author     : 85266
--%>

<%@page import="ict.bean.Product"%>
<%@page import="ict.bean.Account"%>
<%@page import="ict.bean.ComicBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="UTF-8">
        <title>`Title`</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">  
        <script src="https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.3.1/dist/lazyload.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/createRealistic.css">
        <style type="text/css">
            body{
                background: #eef1f6;
            }
            #outer{
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                height: 600px;
                display: flex;
                flex-wrap: wrap;
                padding: 20px;


            }

            #outer div{
                margin-right: 50px;
                border-radius: 4px  ;
                width: 18%;
                height: 400px;
                margin-bottom: 20px;
            }
            #Voteimg{
                height: 90%;
                width: 100%;
            }
            .ComicInfo{
                background: white;
                height: 10%;
            }
        </style>
    </head>

    <body>

        <script>
            $(document).ready(function () {
            <%
                ArrayList<Product> ProductList = (ArrayList) request.getAttribute("Product");
                String event_Id = (String) request.getAttribute("event_Id");
                ArrayList<ComicBean> comicList = (ArrayList<ComicBean>) request.getAttribute("comicList");
                for (int i = 0; i < ProductList.size(); i++) {
                    Product p = ProductList.get(i);
                    out.println("$('#" + p.getProduct_id() + "').click(function(){");
                    out.println("$('#ComicTitle').empty();");
                    out.println("$('#ComicTitle').append('" + p.getName() + "');");
                    out.println("$('#Point').val('" + p.getPoint() + "');");
                    out.println("$('#productId').val('" + p.getProduct_id() + "');");
                    out.println("$('#exampleModal').modal('show');");
                    out.println("});");
                }

            %>
            });
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

        <div style="position: fixed;z-index:2104;width: 8%;height: 92vh;background: rgba(255,255,255,0.6);top:60px">
            <div id="left">
                <div id="itemCall" class="mangePoint">
                    <a href="pointListManagement.jsp">
                        <div id="sideLogo"><img src="images/coin.svg" alt=""></div>
                        <div id="sideDescription">Point List Mangement</div>
                    </a>
                </div>
                <div id="spLine"></div>
                <div id="itemCall">
                    <div id="sideLogo"><img src="images/coin.svg" alt=""></div>
                    <div id="sideDescription">Comic Work Maintance</div>
                </div>

                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="videoUpload.jsp">
                        <div id="sideLogo"><img src="images/videoUpload.svg" alt=""></div>
                        <div id="sideDescription">Video Upload</div>
                    </a>
                </div>
                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="createRBundle?action=all">
                        <div id="sideLogo"><img src="images/open-book.svg" alt=""></div>
                        <div id="sideDescription">Create Realistric Book</div>
                    </a>
                </div>

                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="Voting?action=Product">
                        <div id="sideLogo"><img src="images/open-book.svg" alt=""></div>
                        <div id="sideDescription">Create Electric Book</div>
                    </a>
                </div>

                <div id="spLine"></div>
                <div id="itemCall">
                    <a href="login2?action=logout">
                        <div id="sideLogo"><img src="images/logout.svg" alt=""></div>
                        <div id="sideDescription">Logout</div>
                    </a>
                </div>

            </div>
        </div>

        <div id="StaffNav"></div>


        <div id="outer">
            <%                for (int i = 0; i < ProductList.size(); i++) {
                    Product p = ProductList.get(i);
                    out.println("<div id=" + p.getProduct_id() + "><image id='Voteimg' src='data:image/jpg;base64," + p.getCoverPage() + "'><p class='ComicInfo'> " + p.getName() + "</p></div>");
                }
            %>
        </div>


        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <form action="Voting">
                <input hidden name="action" value="ProductUpdate"/>
                <input hidden name="productId" id="productId" value=""/>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ComicTitle"></h5>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <label for="recipient-name" class="col-form-label" >Point</label>
                                    <input type="text" class="form-control" id="Point" name="Point" value="">
                                </div>
                                <div class="form-group">
                                    <label for="recipient-name" class="col-form-label" >Public</label>
                                    <select id="Public" name="Public">
                                        <option selected value="T">T</option>
                                        <option value="F">F</option>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" id="Confirm">Confirm</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
