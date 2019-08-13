<div class="white-background">
    <div class="minimum-height">
        <h2>Create New User Account</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to create this user?')") ?>
                    <?php echo form_open_multipart('Useraccounts/save', $attribute); ?>
                    <div class="form-group">
                        <label>System User Name</label>
                        <input type="text" class="form-control" name="SystemUserName" placeholder="System User Name"
                               required>
                    </div>
                    <div class="form-group">
                        <label>Select System User Designation</label>
                        <select class="form-control" name="SystemUserDesignation">
                            <?php foreach ($designations as $designation) : ?>
                                <option value="<?php echo $designation['designations_table_id']; ?>"><?php echo $designation['designation']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>System User Mobile Number</label>
                        <input type="text" class="form-control" name="SystemUserMobile"
                               placeholder="System User Mobile Number" pattern="(?=.*\d).{10}"
                               title="Must contain numbers only, and the length is 10" required>
                    </div>
                    <div class="form-group">
                        <label>Select System User Location</label>
                        <select class="form-control" name="SystemUserLocation">
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>"><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select System User Type</label>
                        <select class="form-control" name="SystemUserType">
                            <?php foreach ($usertypes as $usertype) : ?>
                                <option value="<?php echo $usertype['usertypes_table_id']; ?>"><?php echo $usertype['usertype']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>User Name</label>
                        <input type="text" class="form-control" name="UserName" placeholder="User Name" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" id="Password" name="Password" placeholder="Password"
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                               title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
                               required>
                    </div>
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <input type="password" class="form-control" id="ConfirmPassword" name="ConfirmPassword"
                               placeholder="Confirm Password" required>
                    </div>
                    <div class="form-group">
                        <label>Upload an Image</label>
                        <input type="file" class="form-control" size="20" name="userfile">
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" id="btnSubmit" class="form-control btn btn-primary" value="Submit"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to submit this user account details">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="reset" class="form-control btn btn-secondary" value="Clear"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to clear all this user account details"
                                   onclick="return confirm('Are you sure, you want to clear this user details?')">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var password = document.getElementById("Password");
    var confirm_password = document.getElementById("ConfirmPassword");
    var btnsubmit = document.getElementById("btnSubmit");

    function validatePassword() {
        if (password.value != confirm_password.value) {
            confirm_password.setCustomValidity("Passwords Don't Match");
        } else {
            confirm_password.setCustomValidity('');
        }
    }

    btnsubmit.onclick = validatePassword;
</script>
