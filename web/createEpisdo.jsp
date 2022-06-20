<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
</head>
<style>
    #outer {
        width: 93%;
        /*border: 1px solid red;*/
        margin-left: 7%;
        height: 300vh;
        background: #eef1f6;
    }

    #titleNameC {
        font-family: AppleMyungjo;
        margin-left: 40px;
        display: inline-block;
        font-size: 23px;
        margin-top: 10px;
        color: #8e9196;
    }

    #detailList {
        width: 30%;
        /*height: 100vh;*/
        border: 1px solid gainsboro;
        position: absolute;
        left: 70%;
        z-index: 12;
    }

    #ComicForm {
        margin-top: 20px;
        width: 50%;
        height: 400px;
        margin-left: 20px;

        /*border: 1px solid red;*/
        /*margin: auto;*/
        margin-top: 30px;
        border-radius: 3px;
        background: white;
        box-shadow: 1px 2px 20px #aeb1b5;
    }

    #heading {
        padding-left: 30px;
        background: #5e636d;
        width: 90%;
        font-size: 17px;
        margin-bottom: 20px;
        margin-top: 15px;
        margin-left: 20px;

        margin-left: 30px;
        padding-top: 8px;
        color: #aeb1b5;
        height: 40px;
        /*box-shadow: 1px 2px 20px #aeb1b5;*/
    }

    #typeList div {
        width: 33%;
        height: 30px;
    }

    #CmContent input[type="text"] {
        border: none;
        border-bottom: 1px solid #aeb1b5;
    }

    #EpisodeList {
        width: 90%;
        margin-top: 30px;
        /*border: 1px solid red;*/
        margin-left: 25px;
    }

    #Se {
        width: 30%;

    }

    #SeContainer {
        margin-top: 10px;
        margin-left: 30px;
    }

    #chapterContainer {
        display: flex;
        height: 390px;
        overflow: auto;
        flex-wrap: wrap;

    }

    #chapterItem {
        width: 33.3%;
        height: 190px;
        /*border: 1px solid red;*/
        padding: 10px;
    }

    #chapter {
        background: white;
        box-shadow: 1px 2px 10px #aeb1b5;
        width: 100%;
        height: 100%;
    }

    #btnSet {
        left: 60%;
        display: inline-block;
        position: absolute;

        /*width: 40%;*/
        /*border: 1px  solid red;*/
        top: 50px;
    }

    #btnSet div {
        display: inline-block;
        background: #3f4a56;
        color: #bfc8d2;
        border-radius: 2px;
        padding: 4px 10px;
        font-size: 15px;
        margin: 0px 4px;

    }

    #ProductList {
        background: #cb4680;
    }

    #bundleContainer {
        margin-top: 50px;
        max-height: 750px;
        /*margin-top: 20px;*/
        /*margin-left: 10%;*/
        width: 90%;
        margin-left: 2%;
    }

    #BundleContent {
        width: 100%;
        height: 150px;
        background: white;
        border-bottom: 1px solid #c5cdd6;
        /*box-shadow: 2px 2px 10px #aeb1b5;*/
    }

    #chapter {
        display: flex;
        flex-direction: row;
        padding: 10px;
    }

    img {
        width: 100%;
        height: 100%;
    }

    #chapterViewr {
        width: 40%;
        /*border: 1px solid red;*/
    }

    #chapterDescript {
        width: 60%;
        padding: 0px 20px;
    }

    #createProduct {
        border: none;
        outline: none;
        height: 100%;
        color: #bfc8d2;
        padding: 5px 10px;
        border-radius: 3px;
        display: inline-block;

    }

    #ComicName, #eleName {
        font-family: AppleMyungjo;

    }

    #ChapterTitle {
        margin-top: 10px;
        font-size: 19px;
        color: #aeb1b5;
    }

    #side {

    }

    #BundleContent {
        display: flex;
    }

    #side {
        font-size: 36px;
        color: #aeb1b5;
    }

    #move {
        /*border: 1px solid red;*/
        width: 10%;
        padding-left: 40px;
        /*margin-top: 40px;*/
        /*display: inline-block;*/
        padding-top: 30px;
    }

    #Period {
        padding-top: 40px;
        font-size: 20px;
        color: #aeb1b5;
        width: 10%;
        /*border: 1px solid red;*/
    }

    #BundleCover {
        width: 13%;
        padding: 10px;
        /*border: 1px solid gainsboro;*/
    }

    #BundleTitle {
        /*border: 1px solid gainsboro;*/
        width: 30%;

        /*height: 120px;*/
        margin-top: 15px;
        margin-left: 2%;
    }

    #bdName {
        margin-top: 10px;
        font-family: AppleMyungjo;
        display: inline-block;
    }

    #removeBundle {
        height: 30px;
        color: #8592a0;
        /*background: #8592a0;*/
        border: none;
        border: 1px solid gainsboro;

    }

    #removeContainer {
        /*border: 1px solid gainsboro ;*/
        margin-left: 24%;
        padding-top: 90px;
        /*background: gainsboro;*/
    }

    #ProductContainer {
        background: white;
        width: 90%;
        margin-top: 50px;
        margin-left: 2%;
        box-shadow: 1px 2px 6px #6e7e8c;
        height: 450px;
    }

    #fh {
        font-family: AppleMyungjo;
        padding-right: 30px;

    }

    #msd input[type='text'] {
        border: none;
        /*background: #dde7ee;*/
        border-bottom: 1px solid #b7b3b3;
    }
    #productDes{
        width: 50%;
    }
    #productCover{
        position: relative;
        width: 20%;
        left: 70%;
        top:-300px;
        height: 300px;
        border: 1px solid gainsboro;
    }
    #fileName{
        text-align: center;
        display: inline-block;
        width: 100%;
        font-size: 12px;
        margin-bottom: 3px;
        margin-top: 2px;

    }
    #btnUpload{
        width: 100%;
        text-align: center;
        background: #b8c5d2;
        border-radius: 3px;
        color: #e343b6;
    }

    #create{
        width:20%;
        float: right;
        height: 30px;
        background: #6e7e8c;
        color: white;
        margin-right: 110px;
        padding-top: 2px;
        border-radius: 3px;
        margin-top: 50px;
        text-align: center;
    }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.10.2/Sortable.min.js"></script>

