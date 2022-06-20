<%-- 
    Document   : showVoteResult
    Created on : 2021/1/28, 下午 09:42:59
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="ict.bean.voteBean"%>
<%@page import="ict.bean.Account"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="js/canvasjs.min.js"></script>
        <style type="text/css">
            :root {
                --backgroundColor: rgba(246, 241, 209);
                --colorShadeA: rgb(106, 163, 137);
                --colorShadeB: rgb(121, 186, 156);
                --colorShadeC: rgb(150, 232, 195);
                --colorShadeD: rgb(187, 232, 211);
                --colorShadeE: rgb(205, 255, 232);
            }

            * {
                box-sizing: border-box;
            }

            *::before,
            *::after {
                box-sizing: border-box;
            }

            .left {
                padding: 10px;
                height: auto;
                width: 500px;
            }

            .right {
                padding: 10px;
                width: auto;
                margin-top: 54px;
            }

            .rank {
                margin-top: 10px;
            }

            .own {
                margin-left: 10px;
                color: red;
            }
        </style>

        <%
            String id = request.getParameter("eventID");
            String dburl = "jdbc:mysql://localhost:3306/fyp";
            String dbUser = "root";
            String dbPassword = "";
            int totalvote = 0;
            List<Integer> it = new ArrayList<Integer>();
            ArrayList<voteBean> vote = new ArrayList<voteBean>();
            ArrayList<voteBean> voteET = new ArrayList<voteBean>();
            ArrayList<voteBean> Vrank = new ArrayList<voteBean>();
            ArrayList<voteBean> Yrank = new ArrayList<voteBean>();

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dburl, dbUser, dbPassword);
                PreparedStatement pstmt = null;
                String s = "select Name,voting.eAddress as eAddress,voting.comic_Id as comic_Id from voting,comicworks WHERE voting.comic_Id = comicworks.comic_Id and event_id = " + id + "";
                pstmt = con.prepareStatement(s);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    voteBean v = new voteBean();
                    v.setComicName(rs.getString("Name"));
                    v.seteAddress(rs.getString("eAddress"));
                    v.setComicID(rs.getString("comic_Id"));
                    vote.add(v);
                }

                HashSet<String> getCount = new HashSet<String>();
                for (voteBean fvb : vote) {
                    getCount.add(fvb.getComicID());
                }

                for (String i : getCount) {
                    String str = "select COUNT(voting.comic_Id) as comic_Id,voting.comic_Id as comicID,Name from voting,comicworks WHERE voting.comic_Id = comicworks.comic_Id and event_id = '" + id + "' AND voting.comic_Id = '" + i + "' GROUP BY voting.comic_Id";
                    pstmt = con.prepareStatement(str);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        if (rs.getString("comicID").equals(i)) {
                            voteBean vb = new voteBean();
                            vb.setEachvote(rs.getString("comic_Id"));
                            vb.setComicName(rs.getString("Name"));
                            totalvote += Integer.parseInt(rs.getString("comic_Id"));
                            voteET.add(vb);
                        }
                    }
                }

                String ranks = "select COUNT(voting.comic_Id) as comic_Id,voting.comic_Id as comicID,Name,coverPage,comicworks.eAddress as eAddress from voting,comicworks WHERE voting.comic_Id = comicworks.comic_Id and event_id = '" + id + "' GROUP BY voting.comic_Id ORDER BY comic_Id DESC";
                pstmt = con.prepareStatement(ranks);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    voteBean vb = new voteBean();
                    Blob blob = rs.getBlob("coverPage");
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();
                    outputStream.close();

                    vb.setBase64Image(base64Image);
                    vb.setComicName(rs.getString("Name"));
                    vb.setEachvote(rs.getString("comic_Id"));
                    vb.setCoverPage(rs.getString("coverPage"));
                    vb.setEmail(rs.getString("eAddress"));
                    Vrank.add(vb);
                }

                String Yranks = "select COUNT(voting.comic_Id) as comic_Id,voting.comic_Id as comicID,Name,coverPage,comicworks.eAddress as eAddress from voting,comicworks WHERE voting.comic_Id = comicworks.comic_Id and event_id = '" + id + "' GROUP BY voting.comic_Id ORDER BY comic_Id ASC";
                pstmt = con.prepareStatement(Yranks);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    voteBean vb = new voteBean();
                    Blob blob = rs.getBlob("coverPage");
                    InputStream inputStream = blob.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                    inputStream.close();
                    outputStream.close();

                    vb.setBase64Image(base64Image);
                    vb.setComicName(rs.getString("Name"));
                    vb.setEachvote(rs.getString("comic_Id"));
                    vb.setCoverPage(rs.getString("coverPage"));
                    vb.setEmail(rs.getString("eAddress"));
                    Yrank.add(vb);
                }

                con.close();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            } catch (SQLException ex) {
                while (ex != null) {
                    ex.printStackTrace();
                    ex = ex.getNextException();
                }

            }

            Gson gsonObj = new Gson();
            Map<Object, Object> map = null;
            List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();

            if (vote != null) {
                for (int i = 0; i < voteET.size(); i++) {
                    voteBean v = voteET.get(i);
                    it.add(Integer.parseInt(v.getEachvote()));
                }
                int max = Collections.max(it);
                for (int i = 0; i < voteET.size(); i++) {
                    voteBean v = voteET.get(i);
                    map = new HashMap<Object, Object>();
                    if (max == Integer.parseInt(v.getEachvote())) {
                        map.put("label", v.getComicName());
                        map.put("y", Integer.parseInt(v.getEachvote()));
                        map.put("indexLabel", "Highest");
                        list.add(map);
                    } else {
                        map.put("label", v.getComicName());
                        map.put("y", Integer.parseInt(v.getEachvote()));
                        list.add(map);
                    }

                }
            }
            String dataPoints = gsonObj.toJson(list);

        %>
        <script>
            $(document).ready(function () {
                $("#showchart").click(function () {
                    $("#chart2").hide();
                    $("#chart3").hide();
                    $("#chart").show();
                    var chart = new CanvasJS.Chart("chart", {
                        animationEnabled: true,
                        theme: "light2", // "light1", "light2", "dark1", "dark2"
                        title: {
                            text: "Vote Result(Column Chart)"
                        },
                        axisY: {
                            title: "Comic"
                        },
                        data: [{
                                type: "column",
                                dataPoints: <%out.print(dataPoints);%>
                            }]
                    });
                    chart.render();
                });
            });

        </script>        
    </head>
    <body>
        <%
            Account editor = (Account) request.getSession().getAttribute("editor");
            int rank = 1;
            int yearrank = 1;
            if (vote != null && voteET != null) {%>
        <div class="left">
            <h1>TotalVoteAmount: <%=totalvote%></h1>
            <h2>Rank 1-10 </h2>
            <%for (voteBean fvb : Vrank) {%>
            <div style="font-family: Helvetica;" class="rank"><%=rank%>. <%out.println("<image src='data:image/jpg;base64," + fvb.getBase64Image() + "' width='150px' height='100px'>");%> 
                <%
                    out.println(fvb.getComicName());
                    if (fvb.getEmail().equals(editor.geteAddress())) {
                        out.println("<span class='own'>*</span>");
                    }
                %></div>
                <%rank++;
                    }%>
        </div>
        <div class="right">
            <h2>Year Range(10-20)</h2>
            <%for (voteBean fvb : Yrank) {%>
            <div style="font-family: Helvetica;" class="rank"><%=yearrank%>. <%out.println("<image src='data:image/jpg;base64," + fvb.getBase64Image() + "' width='150px' height='100px'>");%><%=fvb.getComicName()%></div>
            <%yearrank++;
                }%>
        </div>

        <%}%>
    </body>
