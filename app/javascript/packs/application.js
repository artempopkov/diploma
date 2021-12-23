// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

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
