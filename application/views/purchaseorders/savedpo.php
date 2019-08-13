<div class="white-background">
    <div class="minimum-height">
        <h2>Saved Purchase Orders</h2>
        <div class="table-responsive">
            <table id="SavedPurchaseOrdersDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">PO Number</th>
                    <th scope="col">MR Code</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory 1 Name</th>
                    <th scope="col">Subcategory 2 Name</th>
                    <th scope="col">Subcategory 3 Name</th>
                    <th scope="col">Required Quantity</th>
                    <th scope="col">Delivery Location</th>
                    <th scope="col">PO Status</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($purchaseorders as $purchaseorder) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $purchaseorder['purchaseorder_no']; ?></td>
                        <td><?php echo $purchaseorder['materialrequest_code']; ?></td>
                        <td><?php echo $purchaseorder['product_name']; ?></td>
                        <td><?php echo $purchaseorder['category_name']; ?></td>
                        <td><?php echo $purchaseorder['subcategory_1_name']; ?></td>
                        <td><?php echo $purchaseorder['subcategory_2_name']; ?></td>
                        <td><?php echo $purchaseorder['subcategory_3_name']; ?></td>
                        <td><?php echo $purchaseorder['quantity']; ?></td>
                        <td><?php echo $purchaseorder['location']; ?></td>
                        <td><?php if($purchaseorder['po_status'] == "Pending") : ?><span class="text-danger"><?php echo $purchaseorder['po_status']; ?> / <?php echo $purchaseorder['poitem_status']; ?></span><?php else : ?><span class="text-success"><?php echo $purchaseorder['po_status']; ?> / <?php echo $purchaseorder['poitem_status']; ?></span><?php endif; ?></td>
                        <td>
                            <?php if($purchaseorder['po_status'] == "Pending") : ?>
                                <div class="bs-component">
                                    <a href="<?php echo site_url('/purchaseorders/'.$purchaseorder['purchaseorders_table_id']); ?>" class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to save this PO request">Save</a>
                                </div>
                                <br>
                            <?php endif; ?>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/purchaseorders/details/'.$purchaseorder['purchaseorders_table_id']); ?>" class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to view this PO request">View</a>
                            </div>
                        </td>
                    </tr>
                    <?php $count++; ?>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>