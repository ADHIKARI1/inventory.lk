var LoadDataTables = function () {
    return {
        init: function () {
            $('#AdjustProductsDataTable').DataTable();
            $('#StockAdjustDataTable').DataTable();
            $('#StockInDataTable').DataTable();
        }
    }
}();

var AdjustStock = function (){
	return {
		init: function(){
            $(document).on("click", ".btn-stock-adjust", function(){
                console.log("console");
                var id = $(this).attr("id");
                var count = $(this).attr("data-count");
                var qty = $("input[name="+count+"Quantity]").val();               

                $.ajax({
                    type:'POST',
                    dataType:'json',
                    processData: false,
                    contentType: false, 
                    url: BASE_URL + "stock/saveadjustetdquantity/"+id+"/"+qty,
                    success: function(response){
                        if(response['type'] == 'success')
                        {
                             swal("", response['message'], "success").then((e)=>{
                                location.reload();
                             });
                        }                       
                        else
                        {
                            swal("", response['message'], "error").then((e)=>{
                                location.reload();
                             });
                        }                       
                                        
                    },
                    error : function(error){                    
                        swal("", error['message'], "error").then((e)=>{
                                location.reload();
                        });                
                    }

                });

            });			
		}
	}
}();

jQuery(document).ready(function () {

    LoadDataTables.init();
    AdjustStock.init();

});