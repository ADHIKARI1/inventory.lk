<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $materialrequest['materialrequest_code']; ?>
            - <?php echo $materialrequest['project_name']; ?></h2>
        <hr>
        <div class="row">
            <div class="col-md-4 py-2">
                <div class="card rounded-0">
                    <div class="card-body">

                        <input type="hidden" name="MRCode" id="MRCode"
                               value="<?php echo $materialrequest['materialrequest_code']; ?>">
                        <form id = "addItemForm" name = "addItemForm">
                        <div class="form-group">
                            <div id="dynamic-fields">

                                <div class="form-group">
                                    <label>Select Category</label>
                                    <select class="form-control filterSelect" name="CategoryCode"
                                            data-target='select-sub1' id='select-cat'>
                                        <?php foreach ($categories as $category) : ?>
                                            <option value="<?php echo $category['category_code']; ?>"
                                                    data-reference="<?php echo $category['category_code']; ?>"><?php echo $category['category_name']; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Select Sub Category 1</label>
                                    <select class="form-control filterSelect" name="SubCategory1Code"
                                            data-target='select-sub2' id='select-sub1'>
                                        <?php foreach ($subcategories1 as $subcategory1) : ?>
                                            <option value="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                                    data-reference="<?php echo $subcategory1['subcategory_1_code']; ?>"
                                                    data-belongsto="<?php echo $subcategory1['category_code']; ?>"><?php echo $subcategory1['subcategory_1_name']; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Select Sub Category 2</label>
                                    <select class="form-control filterSelect" name="SubCategory2Code"
                                            data-target='select-sub3' id='select-sub2'>
                                        <?php foreach ($subcategories2 as $subcategory2) : ?>
                                            <option value="<?php echo $subcategory2['subcategory_2_code']; ?>"
                                                    data-reference="<?php echo $subcategory2['subcategory_2_code']; ?>"
                                                    data-belongsto="<?php echo $subcategory2['subcategory_1_code']; ?>"><?php echo $subcategory2['subcategory_2_name']; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Select Sub Category 3</label>
                                    <select class="form-control filterSelect" name="SubCategory3Code"
                                            data-target='select-product' id='select-sub3'>
                                        <?php foreach ($subcategories3 as $subcategory3) : ?>
                                            <option value="<?php echo $subcategory3['subcategory_3_code']; ?>"
                                                    data-reference="<?php echo $subcategory3['subcategory_3_code']; ?>"
                                                    data-belongsto="<?php echo $subcategory3['subcategory_2_code']; ?>"><?php echo $subcategory3['subcategory_3_name']; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Select MR Item</label>
                                    <select class="form-control" name="MRItems" id="select-product">
                                        <?php foreach ($products as $product) : ?>
                                            <option value="<?php echo $product['product_code']; ?>"
                                                    data-belongsto="<?php echo $product['subcategory_3_code']; ?>"><?php echo $product['product_name']; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>MR Item Quantity</label>
                                    <div style="display: flex;">
                                        <div class="col-md-8 px-0">
                                            <input type="number" step="0.01" class="form-control" name="MRItemQty"
                                                   id="MRItemQty" placeholder="MR Item Quantity" value="0.00" min="0"
                                                   required>
                                        </div>

                                        <div class="col-md-4 pr-0">
                                            <select class="form-control" name="QuantityType" id="QuantityType">
                                                <option value="Nos">Nos</option>
                                                <option value="Length">Length</option>
                                                <option value="Roll">Roll</option>
                                                <option value="Kilograms">Kilograms</option>
                                                <option value="Packet">Packet</option>
                                                <option value="Meters">Meters</option>
                                                <option value="Bottles">Bottles</option>
                                                <option value="Tube">Tube</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <hr>
                            </div>
                        </div>
                        </form>
                        <div class="form-group">
                            <div class="bs-component">
                                <input type="submit" id="add_data" class="form-control btn btn-primary" value="Add Item"
                                       data-toggle="tooltip" data-placement="bottom" title=""
                                       data-original-title="Click to add items for MR">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="bs-component">
                                <input type="submit" id="save_added_data" class="form-control btn btn-success"
                                       value="Save" data-toggle="tooltip" data-placement="bottom" title=""
                                       data-original-title="Click to save this added items for this MR">
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-md-8 py-2 table-responsive">
                <table class="table table-hover table stripped table-bordered" id="data_table">
                    <thead>
                    <tr>
                        <th>MR Code</th>
                        <th>Category</th>
                        <th>Sub Category 1</th>
                        <th>Sub Category 2</th>
                        <th>Sub Category 3</th>
                        <th>Product</th>
                        <th>MR Item Qty</th>
                        <th>Qty Type</th>
                        <th>Remove</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>

            </div>
        </div>


    </div>
</div>





  


    


   
        

