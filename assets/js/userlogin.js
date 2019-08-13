var LoadDataTables = function () {

    return {
        init: function () {

            $('#DataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});