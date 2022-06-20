function Searching() {


    Searching.prototype.initComicTypeField = function () {
        $.ajax({
            url: "SearchingEngine",
            type: "get",
            data: {
                field: "getComicType",
                operation: "epConfig"
            },
            success: function (res) {
                var tag = "";
                var item = JSON.parse(res);
                for (var s = 0; s < item.length; s++)
                    tag += "<span>" + item[s].type + "</span>"
                $('#tagBar').append(tag);
            }


        })
    }
    
        Searching.prototype.initYearField =function() {
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            field: "getYear",
                            operation: "epConfig"
                        },
                        success: function (res) {
                            var tag = "<option value='-'>Years for registration</option>";
                            ;
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++)
                                tag += "<option value='" + item[s].year + "'>" + item[s].year + "</option>";
                            $('#year').html(tag);
                        }
                    })

                }
                
             Searching.prototype.initAuthorFiled =function(){
                    $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        enctype: 'multipart/form-data',
                        data: {
                            field: "getAuthor",
                            operation: "epConfig"
                        },
                        success: function (res) {
                            var tag = "<option value='-'>Author</option>";
                            var item = JSON.parse(res);
                            for (var s = 0; s < item.length; s++)
                                tag += "<option value='" + item[s].Author + "'>" + item[s].Author + "</option>";
                            $('#author').html(tag);
                        }
                    })
                }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    Searching.prototype.initComicField = function () {
        $.ajax({
            url: "SearchingEngine",
            type: "get",
            data: {
                field: "getComicWorks",
                operation: "epConfig"
            },
            success: function (res) {
                var tag = "<option value='-'>Comic Name</option>"; 
                var item = JSON.parse(res);
                for (var s = 0; s < item.length; s++)
                    tag += "<option value='" + item[s].comic + "'>" + item[s].comic + "</option>";
                $('#comic').html(tag);
            }
        })
    }


  
    
    Searching.prototype.SearchAuthorByYear = function (years) {
        $.ajax({
            url: "SearchingEngine",
            type: "get",
            data: {
                operation: "epConfig",
                field: "getAuthorByYear",
                year: years
            }, success: function (res) {
                var item = JSON.parse(res);
                var str = "<option value='-'>Author</option>";
                for (var s = 0; s < item.length; s++)
                    str += "<option>" + item[s] + "</option>";
                $('#author').html(str);
            }

        })
    }
    Searching.prototype. SearchingComicByAuthor=function(authors ,years){
                     $.ajax({
                        url: "SearchingEngine",
                        type: "get",
                        data: {
                            operation: "epConfig",
                            field: "getComicByAuthor",
                             author:authors,
                             year:years                             
                        }, success: function (res) {                         
                            var item = JSON.parse(res);
                            var str = "<option value='-'>ComicName</option>";
                            for (var s = 0; s < item.length; s++)
                                str += "<option>" + item[s] + "</option>";
                            $('#comic').html(str);
                        }

                    })
                }

           Searching.prototype.base64ToBlob =function(str){
                              
               return  new ImageTranslator().base64ToBlob(str);
           }

          Searching.prototype.ToObjectURL =function(blob){
                              
               return  new ImageTranslator().ToObjectURL(blob);
           }

}