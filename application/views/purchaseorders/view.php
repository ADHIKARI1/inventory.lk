<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $purchaseorder['purchaseorder_no']; ?><?php date_default_timezone_set('Asia/Colombo');
            if ($purchaseorder['poitem_status'] == "Pending" && $purchaseorder['delivery_date'] < date('Y-m-d') && $purchaseorder['delivery_date'] != strtotime("0000-00-00")) echo '<span class="text-danger"> - Estimated delivery date exceeded</span>'; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Purchase Order Number : </strong><?php echo $purchaseorder['purchaseorder_no']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Material Request Code : </strong><?php echo $purchaseorder['materialrequest_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Category Name : </strong><?php echo $purchaseorder['category_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 1 Name : </strong><?php echo $purchaseorder['subcategory_1_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 2 Name : </strong><?php echo $purchaseorder['subcategory_2_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 3 Name : </strong><?php echo $purchaseorder['subcategory_3_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Product Name : </strong><?php echo $purchaseorder['product_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Quantity : </strong><?php echo $purchaseorder['quantity']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Name : </strong><?php echo $purchaseorder['supplier_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Delivery Location : </strong><?php echo $purchaseorder['location']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Purchase Order Placed Date : </strong><?php echo $purchaseorder['po_date']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Purchase Order Delivery Date : </strong><?php echo $purchaseorder['delivery_date']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this purchase order?')") ?>
                    <?php echo form_open('/Purchaseorders/delete/' . $purchaseorder['purchaseorders_table_id'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this PO" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
