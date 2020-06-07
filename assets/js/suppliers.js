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
                        /*{
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<form method='POST'  action=" + BASE_URL + "suppliers/deleteproduct/" + full['supplierproducts_table_id'] + ">" +
                                    "<input type='submit' class='btn btn-danger' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to delete this product from this supplier' value='X'>" +
                                    "</form>" +
                                    "</div>";
                            }
                        },*/
                        {
                            "render": function(data, typ, full){
                                return "<input type='checkbox' class='checkbox' name='delete' value='"+full['supplierproducts_table_id']+"' >";
                            }
                        }
                    ]
                }
            );
        }
    }
}();

var DeleteSupplierItems = function(){
    return{
        init: function(){            

        // Check all
        $("#checkall").change(function(){

           var checked = $(this).is(':checked');
           if(this.checked){
              $(".checkbox").each(function(){
                  $(this).prop("checked",true);
              });
           }else{
              $(".checkbox").each(function(){
                  $(this).prop("checked",false);
              });
           }
        });

        // Changing state of CheckAll checkbox 
            $('#SupplierProductsDataTable').on('click','.checkbox',function(){
                if($('.checkbox:checked').length == $('.checkbox').length){
                    $('#checkall').prop('checked',true);
                }else{
                    $('#checkall').prop('checked',false);
                }
            }); 

            /*
            $("#user").on("click", ".checkbox", function() {
                $("#select-all").prop('checked', true)
                $("#user").find(".checkbox").each(function() {
                if (!$(this).prop('checked')){
                $("#select-all").prop('checked', false);
                return;
                }
                })
            })*/      

            function delete_confirm(){
                if($('.checkbox:checked').length > 0){
                    var result = confirm("Are you sure to delete this record's ?");
                    if(result){
                        return true;
                    }else{
                        return false;
                    }
                }else{
                    alert('Select at least 1 record to delete.');
                    return false;
                }
            }

            // Delete button clicked
            $('#deleteSupplierItem').click(function(){
                // Confirm alert          
            if (delete_confirm()) {

            // Get userid from checked checkboxes
              var item_arr = [];
              $(".checkbox:checked").each(function(){
                  var id = $(this).val();

                  item_arr.push(id);
                  //console.log(id);
              });

              // Array length
              var length = item_arr.length;
              if (length > 0) {
                 // AJAX request
                 $.ajax({
                    url:  BASE_URL +'Suppliers/deletebulkproducts',
                    type: 'post',
                    data: {table_ids: item_arr},
                    success: function(response){
                        ReloadSupplierProducts.init();   
                        
                       // Remove <tr>
                       /*$(".checkbox:checked").each(function(){
                        
                           var userid = $(this).val();

                           $('#tr_'+userid).remove();
                       });*/
                    }
                 });
              };

           }
            });            
        }
    }

}();

var ReloadSupplierProducts = function () {
    return {
        init: function () {
            var supplierCode = $('#supplier-products-supplier-code').val();
            $('#SupplierProductsDataTable').DataTable().ajax.url(BASE_URL + 'suppliers/products/data/' + supplierCode).load(null, false);

        }
    }
}();

jQuery(document).ready(function () {
    LoadSuppliers.init();
    LoadSupplierProducts.init();
    DeleteSupplierItems.init();

});