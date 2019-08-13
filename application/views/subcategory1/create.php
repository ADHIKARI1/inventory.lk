<div class="white-background">
    <div class="minimum-height">
        <h2>Create New Sub Category 1</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to create this sub category 1?')") ?>
                    <?php echo form_open('Subcategory1/save', $attribute); ?>
                    <div class="form-group">
                        <label>Select Category</label>
                        <select class="form-control" name="CategoryCode">
                            <?php foreach ($categories as $category) : ?>
                                <option value="<?php echo $category['category_code']; ?>"><?php echo $category['category_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 1 Name</label>
                        <input type="text" class="form-control" name="SubCategory1Name"
                               placeholder="Sub Category 1 Name" required>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 1 Description</label>
                        <textarea class="form-control" name="SubCategory1Description" rows="5"
                                  placeholder="Sub Category 1 Description" required></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save" data-toggle="tooltip"
                                   data-placement="bottom" title=""
                                   data-original-title="Click to save this new sub category 1">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="reset" class="form-control btn btn-secondary" value="Clear"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to clear sub category 1 details"
                                   onclick="return confirm('Are you sure, you want to clear this sub category 1 details?')">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