<script>

    var listItem = [1, 2, 3, 4];
    // alert(listItem);


    $(document).ready(function () {
        var el = document.getElementById('bundleContainer');
        var sortable = Sortable.create(el, {
            group: "grid",
            onEnd: function (/**Event*/evt) {
                var oldPosition = evt.oldIndex; // element's old index within old parent
                var newPosition = evt.newIndex; // element's new index within new parent
                // alert("old index " + (s) + " ," + "new Index" + (k));
                let val = listItem[oldPosition];
                let beget = listItem[newPosition];
                listItem[oldPosition] = beget
                listItem[newPosition] = val;
                // alert(listItem.toString())
            }
        })
        // alert($("#bundletContainer").innerHeight())
    })

</script>
<body>

<div id="outer">

    <div id="titleNameC">Comic Book Configuration</div>
    <div id="SeContainer">
        <input type="text" id="Se" placeholder="Comic ID or Name">
    </div>
    <div id="btnSet">
        <div id="ProductList">Product List</div>
        <div id="cmMain">Comic Work List</div>
        <select id="createProduct" style="background: #cb4680;">
            <option value="">Create Product</option>
        </select>
    </div>

    <div id="heading">Episode List</div>
    <div id="EpisodeList">
        <div id="chapterContainer">
            <div id="chapterItem">
                <div id="chapter">
                    <div id="chapterViewr"><img src="s9.jpg" alt=""></div>
                    <div id="chapterDescript">
                        <span id="eleName">Emalmsms</span><br>
                        <span id="ChapterTitle">Episode 32- sasjajssj </span>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <div id="ProductContainer">
        <div id="heading" style="background: #3f4a56;color: #b6bbd2;width: 100%;margin-left: 0">Product Information</div>
        <div id="msd" style="margin-left: 20px">
            <span id="fh">Comic Works:</span><input type="text" id="cm" disabled>
            <span id="fh">Author:</span><input type="text" id="authorN" disabled><br>
            <div style="margin-top: 20px">
                <span id="fh">Episode No :</span><input type="text" id="Ep" disabled>
                <span id="fh" style="padding-left: 30px">Point Required :</span><input type="text" id="bookName">
            </div>

        </div>

        <div class="form-group purple-border" style="margin-left: 20px;margin-top: 20px;">
            <span>Description</span>
            <textarea class="form-control"  id="productDes" rows="6" col="50"></textarea>
        </div>
        <div id="productCover">
            <img src="s9.jpg" alt="">
            <span id="fileName">SAS.jpg</span>
            <div id="btnUpload">Upload</div>
        </div>
    </div>
    <div id="create">Create New Product</div>



</div>

</body>
</html>