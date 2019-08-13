<div class="white-background">
    <div class="minimum-height">
        <h2>Unsaved Purchase Orders</h2>
        <div class="table-responsive">
            <table id="DataTablePoSave" class="table table-hover">
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
                        <td><?php if ($purchaseorder['po_status'] == "Pending") : ?><span
                                    class="text-danger"><?php echo $purchaseorder['po_status']; ?>
                                / <?php echo $purchaseorder['poitem_status']; ?></span><?php else : ?><span
                                    class="text-success"><?php echo $purchaseorder['po_status']; ?>
                                / <?php echo $purchaseorder['poitem_status']; ?></span><?php endif; ?></td>
                        <td class="d-none"><?php echo $purchaseorder['purchaseorders_table_id']; ?></td>
                    </tr>
                    <?php $count++; ?>
                <?php endforeach; ?>
                </tbody>
            </table>
            <div class="form-group">
                <div class="bs-component">
                    <!-- <input type="submit" id = "save_po_request" class="btn btn-success btn-block"  data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to save this PO request" value="Save Purchase Order's"> -->
                    <?php if ($purchaseorders != NULL) { ?>
                        <button type="button" class="btn btn-primary" id="save_po_request" data-toggle="modal"
                                data-target="#create_form_modal">Save Items
                        </button>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="create_form_modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header ">
                <h2 class="modal-title">Save Purchase Order Requests</h2>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <?php //print_r($purchaseorders); ?>

            <div class="col-md-12 py-2">
                <div class="card rounded-0">
                    <div class="card-body">
                        <form action="#" method="#" id="save-po-form">
                            <div class="form-group">
                                <input type="hidden" name="PurchaseOrderTableNo"
                                       value="<?php //echo $purchaseorder['purchaseorders_table_id']; ?>">
                                <label>Purchase Order Number</label>
                                <input id="PurchaseOrderNo" type="text" class="form-control" name="PurchaseOrderNo"
                                       placeholder="Purchase Order Number"
                                       value="<?php //echo $purchaseorder['purchaseorder_no']; ?>" required>
                            </div>
                            <div class="form-group">
                                <label>Material Request Code</label>
                                <input type="text" class="form-control" name="MRCode"
                                       placeholder="Material Request Code"
                                       value="<?php echo $purchaseorders[0]['materialrequest_code']; ?>" readonly="">
                            </div>
                            <div class="form-group">
                                <label>Select Supplier</label>
                                <select id="SupplierCode" class="form-control" name="SupplierCode" required>

                                </select>
                            </div>
                            <div class="form-group">
                                <label>Delivery Location</label>
                                <select id="DeliveryLocation" class="form-control" name="DeliveryLocation" required>

                                </select>
                            </div>
                            <div class="form-group">
                                <label>Purchase Order Placed Date</label>
                                <input id="PODate" type="date" class="form-control" name="PODate"
                                       placeholder="Purchase Order Placed Date" required>
                            </div>
                            <div class="form-group">
                                <label>Purchase Order Delivery Date</label>
                                <input id="PODeliveryDate" type="date" class="form-control" name="PODeliveryDate"
                                       placeholder="Purchase Order Delivery Date" required>
                            </div>
                            <div class="form-group">
                                <div class="bs-component">
                                    <input id="save_po" type="button" class="form-control btn btn-primary" value="Save"
                                           data-toggle="tooltip" data-placement="bottom" title=""
                                           data-original-title="Click to save this PO">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
