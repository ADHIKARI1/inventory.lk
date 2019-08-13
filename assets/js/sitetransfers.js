var LoadDataTables = function () {

    return {
        init: function () {

            $('#SiteTransfersDataTable').DataTable();
            $('#PendingSiteTransfersDataTable').DataTable();
            $('#ApproveSTDataTable').DataTable();
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});