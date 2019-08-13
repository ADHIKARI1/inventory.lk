<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $subcategory2['subcategory_2_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this sub category 2 details?')") ?>
                    <?php echo form_open('Subcategory2/update', $attribute); ?>
                    <div class="form-group">
                        <label>Select Category</label>
                        <select class="form-control" name="CategoryCode">
                            <?php foreach ($categories as $category) : ?>
                                <option value="<?php echo $category['category_code']; ?>" <?php if ($subcategory2['category_code'] === $category['category_code']) echo 'selected="selected"' ?>><?php echo $category['category_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Sub Category 1</label>
                        <select class="form-control" name="SubCategory1Code">
                            <?php foreach ($subcategories as $subcategory1) : ?>
                                <option value="<?php echo $subcategory1['subcategory_1_code']; ?>" <?php if ($subcategory2['subcategory_1_code'] === $subcategory1['subcategory_1_code']) echo 'selected="selected"' ?>><?php echo $subcategory1['subcategory_1_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 2 Code</label>
                        <input type="text" class="form-control" name="SubCategory2Code"
                               placeholder="Sub Category 2 Code"
                               value="<?php echo $subcategory2['subcategory_2_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Sub Category 2 Name</label>
                        <input type="text" class="form-control" name="SubCategory2Name"
                               placeholder="Sub Category 2 Name"
                               value="<?php echo $subcategory2['subcategory_2_name']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 2 Description</label>
                        <textarea class="form-control" name="SubCategory2Description" rows="5"
                                  placeholder="Sub Category 2 Description"
                                  required><?php echo $subcategory2['subcategory_2_description']; ?></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this sub category 2 details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
