var LoadDataTables = function () {

    return {
        init: function () {

            $('#ReportsDataTable').DataTable();
            $('#ViewLocationDataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});