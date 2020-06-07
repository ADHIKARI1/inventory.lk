<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $supplier['supplier_name']; ?></h2>
        <hr>
        <div class="bs-component">
            <a href="<?php echo site_url('suppliers/addproducts/' . $supplier['supplier_code']); ?>"
               class="btn btn-secondary btn-lg mx-3" data-toggle="tooltip" data-placement="bottom" title=""
               data-original-title="Click to add a new product to this supplier">+ Add New</a><br>
        </div>
        <br>
        <div class="table-responsive">
            <input type="hidden" name="supplier_code" id="supplier-products-supplier-code" value="<?php echo $supplier['supplier_code']; ?>">
            <table id="SupplierProductsDataTable" class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Sub Category 1 Name</th>
                    <th scope="col">Sub Category 2 Name</th>
                    <th scope="col">Sub Category 3 Name</th>
                    <!-- <th scope="col"></th> -->
                    <th scope="col"><input type="checkbox" id="checkall" value='1'>&nbsp;<input type='submit' id="deleteSupplierItem" class='btn btn-danger float-right' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to delete this products from this supplier' value='DELETE'></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
