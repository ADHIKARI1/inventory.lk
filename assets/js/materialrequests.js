var LoadMaterialRequests = function () {

    return {
        init: function () {

            $('#MaterialRequestsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'materialrequests/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "materialrequest_code"},
                        {"data": "system_user_name"},
                        {"data": "request_datetime"},
                        {"data": "materialrequest_status"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'materialrequest/' + full['materialrequest_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view this MR details'>View</a>" +
                                    "</div>";
                            }
                        },
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'materialrequest/materialrequestitems/' + full['materialrequest_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view this MR items'>View MR Items</a>" +
                                    "</div>";
                            }
                        }
                    ]
                }
            );

            $('#ApproveMRDataTable').DataTable();
            $('#PendingMRDataTable').DataTable();
        }
    }
}();

var LoadMaterialRequestItems = function () {

    return {
        init: function () {            

            var mr_code = $('#material-request-item-mr-code').val();

            $('#MaterialRequestsItemsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'materialrequest/materialrequestitems/data/' + mr_code,
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "product_name"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {"data": "requested_quantity"},
                        {"data": "balanced_quantity"},
                        {"data": "status"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'materialrequest/requestsitetransfer/' + full['materialrequestitems_table_id'] + " class='btn btn-primary btn-block'" +
                                    "data-toggle='tooltip' data-placement='bottom' title=''" +
                                    "data-original-title='Click to request a site transfer for this item'>Request Site Transfer</a>" +
                                    "</div>";

                            }
                        },
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<form method='POST'  action=" + BASE_URL + "Materialrequests/deleteitem/" + full['materialrequestitems_table_id'] + ">" +
                                    "<input type='submit' class='btn btn-danger' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to delete this item from this MR' value='X'>" +
                                    "</form>" +
                                    "</div>";
                            }
                        },
                        {
                            "render": function (data, type, full) {
                                return "<div class='d-none'>" +
                                    full['materialrequestitems_table_id'] +
                                    "</div>";
                            }
                        }
                    ]
                }
            );
            
            /*ar amountOfRows = $("#MaterialRequestsItemsDataTable tbody tr").length;
            console.log(data);
            if(amountOfRows == 0)
                $("#request_po").hide();*/


        }         
    }
}();

var LoadMaterialRequestsForApproval = function () {

    return {
        init: function () {

            $('#MaterialRequestsForApprovalDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'materialrequest/materialrequestitems/data/' + mr_code,
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "product_name"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},
                        {"data": "requested_quantity"},
                        {"data": "balanced_quantity"},
                        {"data": "status"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<form method='POST'  action=" + BASE_URL + "Materialrequests/deleteitem/" + full['materialrequestitems_table_id'] + ">" +
                                    "<input type='submit' class='btn btn-danger' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to delete this item from this MR' value='X'>" +
                                    "</form>" +
                                    "</div>";
                            }
                        },
                        {
                            "visible": false,
                            "render": function (data, type, full) {
                                return "<div class=''>" +
                                    full['materialrequestitems_table_id'] +
                                    "</div>";
                            }
                        }
                    ]
                }
            );
        }
    }
}();

var RequestPurchaseOrder = function () {

    return {
        init: function () {

            $('#MaterialRequestsItemsDataTable tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');

            });

            $('#request_po').click(function () {
                var po_table_data = [];
                $.each($('#MaterialRequestsItemsDataTable').DataTable().rows('.selected').data(), function (row, tr) {
                    var data_table = {
                        'table_id': tr["materialrequestitems_table_id"]
                    };
                    po_table_data.push(data_table);
                });

                var data = {'data_table': po_table_data};
                $.ajax({
                    type: "POST",
                    url: BASE_URL + "Materialrequests/requestpo",
                    data: data,
                    crossOrigin: false,
                    dataType: "json",
                    success: function (response) {
                        if (response['type'] === 'success') {
                            swal("", response['message'], "success");
                        } else {
                            swal("", response['message'], "error");
                        }
                    },
                    error: function (response) {
                        swal("", response['message'], "error");
                    }


                });

            });

        }
    }
}();

jQuery(document).ready(function () {

    LoadMaterialRequests.init();
    LoadMaterialRequestItems.init();
    RequestPurchaseOrder.init();

});