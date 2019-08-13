<div class="white-background">
    <div class="minimum-height">
        <div class="bs-component">
            <a href="<?php echo site_url('sitetransfers/create'); ?>" class="btn btn-lg btn-secondary"
               data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to add a new transfer">+
                Add New</a>
        </div>
        <hr>
        <h2>Site Transfers</h2>
        <div class="table-responsive">
            <table id="SiteTransfersDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Material Code</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Sub Category 1 Name</th>
                    <th scope="col">Sub Category 2 Name</th>
                    <th scope="col">Sub Category 3 Name</th>
                    <th scope="col">Requested Quantity</th>
                    <th scope="col">Transferred Quantity</th>
                    <th scope="col">Requested Location</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($sitetransfers as $sitetransfer) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $sitetransfer['materialrequest_code']; ?></td>
                        <td><?php echo $sitetransfer['product_name']; ?></td>
                        <td><?php echo $sitetransfer['category_name']; ?></td>
                        <td><?php echo $sitetransfer['subcategory_1_name']; ?></td>
                        <td><?php echo $sitetransfer['subcategory_2_name']; ?></td>
                        <td><?php echo $sitetransfer['subcategory_3_name']; ?></td>
                        <td><?php echo $sitetransfer['requested_quantity']; ?></td>
                        <td><?php echo $sitetransfer['transferred_quantity']; ?></td>
                        <td><?php echo $sitetransfer['location']; ?></td>
                        <td>
                            <?php if ($sitetransfer['requested_quantity'] > $sitetransfer['transferred_quantity']) : ?>
                                <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to issue this site transfer?')") ?>
                                <?php echo form_open('sitetransfers/issue', $attribute); ?>
                                <input type="hidden" name="SiteTranferNo"
                                       value="<?php echo $sitetransfer['sitetransfers_table_id']; ?>">
                                <div class="form-group">
                                    <input type="text" name="GatePassNo" class="form-control" placeholder="Gate Pass No"
                                           required>
                                </div>
                                <div class="bs-component">
                                    <input type="submit" class="btn btn-primary btn-block" value="Issue"
                                           data-toggle="tooltip" data-placement="bottom" title=""
                                           data-original-title="Click to transfer this item">
                                </div>
                                <?php echo form_close(); ?>
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
