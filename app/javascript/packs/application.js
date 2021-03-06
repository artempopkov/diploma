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
import "datatables.net-buttons-dt";
import "datatables.net-buttons-bs4";
import * as Select2Ru from "select2/src/js/select2/i18n/ru";

require("trix");
require("@rails/actiontext");
require("datatables.net");
require("datatables.net-bs4");
require("datatables.net-buttons-dt");
require("datatables.net-buttons");

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on("turbolinks:load", function() {
    $("#comments-datatable").DataTable({
        language: {
            processing: "Подождите...",
            search: "Поиск:",
            lengthMenu: "Записей на странице _MENU_",
            info: "Записи с _START_ до _END_ из _TOTAL_ записей",
            infoEmpty: "Записи с 0 до 0 из 0 записей",
            infoFiltered: "(отфильтровано из _MAX_ записей)",
            loadingRecords: "Загрузка записей...",
            zeroRecords: "Записи отсутствуют.",
            emptyTable: "В таблице отсутствуют данные",
            paginate: {
                first: "Первая",
                previous: "Предыдущая",
                next: "Следующая",
                last: "Последняя",
            },
            aria: {
                sortAscending: ": активировать для сортировки столбца по возрастанию",
                sortDescending: ": активировать для сортировки столбца по убыванию",
            },
            select: {
                rows: {
                    _: "Выбрано записей: %d",
                    0: "Кликните по записи для выбора",
                    1: "Выбрана одна запись",
                },
            },
        },
        lengthMenu: [
            [10, 25, 50, -1],
            [10, 25, 50, "All"],
        ],
        dom: '<"top"fi>rt<"bottom"pbl>',
        processing: true,
        serverSide: true,
        ajax: {
            url: $("#comments-datatable").data("source"),
        },
        pagingType: "simple_numbers",
        columns: [
            { data: "id" },
            { data: "comment" },
            { data: "date" },
            { data: "options", orderable: false },
        ],
    });
});

$(document).on("turbolinks:load", function() {
    $("#categories-datatable").DataTable({
        language: {
            processing: "Подождите...",
            search: "Поиск:",
            lengthMenu: "Записей на странице _MENU_",
            info: "Записи с _START_ до _END_ из _TOTAL_ записей",
            infoEmpty: "Записи с 0 до 0 из 0 записей",
            infoFiltered: "(отфильтровано из _MAX_ записей)",
            loadingRecords: "Загрузка записей...",
            zeroRecords: "Записи отсутствуют.",
            emptyTable: "В таблице отсутствуют данные",
            paginate: {
                first: "Первая",
                previous: "Предыдущая",
                next: "Следующая",
                last: "Последняя",
            },
        },
        lengthMenu: [
            [10, 25, 50, -1],
            [10, 25, 50, "All"],
        ],
        dom: '<"top"fi>rt<"bottom"pbl>',
        processing: true,
        serverSide: true,
        ajax: {
            url: $("#categories-datatable").data("source"),
        },
        pagingType: "simple_numbers",
        order: [
            [1, "asc"]
        ],
        columns: [
            { data: "edit", orderable: false },
            { data: "id" },
            { data: "name" },
            { data: "destroy", orderable: false },
        ],
    });
});

$(document).on("turbolinks:load", function() {
    $("#users-datatable").DataTable({
        language: {
            processing: "Подождите...",
            search: "Поиск:",
            lengthMenu: "Записей на странице _MENU_",
            info: "Записи с _START_ до _END_ из _TOTAL_ записей",
            infoEmpty: "Записи с 0 до 0 из 0 записей",
            infoFiltered: "(отфильтровано из _MAX_ записей)",
            loadingRecords: "Загрузка записей...",
            zeroRecords: "Записи отсутствуют.",
            emptyTable: "В таблице отсутствуют данные",
            paginate: {
                first: "Первая",
                previous: "Предыдущая",
                next: "Следующая",
                last: "Последняя",
            },
            aria: {
                sortAscending: ": активировать для сортировки столбца по возрастанию",
                sortDescending: ": активировать для сортировки столбца по убыванию",
            },
            select: {
                rows: {
                    _: "Выбрано записей: %d",
                    0: "Кликните по записи для выбора",
                    1: "Выбрана одна запись",
                },
            },
        },
        lengthMenu: [
            [10, 25, 50, -1],
            [10, 25, 50, "All"],
        ],
        dom: '<"top"fi>rt<"bottom"pbl>',
        processing: true,
        serverSide: true,
        ajax: {
            url: $("#users-datatable").data("source"),
        },
        pagingType: "simple_numbers",
        order: [
            [1, "asc"]
        ],
        columns: [
            { data: "edit", orderable: false },
            { data: "id" },
            { data: "name" },
            { data: "email" },
            { data: "destroy", orderable: false },
        ],
    });
});

$(document).on("turbolinks:load", function() {
    $("#moderators-datatable").DataTable({
        language: {
            processing: "Подождите...",
            search: "Поиск:",
            lengthMenu: "Записей на странице _MENU_",
            info: "Записи с _START_ до _END_ из _TOTAL_ записей",
            infoEmpty: "Записи с 0 до 0 из 0 записей",
            infoFiltered: "(отфильтровано из _MAX_ записей)",
            loadingRecords: "Загрузка записей...",
            zeroRecords: "Записи отсутствуют.",
            emptyTable: "В таблице отсутствуют данные",
            paginate: {
                first: "Первая",
                previous: "Предыдущая",
                next: "Следующая",
                last: "Последняя",
            },
            aria: {
                sortAscending: ": активировать для сортировки столбца по возрастанию",
                sortDescending: ": активировать для сортировки столбца по убыванию",
            },
            select: {
                rows: {
                    _: "Выбрано записей: %d",
                    0: "Кликните по записи для выбора",
                    1: "Выбрана одна запись",
                },
            },
        },
        lengthMenu: [
            [10, 25, 50, -1],
            [10, 25, 50, "All"],
        ],
        dom: '<"top"fi>rt<"bottom"pbl>',
        processing: true,
        serverSide: true,
        ajax: {
            url: $("#moderators-datatable").data("source"),
        },
        pagingType: "simple_numbers",
        order: [
            [1, "asc"]
        ],
        columns: [
            { data: "edit", orderable: false },
            { data: "id" },
            { data: "name" },
            { data: "email" },
            { data: "role" },
            { data: "destroy", orderable: false },
        ],
    });
});

