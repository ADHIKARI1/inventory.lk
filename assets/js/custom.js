var PreLoader = function () {

    return {
        init: function () {

            $(window).on('load', function () {
                $(".preloader").fadeOut("slow")
            });
        }
    }
}();

var ReturnTop = function () {

    return {
        init: function () {

            $(window).scroll(function () {
                if ($(this).scrollTop() >= 50) {
                    $('#return-to-top').fadeIn(200)
                } else {
                    $('#return-to-top').fadeOut(200)
                }
            });

            $('#return-to-top').click(function () {
                $('body,html').animate({
                    scrollTop: 0
                }, 500)
            });
        }
    }
}();

var ToolTip = function () {

    return {
        init: function () {

            $('.bs-component [data-toggle="tooltip"]').tooltip();
        }
    }
}();

var Notification = function () {

    return {
        init: function () {

            setInterval(function () {
                var base_url = document.getElementById('base_url').value;
                $("#notification").load(base_url + "/notifications");
            }, 1000);
        }
    }
}();

var FilterSelect = function () {

    return {
        init: function () {

            if ($(".filterSelect").hasClass("filterSelect")) {
                $('.filterSelect').filterSelect({
                    allowEmpty: true
                });
            }
        }
    }
}();

var LoadDataTables = function () {

    return {
        init: function () {

            $('#DataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    PreLoader.init();
    ReturnTop.init();
    ToolTip.init();
    Notification.init();
    FilterSelect.init();
    LoadDataTables.init();

});






