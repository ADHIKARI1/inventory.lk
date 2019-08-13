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
			
		}
	}

}();

jQuery(document).ready(function () {

    LoadDataTables.init();

});