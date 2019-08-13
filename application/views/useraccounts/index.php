<div class="white-background">
    <div class="minimum-height">
        <div class="bs-component">
            <a href="<?php echo site_url('useraccounts/create'); ?>" class="btn btn-lg btn-secondary"
               data-toggle="tooltip" data-placement="bottom" title=""
               data-original-title="Click to add a new user account">+ Add New</a>
        </div>
        <hr>
        <h2>User Accounts</h2>
        <div class="table-responsive">
            <table id="UserAccountsDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col"></th>
                    <th scope="col">User Name</th>
                    <th scope="col">User Designation</th>
                    <th scope="col">User Location</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($users as $user) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><img class="user-index-img"
                                 src="<?php echo site_url(); ?>assets/images/users/<?php echo $user['system_user_image']; ?>">
                        </td>
                        <td><?php echo $user['system_user_name']; ?></td>
                        <td><?php echo $user['designation']; ?></td>
                        <td><?php echo $user['location']; ?></td>
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/useraccounts/' . $user['useraccounts_table_id']); ?>"
                                   class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to view this user account">View</a>
                            </div>
                        </td>
                    </tr>
                    <?php $count++; ?>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
