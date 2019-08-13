<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $category['category_name']; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Category Code : </strong><?php echo $category['category_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Category Name : </strong><?php echo $category['category_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Category Description : </strong><?php echo $category['category_description']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <a href="<?php echo base_url(); ?>Categories/edit/<?php echo $category['category_code']; ?>"
                       class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="Click to edit this category details">Edit</a><br>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this category?')") ?>
                    <?php echo form_open('/Categories/delete/' . $category['category_code'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this category" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
