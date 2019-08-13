<div class="white-background">
    <div class="minimum-height">
        <h2>Request Site Transfer</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to request a site transfer for this material request product?')") ?>
                    <?php echo form_open('Materialrequests/savesitetransfer', $attribute); ?>
                    <div class="form-group">
                        <label>Material Request Code</label>
                        <input type="text" class="form-control" name="MRCode" placeholder="Material Request Code"
                               value="<?php echo $materialrequest['materialrequest_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="hidden" name="CategoryCode"
                               value="<?php echo $materialrequest['category_code']; ?>">
                        <input type="text" class="form-control" name="CategoryName" placeholder="Product Name"
                               value="<?php echo $materialrequest['category_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 1 Name</label>
                        <input type="hidden" name="SubCategory1Code"
                               value="<?php echo $materialrequest['subcategory_1_code']; ?>">
                        <input type="text" class="form-control" name="Subcategory1Name" placeholder="Product Name"
                               value="<?php echo $materialrequest['subcategory_1_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 2 Name</label>
                        <input type="hidden" name="SubCategory2Code"
                               value="<?php echo $materialrequest['subcategory_2_code']; ?>">
                        <input type="text" class="form-control" name="Subcategory2Name" placeholder="Product Name"
                               value="<?php echo $materialrequest['subcategory_2_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Subcategory 3 Name</label>
                        <input type="hidden" name="SubCategory3Code"
                               value="<?php echo $materialrequest['subcategory_3_code']; ?>">
                        <input type="text" class="form-control" name="Subcategory3Name" placeholder="Product Name"
                               value="<?php echo $materialrequest['subcategory_3_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="hidden" name="ProductCode" value="<?php echo $materialrequest['product_code']; ?>">
                        <input type="text" class="form-control" name="ProductName" placeholder="Product Name"
                               value="<?php echo $materialrequest['product_name']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Requesting Quantity</label>
                        <input type="text" class="form-control" name="RequestingQty" placeholder="Requesting Quantity"
                               value="<?php echo $materialrequest['balanced_quantity']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Requesting location</label>
                        <input type="hidden" name="RequestingLocationID"
                               value="<?php echo $materialrequest['locations_table_id']; ?>">
                        <input type="text" class="form-control" name="RequestingLocation"
                               placeholder="Requesting Location" value="<?php echo $materialrequest['location']; ?>"
                               readonly="">
                    </div>
                    <div class="form-group">
                        <label>Select Destination Location</label>
                        <select class="form-control" name="DestinationLocation" required>
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>"><?php echo $location['location']; ?>
                                    / <?php echo $location['quantity']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Request"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save request">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
