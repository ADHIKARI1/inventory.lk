<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $user['system_user_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this user password?')") ?>
                    <?php echo form_open('useraccounts/update_password', $attribute); ?>
                    <input type="hidden" name="SystemUserID" value="<?php echo $user['useraccounts_table_id']; ?>">
                    <div class="form-group">
                        <label>Old Password</label>
                        <input type="password" class="form-control" name="OldPassword" placeholder="Old Password"
                               required>
                    </div>
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" class="form-control" id="NewPassword" name="NewPassword"
                               placeholder="New Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                               title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
                               required>
                    </div>
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" class="form-control" id="ConfirmNewPassword" name="ConfirmNewPassword"
                               placeholder="Confirm New Password" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" id="btnSubmit" class="form-control btn btn-primary"
                                   value="Save Changes" data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save changes this user account password">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var password = document.getElementById("NewPassword");
    var confirm_password = document.getElementById("ConfirmNewPassword");
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
