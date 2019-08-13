<div class="white-background">
    <div class="minimum-height">
        <div class="bs-component">
            <button type="button" id="add-categories-btn" class="btn btn-lg btn-secondary"
               data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to add a new category">+
                Add New</button>
        </div>
        <?php
            include 'create_modal.php';
        ?>
        <hr>
        <h2>Categories</h2>
        <div class="table-responsive">
            <table id="CategoriesDataTable" class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Category Code</th>
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