</html>
<script>
    $("#showBarchar").click(function () {
        $("#chart").hide();
        $("#chart3").hide();
        $("#chart2").show();
        var chart = new CanvasJS.Chart("chart2", {
            animationEnabled: true,
            theme: "light2", // "light1", "light2", "dark1", "dark2"
            title: {
                text: "Vote Result(Bar Chart)"
            },
            axisY: {
                title: "Comic"
            },
            data: [{
                    type: "bar",
                    indexLabel: "{y}",
                    indexLabelFontColor: "#444",
                    indexLabelPlacement: "inside",
                    dataPoints: <%out.print(dataPoints);%>
                }]
        });
        chart.render();
    });
    $("#showPiechar").click(function () {
        $("#chart").hide();
        $("#chart2").hide();
        $("#chart3").show();
        var chart = new CanvasJS.Chart("chart3", {
            animationEnabled: true,
            theme: "light2",
            exportFileName: "New Year Resolutions",
            exportEnabled: true, // "light1", "light2", "dark1", "dark2"
            title: {
                text: "Vote Result(Pie Chart)"
            },
            data: [{
                    type: "pie",
                    showInLegend: true,
                    legendText: "{label}",
                    toolTipContent: "{y} - #percent %",
                    indexLabel: "{label} {y}",
                    dataPoints: <%out.print(dataPoints);%>
                }]
        });
        chart.render();
    });
</script>
