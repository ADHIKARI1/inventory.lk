<div class="white-background">
    <div class="minimum-height">
        <h2>Save Purchase Order Requests</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to save this purchase order?')") ?>
                    <?php echo form_open('Purchaseorders/save', $attribute); ?>
                    <div class="form-group">
                        <input type="hidden" name="PurchaseOrderTableNo"
                               value="<?php echo $purchaseorder['purchaseorders_table_id']; ?>">
                        <label>Purchase Order Number</label>
                        <input type="text" class="form-control" name="PurchaseOrderNo"
                               placeholder="Purchase Order Number"
                               value="<?php echo $purchaseorder['purchaseorder_no']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Material Request Code</label>
                        <input type="text" class="form-control" name="MRCode" placeholder="Material Request Code"
                               value="<?php echo $purchaseorder['materialrequest_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" class="form-control" name="CategoryName" placeholder="Product Name"
                               value="<?php echo $purchaseorder['category_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 1 Name</label>
                        <input type="text" class="form-control" name="Subcategory1Name" placeholder="Product Name"
                               value="<?php echo $purchaseorder['subcategory_1_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 2 Name</label>
                        <input type="text" class="form-control" name="Subcategory2Name" placeholder="Product Name"
                               value="<?php echo $purchaseorder['subcategory_2_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 3 Name</label>
                        <input type="text" class="form-control" name="Subcategory3Name" placeholder="Product Name"
                               value="<?php echo $purchaseorder['subcategory_3_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" class="form-control" name="ProductName" placeholder="Product Name"
                               value="<?php echo $purchaseorder['product_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Product Quantity</label>
                        <input type="text" class="form-control" name="ProductQty" placeholder="Product Quantity"
                               value="<?php echo $purchaseorder['quantity']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Select Supplier</label>
                        <select class="form-control" name="SupplierCode" required>
                            <?php foreach ($suppliers as $supplier) : ?>
                                <option value="<?php echo $supplier['supplier_code']; ?>"><?php echo $supplier['supplier_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Delivery Location</label>
                        <select class="form-control" name="DeliveryLocation" required>
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>"><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Purchase Order Placed Date</label>
                        <input type="date" class="form-control" name="PODate" placeholder="Purchase Order Placed Date"
                               required>
                    </div>
                    <div class="form-group">
                        <label>Purchase Order Delivery Date</label>
                        <input type="date" class="form-control" name="PODeliveryDate"
                               placeholder="Purchase Order Delivery Date" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save" data-toggle="tooltip"
                                   data-placement="bottom" title="" data-original-title="Click to save this PO">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
