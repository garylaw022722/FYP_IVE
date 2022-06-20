<%-- 
    Document   : EditorContract
    Created on : 16-Apr-2021, 18:31:24
    Author     : law
--%>

<%@page import="ict.bean.ComicTypeBean"%>
<%@page import="ict.db.ComicTypeDB"%>
<%@page  import="ict.bean.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Contract Agreement</title>
        <script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="css/EditorController.css">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
        <link rel="stylesheet" href="css/EditorContract.css">

    </head>
    <style>

    </style>
    
       <%Account editor = (Account)request.getSession().getAttribute("editor");%>
    
    <%if(editor==null){%>
    <script>window.location.href = "Login2.jsp";</script>
    <%}%>
    
    <script>

        var searchId;

        var typeList = [];
        var maxContractID;
        var checkContainer = [];
        $(document).ready(function () {
            var block = false;

            createDate();
            $("#glassLayOut1").hide();
            $("#glassLayOut2").hide();

            $("#FindContract").keydown(function (e) {
                var keyCode = e.keyCode || e.which;
                var val = $(this).val();
                if (keyCode == "13")
                    getContributionSender(val);
            })

            $("#ConSearch").click(function () {
                var val = $("#FindContract").val();
                getContributionSender(val);
            })


            $("#hkidD").change(function () {
                var val = $(this).val()
                if (!/[0-9]{6}/.test(val))
                    alert("you must enter 0-9 value")

            })




            $("#hkidL").change(function () {
                var val = $(this).val()
                val = parseInt(val);
                if (!/[0-9]/.test(val))
                    alert("you must enter 0-9 value")

            })

            $("#hkidA").change(function () {
                var val = $(this).val();
                if (/[A-Z]/.test(val) || /[a-z]/.test(val)) {
                    $(this).val(val.toUpperCase());
                } else {
                    alert("you must input A-Z value")
                }


            })


            function checkField(v1, v2, label) {
                if (v1 == v2) {
                    $(label).css({"color": "red"})
                    return true;
                } else {
                    $(label).css({"color": "#3f4a56"})
                    return false;
                }

            }




            $("#NewContract").click(function () {
                $.ajax({
                    url: "contractControleler",
                    type: "get",
                    data: {operation: "getNextId"},
                    success: function (res) {

                        var item = JSON.parse(res);
                        var con = item[0].id

                        var numYear = $("#Year").val()
                        var month = $("#Month").val()
                        var date = $("#Day").val()
                        var building = $("#building").val()
                        var floor = $("#floor").val()
                        var dest = $("#dest").val()
                        var fn = $("#fn").val()
                        var ln = $("#ln").val()
                        var gender = $("input[name=gender]:Checked").val()
                        var penName = $("#penName").val();
                        var tel = $("#conNum").val();
                        var comicName = $("#cName").val();
                        var price = $("#price").val();
                        var periodUnit = $("#per").val();
                        var paymentMethod = $("input[name=payment]:Checked").val();
                        var period = $("#period").val();
                        var serDay = $("input[name=type]:Checked").val();
                        var hkidD = $("#hkidD").val();
                        var hkidA = $("#hkidA").val();
                        var hkidL = $("#hkidL").val();
                        var bank = $("#bank").val();

                        checkField(hkidA, "", ".hkid")
                        checkField(hkidD, "", ".hkid")
                        checkField(hkidL, "", ".hkid")
                        checkField(bank, "", ".ba")




                        if (checkField(hkidA, "", ".hkid")) {
                            alert("you may fill in all of field")
                            return;
                        }
                        if (checkField(hkidD, "", ".hkid")) {
                            alert("you may fill in all of field")
                            return;
                        }
                        if (checkField(hkidL, "", ".hkid")) {
                            alert("you may fill in all of field")
                            return;
                        }
                        if (checkField(bank, "", ".ba")) {
                            alert("you may fill in all of field")
                            return;
                        }
                        if (checkField(bank, "", ".ba")) {
                            alert("you may fill in all of field")
                            return;
                        }












                        var HKID = hkidA + hkidD + hkidL;
                        var DOB = numYear + "-" + month + "-" + date;
                        var address = building + "," + floor + "," + dest;
                        var peal = (gender == "male") ? "Mrs" : "Miss"
                        var fullName = peal + " " + ln + " " + fn;
                        period = period + " " + periodUnit;


                        sessionStorage.setItem("serDay", serDay);
                        sessionStorage.setItem("con", con)
                        sessionStorage.setItem("cid", searchId)
                        sessionStorage.setItem("price", price)
                        sessionStorage.setItem("period", period)
                        sessionStorage.setItem("cn", comicName)
                        sessionStorage.setItem("pn", penName)
                        sessionStorage.setItem("pm", paymentMethod)





                        sessionStorage.setItem("fullName", fullName);
                        sessionStorage.setItem("fn", fn);
                        sessionStorage.setItem("ln", ln);
                        sessionStorage.setItem("tel", tel);
                        sessionStorage.setItem("gender", gender)
                        sessionStorage.setItem("building", building)
                        sessionStorage.setItem("floor", floor);
                        sessionStorage.setItem("dest", dest);



                        window.open("contractTemplate.jsp")


                        $("#glassLayOut1").show();

                    }

                })



                return

                selectedDate(numYear, date, month);
                var address = item[s].Address.split(",")
                $("#building").val(address[0])
                $("#floor").val(address[1])
                $("#dest").val(address[2])
                var contactNum = item[s].tel;
                $("#conNum").val(contactNum);
                $("#fn").val(item[s].FirstName);
                $("#ln").val(item[s].LastName);
                $("#email").val(item[s].email);
                var id = item[s].idenNo;
                if (id != null) {
                    alert(id.charAt(id.length - 1));
                    $("#hkidA").val(id.charAt(0))
                    $("#hkidD").val(id.substring(1, id.length - 1))
                    $("#hkidL").val(id.charAt(id.length - 1))
                }

                $("#cName").val(item[s].title)

















            })



            $("#newType").keypress(function (e) {
                var keycode = e.KeyCode || e.which
                var type = $("#newType").val();

                if (keycode == 13)
                    addNewType(type)


            })


            $("#uploadContract").change(function () {
                var file = $(this)[0].files[0]
                $("#fileName").text(file.name)
                $("#btnUpload").text("Select Other")
            })



            $("#addNew").click(function () {
                var file = $("#uploadContract")[0].files[0];
                if (file == null) {
                    alert("You have not upload  contract yet")
                    return;

                }


                var email = $("#email").val()
                var numYear = $("#Year").val()
                var month = $("#Month").val()
                var date = $("#Day").val()
                var building = $("#building").val()
                var floor = $("#floor").val()
                var dest = $("#dest").val()
                var fn = $("#fn").val()
                var ln = $("#ln").val()
                var gender = $("input[name=gender]:Checked").val()
                var penName = $("#penName").val();
                var tel = $("#conNum").val();
                var price = $("#price").val();
                var comicName = $("#cName").val();



                var periodUnit = $("#per").val();
                var paymentMethod = $("input[name=payment]:Checked").val();
                var period = $("#period").val();
                var serDay = $("input[name=type]:Checked").val();
                var bank = $("#bank").val();



                var HKID = $("#hkidA").val() + $("#hkidD").val() + $("#hkidL").val()
                var DOB = numYear + "-" + month + "-" + date;
                var address = building + "," + floor + "," + dest;


                var formdata = new FormData();
                formdata.append("fn", fn);
                formdata.append("ln", ln);
                formdata.append("gender", gender);
                formdata.append("hkid", HKID)
                formdata.append("bank", bank);
                formdata.append("conNum", tel);
                formdata.append("address", address)
                formdata.append("comicName", comicName)
                formdata.append("penName", penName);
                formdata.append("serDay", serDay);
                formdata.append("paymentMehtod", paymentMethod)
                formdata.append("price", price);
                formdata.append("period", period);
                formdata.append("periodUnit", periodUnit);
                formdata.append("file", file)
                formdata.append("fileName", file.name)
                formdata.append("email", email)
                formdata.append("conId", searchId);
                formdata.append("dob", DOB);

                $.ajax({
                    url: "contractControleler",
                    type: "post",
                    data: formdata,
                    processData: false,
                    contentType: false,
                    success: function (res) {



                        alert(res);
                    }
                })


            })

            $("#cancelNew").click(function () {
                $("#glassLayOut1").hide();

            })

            $("#price").keydown(function (e) {
                var keyCode = e.KeyCode || e.which
//              alert(keyCode)
                var val = $(this).val()
                var leng = val.length;
                if (leng == 1 && keyCode !== 8)
                    $(this).val("$" + val);
//              else if
//            else if(leng ==1 &&keyCode ==8 )    
//                    $(this).val("")

            })


            $("input[name=type]").click(function () {
                var tv = $(this).val();
                takeplace(tv);
            })

            $("#period").change(function () {

                var period = $("#per").val();
                var num = $("#period").val();
                if (num.length > 1)
                    contractPeriodChecking(period, num)

            })

            $("#per").change(function () {
                var period = $("#per").val();
                var num = $("#period").val();
                if (num != "")
                    contractPeriodChecking(period, num)
//                alert("ssa")
            })


            $("#uploadContract").change(function () {
                var file = $(this)[0].files[0]
                $("#fileName").text(file.name)
                $("#btnUpload").text("Select Other")
            })



        })

        function contractPeriodChecking(period, num) {
            var flag = false;

            if (period == "Days") {
                if (num < 30)
                    alert("The  Validation period should not less than 30 Days")
                else if (num > 1825)
                    alert("The  Validation period should not more than 1825 Days")
                flag = true;
            } else if (period == "Years") {
                if (num <= 1)
                    alert("The  Validation period should not less than 1 Years")
                else if (num > 5)
                    alert("The  Validation period should not more than 5 Years")
                flag = true;
            } else if (period == "Months") {
                if (num <= 1)
                    alert("The  Validation period should not less than 1  Months")
                else if (num > 70)
                    alert("The  Validation period should not more than  70 Months")
                flag = true;

            }
            return  flag;


        }

        function checkLeng_A_digit(val) {
            var isMatchLength = true;
            var isDigit = true;
            var result = [];
            if (val.length < 6)
                isMatchLength = false;
            else {
                for (var s = 0; s < val.length; s++) {
                    if (!/[0-9]/.test(val.chartAt(s)))
                        isDigit = false;
                }

            }

            result.push(isMatchLength);
            result.push(isDigit)
            return result;
        }

        function addNewType(types) {

            $.ajax({
                url: "ProductController",
                type: "get",
                data: {operation: "addNewType", newType: types},
                success: function (res) {
                    $("#newType").val("");
                    $("#glassLayOut1").hide();

                    var item = JSON.parse(res);
                    var size = $("typeList option").length
                    alert("You have been add a new type");
                    $("#typeList div").eq(size - 1).before("<div><input type='checkbox' name='type' value='" + item[0].tid + " '  onclick='checkTypeList(" + item[0].tid + ")'><span id='tn'>" + item[0].name + "</span></div>")
                    checkTypeList();


                }
            })



        }




        function  takeplace(day) {

            for (var s = 0; s < $("#typeList input").length; s++) {
                if ($("#typeList input").eq(s).val() !== day)
                    $("#typeList input").eq(s).prop("checked", false);

            }

        }

        function getContributionSender(key) {
            $.ajax({
                url: "Contribution",
                tpye: "get",
                data: {operation: "getContributionSender", keyword: key},
                success: function (res) {
                    var item = JSON.parse(res);
                    if (item.length == 0)
                        alert("No Any Searching Result")
                    else if (item[0].msg != null)
                        alert(item[0].msg)
                    else {
                        for (var s = 0; s < item.length; s++) {
                            searchId = item[s].conId;
                            if (item[s].gender === "Male") {
                                $("#male").prop("checked", true)

                            } else {
                                $("#female").prop("checked", true)
                            }

                            var DOB = item[s].DOB.split("-");
                            var numYear = DOB[0]
                            var month = DOB[1]
                            var date = DOB[2];
                            selectedDate(numYear, date, month);
                            var address = item[s].Address.split(",")
                            $("#building").val(address[0])
                            $("#floor").val(address[1])
                            $("#dest").val(address[2])
                            var contactNum = item[s].tel;
                            $("#conNum").val(contactNum);
                            $("#fn").val(item[s].FirstName);
                            $("#ln").val(item[s].LastName);
                            $("#email").val(item[s].email);
                            var id = item[s].idenNo;
                            if (id != null) {
                                alert(id.charAt(id.length - 1));
                                $("#hkidA").val(id.charAt(0))
                                $("#hkidD").val(id.substring(1, id.length - 1))
                                $("#hkidL").val(id.charAt(id.length - 1))
                            }

                            $("#cName").val(item[s].title)



                        }

                    }
                }




            })


        }


        function createDate() {
            var Str;
            for (var s = 1; s <= 31; s++) {
                Str = (s < 10) ? ("0" + s) : s
                $("#Day").append("<option value='" + Str + "'>" + Str + "</option>")

            }
            for (var j = 1; j <= 12; j++) {
                Str = (j < 10) ? ("0" + j) : j
                $("#Month").append("<option value='" + Str + "'>" + Str + "</option>")

            }

            for (var c = 1958; c <= new Date().getFullYear(); c++) {//            

                $("#Year").append("<option value='" + c + "'  >" + c + "</option>")
            }



        }






        function selectedDate(year, date, month) {

            setDateField("#Year option", year)
            setDateField("#Month option", month)
            setDateField("#Day option", date)
        }

        function displayListContent() {
            var str = "";
            for (var s = 0; s < typeList.length; s++) {
                if (s < typeList.length - 1)
                    str += typeList[s] + "-"
                else
                    str += typeList[s]

            }
            alert(str);
        }


        function displayListContent2() {
            var str = "";
            for (var s = 0; s < checkContainer.length; s++) {
                if (s < checkContainer.length - 1)
                    str += checkContainer[s] + "-"
                else
                    str += checkContainer[s]

            }
            alert(str);
        }


        function popType(num) {
            var newList = [];
            for (var s = 0; s < typeList.length; s++) {
                if (typeList[s] != num)
                    newList.push(typeList[s]);
            }
            return newList

        }
        function  uncheckedLastOption(num) {
            for (var s = 0; s < $("input[name=type]").length; s++) {
                if ($("input[name=type]").eq(s).val() == num)
                    $("input[name=type]").eq(s).prop("checked", false);
            }




        }

        function checkboxLimitation() {
            var tv = $(this).val()


            if ($(this).prop("checked")) {

                if (typeList.length == 3 || tv == "other") {
                    if (typeList.length == 3)
                        alert("Don't choose more than 3 types")

                    uncheckedLastOption(tv);
                    return;
                }

                typeList.push(tv);
            } else
                typeList = popType(tv);

            displayListContent();



        }

        function setDateField(field, num) {
            var fieldL = ($(field).length);
            var fieldSet = $(field);
            for (var s = 0; s < fieldL; s++) {
                if (fieldSet.eq(s).val() == num)
                    fieldSet.eq(s).replaceWith("<option value='" + fieldSet.eq(s).val() + "' selected >" + fieldSet.eq(s).val() + "</option>");
            }




        }




    </script>
    <style>

        .error{

            color:red;
        }

        #glassLayOut1{
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.05);
            position: fixed;
            z-index:2012;
        }
        #dialog{
            z-index: 2013;
            /*border: 1px solid red;*/
            background: rgb(239, 241, 241);
            box-shadow: 1px 2px 10px rgba(0,0,0,0.8);
            top:150px;
            left: 30%;
            width: 35%;
            position: absolute;
            height: 220px;
        }
        #ch{
            color: white;
            height: 40px;
            padding-top: 10px;
            padding-left: 20px;
            margin-top: 0;
            background: #485667;
        }
        #cmain{
            width: 90%;
            margin-top: 25px;
            margin-left: 5%;
            font-family: "Al Nile";
            font-size: 16px;
        }
        #newType{
            margin-top: 10px;
            text-align: center;
            padding: 4px 0px;
            font-size: 16px;
        }
        #cancelNew,#addNew{
            float:right;
            margin-top: 40px;
            width: 15%;
            border: 1px solid #aeb1b5;
        }
        #addNew{
            margin-right: 40px;
            /*border: 1px solid #aeb1b5;*/
            margin-left: 20px;
        }

        #uploadContract{
            top:-30px;
            visibility: hidden;
            position: absolute;
            z-index: 1240;
        }
        #btnUpload{
            /*margin-bottom: 10px;*/
            /*width: 20%;*/
            margin-top: 5px;
            border-radius: 3px;
            padding: 3px;
            text-align: center;
            width: 100%;
            padding-top: 8px;
            /*background: #cad8ea;*/
            font-family: "Al Nile";
            font-size: 16px;
            color: #a8aeae;
        }

        


    </style>



    <body>
        <input id="uploadContract" type="file">
        <div id="glassLayOut1">
            <div id="dialog">
                <div id="ch">New Comic Type</div>
                <div id="cmain">
                    <span>Selected File :</span><span id="fileName"></span><br>

                    <label id="btnUpload"  for="uploadContract" class="form-control">Find your file</label>
                </div>
                <button id="addNew">Add</button>
                <button id="cancelNew">Cancel</button>
            </div>
        </div>
        <div id="glassLayOut2">

        </div>


        <div id="topNav"></div>
        <div id="left">
           <%@include file="parts/editorLeftBar.jsp" %>
        </div>
        <div id="reight">
            <div id="contentInsert">
                <div id="contractTab">
                    <div id="titleField">Author Contract</div>
                    <input type="text" id="FindContract" placeholder="Email or Contribution ID.">
                    <button id="ConSearch">Search</button>
                    <button id="NewContract">New Contract</button>
                    <!--<button id="uploadContractBTN">upload Contract</button>-->
                </div>

                <div id="ContractLayOut1">
                    <div id="headingSK">
                        <li>Author Information</li>
                    </div>
                    <div id="fieldSet"><span id="must" style="color: red">*</span><span id="fieN" class="FirstName">First Name :</span>
                        <input
                            id="fn" type="text"></div>
                    <div id="fieldSet" style="margin-left: 6%"><span id="must" style="color: red">*</span><span id="fieN" class="LastName">Last Name :</span><input
                            id="ln" type="text"></div>
                    <br>
                    <div id="fieldSet" style="width: 70%;"><span id="must" style="color: red;visibility: hidden">*</span><span
                            id="fieN" class="email">Email Address :</span><input id="email" type="text" disabled></div>
                    <br>
                    <div id="fieldSet"><span id="must" style="color: red">*</span><span id="fieN" style="margin-top: -5px;" class="gender">Gender :</span>
                        <div id="radioSet">
                            <input name="gender" type="radio" id="male" value="male"><span id="gen">Male</span>
                        </div>
                        <div id="radioSet">
                            <input name="gender" type="radio" id="female" value="female"><span id="gen">Female</span>
                        </div>
                    </div>
                    <br>
                    <div id="fieldSet" style="width: 100%">
                        <span id="must" style="color: red">*</span><span id="fieN" class="dob">Date of Birth :</span>

                        <select name="Year" id="Day">
                            <option value="option">Day</option>
                        </select>
                        <select name="Year" id="Month">
                            <option value="option">Month</option>
                        </select>

                        <select name="Year" id="Year">
                            <option value="option">Year</option>
                        </select>
                        <!--<br><span style="color:#aeb1b5 ;font-size: 12px;">(DD-MM-YYYY)</span>-->
                    </div>
                    <div id="fieldSet" style="width: 70%;">
                        <span id="must" style="color: red;">*</span>
                        <span id="fieN" class="hkid">HKID :</span>
                        <input id="hkidA" type="text" maxlength="1">
                        <input id="hkidD" type="text" maxlength="6">
                        (&nbsp;<input id="hkidL" type="text" maxlength="1">&nbsp;)
                    </div>

                    <div id="fieldSet" style="width: 70%;">
                        <span id="must" style="color: red;">*</span>
                        <span id="fieN" class="ba">Bank Account :</span>
                        <input id="bank" type="text" style="
                               border: none;
                               border-bottom: 1px solid #dcdcdc;
                               " maxlength="14">
                    </div>


                </div>

                <div id="ContractLayOut2">
                    <div id="headingSK" style="margin-top: 0px;">
                        <li>Contact Information</li>
                    </div>
                    <div id="fieldSet" style="width: 100%;">
                        <span id="must" style="color: red;">*</span>
                        <span id="fieN" class="contact">Contact Numbers  :</span>
                        <input id="conNum" type="text">
                    </div>
                    <div id="fieldSet" style="width: 100%;">
                        <span id="must" style="color: red;">*</span>
                        <span id="fieN" class="add">Address  :</span><br>
                        <div style="margin-left: 10%;padding-top: 20px">
                            <span style="font-size: 12px;color: #6e7e8c;margin-right: 23px">Building :</span>
                            <input id="building" type="text"><br>
                            <span style="font-size: 12px;color: #6e7e8c">Floor /Flat :</span>
                            <input id="floor" type="text"><br>
                            <span style="font-size: 12px;color: #6e7e8c;margin-right: 23px">Destrict :</span>
                            <input id="dest" type="text"><br>
                        </div>

                    </div>

                </div>





            </div>
            <div id="ContractResult">
                <div id="headingSK" style="margin-top: 0px;">
                    <li>Contract Details</li>
                </div>
                <span id="must" style="color: red;">*</span>
                <span class="fss" id="fieN" style="margin-top: 10px">Comic Name :</span><br>
                <input class="fs" id="cName" type="text"><br>
                <span id="must" style="color: red;">*</span>
                <span class="fss" id="fieN" class="pen">Pen Name  :</span><br>
                <input class="fs" id="penName" type="text"><br>
                <span id="ctLogo">Serialization period</span>
                <div id="typeList">   

                    <div><input type="checkbox" name='type'value='Sunday'><span id="tn">Sunday</span></div>
                    <div><input type="checkbox" name='type'value='Monday'><span id="tn">Monday</span></div>
                    <div><input type="checkbox" name='type'value='Tuesday'><span id="tn">Tuesday</span></div>
                    <div><input type="checkbox" name='type'value='Wednesday'><span id="tn">Wednesday</span></div>
                    <div><input type="checkbox" name='type'value='Thursday'><span id="tn">Thursday</span></div>
                    <div><input type="checkbox" name='type'value='Friday'><span id="tn">Friday</span></div>
                    <div><input type="checkbox" name='type'value='Saturday'><span id="tn">Saturday</span></div>
                    <div><input type="checkbox" name='type'value='Monthly'><span id="tn">Monthly</span></div>


                </div>
                <div id="paymentList">
                    <span id="paymentMethod">Payement Method</span>
                    <div id="paymentConponent">
                        <div><input type="radio" name="payment" value="Full Payment"><span id="prp">One times payment</span></div>
                        <div><input type="radio" name="payment" value="monthly"><span id="mpm">Monthly</span></div>
                        <div style="margin-top: 10px;margin-bottom: 5px">
                            <span id="must" style="color: red;margin-left: 0">*</span>
                            <span style="color: #aeb1b5" id="lbPrice">Price :</span> <input id="price" type="text">
                        </div>
                        <div>
                            <span id="must" style="color: red;margin-left: 0">*</span>
                            <span style="color: #aeb1b5" class="period">Validation Period :</span> <input id="period" type="number">
                            <select name="per" id="per">
                                <option value="Days">Day(s)</option>
                                <option value="Years">year(s)</option>
                                <option value="Months">month(s)</option>
                            </select>
                        </div>
                    </div>
                    <!--                <span>Price:</span> <input type="text">-->
                </div>

            </div>
        </div>


    </body>
</html>