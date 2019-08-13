<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $subcategory['subcategory_2_name']; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 2 Code : </strong><?php echo $subcategory['subcategory_2_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 2 Name : </strong><?php echo $subcategory['subcategory_2_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Category Name : </strong><?php echo $subcategory['category_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 1 Name : </strong><?php echo $subcategory['subcategory_1_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Sub Category 2 Description : </strong><?php echo $subcategory['subcategory_2_description']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <a href="<?php echo base_url(); ?>Subcategory2/edit/<?php echo $subcategory['subcategory_2_code']; ?>"
                       class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="Click to edit this sub category 2 details">Edit</a><br>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this sub category 2?')") ?>
                    <?php echo form_open('/Subcategory2/delete/' . $subcategory['subcategory_2_code'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this sub category 2" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
