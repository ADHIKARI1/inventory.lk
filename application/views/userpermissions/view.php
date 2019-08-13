<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $user['system_user_name']; ?></h2>
        <hr>
        <div class="bs-component">
            <a href="<?php echo site_url('userpermissions/addpermissions/' . $user['useraccounts_table_id']); ?>"
               class="btn btn-secondary btn-lg mx-3" data-toggle="tooltip" data-placement="bottom" title=""
               data-original-title="Click to add a new permission to this user">+ Add New</a><br>
        </div>
        <br>
        <div class="col-md-6">
            <div class="list-group">
                <?php foreach ($userpermissions as $userpermission) : ?>
                    <div class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                        <?php echo $userpermission['permission']; ?>
                        <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to remove this permission from this user?')") ?>
                        <?php echo form_open('userpermissions/deletepermission/' . $userpermission['userpermissions_table_id'], $attribute); ?>
                        <div class="bs-component">
                            <input type="submit" class="btn btn-danger" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to delete this permission from this user"
                                   value="X">
                        </div>
                        <?php echo form_close(); ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
        <br>
    </div>
</div>
