var LoadProducts = function () {

    return {
        init: function () {

            $('#ProductsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'products/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "product_code"},
                        {"data": "product_name"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {"data": "productlocation"},
                        {"data": "quantity"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'products/' + full['product_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view this product'>View</a>" +
                                    "</div>";
                            }
                        }
                    ]
                }
            );
        }
    }
}();

jQuery(document).ready(function () {

    LoadProducts.init();

});