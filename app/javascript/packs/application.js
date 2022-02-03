// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
require("trix");
require("@rails/actiontext");

Rails.start();
Turbolinks.start();
ActiveStorage.start();

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
  $("#customFile").change(function (e) {
    let file_name = e.target.files[0].name;
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
