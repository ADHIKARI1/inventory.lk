<div class="white-background">
    <div class="minimum-height">
        <h2>Create New Location</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to create this location?')") ?>
                    <?php echo form_open('Locations/save', $attribute); ?>
                    <div class="form-group">
                        <label>Location Name</label>
                        <input type="text" class="form-control" name="LocationName" placeholder="Location Name"
                               required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save" data-toggle="tooltip"
                                   data-placement="bottom" title=""
                                   data-original-title="Click to save this new location">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="reset" class="form-control btn btn-secondary" value="Clear"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to clear location details"
                                   onclick="return confirm('Are you sure, you want to clear this location details?')">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
