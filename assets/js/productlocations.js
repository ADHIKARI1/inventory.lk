var LoadProductLocations = function () {

    return {
        init: function () {

            $('#ProductLocationsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'productlocations/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "productlocation"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'Productlocations/edit/' + full['productlocations_table_id'] + " class='btn btn-success btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to edit this product location'>Edit</a>" +
                                    "</div>";
                            }
                        },
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<form method='POST'  action=" + BASE_URL + "Productlocations/delete/" + full['productlocations_table_id'] + ">" +
                                    "<input type='submit' class='btn btn-danger btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to delete this product location' value='Delete'>" +
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

    LoadProductLocations.init();

});