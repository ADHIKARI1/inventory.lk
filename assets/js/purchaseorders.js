var LoadDataTables = function () {

    return {
        init: function () {

            $('#PurchaseOrdersDataTable').DataTable();
            $('#PendingPurchaseOrdersDataTable').DataTable();
            $('#DataTablePoSave').DataTable();
            $('#UnsavedPurchaseOrdersDataTable').DataTable();
            $('#ViewGRNDataTable').DataTable();
            $('#SavedPurchaseOrdersDataTable').DataTable();
        }
    }
}();

var SavePurchaseOrder = function () {
    return {
        init : function () {
            this.dataTableRowSelect();
            this.saveModal();
        },

        dataTableRowSelect : function () {
            $('#DataTablePoSave tbody').on('click', 'tr', function () {
                $(this).toggleClass('selected');
            });
        },

        getSuppliers : function () {
            var form = $('#save-po-form');

            $('#SupplierCode', form).find('option').remove();
            $.each($('#DataTablePoSave').DataTable().rows('.selected').data(), function (row, tr) {
                $.ajax({
                    type: "POST",
                    url: BASE_URL + 'Purchaseorders/getSuppliers/'+tr[11],
                    crossOrigin: false,
                    dataType: "json",
                    success: function (response) {
                        $.each(response, function (index, value) {
                            $('#SupplierCode', form).append($("<option></option>").attr("value", value["code"]).text(value["supplier"]))
                        });
                    }

                });
            });
        },

        getLocations : function () {
            var form = $('#save-po-form');

            $('#DeliveryLocation', form).find('option').remove();
            $.ajax({
                type: "POST",
                url: BASE_URL + 'Purchaseorders/getLocations',
                crossOrigin: false,
                dataType: "json",
                success: function (response) {
                    $.each(response, function (index, value) {
                        $('#DeliveryLocation', form).append($("<option></option>").attr("value", value["location_id"]).text(value["location"]))
                    });
                }

            });
        },

        saveModal : function () {
            let context = this;
            var modal = $('#create_form_modal');

            $('#save_po_request').on('click', function () {
                modal.modal({
                    keyboard: false,
                    show: true,
                    backdrop: 'static'
                });
            });

            modal.on('show.bs.modal', function () {
                context.getSuppliers();
                context.getLocations();
            });

            modal.on('shown.bs.modal', function () {
                context.savePO();
            });

            modal.on('hidden.bs.modal', function () {
            });
        },

        savePO : function () {
            $("#save_po").click(function () {

                var po_no = $('#PurchaseOrderNo').val();
                var po_date = $('#PODate').val();
                var delivery_location = $('#DeliveryLocation option:selected').val();
                var supplier_code = $('#SupplierCode option:selected').val();
                var delivery_date = $('#PODeliveryDate').val();


                var po_save_data = [];
                $.each($('#DataTablePoSave').DataTable().rows('.selected').data(), function (row, tr) {
                    var dataTable = {
                        'purchaseorders_table_id': tr[11],
                        'purchaseorder_no': po_no,
                        'po_date': po_date,
                        'delivery_location': delivery_location,
                        'supplier_code': supplier_code,
                        'delivery_date': delivery_date
                    };
                    po_save_data.push(dataTable);
                });

                var data = {'data_table': po_save_data};
                $.ajax({
                    type: "POST",
                    url: BASE_URL + 'Purchaseorders/save',
                    data: data,
                    crossOrigin: false,
                    dataType: "json",
                    success: function (response) {
                        /*$('#error-alert').removeClass('d-none');
                        $('#success-alert').removeClass('d-none');
                        if (response['type'] === 'success') {
                            $('#success-alert').html(response['message']);
                            $('#error-alert').addClass('d-none');
                            $('#error-alert').html(response['message']);
                            $('#success-alert').addClass('d-none');
                        }
                        $("html, body").animate({scrollTop: 0}, 200);*/
                         swal("", response['message'], "success");
                    },
                    error: function (error) {
                        /*$('#error-alert').removeClass('d-none');
                        $('#success-alert').removeClass('d-none');
                        $('#error-alert').html(error['message']);
                        $('#success-alert').addClass('d-none');
                        $('#error-alert').addClass('d-block');
                        $("html, body").animate({scrollTop: 0}, 200);*/
                        swal("", response['message'], "error");

                    }

                });

            });
        }
    }
}();

jQuery(document).ready(function () {

    LoadDataTables.init();
    SavePurchaseOrder.init();

});