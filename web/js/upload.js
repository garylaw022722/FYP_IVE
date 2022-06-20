$(document).ready(function(){
    var start = "";
//                sa = function () {
//                    $.getJSON("createState", function (data) {
//                        $("h1").text(data.isB);
//                    })
//                }
//                window.setInterval(sa, 0.000001);
//              
    $('.uploadBox').on("dragover", function () {
        $(this).addClass('fileDrag');
        return false;
    })
    $('.uploadBox').on('dragleave', function () {
        $(this).removeClass('fileDrag');
        return false;
    })


    function setProgressInfo(start, end, e) {
        var hr = 0;
        var duration = (end - start) / 1000;
        var bps = e.loaded / duration;
        var mbps = e.total / Math.pow(1000, 1);
        var time = (e.total - e.loaded) / bps;
        var sec = time % 60;
        var min = time / 60;
        if (min > 59) {
            hr = time / 60;
            min = min % 60;
        }

        var timeStr = hr + " hr : " + Math.floor(min) + " min : " + Math.floor(sec) + " second  ";

        $('#time').html(timeStr);
        $('#fs').html(Math.round(mbps * 10) / 10 + " Kb");



    }
   
    $('.uploadBox').on('drop', function (e) {
        e.preventDefault();
//        $(this).removeClass('fileDrag');
//        $('#progressBox').css({"visibility": "visible"});
//    $('#sub').click(function () {
        start = new Date().getTime();
//        var formData = new FormData($('#upload')[0]);
     var formData = new FormData();
     var s =e.originalEvent.dataTransfer.files;
       for(let i=0; i<s.length; i++) {
        formData.append("comic", s[i]);
        
    }
    
	
        var progBar = new ldBar("#progressbar");
        $.ajax({
            url: "createState",
            data: formData,
            type: 'post',
            processData: false,
            contentType: false,
            async: true,
            xhr: function () {

                var xhr = $.ajaxSettings.xhr();
                xhr.upload.onprogress = function (e) {
                    var v = e.loaded / e.total
                    console.log(v * 1000);
                    progBar.set(v * 100);//                   
                    setProgressInfo(start, new Date().getTime(), e);
//                             
                }
                return xhr;
            },
            success: function (res) {
         
//                            document.getElementById("upload").reset();
//                            alert("The file is handled");
//                            document.querySelector("#progress").style.width = (0) + "%";
            }

        })



    });
    $('#la').change(function () {
        var option = $(this).val();
        $.get('texting', {
            optionItem: option
        }, function (res) {
            $('h2').css({color: 'red'});
            $('h2').text(res);

        });
    });

    $('#comic').change(function () {

        $('h2').text("");
    });

    $('#su').click(() => {

        document.querySelector("#progress").style.width = "123px";
    });
});