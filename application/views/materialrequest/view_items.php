<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $materialrequest['materialrequest_code']; ?>
            - <?php echo $materialrequest['project_name']; ?></h2>
        <hr>
        <?php if($status == 0) { ?>      
        <div class="bs-component">
            <a href="<?php echo site_url('/materialrequest/addmaterialrequestitems/' . $materialrequest['materialrequest_code']); ?>"
               class="btn btn-secondary btn-lg mx-3" data-toggle="tooltip" data-placement="bottom" title=""
               data-original-title="Click to add a new items to this MR">+ Add New</a><br>
        </div>
        <?php } ?>
        <br>
        <div class="table-responsive">
            <input type="hidden" name="mr_code" id="material-request-item-mr-code"
                   value="<?php echo $materialrequest['materialrequest_code']; ?>">
            <table id="MaterialRequestsItemsDataTable" class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory 1 Name</th>
                    <th scope="col">Subcategory 2 Name</th>
                    <th scope="col">Subcategory 3 Name</th>
                    <th scope="col">Requested Quantity</th>
                    <th scope="col">Balanced Quantity</th>
                    <th scope="col">Status</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                    <th class="d-none" scope="col"></th>
                </tr>
                </thead>
            </table>
            <?php
                if ($mr_item_count > 0) {
            ?>
                <div class="form-group">
                    <div class="bs-component">
                        <input type="button" id="request_po" class="btn btn-success btn-block" data-toggle="tooltip"
                               data-placement="bottom" title="" data-original-title="Click to request a PO for this item"
                               value="Request Purchase Order's">
                    </div>
                </div>
            <?php
                }
            ?>
        </div>
    </div>
</div>


