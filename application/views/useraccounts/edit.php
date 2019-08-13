<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $user['system_user_name']; ?> - <?php echo $user['usertype']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this user details?')") ?>
                    <?php echo form_open('useraccounts/update', $attribute); ?>
                    <input type="hidden" name="SystemUserID" value="<?php echo $user['useraccounts_table_id']; ?>">
                    <div class="form-group">
                        <label>System User Name</label>
                        <input type="text" class="form-control" name="SystemUserName" placeholder="System User Name"
                               value="<?php echo $user['system_user_name']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Select System User Designation</label>
                        <select class="form-control" name="SystemUserDesignation">
                            <?php foreach ($designations as $designation) : ?>
                                <option value="<?php echo $designation['designations_table_id']; ?>" <?php if ($user['designation_id'] == $designation['designations_table_id']) echo 'selected="selected"' ?>><?php echo $designation['designation']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>System User Mobile Number</label>
                        <input type="text" class="form-control" name="SystemUserMobile"
                               placeholder="System User Mobile Number"
                               value="<?php echo $user['system_user_mobile']; ?>" pattern="(?=.*\d).{10}"
                               title="Must contain numbers only, and the length is 10" required>
                    </div>
                    <div class="form-group">
                        <label>Select System User Location</label>
                        <select class="form-control" name="SystemUserLocation">
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>" <?php if ($user['location_id'] === $location['locations_table_id']) echo 'selected="selected"' ?>><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select System User Type</label>
                        <select class="form-control" name="SystemUserType">
                            <?php foreach ($usertypes as $usertype) : ?>
                                <option value="<?php echo $usertype['usertypes_table_id']; ?>" <?php if ($user['user_type'] === $usertype['usertypes_table_id']) echo 'selected="selected"' ?>><?php echo $usertype['usertype']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>User Name</label>
                        <input type="text" class="form-control" name="UserName" placeholder="User Name"
                               value="<?php echo $user['user_name']; ?>" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save changes this user account details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
