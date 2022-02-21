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
require("datatables.net");
require("datatables.net-bs4");

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on('turbolinks:load', function(){
  // $("table[role='datatable']").each(function(){
  //   $(this).DataTable({
  //     processing: true,
  //     serverSide: true,
  //     ajax: $(this).data('url'),
  //     "pagingType": "full_members",
  //     "columns": [
  //       { "data": "id" },
  //       { "data": "comment" },
  //       { "data": "date" }
  //     ]
  //   });
  // });  
  $('#comments-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $("#comments-datatable").data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      { "data": "id" },
      { "data": "comment" },
      { "data": "date" },
      {"data": "options", "orderable": false}
    ]
  });
})

$(document).on("turbolinks:load", function () {
  $(".flash_message").each(function () {
    const $this = $(this);

    new Noty({
      type: $this.attr("flash-type"),
      theme: "bootstrap-v4",
      text: $this.text(),
      timeout: 3000,
    }).show();
  });
});

$(document).on("turbolinks:load", function () {
  if ($("#yield-area").height() > 0)
    $("#yield-area").addClass("border border-3 rounded");
});

$(document).on("turbolinks:load", function () {
  if ($(document).height() <= $(window).height())
    $("#footer").addClass("fixed-bottom");
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
  if (/articles[/]search/.test(window.location.href)) {
    $("body").toggleClass("open-search-form");
    $(".search-close").show();
  }
  if ($("#tag-search-input").val() == "") {
    $("#title-search").addClass("active");
    $("#title-search-input").show();
    $("#tag-search-input").hide();
  } else {
    $("#tag-search").addClass("active");
    $("#tag-search-input").show();
    $("#title-search-input").hide();
  }
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
  $("#submit-search-button").hide();

  $("#title-search").on("click", function () {
    $("#title-search").addClass("active");
    $("#tag-search").removeClass("active");
    $("#title-search-input").show();
    $("#tag-search-input").hide();
    $("#tag-search-input").val("");
  });
  $("#tag-search").on("click", function () {
    $("#tag-search").addClass("active");
    $("#title-search").removeClass("active");
    $("#title-search-input").hide();
    $("#title-search-input").val("");
    $("#tag-search-input").show();
  });
});

$(document).on("turbolinks:load", function () {
  $("#customFile").change(function (e) {
    var file_name = e.target.files[0].name;
    $(".custom-file-label").html(file_name);
  });
});

$(document).on("turbolinks:load", function () {
  $("#open-comment-field").on("click", function () {
    $("#review-comment").toggle("slow");
  });
});

$(document).on("turbolinks:load", function () {
  const chooseFile = document.getElementById("customFile");
  const imgPreview = document.getElementById("img-preview");
  if (chooseFile) {
    chooseFile.addEventListener("change", function () {
      const files = chooseFile.files[0];
      if (files) {
        const fileReader = new FileReader();
        fileReader.readAsDataURL(files);
        fileReader.addEventListener("load", function () {
          imgPreview.style.display = "block";
          imgPreview.innerHTML =
            '<img src="' +
            this.result +
            '" /> <a href="" id="remove-img"> Remove image</a>';
          const removeImg = document.getElementById("remove-img");
          const fileNameLabel = document.getElementById("file-name-input");
          removeImg.addEventListener("click", function (event) {
            event.preventDefault();
            imgPreview.style.display = "none";
            imgPreview.innerHTML = "";
            chooseFile.value = "";
            fileNameLabel.innerHTML = "Choose image";
          });
        });
      }
    });
  }
});
