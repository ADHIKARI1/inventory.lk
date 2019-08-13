<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $purchaseorder['purchaseorder_no']; ?><?php date_default_timezone_set('Asia/Colombo');
            if ($purchaseorder['poitem_status'] == "Pending" && $purchaseorder['delivery_date'] < date('Y-m-d')) echo '<span class="text-danger"> - Estimated delivery date exceeded</span>'; ?></h2>
        <div class="table-responsive">
            <table id="ViewGRNDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">GRN Number</th>
                    <th scope="col">PO Number</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory 1 Name</th>
                    <th scope="col">Subcategory 2 Name</th>
                    <th scope="col">Subcategory 3 Name</th>
                    <th scope="col">Received Quantity</th>
                    <th scope="col">Balanced Quantity</th>
                    <th scope="col">GRN Status</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($goodreceivenotes as $goodreceivenote) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $goodreceivenote['goodreceivenote_no']; ?></td>
                        <td><?php echo $goodreceivenote['purchaseorder_no']; ?></td>
                        <td><?php echo $goodreceivenote['product_name']; ?></td>
                        <td><?php echo $goodreceivenote['category_name']; ?></td>
                        <td><?php echo $goodreceivenote['subcategory_1_name']; ?></td>
                        <td><?php echo $goodreceivenote['subcategory_2_name']; ?></td>
                        <td><?php echo $goodreceivenote['subcategory_3_name']; ?></td>
                        <td><?php echo $goodreceivenote['received_quantity']; ?></td>
                        <td><?php echo $goodreceivenote['balanced_quantity']; ?></td>
                        <td><?php if ($goodreceivenote['grn_status'] == "Pending") : ?><span
                                    class="text-danger"><?php echo $goodreceivenote['grn_status']; ?></span><?php else : ?>
                                <span class="text-success"><?php echo $goodreceivenote['grn_status']; ?></span><?php endif; ?>
                        </td>
                        <td>
                            <?php if ($goodreceivenote['goodreceivenote_no'] == null) : ?>
                                <div class="bs-component">
                                    <a href="<?php echo site_url('goodreceivenotes/saveasgrn/' . $goodreceivenote['goodreceivenotes_table_id']); ?>"
                                       class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom"
                                       title="" data-original-title="Click to save this delivery note as a GRN">Save</a>
                                </div>
                            <?php endif; ?>
                        </td>
                    </tr>
                    <?php $count++; ?>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
