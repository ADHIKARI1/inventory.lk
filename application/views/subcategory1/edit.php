<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $subcategory['subcategory_1_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this sub category 1 details?')") ?>
                    <?php echo form_open('Subcategory1/update', $attribute); ?>
                    <div class="form-group">
                        <label>Select Category</label>
                        <select class="form-control" name="CategoryCode">
                            <?php foreach ($categories as $category) : ?>
                                <option value="<?php echo $category['category_code']; ?>" <?php if ($subcategory['category_code'] === $category['category_code']) echo 'selected="selected"' ?>><?php echo $category['category_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 1 Code</label>
                        <input type="text" class="form-control" name="SubCategory1Code"
                               placeholder="Sub Category 1 Code"
                               value="<?php echo $subcategory['subcategory_1_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Sub Category 1 Name</label>
                        <input type="text" class="form-control" name="SubCategory1Name"
                               placeholder="Sub Category 1 Name"
                               value="<?php echo $subcategory['subcategory_1_name']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 1 Description</label>
                        <textarea class="form-control" name="SubCategory1Description" rows="5"
                                  placeholder="Sub Category 1 Description"
                                  required><?php echo $subcategory['subcategory_1_description']; ?></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this sub category 1 details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
