var LoadDataTables = function () {

    return {
        init: function () {

            $('#UserAccountsDataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});