$(document).on("turbolinks:load", function() {
    $(".flash_message").each(function() {
        const $this = $(this);

        new Noty({
            type: $this.attr("flash-type"),
            theme: "bootstrap-v4",
            text: $this.text(),
            timeout: 3000,
        }).show();
    });
});

$(document).on("turbolinks:load", function() {
    if ($("#yield-area").height() > 0)
        $("#yield-area").addClass("border border-3 rounded");
});

$(document).on("turbolinks:load", function() {
    if ($(document).height() <= $(window).height())
        $("#footer").addClass("fixed-bottom");
});

$(document).on("turbolinks:load", function() {
    Turbolinks.clearCache();
    $(".js-multiple-select").each(function() {
        const $this = $(this);

        let opts = {
            theme: "classic",
            width: "100%",
            placeholder: $this.data("placeholder"),
            allowClear: Boolean($this.data("allow-clear")),
            templateResult: hideSelected,
            language: Select2Ru,
        };

        $this.select2(opts);
    });
});

$(document).on("turbolinks:load", function() {
    Turbolinks.clearCache();
    $(".tag-select").each(function() {
        const $this = $(this);

        let opts = {
            theme: "classic",
            width: "100%",
            placeholder: $this.data("placeholder"),
            allowClear: Boolean($this.data("allow-clear")),
            templateResult: hideSelected,
            tags: true,
            tokenSeparators: [",", " "],
            placeholder: "Выберите тэги",
            language: Select2Ru,
        };

        $this.select2(opts);
    });
});

function hideSelected(value) {
    if (value && !value.selected) {
        return $("<span>" + value.text + "</span>");
    }
}

$(document).on("turbolinks:before-cache", function(e) {
    return $(".js-multiple-select").each(function() {
        return $(this).select2("destroy");
    });
});

$(document).on("turbolinks:before-cache", function(e) {
    return $(".tag-select").each(function() {
        return $(this).select2("destroy");
    });
});

$(document).on("turbolinks:load", function() {
    $("#preloader-active").delay(450).fadeOut("slow");
    $("body").delay(450).css({
        overflow: "visible",
    });
});

$(document).on("turbolinks:load", function() {
    if (/search/.test(window.location.href)) {
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

$(document).on("turbolinks:load", function() {
    if ($("body").hasClass("open-search-form")) {
        $("button.search-icon").hide();
    } else {
        $(".search-close").hide();
    }
    $("button.search-icon").on("click", function() {
        $(this).hide();
        $("body").toggleClass("open-search-form");
        $(".search-close").show();
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });
    $(".search-close").on("click", function() {
        $(this).hide();
        $("body").removeClass("open-search-form");
        $("button.search-icon").show();
    });
});

$(document).on("turbolinks:load", function() {
    $("#submit-search-button").hide();

    $("#title-search").on("click", function() {
        $("#title-search").addClass("active");
        $("#tag-search").removeClass("active");
        $("#title-search-input").show();
        $("#tag-search-input").hide();
        $("#tag-search-input").val("");
    });
    $("#tag-search").on("click", function() {
        $("#tag-search").addClass("active");
        $("#title-search").removeClass("active");
        $("#title-search-input").hide();
        $("#title-search-input").val("");
        $("#tag-search-input").show();
    });
});

$(document).on("turbolinks:load", function() {
    $("#customFile").change(function(e) {
        var file_name = e.target.files[0].name;
        $(".custom-file-label").html(file_name);
    });
});

$(document).on("turbolinks:load", function() {
    $("#open-comment-field").on("click", function() {
        $("#review-comment").toggle("slow");
    });
});

$(document).on("turbolinks:load", function() {
    const chooseFile = document.getElementById("customFile");
    const imgPreview = document.getElementById("img-preview");
    if (chooseFile) {
        chooseFile.addEventListener("change", function() {
            const files = chooseFile.files[0];
            if (files) {
                const fileReader = new FileReader();
                fileReader.readAsDataURL(files);
                fileReader.addEventListener("load", function() {
                    imgPreview.style.display = "block";
                    imgPreview.innerHTML =
                        '<img src="' +
                        this.result +
                        '" /> <a href="" id="remove-img">Удалить изображение</a>';
                    const removeImg = document.getElementById("remove-img");
                    const fileNameLabel = document.getElementById("file-name-input");
                    removeImg.addEventListener("click", function(event) {
                        event.preventDefault();
                        imgPreview.style.display = "none";
                        imgPreview.innerHTML = "";
                        chooseFile.value = "";
                        fileNameLabel.innerHTML = "Выберите изображение";
                    });
                });
            }
        });
    }
});

$(document).on("turbolinks:load", function() {
    $(".top-bar").removeClass("d-none");
});

$(document).on("turbolinks:load", function() {
    $(".search_field").on("keyup", function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            document.getElementById("submit-search-button").click();
        }
    });
});
