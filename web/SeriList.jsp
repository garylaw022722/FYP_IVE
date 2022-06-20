
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Serialized List</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.10.2/Sortable.min.js"></script>
        <link rel="stylesheet" href="css/SeriList.css">
        <script src="js/ImageTranslator.js"></script>
    </head>

    <script>
        function ReadDeatils(cid, event) {
//            

            window.location.href = "ReadBookController?operation=SelectComic&comicId=" + cid

        }


        var it = new ImageTranslator();
        $(document).ready(function () {
            $("#ddNav").load("parts/memberNav2.jsp");


            getSeriList();


        })


        function getSeriList() {
            $.ajax({
                url: "ProductController",
                type: "get",
                data: {operation: "showProductList"},
                success: function (res) {

                    var item = JSON.parse(res);

                    for (var s = 0; s < item.length; s++) {
                        var tr = createLayout(item[s], s)

                        $("#Serilist").append(tr);
                        var n = colorPicker(item[s].period).split("-");
                        var color = n[0];
                        var shadow = n[1];

                        $("#Serilist #DatePeriod").eq(s).css({"color": color, "border-bottom": "7px solid", "text-shadow": "2px 2px 10px " + shadow});

                    }





                }

            })


            function createLayout(item, s) {

                var str = "<div id='DatePeriod'><i class='bi bi-calendar-minus'  style='padding-right: 20px'></i>" + item.period + "</div>"
                str += createRow(item, item.period);
                str += "</div>"
                return str;
            }

            function createRow(item, week) {
                var cm = item.comic


                var str = "<div id='Session' style='margin-bottom:80px'>";

                for (var s = 0; s < cm.length; s++) {
                    var code = week + s;

                    str += "<div id='SeriContent' onclick='ReadDeatils(" + cm[s].cid + ")'>" +
                            "<div id='comic'>" +
                            "<div id='cover' class='" + code + "'></div>" +
                            " <div id='des'>" + cm[s].name + "</div>" +
                            " </div>" +
                            " </div>";
                    if (s % 4 == 0 && s != 0)
                        str += "<div id='sepBar';style='linear-gradient(to right, #fc5a9f 80%, #949292 20%)'></div>"
                    var blob = it.base64ToBlob(cm[s].image);
                    it.preLoad(blob, "." + code);
                }

                str += "<div>"




                return str;

            }



            function colorPicker(wk) {
                var str = ""
                if (wk == "Sunday")
                    str = "#8553cb-#7b5ad2"


                else if (wk == "Monday")
                    str = "#ef608e-#e24d8b"

                else if (wk == "Tuesday")
                    str = "orange-#ecab59"


                else if (wk === "Wednesday")
                    str = "#ef9aef-#df97ee"

                else if (wk === "Thursday")
                    str = "#8ad7d3-#87c3bf"

                else if (wk === "Friday")
                    str = "#d72788- #fc5a9f"


                else if (wk === "Saturday")
                    str = "#61a3d9-  #45a9de"


                else if (wk === "Monthly")
                    str = "#d72788- #fc5a9f"


                return str;










            }



        }

    </script>


    <body>
        <div id="ddNav"></div>
        <div style="position: absolute;top:80px;width:100%;font-size: 18px;text-align:center ;background: #2e2e30;color: #ea6d72;padding: 20px 10px;" >Serialized Comic  List</div>
        <div id="Serilist"></div>


    </body>
</html>