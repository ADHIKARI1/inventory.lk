<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $user['system_user_name']; ?></h2>
        <hr>
        <div class="row">
            <div class="col-md-3">
                <img class="img user-img"
                     src="<?php echo site_url(); ?>assets/images/users/<?php echo $user['system_user_image']; ?>">
                <br><br>
                <div class="bs-component">
                    <a href="<?php echo base_url(); ?>Useraccounts/edit_image/<?php echo $user['useraccounts_table_id'] ?>"
                       class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="Click to edit this user account image">Change Image</a>
                </div>
                <br>
            </div>
            <div class="col-md-9">
                <div class="list-group">
                    <div class="list-group-item list-group-item-action">
                        <strong>Full Name : </strong><?php echo $user['system_user_name']; ?>
                    </div>
                    <div class="list-group-item list-group-item-action">
                        <strong>Designation : </strong><?php echo $user['designation']; ?>
                    </div>
                    <div class="list-group-item list-group-item-action">
                        <strong>Location : </strong><?php echo $user['location']; ?>
                    </div>
                    <div class="list-group-item list-group-item-action">
                        <strong>Mobile # : </strong><?php echo $user['system_user_mobile']; ?>
                    </div>
                    <div class="list-group-item list-group-item-action">
                        <strong>User Type : </strong><?php echo $user['usertype']; ?>
                    </div>
                    <div class="list-group-item list-group-item-action">
                        <strong>User Name : </strong><?php echo $user['user_name']; ?>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="bs-component">
                                <a href="<?php echo base_url(); ?>Useraccounts/edit_password/<?php echo $user['useraccounts_table_id'] ?>"
                                   class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to edit this user account password">Change
                                    Password</a><br>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="bs-component">
                                <a href="<?php echo base_url(); ?>Useraccounts/edit/<?php echo $user['useraccounts_table_id'] ?>"
                                   class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to edit this user account details">Edit</a><br>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="bs-component">
                                <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this user?')") ?>
                                <?php echo form_open('/Useraccounts/delete/' . $user['useraccounts_table_id'], $attribute); ?>
                                <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip"
                                       data-placement="bottom" title=""
                                       data-original-title="Click to delete this user account" value="Delete"><br>
                                <?php echo form_close(); ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
