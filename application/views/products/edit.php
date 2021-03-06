<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $product['product_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this product details?')") ?>
                    <?php echo form_open('Products/update', $attribute); ?>
                    <div class="form-group">
                        <label>Product Code</label>
                        <input type="text" class="form-control" name="ProductCode" placeholder="Product Code"
                               value="<?php echo $product['product_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" class="form-control" name="ProductName" placeholder="Product Name"
                               value="<?php echo htmlspecialchars($product['product_name'], ENT_QUOTES); ?>" required>
                    </div>                                   
                    <div class="form-group">
                        <label>Select Category</label>
                        <select class="form-control filterSelect" name="CategoryCode" data-target='select-sub1'
                                id='select-cat'>
                            <?php foreach ($categories as $category) : ?>
                                <option value="<?php echo $category['category_code']; ?>"
                                        data-reference="<?php echo $category['category_code']; ?>" <?php if ($product['category_code'] === $category['category_code']) echo 'selected="selected"' ?>><?php echo $category['category_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Sub Category 1</label>
                        <select class="form-control filterSelect" name="SubCategory1Code" data-target='select-sub2'
                                id='select-sub1'>
                            <?php foreach ($subcategories1 as $subcategory1) : ?>
                                <option value="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                        data-reference="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                        data-belongsto="<?php echo $subcategory1['category_code']; ?>" <?php if ($product['subcategory_1_code'] === $subcategory1['subcategory_1_code']) echo 'selected="selected"' ?>><?php echo $subcategory1['subcategory_1_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Sub Category 2</label>
                        <select class="form-control filterSelect" name="SubCategory2Code" data-target='select-sub3'
                                id='select-sub2'>
                            <?php foreach ($subcategories2 as $subcategory2) : ?>
                                <option value="<?php echo $subcategory2['subcategory_2_code']; ?>"
                                        data-reference="<?php echo $subcategory2['subcategory_2_code']; ?>"
                                        data-belongsto="<?php echo $subcategory2['subcategory_1_code']; ?>" <?php if ($product['subcategory_2_code'] === $subcategory2['subcategory_2_code']) echo 'selected="selected"' ?>><?php echo $subcategory2['subcategory_2_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Sub Category 3</label>
                        <select class="form-control" name="SubCategory3Code" id='select-sub3'>
                            <?php foreach ($subcategories3 as $subcategory3) : ?>
                                <option value="<?php echo $subcategory3['subcategory_3_code']; ?>"
                                        data-belongsto="<?php echo $subcategory3['subcategory_2_code']; ?>" <?php if ($product['subcategory_3_code'] === $subcategory3['subcategory_3_code']) echo 'selected="selected"' ?>><?php echo $subcategory3['subcategory_3_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                          <label>Quantity</label>
                          <div style="display: flex;">
                            <div class="col-md-8 px-0">
                              <input type="number" step="0.01" class="form-control" name="Quantity" id="Quantity" placeholder="Quantity" value="<?php echo $stock['quantity']; ?>" min="0" required>
                            </div>
                            <div class="col-md-4 pr-0">
                              <select class="form-control" name="QuantityType" id="QuantityType">
                                <option value="<?php echo $stock['quantity_type']; ?>"><?php echo $stock['quantity_type']; ?></option>
                                <option value="Nos">Nos</option>
                                <option value="Length">Length</option>
                                <option value="Roll">Roll</option>
                              </select>
                            </div>
                          </div>
                    </div>
                    <div class="form-group">
                        <label>Select Location</label>
                        <select class="form-control" name="Location" readonly="readonly">
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>" <?php if($stock['location_id'] === $location['locations_table_id']) echo 'selected="selected"'; ?>><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Product Location</label>
                        <select class="form-control" name="ProductLocation" readonly="readonly">
                            <?php foreach ($productlocations as $productlocation) : ?>
                                <option value="<?php echo $productlocation['productlocations_table_id']; ?>" <?php if ($product['product_location_id'] === $productlocation['productlocations_table_id']) echo 'selected="selected"' ?>><?php echo $productlocation['productlocation']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Product Description</label>
                        <textarea class="form-control" name="ProductDescription" rows="5"
                                  placeholder="Product Description"
                                  required><?php echo $product['product_description']; ?></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this product details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
