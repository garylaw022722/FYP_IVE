<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Account Management</title>
        <link rel="stylesheet" href="css/AccountMan.css">
        <link rel="stylesheet" href="css/AccountManModal.css">
        <style>
            th{
                background-color:#668db5;
                text-align: center;
            }
            #th th{
                text-align: center;
                font-size: 18x;
                padding: 5px;              
            }
            table{
                border-radius: 4px;


            }
            .disabled{
                background-color: #4c4c4c;
            }
        #FieldNam{
                   color:#596c88;
        }






        </style>
        <script>
            var clickTime = 0, TriggerOnce = false, itemRange = 8, soFarItem, JsonLength;
            var SurItem = [], check = [], countKey = 0;
            var initialShow = 0, finalShow = 0;
            //        $('#overlay').load('overlay.html');
            //        $('#overlay').css({visibility:"hidden"})
            function  initLayout(index, UserType, email, password, firstName, lastName, Gender, freeze) {

                var str = "<tr>" +
                        "<td>" + (index + 1) + "</td>" +
                        "<td>" + UserType + "</td>" +
                        "<td>" + email + "</td>" +
                        "<td>" + password + "</td>" +
                        "<td>" + firstName + "</td>" +
                        "<td>" + lastName + "</td>" +
                        "<td>" + Gender + "</td>" +
                        "<td><button id='btnDetails' data-toggle='modal' data-target='#ck' name='" + index + "' value='" + email + "'>View Details</button></td>" +
                        "<td><button id='btn1' name='" + index + "' value='" + email + "'>" + freeze + "</button></td>" +
                        "</tr>"
                return str;
            }

            function initUserInfo() {
                $.ajax({
                    url: "AccountController",
                    type: "get",
                    data: {operation: "init"},
                    success: function (res) {
                        var item = JSON.parse(res);
                        showResult(item);


                    }



                })

            }



            function showResult(item) {
                var str = "";
                for (var s = 0; s < item.length; s++) {
                    str = initLayout(s, item[s].UserType, item[s].email,
                            item[s].password, item[s].firstName, item[s].lastName,
                            item[s].Gender, item[s].freeze);
                    $('#myTable').append(str);
                    if (item[s].freeze == "Disable")
                        $('#myTable tr').eq(s).find("*").addClass("disabled")
                }


            }

            function initModal(utp,email,firstName,lastName,pw,subMail,dob,iden,gender,
              contactNum ,BankAc ,Building,floor,Street) {
                $('#type').text(utp)
                $('#uid').text(email)
                $('#fN').text(firstName);
                $('#lN').text(lastName);
                $('#pwrd').text(pw);
                $('#subEmail').text(subMail);
                $('#dob').text(dob);
                $('#iden').text(iden);
                $('#genDer').text(gender);
                $('#conNum').text(contactNum);
                $('#bankAcc').text(BankAc)
                $("#building").text(Building);
                $("#floor").text(floor);
                $("#street").text(Street);

            }




            $(document).ready(function () {


                $('#ck').click(function (e) {
                    if (e.target.id == "ck" || e.target.id == "close" || e.target.id == "cross")
                        initModal();
                })


                $('#noCondition').css({color: "#61adc8"});
//                $('#noCondition').css('cursor', 'pointer'); 

                $('#ControlOpt div').mouseover(function () {
                    $(this).css({"cursor": "pointer"});
                })

                $('#ControlOpt div').click(function () {  /// show userType
                    $('#ControlOpt >* ').css({color: " #b1adad"});
                    $(this).css({color: "#61adc8"});
                    $('tbody').empty();
                    var type = $(this).text();
                    $.ajax({
                        url: "AccountController",
                        type: "get",
                        data: {operation: "getTypeUser", userType: type},
                        success: function (res) {
                            var item = JSON.parse(res);
                            if (item.length == 0)
                                alert("No Found Record has found ");
                            else
                                showResult(item);
                        }




                    })
                })




                initUserInfo();
                soFarItem = itemRange;


                $('#btnDetails').click(function () {
                    $('#overlay').css({visibility: "visible"})

                })

                $('tbody').click(function (e) {
                    var value = e.target.value;
                    var id = e.target.id;
                    if (e.target.tagName == "BUTTON") {
                        var index = e.target.getAttribute('name')
                          var s = parseInt(index) + 1;
                          var userType = $('tr').eq(s).find("td:eq(1)").text()
                           var password = $('tr').eq(s).find("td:eq(3)").text()                   
                        if (id == "btnDetails") {
                            $.ajax({
                                url: "AccountController",
                                type: "get",
                                data: {operation: "getBackground", email: value},
                                success: function (res) {
                                    alert(res);
                                    var item = JSON.parse(res);
                                    var item = item [0]
                                             initModal(
                                               userType,       
                                              item.email, item.FirstName 
                                             ,item.lastName,password,item.SubAddress , 
                                             item.DOB,item.idenNo, item.gender
                                             ,item.contactNum ,item.BankAccount,item.Building,
                                             item.floor, item.Street, item.destric
                                            );
                                }
                            })


                        
     

                        } else if (id == "btn1") {

                            $.ajax({
                                url: "AccountController",
                                type: "get",
                                data: {operation: "freezing", email: value},
                                success: function (res) {
                                    var state = JSON.parse(res);
                                    if (state == "T") {
                                        e.target.textContent = "Disable";
                                        $('#myTable tr').eq(index).find("*").addClass("disabled")

                                    } else {
                                        e.target.textContent = "Enabling";
                                        $('#myTable tr').eq(index).find("*").removeClass("disabled")

                                    }
                                }
                            })

                        }




                    }


                })





                var countNotMatch = 0, isReact;
                // $('table').css({opacity: "0"})
                $('.sidebar').addClass('ani').one("transitionend", function () {

                })
                var statD;
                var count = 0;




                $('.search-btn').click(() => {
                    if (clickTime == 0) {
                        $('#title').css({marginRight: "8%"})
                        $('.search-box').css({marginLeft: "40%"}, 100)
                        $('.search-txt').css({display: "inline", width: "100px"})
                        $('.search-txt').animate({"width": "400px"}, 400);
                        clickTime = 1;

                    } else {
                    }
                })

                $('#NoMatch').hide();
                var decision;
                $('.search-txt').on('keyup', () => {

                    var val1 = $('.search-txt').val().toLowerCase();
                    var val2 = $('.search-txt').val().toUpperCase();

                    $("#myTable tr").filter(function () {

                        if ($(this).text().toLowerCase().indexOf(val1) > -1 ||
                                $(this).text().toLowerCase().indexOf(val2) > -1) {
                            decision = true;
                        } else {
                            decision = false;
                        }
                        $(this).toggle(decision);

                    });
                    if ($('#myTable tr:visible').length > 0) {
                        $('#NoMatch').hide();
                        $('#myTable tr:visible').show();
                    } else {
                        $('#NoMatch').show();
                    }
                    // alert($('#myTable tr:visible').length)

                })

            })


        </script>
        <script>

            function remove() {
                alert("It is updated");
                $('myTable tr').eq(1).css({display: "none"})
            }

            function beforeLatest() {
                var length = document.querySelectorAll('input').values.length;
                var canSee = $('#myTable tr:visible').length;
                if (length > 1) {
                    for (var z = 0; z <= canSee - 1; z++) {
                        $('#myTable tr:visible').eq(z).hide();
                    }
                }

            }

            var useOnce;
            var getLen;

            function setPageButton() {
                useOnce = true;

                var checkNum = JsonLength % itemRange;
                if (checkNum != 0) {
                    getLen = Math.round(JsonLength / itemRange)
                } else {
                    getLen = JsonLength / itemRange;
                }

                for (var x = 0; x < getLen; x++) {
                    $('#pageButton').prepend("<div><span>" + (x + 1) + "</span></div>")
                    if ($('#pageButton div').length === 3 && useOnce) {
                        $('#pageButton').prepend("<div id='more'><span>....</span></div>")
                        $('#more').css({border: "none"})

                        useOnce = false;
                        return;
                    }
                }
            }

            var pageJump = 0, preClickIndex;

            function setList() {
                var ele = document.querySelectorAll('#pageButton div');
                for (var w = 1; w < ele.length; w++)
                    ele[w].addEventListener("click", function (event) {
                        initialShow = finalShow;
                        $('#myTable tr').slice(0, finalShow).hide();
                        $('#myTable tr').slice(finalShow, finalShow += finalShow).show();
                        pageJump++;
                        // preClickIndex =event.target.index;
                        //  window.location.href = "#Control";

                        window.location = "#Control";

                    });

                // ele[].style.color ="#de1f76";

            }

        </script>
        <style type="text/css">

        </style>
    <body>

        <div class="mainContent">
            <div id="heading">
                <h2 id="title">Account</h2>

                <div class="search-box">
                    <input class="search-txt" value="" type="text" id="chValuesear"
                           placeholder="Enter below info for searching">
                    <a class="search-btn" href="#"><i class="fa fa-search"></i></a>
                </div>
                <div id="UserNameA">
                    <div>LW</div>
                </div>
                <div>Logout</div>
            </div>
            <div id="Control"></div>
            <div id="ControlOpt">
                <div >Disable</div>
                <div >Enable</div>
                <div >Staff</div>
                <div >Author</div>
                <div>Editor</div>
                <div>Member</div>
                <div id='noCondition'>No Condition</div>
            </div>
            <table aria-rowspan="3px" style="width:99% ;background: none">
                <thead>
                    <tr id="th">
                        <th id="No">No.</th>
                        <th id="build" style=" width:120px">User Type</th>
                        <th id="reDate">Email Adress</th>
                        <th id="User">Password</th>
                        <th id="clientName">First Name</th>
                        <th id="clientName">LastName</th>
                        <th id="clientName">Gender</th>
                        <!--            <th id="Accept">Identifical No</th>-->
                        <!--            <th id="conNum">contact Number</th>-->
                        <th id="Mtime">Details</th>
                        <th id="Accept">Execution</th>

                    </tr>
                </thead>
                <tbody id="myTable">

                </tbody>
            </table>

            <div id="NoMatch"><h1>No matching Result</h1></div>
            <div id="pageButton">
                <!--        <div id="more"><span>....</span></div>-->
                <!--        <div><span>1</span></div>-->
                <!--        <div><span>1</span></div>-->
                <!--        <div><span>1</span></div>-->
            </div>
            <div id="overlay"></div>
        </div>
    </div>

    <jsp:include page="parts/accountManModal.jsp"/>


</body>
</html>