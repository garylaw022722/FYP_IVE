<%-- 
    Document   : contractTemplate
    Created on : 18-Apr-2021, 03:50:49
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title id="owner">Contract Sample</title>
        <script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>

    </head>
    <style type="text/css">
        #ContractTitle {
            padding: 10px;
            padding-left: 2%;
            font-size: 38px;
            color: #3b506b;
            margin-bottom: 20px;
            /*text-shadow: 1px  2px 10px #6e7e8c;*/
            border-bottom: 4px solid;

            /*background-color: #3b506b;*/
            /*color: #eef1f6;*/
        }
        

        body {
            /*width: 50%;*/
            font-family: "Roboto Light"
        }

        #left {
            /*border: 1px solid black;*/
            display: flex;
            width: 100%;
            flex-direction: row;
            height: 300px;
        }

        #ContactInfo, #companyInfo {
            /*background-color: #3b506b;*/
            width: 50%;
            height: 100%;
            padding: 30px;
            line-height: 20px;
            font-size: 18px;
        }

        #ContactInfo div {
            margin-bottom: 3px;
        }

        #companyInfo div {
            /*float: right;*/
            font-size: 16px;
            /*border: 1px solid red;*/
            text-align: right;
            margin-bottom: 10px;

        }

        #companyInfo {
            /*background: #fc5a9f;*/
        }

        #Agreement {
            /*border: 1px solid crimson;*/
            width: 80%;
            margin: auto;
        }

        #Agreement h3 {
            text-align: center;
            width: 50%;
            margin: auto;
            margin-top: 30px;
            margin-bottom: 60px;
            padding-bottom: 10px;
            border-bottom: 3px solid;
        }

        table {
            width: 100%;
            /*background: #aeb1b5;*/
        }

        th {
            text-align: center;
            padding: 10px;
            background: #aeb1b5;
            font-size: 17px;
        }

        td {
            text-align: center;
            padding: 40px;
            font-family: "Al Nile";

            /*font-size: 18px;*/
        }

        #print {
            position: absolute;
            z-index: 20;
            width: 10%;
            background: rgba(
                255,
                255,
                255,
                0.7
                );
            /*box-shadow: 1px 2px 10px rgba(0,0,0,0.8);*/
            left: 85%;
            height: 30px;
        }

        #conId {
            width: 100%;
            /*border: 1px solid gainsboro;*/
            text-align: right;
            position: absolute;
            font-size: 16px;
            padding-right: 2%;
            color: #fc5a9f;
            /*text-shadow: none;*/
        }

        #condition {

            width: 100%;
            padding: 30px;
            padding-left: 7%;
            /*border: 1px solid red;*/
            margin: auto;
            margin-top: 140px;

        }

        #header {
            /*border-bottom: 1px solid #6e7e8c;*/
            font-size: 20px;
            width: 50%;
            margin-bottom: 10px;
            padding-bottom: 10px;
        }

        /*#deteails{font-size: 20px;}*/
        p2 {
            font-size: 17px;
        }

        li {
            margin-bottom: 20px;
        }

        #signBox {
            /*border: 1px solid red;*/
            width: 90%;
            display: flex;
            flex-direction: row;
            margin-top: 120px;
            margin-left: 30px;
            /*margin-top: 240px;*/

        }

        #date ,#name{
            width: 50%;
            font-size: 24px;

        }
        #price,#pn,#cn,#pm,#period{
            font-size: 16px;
        }
        #price{
            font-size: 18px;
        }



        #signName ,#sign {
            border-bottom: 1px solid #6e7e8c;
            width: 50%;
            text-align: center;
            display: inline-block;
        }

        #name {
            /*margin-top: 20px;*/
            width: 50%;
            height: 30px;
        }
    </style>
    <script>
        var floor = sessionStorage.getItem("floor");
        var building  =sessionStorage.getItem("building")
        var dest  = sessionStorage.getItem("dest");
        var fullName= sessionStorage.getItem("fullName");
        var tel =  sessionStorage.getItem("tel");
        var conId =  sessionStorage.getItem("cid");
        var cn =   sessionStorage.getItem("cn")
        var pn = sessionStorage.getItem("pn")
        var pm =  sessionStorage.getItem("pm")
        var price =sessionStorage.getItem("price")
        var period =sessionStorage.getItem("period");
        var con =  sessionStorage.getItem("con")
        var serDay =  sessionStorage.getItem("serDay")
        serDay=(serDay!="Montly")?(serDay+="-Every Week"):serDay
        var owner =fullName+"_Contract";
        
        
        function setContractData(){
               $("#authorDes").text(dest);
               $("#authorFloor").text(floor);
               $("#authorBuilding").text(building);
               $("#authorName").text(fullName);
               $("#authorContact").text("Tel:"+tel);
               $("#con").text(genCid(con))

               $("#cn").text(cn);
               $("#pn").text(genCid(conId));
                $("#pm").text(pm);
                $("#serDay").text(serDay)
                $("#owner").text(fullName+"_Contract")
                $("#period").text(period);
                $("#price").text(price);
                
               
            
            
        }
        
       
            
     
        
        
        

    </script>
    <script>
        $(document).ready(function () {
            
            setContractData();
            
            
            // download();
            $("#print").click(function () {
                download();

            })
            $("#sign").text(getDate())
        })

        function download() {
            var s = document.getElementById("contract");
            var opt = {
                filename: owner+".pdf",
                jsPDF: {format: 'A3'}
            }

            html2pdf().set(opt).from(s).save();


        }

        function getDate() {
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth();
            var day = date.getDate();
            if (month < 10)
                month = "0" + (month + 1);
            if (day < 10)
                day = "0" + day;
            return day + " . " + month + " . " + year
        }
        function genCid(cid){
            var num = 5- cid.length;
            var str="";
            for(var s =0 ;s <num ;s++){
                
                str+="0"
                
            }
            return (str+cid)
            
            
        }

    </script>
    <button id="print">Download</button>
    <body>
        <div id="contract">
            <h2 id="ContractTitle">Manga collection</h2>
            <!--    <span>No.32</span>-->
            <div id="conId">Contract ID : <span id="con"></span></div>
            <div id="left">
                <div id="ContactInfo">
                    <div style="margin-top: 20px ;border-bottom: 2px solid  #aeb1b5; width: 60%;padding-bottom: 4px">
                        Client</span></div>
                    <div id="authorName" style="margin-top: 10px"></div>
                    <div id="authorFloor"></div>
                    <div id="authorBuilding"></div>
                    <div id="authorDes"></div>
                    <div id="authorContact"></div>
                </div>

                <div id="companyInfo">
                    <div style="margin-top: 10px;">Manga Collection Hong Kong Limited Company</div>
                    <div>PL/RM A ,12 F</div>
                    <div>Gloucester Tower</div>
                    <div> 11 Pedder Street ,Central</div>
                    <div id="Contact">Tel :2233 3411</div>

                </div>
            </div>
            <div id="Agreement">
                <h3>Author Recruitment Agreement </h3>
                <table border="1">
                    <tr>
                        <th >Comic Name</th>
                        <th>Contribution ID</th>
                        <th>Serialization day</th>
                        <th>Payment Method</th>
                        <th>Validation Period</th>
                        <th>Price</th>
                    </tr>
                    <tr>
                        <td id="cn"></td>
                        <td id="pn"></td>
                        <td id="serDay"></td>
                        <td id="pm"></td>      
                        <td id="period"></td>
                        <td id="price"></td>
                    </tr>
                </table>
            </div>

            <div id="condition">
                <h3>Ordinance</h3>
                <div id="header" style="margin-top: 0px">Duties and responsibilities:</div>
                <p2 id="deteails">
                    <ol>
                        <li>Each Author should not post their own product to other company.
                            <b>If it's discover,our company will view as terminate contract agreement.</b><br>
                            Eventually ,the product owner will be charged <span style="color: red;font: italic;font-size: 17px">triple  contract Price</span>

                        </li>

                        <li>
                            Each Author should be delivery next episode to the editor in specified of time periods punctually .
                        </li>
                        </li>


                        <li>
                            Each Author should be keep the hard copy of the comic work for 2 weeks after due date of submission
                            .
                        </li>
                        </li>

                    </ol>
                </p2>

                <div id="header" style="margin-top: 50px">Terms of services:</div>
                <p2 id="deteails">
                    <ol>
                        <li>Each Author can contact the responsible and seek their commend to the comic work</li>
                    </ol>
                </p2>

                <div id="signBox">
                    <div id="date">
                        <span>Signature Date : </span>
                        <span id="sign"></span>
                    </div>
                    <div id="name">
                        <span>Editor Signature : </span>
                        <span id="signName" ><span style="visibility: hidden">skaskaks</span></span>
                    </div>
                </div>

            </div>
        </div>


    </body>
</html>