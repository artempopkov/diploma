// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
require("trix")
require("@rails/actiontext")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on('turbolinks:load', function() {
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

$(document).on('turbolinks:load', function () {
    $('#customFile').change( function(e){
        var geekss = e.target.files[0].name;
        $('.custom-file-label').html(geekss);
        console.log(geekss);
    });
});


$(document).on('turbolinks:load', function () {
    $('#open-comment-field').on('click', function () {
        $('#review-comment').toggle("slow");
    });
});
