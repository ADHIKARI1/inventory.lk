<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $project['project_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this project details?')") ?>
                    <?php echo form_open('Projects/update', $attribute); ?>
                    <div class="form-group">
                        <label>Project Code</label>
                        <input type="text" class="form-control" name="ProjectCode" placeholder="Project Code"
                               value="<?php echo $project['project_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Project Name</label>
                        <input type="text" class="form-control" name="ProjectName" placeholder="Project Name"
                               value="<?php echo $project['project_name']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Select Location</label>
                        <select class="form-control" name="ProjectLocation">
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>" <?php if ($project['location_id'] === $location['locations_table_id']) echo 'selected="selected"' ?>><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Project Description</label>
                        <textarea class="form-control" name="ProjectDescription" rows="5"
                                  placeholder="Project Description"
                                  required><?php echo $project['project_description']; ?></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this project details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
