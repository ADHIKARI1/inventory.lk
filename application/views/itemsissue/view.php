<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $materialrequest['materialrequest_code']; ?>
            - <?php echo $materialrequest['project_name']; ?></h2>
        <hr>
        <div class="table-responsive">
            <table id="ViewItemsIssueDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory 1 Name</th>
                    <th scope="col">Subcategory 2 Name</th>
                    <th scope="col">Subcategory 3 Name</th>
                    <th scope="col">Requested Quantity / Existing Quantity</th>
                    <th scope="col">Balanced Quantity</th>
                    <th scope="col">Issued Quantity</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($materialrequestitems as $materialrequestitem) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $materialrequestitem['product_name']; ?></td>
                        <td><?php echo $materialrequestitem['category_name']; ?></td>
                        <td><?php echo $materialrequestitem['subcategory_1_name']; ?></td>
                        <td><?php echo $materialrequestitem['subcategory_2_name']; ?></td>
                        <td><?php echo $materialrequestitem['subcategory_3_name']; ?></td>
                        <td><?php echo $materialrequestitem['quantity_type']; ?> <?php echo $materialrequestitem['requested_quantity']; ?>
                            / <?php if ($materialrequestitem['requested_quantity'] <= $materialrequestitem['quantity']) : ?>
                                <span class="text-success"><?php echo $materialrequestitem['quantity']; ?></span><?php else : ?>
                                <span class="text-danger"><?php echo $materialrequestitem['quantity']; ?></span><?php endif; ?>
                        </td>
                        <td><?php echo $materialrequestitem['quantity_type']; ?><?php echo $materialrequestitem['balanced_quantity']; ?></td>
                        <td>
                            <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to issue this material request item?')") ?>
                            <?php echo form_open('Itemsissue/issueitems/' . $materialrequestitem['materialrequestitems_table_id'], $attribute); ?>
                            <div class="form-group">
                                <input type="text" name="GatePassNo" class="form-control" placeholder="Gate Pass No"
                                       >
                            </div>
                            <div class="form-group">
                                <input type="number" name="IssuedQuantity" step="0.01" class="form-control"
                                       max="<?php if ($materialrequestitem['balanced_quantity'] > $materialrequestitem['quantity']) {
                                           echo $materialrequestitem['quantity'];
                                       } else {
                                           echo $materialrequestitem['balanced_quantity'];
                                       } ?>" min="0.00" value="<?php echo $materialrequestitem['issued_quantity']; ?>">
                            </div>
                            <div class="form-group">
                                <div class="bs-component">
                                    <input type="submit" id="btnSubmit" class="form-control btn btn-primary"
                                           value="Issue" data-toggle="tooltip" data-placement="bottom" title=""
                                           data-original-title="Click to issue this item" <?php if ($materialrequestitem['quantity'] == 0) echo 'disabled="disabled"' ?>>
                                </div>
                            </div>
                            <?php echo form_close(); ?>
                        </td>
                    </tr>
                    <?php $count++; ?>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
