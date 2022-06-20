function checkBrowser() {
    if (navigator.userAgent.indexOf("Firefox") != -1) {
        debounceSpeed = 700;
    } else if (navigator.userAgent.indexOf("Chrome") != -1) {
        debounceSpeed = 35;
    } else {
        debounceSpeed = 30;
    }
    return debounceSpeed;
}


function exeFullScreen(elem) {

    if (elem.requestFullscreen) {
        elem.requestFullscreen();
    } else if (elem.mozRequestFullScreen) { /* Firefox */
        elem.mozRequestFullScreen();
        // debounceSpeed = 700;
    } else if (elem.webkitRequestFullscreen) { /* Chrome, Safari & Opera */
        elem.webkitRequestFullscreen();
    } else if (elem.msRequestFullscreen) { /* IE/Edge */
        elem.msRequestFullscreen();
    }
}

function preHoverEffect() {
    $('.pre').mouseenter(function () {

        $('.prePagebtn').css({fill: "#e2387b"})
    })
    $('.pre').mouseleave(function () {
        $('.prePagebtn').css({
            fill: "#fffdfd",
            fillOpacity: "0.7"
        })
    })
}

function nextHoverEffect() {
    $('.next').mouseenter(function () {
        $('.nextPagebtn').css({fill: "#e2387b"})

    })
    $('.next').mouseleave(function () {
        $('.nextPagebtn').css({
            fill: "#fffdfd",
            fillOpacity: "0.7"
        })
    })
}
function fullScreenOperation(isFullScreen){
    if(!isFullScreen){
        closeScreenEffec();
    }else{
        fullScreenEffect();
    }
    backpage();
    setPageSpeed(default_Page_Speed);
}

function  closeScreenEffec(){
    $('.bothSideModePage *').removeClass('fullScreenEffect_Height');
    $('.chapter').removeClass('chapterF');

}
function fullScreenEffect(){

    $('.bothSideModePage *').addClass('fullScreenEffect_Height');
    $('.chapter').addClass('chapterF');
}

function  mouswheell_Trigger(debounceSpeed){

    $('.readingArea').on('mousewheel', _.debounce(function (event) {
        var delx = event.deltaX;
        var dely = event.deltaY;
        if (window.innerHeight == screen.height || document.webkitFullscreenElement) {
            mouseWheelFunc(delx, dely);
        }
    }, debounceSpeed));
}


function  pageLoad(count ,size) {
    op = count * size;
    movingPixel = "translateX(" + (op) + "px) ";
    $('.bothSideModePage').css({
        transition:"transform "+pageSpeed+"s ease-in-out",
        transform: movingPixel
    })
    document.querySelector('.bothSideModePage').addEventListener("transitionend",()=>{
        $('.prePagebtn ,.nextPagebtn').css({
            fill: "#fffdfd",
            fillOpacity: "0.7"
        })
    })
}
function setPageSpeed(ele){
    pageSpeed = ele;
}

function  setoPageScroll(numOfPage){
    $('#pageScroll').attr("max",numOfPage);
}


