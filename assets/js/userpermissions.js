var LoadDataTables = function () {

    return {
        init: function () {

            $('#UserPermissionDataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});