var LoadStocks = function () {

    return {
        init: function () {

            var CurrentLocationStockTable = $('#CurrentLocationStockDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'pages/currentlocationstock/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "product_code"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {"data": "product_name"},
                        {"data": "quantity"},
                        {"data": "productlocation"}
                    ]
                }
            );
            setInterval(function () {
                CurrentLocationStockTable.ajax.reload(null, false);
            }, 5000);

            var OtherLocationsStockTable = $('#OtherLocationsStockDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'pages/getOtherLocationsStock/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "product_code"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {"data": "product_name"},
                        {"data": "quantity"},
                        {"data": "location"},
                        {"data": "productlocation"}
                    ]
                }
            );
            setInterval(function () {
                OtherLocationsStockTable.ajax.reload(null, false);
            }, 5000);

            var AllLocationsStockTable = $('#AllLocationsStockDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'pages/getAllLocationsStock/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "product_code"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {"data": "product_name"},
                        {"data": "quantity"},
                        {"data": "location"},
                        {"data": "productlocation"}
                    ]
                }
            );
            setInterval(function () {
                AllLocationsStockTable.ajax.reload(null, false);
            }, 5000);
        }
    }
}();

jQuery(document).ready(function () {

    LoadStocks.init();

});