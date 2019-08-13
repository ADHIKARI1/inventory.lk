var LoadSuppliers = function () {

    return {
        init: function () {

            $('#SuppliersDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'suppliers/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "supplier_code"},
                        {"data": "supplier_name"},
                        {"data": "supplier_contact_no1"},
                        {"data": "supplier_contact_no2"},
                        {"data": "supplier_fax_no1"},
                        {"data": "supplier_fax_no2"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'suppliers/' + full['supplier_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view this supplier'>View</a>" +
                                    "</div>";
                            }
                        },
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'suppliers/products/' + full['supplier_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view products of this supplier'>Products</a>" +
                                    "</div>";
                            }
                        }
                    ]
                }
            );
        }
    }
}();

var LoadSupplierProducts = function () {

    return {
        init: function () {

            var supplierCode = $('#supplier-products-supplier-code').val();
            $('#SupplierProductsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'suppliers/products/data/' + supplierCode,
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<form method='POST'  action=" + BASE_URL + "suppliers/deleteproduct/" + full['supplierproducts_table_id'] + ">" +
                                    "<input type='submit' class='btn btn-danger' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to delete this product from this supplier' value='X'>" +
                                    "</form>" +
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

    LoadSuppliers.init();
    LoadSupplierProducts.init();

});