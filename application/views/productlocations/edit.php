<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $productlocation['productlocation']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this product location details?')") ?>
                    <?php echo form_open('Productlocations/update', $attribute); ?>
                    <div class="form-group">
                        <input type="hidden" name="ProductLocationID"
                               value="<?php echo $productlocation['productlocations_table_id']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Product Location Name</label>
                        <input type="text" class="form-control" name="ProductLocationName"
                               placeholder="Product Location Name"
                               value="<?php echo $productlocation['productlocation']; ?>" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this product location details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
