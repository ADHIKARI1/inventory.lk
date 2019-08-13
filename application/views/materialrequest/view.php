<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $materialrequest['materialrequest_code']; ?>
            - <?php echo $materialrequest['project_name']; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Material Request Code : </strong><?php echo $materialrequest['materialrequest_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Project Name : </strong><?php echo $materialrequest['project_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Requester Name : </strong><?php echo $materialrequest['system_user_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Requester Location : </strong><?php echo $materialrequest['location']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Request Date & Time : </strong><?php echo $materialrequest['request_datetime']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this material request?')") ?>
                    <?php echo form_open('/Materialrequests/delete/' . $materialrequest['materialrequest_code'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this MR" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
