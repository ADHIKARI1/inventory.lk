<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $location['location']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this location details?')") ?>
                    <?php echo form_open('Locations/update', $attribute); ?>
                    <div class="form-group">
                        <input type="hidden" name="LocationID" value="<?php echo $location['locations_table_id']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Location Name</label>
                        <input type="text" class="form-control" name="LocationName" placeholder="Location Name"
                               value="<?php echo $location['location']; ?>" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this location details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
