<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $supplier['supplier_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to assign these category(ies) or subcategory(ies) this supplier?')") ?>
                    <?php echo form_open('Suppliers/savesupplierproducts', $attribute); ?>
                    <input type="hidden" name="SupplierCode" value="<?php echo $supplier['supplier_code']; ?>">
                    <div class="form-group">
                        <div id="dynamic-fields">
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
                                <select class="form-control filterSelect" name="SubCategory1Code[]" id='select-sub1'
                                        size="10" multiple="">
                                    <?php foreach ($subcategories1 as $subcategory1) : ?>
                                        <option value="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                                data-belongsto="<?php echo $subcategory1['category_code']; ?>"><?php echo $subcategory1['subcategory_1_name']; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <!-- <div class="form-group">
                          <label>Select Sub Category 2</label>
                          <select class="form-control filterSelect" name="SubCategory2Code[]" data-target='select-sub3' id='select-sub2' size="10" multiple="">
                            <?php foreach ($subcategories2 as $subcategory2) : ?>
                              <option value="<?php echo $subcategory2['subcategory_2_code']; ?>" data-reference="<?php echo $subcategory2['subcategory_2_code']; ?>" data-belongsto="<?php echo $subcategory2['subcategory_1_code']; ?>"><?php echo $subcategory2['subcategory_2_name']; ?></option>
                            <?php endforeach; ?>
                          </select>
                        </div>
                        <div class="form-group">
                          <label>Select Sub Category 3</label>
                          <select class="form-control filterSelect" name="SubCategory3Code[]" id='select-sub3' size="10" multiple="">
                            <?php foreach ($subcategories3 as $subcategory3) : ?>
                              <option value="<?php echo $subcategory3['subcategory_3_code']; ?>" data-belongsto="<?php echo $subcategory3['subcategory_2_code']; ?>"><?php echo $subcategory3['subcategory_3_name']; ?></option>
                            <?php endforeach; ?>
                          </select>
                        </div> -->
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Submit"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save this added products for this supplier">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
