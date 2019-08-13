<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $category['category_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <form action="#" method="#" id="category-update-form">
                        <div class="form-group">
                            <label>Category Code</label>
                            <input type="text" class="form-control" name="category_code" id="category_code" placeholder="Category Code"
                                   value="<?php echo $category['category_code']; ?>" readonly="">
                        </div>
                        <div class="form-group">
                            <label>Category Name</label>
                            <input type="text" class="form-control" name="category_name" id="category_name" placeholder="Category Name"
                                   value="<?php echo $category['category_name']; ?>">
                        </div>
                        <div class="form-group">
                            <label>Category Description</label>
                            <textarea class="form-control" name="category_description" id="category_description" rows="5"
                                      placeholder="Category Description"><?php echo $category['category_description']; ?></textarea>
                        </div>
                        <div class="form-group">
                            <div class="bs-component">
                                <input type="button" id="category-update-btn" class="form-control btn btn-primary" value="Save Changes"
                                       data-toggle="tooltip" data-placement="bottom" title=""
                                       data-original-title="Click to update this category details">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
