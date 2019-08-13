<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $user['system_user_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this user image?')") ?>
                    <?php echo form_open_multipart('Useraccounts/update_image', $attribute); ?>
                    <input type="hidden" name="SystemUserID" value="<?php echo $user['useraccounts_table_id']; ?>">
                    <input type="hidden" name="OldSystemUserImage" value="<?php echo $user['system_user_image']; ?>">
                    <div class="form-group">
                        <label>Upload an Image</label>
                        <input type="file" class="form-control" size="20" name="userfile">
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save changes this user account image">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
