<div class="white-background">
    <div class="minimum-height">
        <h2>Approve Site Transfer</h2>
        <div class="table-responsive">
            <table id="ApproveSTDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">MR Code</th>
                   <!-- <th scope="col">Requester Name</th>
                    <th scope="col">Request Date & Time</th> -->
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($sitetransfers as $sitetransfer) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $sitetransfer['materialrequest_code']; ?></td>
                        <!-- <td><?php echo $sitetransfer['system_user_name']; ?></td>
                        <td><?php echo $sitetransfer['request_datetime']; ?></td> -->
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/Sitetransfers/approve/' . $sitetransfer['materialrequest_code']); ?>"
                                   class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to approve this site transfer details">Approve</a>
                            </div>
                        </td>
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/Sitetransfers/' . $sitetransfer['materialrequest_code']); ?>"
                                   class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to reject this site transfer details">Reject</a>
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