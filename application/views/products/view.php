<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $product['product_name']; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Product Code : </strong><?php echo $product['product_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Product Name : </strong><?php echo $product['product_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong> Quantity : </strong><?php echo $stock['quantity']; ?> <strong style="margin-left:10px"> Type: </strong><?php echo $stock['quantity_type']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Category Name : </strong><?php echo $product['category_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 1 Name : </strong><?php echo $product['subcategory_1_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 2 Name : </strong><?php echo $product['subcategory_2_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 3 Name : </strong><?php echo $product['subcategory_3_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Location : </strong><?php echo $stock['location']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Product Location : </strong><?php echo $product['productlocation']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Product Description : </strong><?php echo $product['product_description']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <a href="<?php echo base_url(); ?>Products/edit/<?php echo $product['product_code']; ?>"
                       class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="Click to edit this product details">Edit</a><br>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this product?')") ?>
                    <?php echo form_open('/Products/delete/' . $product['product_code'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this product" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
