<div class="white-background">
    <div class="minimum-height">
        <h2>Create Site Transfer</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to do this site transfer? PLEASE DOUBLE CHECK BEFORE SAVE. ONCE YOU SAVED, IT CANNOT BE DELETED!!!')") ?>
                    <?php echo form_open('Sitetransfers/savesitetransfer', $attribute); ?>
                    <div class="form-group">
                        <label>Gate Pass Number</label>
                        <input type="text" name="GatePassNo" class="form-control" placeholder="Gate Pass Number"
                               required>
                    </div>
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
                        <select class="form-control filterSelect" name="SubCategory1Code" data-target='select-sub2'
                                id='select-sub1'>
                            <?php foreach ($subcategories1 as $subcategory1) : ?>
                                <option value="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                        data-reference="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                        data-belongsto="<?php echo $subcategory1['category_code']; ?>"><?php echo $subcategory1['subcategory_1_name']; ?></option>
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
                                        data-belongsto="<?php echo $subcategory2['subcategory_1_code']; ?>"><?php echo $subcategory2['subcategory_2_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Sub Category 3</label>
                        <select class="form-control filterSelect" name="SubCategory3Code" data-target='select-product'
                                id='select-sub3'>
                            <?php foreach ($subcategories3 as $subcategory3) : ?>
                                <option value="<?php echo $subcategory3['subcategory_3_code']; ?>"
                                        data-reference="<?php echo $subcategory3['subcategory_3_code']; ?>"
                                        data-belongsto="<?php echo $subcategory3['subcategory_2_code']; ?>"><?php echo $subcategory3['subcategory_3_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Transferring Item</label>
                        <select class="form-control" name="STItems" id="select-product">
                            <?php foreach ($products as $product) : ?>
                                <option value="<?php echo $product['product_code']; ?>"
                                        data-belongsto="<?php echo $product['subcategory_3_code']; ?>"><?php echo $product['product_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Transfering Quantity</label>
                        <div style="display: flex;">
                            <div class="col-md-8 px-0">
                                <input type="number" step="0.01" class="form-control" name="STItemQty"
                                       placeholder="Transfering Quantity" value="0.00" min="0" required>
                            </div>
                            <div class="col-md-4 pr-0">
                                <select class="form-control" name="QuantityType">
                                    <option value="Nos">Nos</option>
                                    <option value="Length">Length</option>
                                    <option value="Roll">Roll</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Select Destination Location</label>
                        <select class="form-control" name="DestinationLocation" required>
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>"><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Submit"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save this site transfer">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
