
function  ImageTranslator() {

    ImageTranslator.prototype.base64ToBlob = function (base64String) {
        var byteString = atob(base64String.split(',')[1]);
        var ab = new ArrayBuffer(byteString.length);
        var ia = new Uint8Array(ab);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }
        return new Blob([ab], {type: 'image/jpeg'});
    }

    ImageTranslator.prototype.ToObjectURL = function (Blob) {

        return URL.createObjectURL(Blob);

    }


     
        ImageTranslator.prototype.preLoad=function(Blob, id) {
                var reader = new FileReader();
                reader.addEventListener("loadend", function () {
                    var image = new Image();
                    image.src = this.result;
                    $(id).append(image);
                }, false);

                reader.readAsDataURL(Blob);
            }




}


