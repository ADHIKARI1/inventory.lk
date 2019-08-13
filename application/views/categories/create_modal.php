<div class="modal fade" id="add-categories-modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Create New Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="#" method="#" id="category-save-form">
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" class="form-control" name="category_name" id="category_name" placeholder="Category Name">
                    </div>
                    <div class="form-group">
                        <label>Category Description</label>
                        <textarea class="form-control" name="category_description" id="category_description" rows="5" placeholder="Category Description"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="button" id="category-save-btn" class="form-control btn btn-primary" value="Save" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to save this new category">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="reset" class="form-control btn btn-secondary" value="Clear" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to clear category details">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
