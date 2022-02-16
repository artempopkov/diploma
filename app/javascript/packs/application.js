// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
import $ from "jquery";
import "select2/dist/js/select2";
import Noty from "noty/lib/noty.js";

require("trix");
require("@rails/actiontext");

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function () {
  $(".flash_message").each(function () {
    const $this = $(this);

    new Noty({
      type: $this.attr("flash-type"),
      theme: "bootstrap-v4",
      text: $this.text(),
      timeout: 3000
    }).show();
  });
});

$(document).on("turbolinks:load", function () {
  Turbolinks.clearCache();
  $(".js-multiple-select").each(function () {
    const $this = $(this);

    let opts = {
      theme: "classic",
      width: "100%",
      placeholder: $this.data("placeholder"),
      allowClear: Boolean($this.data("allow-clear")),
    };

    $this.select2(opts);
  });
});

$(document).on("turbolinks:before-cache", function (e) {
  return $(".js-multiple-select").each(function () {
    return $(this).select2("destroy");
  });
});

$(document).on("turbolinks:load", function () {
  $("#preloader-active").delay(450).fadeOut("slow");
  $("body").delay(450).css({
    overflow: "visible",
  });
});

$(document).on("turbolinks:load", function () {
  $(".search-close").hide();
  $("button.search-icon").on("click", function () {
    $(this).hide();
    $("body").toggleClass("open-search-form");
    $(".search-close").show();
    $("html, body").animate({ scrollTop: 0 }, "slow");
  });
  $(".search-close").on("click", function () {
    $(this).hide();
    $("body").removeClass("open-search-form");
    $("button.search-icon").show();
  });
});

$(document).on("turbolinks:load", function () {
  $("#open-comment-field").on("click", function () {
    $("#review-comment").toggle("slow");
  });
});
