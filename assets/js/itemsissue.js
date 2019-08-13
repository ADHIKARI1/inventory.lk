var LoadDataTables = function () {

    return {
        init: function () {

            $('#ItemsIssueDataTable').DataTable();
            $('#ViewItemsIssueDataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});