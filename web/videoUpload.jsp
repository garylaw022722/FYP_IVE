<%-- 
    Document   : videoUpload
    Created on : 2021/3/7, 下午 03:29:00
    Author     : User
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

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/PointManagemen.css">
        <script src="https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.3.1/dist/lazyload.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <style type="text/css">
            progress{
                -webkit-appearance: progress-bar;
                box-sizing: border-box;
                display: inline-block;
                height: 1em;
                width: 10em;
                vertical-align: -0.2em;
            }
            progress[value] {
                -webkit-appearance: none;
                appearance: none;
                width: 500px;
                height: 40px;
            }

            progress[value]::-webkit-progress-bar {
                background-color: #eee;
                border-radius: 2px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.25) inset;
            }
            progress[value]::-webkit-progress-value {
                background-image:
                    -webkit-linear-gradient(-45deg, 
                    transparent 33%, rgba(0, 0, 0, .1) 33%, 
                    rgba(0,0, 0, .1) 66%, transparent 66%),
                    -webkit-linear-gradient(top, 
                    rgba(255, 255, 255, .25), 
                    rgba(0, 0, 0, .25)),
                    -webkit-linear-gradient(left, #09c, #f44);

                border-radius: 2px; 
                background-size: 35px 20px, 100% 100%, 100% 100%;
            }

            .drop-zone {
                max-width: 500px;
                height: 300px;
                padding: 25px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                font-family: "Quicksand", sans-serif;
                font-weight: 500;
                font-size: 20px;
                cursor: pointer;
                color: #cccccc;
                border: 4px dashed #0099ff;
                border-radius: 10px;
            }

            .drop-zone--over {
                border: 4px dashed #0099ff;
                opacity: 0.6;
            }

            .drop-zone__input {
                display: none;
            }

            .drop-zone__thumb {
                width: 100%;
                height: 100%;
                border-radius: 10px;
                overflow: hidden;
                background-color: #cccccc;
                background-size: cover;
                position: relative;

            }

            .drop-zone__thumb::after {
                content: attr(data-label);
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                padding: 5px 0;
                color: #ffffff;
                background: rgba(0, 0, 0, 0.75);
                font-size: 14px;
                text-align: center;
            }
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
            </style>
        </head>
        <body>
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
                            <a href="videoUpload">
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

                <div class="container">
                    <div class="row">
                        <div class="well-block">
                            <div class="well-title">
                                <h4>Upload Video</h4>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 m-b30">
                                    <div class="widget-box">
                                        <div class="wc-title">
                                            <h4>Upload List</h4>
                                        </div>
                                        <div class="widget-inner">
                                            <form class="edit-profile m-b30" action="uploadVideo"  method="POST" enctype="multipart/form-data">
                                                <div class="row">

                                                    <div class="form-group col-6">
                                                        <label class="col-form-label">Title</label>
                                                        <div>
                                                            <input class="form-control" type="text" value="" name="title">
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-12">
                                                        <label class="col-form-label">Description</label>
                                                        <div>
                                                            <textarea class="form-control" name="descript"> </textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-6">
                                                        <label class="col-form-label">Video</label>
                                                        <div class="drop-zone">
                                                            <span class="drop-zone__prompt">Drop file here or click to upload</span>
                                                            <input class="drop-zone__input" type="file"  name="file" id="file" onchange="upload()" ><br>
                                                        </div><br>
                                                        <progress id="progressBar" value="0" max="100" ></progress>
                                                        <div class="status" id="status"></div>
                                                        <p id="loadedtotal"></p>
                                                    </div>

                                                    <div class="col-12">
                                                        <input type="submit" class="button button5" value='Upload'>
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
        <script>
            function _(el) {
                return document.getElementById(el);
            }

            function upload() {
                var file = _("file").files[0];
                var formdata = new FormData();
                formdata.append("file", file);
                var ajax = new XMLHttpRequest();
                ajax.upload.addEventListener("progress", progressHandler, false);
                ajax.addEventListener("load", completeHandler, false);
                ajax.addEventListener("error", errorHandler, false);
                ajax.addEventListener("abort", abortHandler, false);
                ajax.open("POST", "VieoUploadSuccessful");
                ajax.send(formdata);
            }

            function progressHandler(event) {
                _("loadedtotal").innerHTML = "Uploaded " + event.loaded + " bytes of " + event.total;
                var percent = (event.loaded / event.total) * 100;
                _("progressBar").value = Math.round(percent);
                _("status").innerHTML = Math.round(percent) + "% uploaded... please wait";
            }

            function completeHandler(event) {
                _("status").innerHTML = "Upload completed";
            }

            function errorHandler(event) {
                _("status").innerHTML = "Upload Failed";
            }

            function abortHandler(event) {
                _("status").innerHTML = "Upload Aborted";
            }

            document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
                const dropZoneElement = inputElement.closest(".drop-zone");

                dropZoneElement.addEventListener("click", (e) => {
                    inputElement.click();
                });

                inputElement.addEventListener("change", (e) => {
                    if (inputElement.files.length) {
                        updateThumbnail(dropZoneElement, inputElement.files[0]);
                    }
                });

                dropZoneElement.addEventListener("dragover", (e) => {
                    e.preventDefault();
                    dropZoneElement.classList.add("drop-zone--over");
                });

                ["dragleave", "dragend"].forEach((type) => {
                    dropZoneElement.addEventListener(type, (e) => {
                        dropZoneElement.classList.remove("drop-zone--over");
                    });
                });

                dropZoneElement.addEventListener("drop", (e) => {
                    e.preventDefault();

                    if (e.dataTransfer.files.length) {
                        inputElement.files = e.dataTransfer.files;
                        updateThumbnail(dropZoneElement, e.dataTransfer.files[0]);
                        upload();
                    }

                    dropZoneElement.classList.remove("drop-zone--over");
                });
            });

            function updateThumbnail(dropZoneElement, file) {
                let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");

                // First time - remove the prompt
                if (dropZoneElement.querySelector(".drop-zone__prompt")) {
                    dropZoneElement.querySelector(".drop-zone__prompt").remove();
                }

                // First time - there is no thumbnail element, so lets create it
                if (!thumbnailElement) {
                    thumbnailElement = document.createElement("div");
                    thumbnailElement.classList.add("drop-zone__thumb");
                    dropZoneElement.appendChild(thumbnailElement);
                }

                thumbnailElement.dataset.label = file.name;

                // Show thumbnail for image files
                if (file.type.startsWith("image/")) {
                    const reader = new FileReader();

                    reader.readAsDataURL(file);
                    reader.onload = () => {
                        thumbnailElement.style.backgroundImage = `url('${reader.result}')`;
                    };
                } else {
                    thumbnailElement.style.backgroundImage = null;
                }
            }
        </script>
