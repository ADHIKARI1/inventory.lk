<div class="white-background">
    <div class="minimum-height">
        <h2>Save Delivery Note As Good Received Note</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to save this delivery note as a good received note?')") ?>
                    <?php echo form_open('Goodreceivenotes/savedeliverynote', $attribute); ?>
                    <div class="form-group">
                        <input type="hidden" name="GoodreceivenoteTableNo"
                               value="<?php echo $goodreceivenote['goodreceivenotes_table_id']; ?>">
                        <label>Good Receieved Note Number</label>
                        <input type="text" class="form-control" name="GoodReceivedNoteNo"
                               placeholder="Good Receieved Note Number" required>
                    </div>
                    <div class="form-group">
                        <label>Purchase Order Number</label>
                        <input type="text" class="form-control" name="PurchaseOrderNo"
                               placeholder="Purchase Order Number"
                               value="<?php echo $goodreceivenote['purchaseorder_no']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" class="form-control" name="CategoryName" placeholder="Product Name"
                               value="<?php echo $goodreceivenote['category_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 1 Name</label>
                        <input type="text" class="form-control" name="Subcategory1Name" placeholder="Product Name"
                               value="<?php echo $goodreceivenote['subcategory_1_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 2 Name</label>
                        <input type="text" class="form-control" name="Subcategory2Name" placeholder="Product Name"
                               value="<?php echo $goodreceivenote['subcategory_2_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 3 Name</label>
                        <input type="text" class="form-control" name="Subcategory3Name" placeholder="Product Name"
                               value="<?php echo $goodreceivenote['subcategory_3_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" class="form-control" name="ProductName" placeholder="Product Name"
                               value="<?php echo $goodreceivenote['product_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Good Received Date</label>
                        <input type="text" class="form-control" name="GoodReceivedDate" placeholder="Good Received Date"
                               value="<?php echo $goodreceivenote['goodreceived_date']; ?>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Received Quantity</label>
                        <input type="text" class="form-control" name="ReceivedQty" placeholder="Product Quantity"
                               value="<?php echo $goodreceivenote['received_quantity']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save" data-toggle="tooltip"
                                   data-placement="bottom" title=""
                                   data-original-title="Click to save this delivery note as GRN">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
