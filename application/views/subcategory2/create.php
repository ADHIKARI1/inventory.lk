<div class="white-background">
    <div class="minimum-height">
        <h2>Create New Sub Category 2</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to create this sub category 2?')") ?>
                    <?php echo form_open('Subcategory2/save', $attribute); ?>
                    <div class="form-group">
                        <label>Select Category</label>
                        <select class="form-control filterSelect" name="CategoryCode" data-target='select-sub1'
                                id='select-cat'>
                            <?php foreach ($categories as $category) : ?>
                                <option value="<?php echo $category['category_code']; ?>"
                                        data-reference="<?php echo $category['category_code']; ?>"><?php echo $category['category_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Sub Category 1</label>
                        <select class="form-control" id="select-sub1" name="SubCategory1Code">
                            <?php foreach ($subcategories as $subcategory) : ?>
                                <option value="<?php echo $subcategory['subcategory_1_code']; ?>"
                                        data-belongsto="<?php echo $subcategory['category_code']; ?>"><?php echo $subcategory['subcategory_1_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 2 Name</label>
                        <input type="text" class="form-control" name="SubCategory2Name"
                               placeholder="Sub Category 2 Name" required>
                    </div>
                    <div class="form-group">
                        <label>Sub Category 2 Description</label>
                        <textarea class="form-control" name="SubCategory2Description" rows="5"
                                  placeholder="Sub Category 2 Description" required></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save" data-toggle="tooltip"
                                   data-placement="bottom" title=""
                                   data-original-title="Click to save this new sub category 2">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="reset" class="form-control btn btn-secondary" value="Clear"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to clear sub category 2 details"
                                   onclick="return confirm('Are you sure, you want to clear this sub category 2 details?')">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
