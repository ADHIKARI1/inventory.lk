<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $user['system_user_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to add these permission(s) for this user?')") ?>
                    <?php echo form_open('Userpermissions/savepermission', $attribute); ?>
                    <input type="hidden" name="UserID" value="<?php echo $user['useraccounts_table_id']; ?>">
                    <div class="form-group">
                        <div id="dynamic-fields">
                            <div class="form-group">
                                <label>Select User Permission</label>
                                <select class="form-control" name="UserPermission[]" size="15" multiple>
                                    <?php foreach ($permissions as $permission) : ?>
                                        <option value="<?php echo $permission['permissions_table_id']; ?>"><?php echo $permission['permission']; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Submit"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save this user permissions">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
