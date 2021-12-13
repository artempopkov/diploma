$(window).on('turbolinks:load', function() {
    $('#preloader-active').delay(450).fadeOut('slow');
    $('body').delay(450).css({
        'overflow': 'visible'
    });
});

$(document).on('turbolinks:load', function () {
    $('.search-close').hide();
    $('button.search-icon').on('click', function () {
        $(this).hide();
        $('body').toggleClass("open-search-form");
        $('.search-close').show();
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });
    $('.search-close').on('click', function () {
        $(this).hide();
        $('body').removeClass("open-search-form");
        $('button.search-icon').show();
    });
});
