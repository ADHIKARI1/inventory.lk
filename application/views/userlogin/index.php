<div class="minimum-height py-5">
    <div class="col-md-4 mx-auto">
        <div class="card rounded-0">
            <div class="card-header">
                <h3 class="text-center">Log In</h3>
                <center><img class="img login-avatar" src="<?php echo base_url(); ?>assets/images/Login-Avatar.jpg">
                </center>
            </div>
            <div class="card-body">
                <?php echo form_open('Userlogin/login'); ?>
                <div class="form-group">
                    <label for="UserName">User Name</label>
                    <input type="text" class="form-control" name="UserName" placeholder="User Name" autofocus required>
                </div>
                <div class="form-group">
                    <label for="Password">Password</label>
                    <input type="password" class="form-control" name="Password" placeholder="Password" required>
                </div>
                <div class="form-group">
                    <input type="submit" class="form-control btn btn-primary" value="Log In">
                </div>
                <?php echo form_close(); ?>
            </div>
        </div>
    </div>
</div>
