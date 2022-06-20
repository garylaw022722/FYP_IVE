<%-- 
    Document   : ClientContribution
    Created on : 11-Apr-2021, 12:49:29
    Author     : law
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Contribution Form</title>
        <script src="https://kit.fontawesome.com/df4f1b5dd7.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="css/ContributionForm.css">
    </head>
    <script>
        $(document).ready(function () {
            var lock = false;
            var contact
            $("#msgBox").hide()
            $("#phone").keydown(function (e) {
                var code = e.keyCode || e.which;
                var num = $(this).val()
                // alert(num)
                var leng = num.length

                if (code == 8 && leng == 6 || leng == 5) {
                    var ans = "";
                    for (var s = 0; s < 5; s++)
                        ans += num.charAt(s);

                    $(this).val(ans)
                } else if (leng === 4 && code !== 8)
                    $(this).val(num + " ")
            })

            $('#phone').change(function (e) {
                var num = $(this).val();
                if (/\D/.test(num)) {
                    alert("shsh")
                }


            })
            $("#sourceComic").change(function () {
                var file = $(this)[0].files[0];
                $("#fileName").text(file.name)
                $("#getFile").text("Select Others File")
                $("#getFile").css({marginLeft: "8%"})
                var item = $(this).val().split(".")
                var name = item[0].split("/")[1]
                alert(item[1])
                if (item[1] !== "pdf")
                    alert("Wrong File Fromate")
            })

            $("#sub").click(function () {
                if (!lock)
                    submistion();
            })


        })


        function submistion() {
            var file = $("#sourceComic")[0].files[0]
            var fileName = file.name;
            var comicName = $("#cName").val();
            var fn = $("#firstName").val();
            var ln = $("#lastName").val();
            var phone = $("#phone").val();
            var gender = $("input[name=gender]:checked").val()
            var callF = $("#callBackF").val();
            var callT = $("#callBackT").val();
            var floor = $("#floor").val();
            var destric = $("#location").val();
            var building = $("#building").val();

            // comic field
            var comic = $("").val();
            var des = $("#des").val();

            var str = fn + "\n" + ln + "\n" + phone + "\n" + callF + "\n" + callT +
                    "\n" + gender + "\n" + comic + "\n" + des + "\n" + building + "\n" + floor
            alert(str)
            var formObj = new FormData();
            formObj.append("operation", "submitContribution");
            formObj.append("FirstName", fn);
            formObj.append("LastName", ln);
            formObj.append("phone", phone);
            formObj.append("gender", gender);
            formObj.append("callF", callF);
            formObj.append("callT", callT);
            formObj.append("floor", floor);
            formObj.append("dest", destric);
            formObj.append("building", building)


            formObj.append("comicName", comicName);
            formObj.append("fileName", fileName);
            formObj.append("source", file)
            formObj.append("descri", des);




            lock = true

            $.ajax({
                url: "Contribution",
                type: "post",
                data: formObj,
                processData: false,
                contentType: false,
                async: true,
                xhr: function () {
                    var xhr = $.ajaxSettings.xhr();
                    xhr.upload.onprogress = function (e) {
                        $("#msgBox").show()

                    }
                    return xhr;
                },
                success: function (res) {
                    setTimeout(function () {
                        $("#msgBox").hide()
                        alert(res)
//                                    window.location.href="Main.jsp"
                    }, 3000);

                }


            })





        }

    </script>
    <body>
        <div id="sa"></div>
        <div id="fNav">
            <input type="file" id="sourceComic">
        </div>
        <div id="msgBox">
            <div style="width: 80px; height: 80px;display: inline-block"><img src="images/load.svg" alt=""></div>
            <span>The Form is handing</span><br>
            <span style="font-size: 12px;display: inline-block;width: 100%;text-align: center;margin-left: -8%;margin-top: -20px"> Wait it for Seconds</span>
        </div>
        <div id="sider">
            <div id="title">Author Recruitment Form</div>
            <div id="SubAlert">
                <span id="preCau">Precaution</span>
                <ul id="preDetail">
                    <li>The uploaded file should be PDF format</li>
                    <li>Each pages must be scan clearly</li>
                    <li>The recruitment result will be announced within 2 weeks</li>
                    <li>Author personal information will not be public outside</li>
                    <li><span>To comfirm your identity ,we will regards above field of firstname and  lastname as your Applelican</span><br>
                        <span style="color: #506267">※&nbsp;If it not match with your portfolio ,your full name will be upadte will these information </span>
                    </li>
                </ul>
            </div>

            <div id="main"><span id="preCau">Field Content</span></div>


            <li id="pi">Personal Information</li>
            <div id="table">
                <div id="rowItem">
                    <div><span>First Name</span></div>
                    <div><span>Last Name</span></div>
                    <div><span>Gender</span></div>
                    <div><span>Contact Number</span></div>
                    <div><span>Phone Call Period</span></div>
                    <div style="border-bottom: none;height: 200px"><span>Address</span></div>
                </div>
                <div id="rowText">
                    <div>
                        <input type="text" id="firstName" maxlength="10"><br>
                        <!--                <span>※ &nbsp; The first Name is Misssed</span>-->
                    </div>
                    <div>
                        <input type="text" id="lastName" maxlength="7"><br>
                        <!--                <span>※&nbsp;The Last Name is Misssed</span>-->
                    </div>
                    <div>
                        <div id="gF">
                            <input type="radio" name="gender" value="Male">
                            <span style="
                                  color: #6e7e8c;
                                  padding:0;
                                  padding-left: 10px;
                                  padding-right:  40px;
                                  font-size: 14px">Male</span>
                            <input type="radio" name="gender" value="Female">
                            <span id="gt" style="
                                  padding:0;
                                  font-size: 14px;
                                  padding-left: 10px;
                                  color: #6e7e8c">Female</span><br>
                            <!--                    <span style="margin-top: -20px">※&nbsp;The Last Name is Misssed</span>-->
                        </div>
                    </div>
                    <div><input type="text" id="phone" minlength="9" maxlength="9"></div>
                    <div>
                        <div style="margin-left: 5%;padding: 18px">
                            <span style="padding: 0;
                                  font-size: 14px;
                                  color: #6e7e8c;
                                  padding-right: 10px;
                                  ">From : </span>
                            <input type="time" id="callBackF">
                            <span style="padding: 0;
                                  font-size: 14px;
                                  color: #6e7e8c;
                                  padding-right: 10px;
                                  padding-left: 20px;
                                  ">To : </span>
                            <input type="time" id="callBackT">
                        </div>
                    </div>
                    <div style="height: 240px">
                        <div id="addContainer" style="height: 100%">
                            <span style="display:block;
                                  font-size: 15px;
                                  /*margin: 0;*/
                                  color: #6e7e8c;
                                  margin-top: 10px;
                                  margin-bottom:-7px;">Building</span>
                            <input type="text" id="building" placeholder="e.g Wing Shing Building">
                            <span style="display:block;
                                  font-size: 15px;
                                  /*margin: 0;*/
                                  color: #6e7e8c;
                                  margin-top: 10px;
                                  margin-bottom:-7px;"
                                  >Floor /Flat</span>
                            <input type="text" id="floor"     placeholder = "e.g floor 124 / Flat E">
                            <span style="display:block;
                                  font-size: 15px;
                                  /*margin: 0;*/
                                  color: #6e7e8c;
                                  margin-top: 10px;
                                  margin-bottom:-7px;">District</span>
                            <input type="text" id="location" placeholder="e.g 45 Pak Tin Par St  Tsuen Wan" >
                        </div>
                    </div>
                </div>

            </div>
            <li id="sp">Submission product</li>
            <div id="table" style="margin-top: 120px">
                <div id="rowItem">
                    <div><span>Comic Title</span></div>
                    <div><span>File</span></div>
                    <div style="height: 200px"><span>Description</span></div>


                </div>
                <div id="rowText">
                    <div><input type="text" id="cName"></div>
                    <div>
                        <span id="fileName" style="color: #3b506b"></span>
                        <label id="getFile" for="sourceComic">Upload Your File</label></div>
                    <div style="height: 200px">
                        <textarea id="des" class="form-control" id="exampleFormControlTextarea1"></textarea>
                    </div>
                </div>
            </div>
            <button id="sub"><span>Submit</span></button>
        </div>
        <!--<div id="ft" style="margin-top: 40px"></div>-->

    </body>
</html>