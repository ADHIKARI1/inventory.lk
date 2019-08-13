var LoadSubcategoriesThree = function () {

    return {
        init: function () {

            $('#SubcategoriesThreeDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'subcategory3/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "subcategory_3_code"},
                        {"data": "subcategory_3_name"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'subcategory3/' + full['subcategory_3_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view this sub category 3'>View</a>" +
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

    LoadSubcategoriesThree.init();

});