<div class="modal fade" id="edit-categories-modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="edit-category-name-header"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="#" method="#" id="category-update-form">
                    <div class="form-group">
                        <label>Category Code</label>
                        <input type="text" class="form-control" name="category_code" id="edit_category_code" placeholder="Category Code"
                               value="" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" class="form-control" name="category_name" id="edit_category_name" placeholder="Category Name"
                               value="">
                    </div>
                    <div class="form-group">
                        <label>Category Description</label>
                        <textarea class="form-control" name="category_description" id="edit_category_description" rows="5"
                                  placeholder="Category Description"></textarea>
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
