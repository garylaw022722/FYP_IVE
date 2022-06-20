/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function mouseWheelFunc(x, y) {
    if (y == 0) {
        if (x > 0) {
            previousPages();
        } else if (x < 0) {
            nextPages();
        }
    }
}

function  previousPages() {
    $('.prePagebtn').css({fill: "#e2387b"})
    if (--countPageLoad < 0)
        countPageLoad = $('.bothSideModePage').length - 1;
    else {
        countPageLoad = countPageLoad--;
    }
    pageLoad(countPageLoad, getPageSize());
}

function  nextPages() {
    $('.nextPagebtn').css({fill: "#e2387b"})
    if (countPageLoad == $('.bothSideModePage').length - 1)
        countPageLoad = -1;
    console.log(countPageLoad);
    pageLoad(++countPageLoad, getPageSize());
}

function  getPageSize() {
    return (document.querySelectorAll('.chapter')[0].clientWidth);
}

function backpage() {
    pageLoad(countPageLoad, getPageSize());
}


function base64ToBlob(base64String) {
    var byteString = atob(base64String.split(',')[1]);
    var ab = new ArrayBuffer(byteString.length);
    var ia = new Uint8Array(ab);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }
    return new Blob([ab], {type: 'image/jpeg'});
}
