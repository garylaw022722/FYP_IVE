$(function () {
    $('.FirstName,.Street,.Building ,.LastName ,.Email,.Password,.UserName,.CNum,.SubEmail,.Floor').click(() => {
        $('.FirstName,.Street,.Floor ,.Building,.LastName ,.Email,.SubEmail,.Password,.UserName,.CNum').show();
        $('.FirstName  span ,.Street span,.Floor span,.Building span,.LastName  span ,.SubEmail span,.Email  span,.Password span,.UserName span').animate({"font-size": "13px"}, 500);
        $('#FirstName,#Street,#LastName,#Floor,#Building,#Email,#SubEmail,#password,#CNum,#UserName').css({height: "20px"})
        $('#FirstName,#Street,#LastName,#Floor,#Building,#Email,#password,#CNum,#UserName,#SubEmail').animate({
            width: "100%",

        }, 1000)

    })
    $('.FirstName').click(() => {
        $('#FirstName').focus();
    })

    $('#month').change(function () {

        alert($(this).val())
    })


    $('#FirstName').blur(() => {
        $('.FirstName').css({boxShadow: "none"})
    })
    $('#FirstName').focus(() => {
        $('.FirstName').css({boxShadow: "0.5px 0.5px 2px dodgerblue"})
    })

    $('.CNum').click(() => {
        $('#CNum').focus();
    })
    $('#CNum').blur(() => {
        $('.CNum').css({boxShadow: "none"})
    })
    $('#CNum').focus(() => {
        $('.CNum').css({boxShadow: ".5px .5px 2px dodgerblue"})
    })


    $('.Floor').click(() => {
        $('#Floor').focus();
    })
    $('#Floor').blur(() => {
        $('.Floor').css({boxShadow: "none"})
    })
    $('#Floor').focus(() => {
        $('.Floor').css({boxShadow: ".5px .5px 2px dodgerblue"})
    })

    $('.Building').click(() => {
        $('#Building').focus();
    })
    $('#Building').blur(() => {
        $('.Building').css({boxShadow: "none"})
    })
    $('#Building').focus(() => {
        $('.Building').css({boxShadow: ".5px .5px 2px dodgerblue"})
    })


    $('.LastName').click(() => {
        $('#LastName').focus();
    })
    $('#LastName').blur(() => {
        $('.LastName').css({boxShadow: "none"})
    })
    $('#LastName').focus(() => {
        $('.LastName').css({boxShadow: ".5px .5px 4px dodgerblue"})
    })

    $('.Password').click(() => {
        $('#password').focus();

    })
    $('#password').blur(() => {
        $('.Password').css({boxShadow: "none"})
    })
    $('#password').focus(() => {
        $('.Password').css({boxShadow: "0.5px .5px 4px dodgerblue"})
    })

    $('.Email').click(() => {
        $('#Email').focus();
    })

    $('#Email').focus(() => {
        $('.Email').css({boxShadow: "0.5px .5px 4px dodgerblue"})
    })

    $('#Email').blur(() => {
        $('.Email').css({boxShadow: "none"})
    })


    $('.Street').click(() => {
        $('#Street').focus();
    })

    $('#Street').focus(() => {
        $('.Street').css({boxShadow: "0.5px .5px 4px dodgerblue"})
    })

    $('#Street').blur(() => {
        $('.Street').css({boxShadow: "none"})
    })


    $('.SubEmail').click(() => {
        $('#SubEmail').focus();
    })

    $('#SubEmail').focus(() => {
        $('.SubEmail').css({boxShadow: "0.5px .5px 4px dodgerblue"})
    })

    $('#SubEmail').blur(() => {
        $('.SubEmail').css({boxShadow: "none"})
    })


    $('.UserName').click(() => {
        $('#UserName').focus();
        $('.UserName').css({
            boxShadow: "0.5px .5px 4px dodgerblue"
        })
    })
    $('#UserName').blur(() => {
        $('.UserName').css({boxShadow: "none"})
    })
    $('#UserName').focus(() => {
        $('.UserName').css({boxShadow: "0.5px .5px 4px dodgerblue"})
    })

})