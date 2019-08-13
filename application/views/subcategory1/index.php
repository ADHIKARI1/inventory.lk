<div class="white-background">
    <div class="minimum-height">
        <div class="bs-component">
            <button type="button" id="add-subcategories-one-btn" class="btn btn-lg btn-secondary"
                    data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to add a new subcategory 1">+
                Add New</button>
        </div>
        <?php
            include 'create_modal.php';
        ?>
        <hr>
        <h2>Sub Category 1</h2>
        <div class="table-responsive">
            <table id="SubcategoriesOneDataTable" class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Sub Category Code</th>
                    <th scope="col">Sub Category Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col"></th>
                </tr>
                </thead>
            </table>
        </div>
        <?php
            include 'view_modal.php';
            include 'edit_modal.php';
        ?>
    </div>
</div>
