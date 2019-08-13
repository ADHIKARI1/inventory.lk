var LoadPurchaseOrderItems = function () {

    return {
        init: function () {

            //var BASE_URL = "http://localhost/inventoryUpdate/"; 
            var po_no = null;
            $('#PoItemsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'purchaseorders/data/'+po_no,
                    },
                    "columns": [
                        {"data": "materialrequest_code"},
                        {"data": "product_name"},
                        {"data": "category_name"},
                        {"data": "subcategory_1_name"},
                        {"data": "subcategory_2_name"},
                        {"data": "subcategory_3_name"},                        
                        {"data": "quantity"},
                        {
                            "render": function(data, type,  full, meta){
                                if(full['grn_status'] == 'Completed')
                                    return "<span class='text-success'>"+full['balanced_quantity']+"</span>";
                                else
                                    return "<span class='text-warning'>"+full['balanced_quantity']+"</span>";
                            }               
                        },
                        {
                            "render": function(data, type,  full, meta){
                                return "<input type='number' class='form-control' name='GoodReceivedQty' placeholder='Qty' required>";
                            }
                        },
                        {
                            "render": function(data, type,  full, meta){
                                return "<span class='d-none'>"+full['purchaseorders_table_id']+"</span>";
                            }               
                        }

                    ]
                }
            );
        }
    }
}();

var LoadPurchaseOrderItemsToPoNo = function () {

    return {
        init: function () {

            //var BASE_URL = "http://localhost/inventoryUpdate/"; 
            var po_dropdown = $('#GrnPurchaseOrderNo');
            po_dropdown.on('change', function () {
                var po_no = $('#GrnPurchaseOrderNo option:selected').val();
                if (po_no == null || po_no == '') {
                    po_no = null;
                }

                if (po_no != null && po_no != '') {

                    $.ajax({
                        type : "POST",    
                        url: BASE_URL + 'Purchaseorders/getPoSupplier',    
                        data : {
                            po_no : po_no
                        },       
                        crossOrigin : false,
                        dataType : "json",
                        success : function(response){
                            console.log(response);
                            $('#SupplierName').val(response.supplier_name);
                        }
                    });
                }
                else {
                    console.log('else');
                    $('#SupplierName').val('');
                }



                $('#PoItemsDataTable').DataTable().ajax.url(BASE_URL + 'purchaseorders/data/'+po_no).load();
            });
        }
    }
}();

jQuery(document).ready(function () {
    $('#rptGrnNo').attr('disabled',false);

    LoadPurchaseOrderItems.init();
    LoadPurchaseOrderItemsToPoNo.init();



    $('#saveGrnData').click(function(){
        //alert('Select field value has changed to ' + $('#GrnPurchaseOrderNo').val());
        var aGrnTableData = [];    

        //var BASE_URL = "http://localhost/inventoryUpdate/";   

        $('#PoItemsDataTable tr').each(function(row, tr){

            function validateInput()
            {
                if($('#GoodReceivedNoteNo').val() == "" || $('#GoodReceivedNoteNo').val() === undefined)
                    return false;
                if($('#GrnPurchaseOrderNo').val() == "" || $('#GrnPurchaseOrderNo').val() === undefined)
                    return false;
                if($('#GoodReceivedDate').val() == "" || $('#GoodReceivedDate').val() === undefined)
                    return false;
                if($('#InvoiceNumber').val() == "" || $('#InvoiceNumber').val() === undefined)
                    return false;
                if($(tr).find('input[name=GoodReceivedQty]').val() == "" || $(tr).find('input[name=GoodReceivedQty]').val() === undefined || $(tr).find('input[name=GoodReceivedQty]').val() <= 0)
                    return false;

                return true;
            }

            if(validateInput())
            {
                var aSub = {
                'GoodReceivedNoteNo' : $('#GoodReceivedNoteNo').val(),
                'PurchaseOrderNo' : $('#GrnPurchaseOrderNo').val(),
                'GoodReceivedDate' : $('#GoodReceivedDate').val(),
                'InvoiceNumber' : $('#InvoiceNumber').val(),
                'GoodReceivedQty' : $(tr).find('input[name=GoodReceivedQty]').val(),
                'PurchaseordersTableId' : $(tr).find('td:eq(9)').text()
                }
                aGrnTableData.push(aSub);
            } 

        });
        
        $('#rptGrnNo').val($('#GoodReceivedNoteNo').val());
        var aData = {'table_grn': aGrnTableData};

        //console.log($('#rptGrnNo').val());
        console.log(aData);
        $.ajax({
            type : "POST",    
            url: BASE_URL + 'Goodreceivenotes/save',    
            data : aData,       
            crossOrigin : false,
            dataType : "json",
            success : function(response){
            //console.log(response);             
            //alert("Success "+response['message']);
            swal("", response['message'], "success");
            $('#printGrnData').attr('disabled',false);
                
            },
            error : function(error){
            //console.log(error);
            //alert("Error "+error['message']);
            swal("", error['message'], "error");
            $('#printGrnData').attr('disabled',true);
            }
            
          });        

    });
});