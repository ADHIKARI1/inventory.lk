<div class="white-background">
    <div class="minimum-height">
        <h2>Approve Material Requests</h2>
        <div class="table-responsive">
            <table id="ApproveMRDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">MR Code</th>
                    <th scope="col">Requester Name</th>
                    <th scope="col">Request Date & Time</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($materialrequests as $materialrequest) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $materialrequest['materialrequest_code']; ?></td>
                        <td><?php echo $materialrequest['system_user_name']; ?></td>
                        <td><?php echo $materialrequest['request_datetime']; ?></td>
                        <td>
                            <div class="bs-component">
                              <a href="<?php echo site_url('/materialrequest/materialrequestitemsapp/'.$materialrequest['materialrequest_code']); ?>" class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to view this MR details">View</a>
                            </div>
                        </td>
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/materialrequest/approve/' . $materialrequest['materialrequest_code']); ?>"
                                   class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to approve this MR details">Approve</a>
                            </div>
                        </td>
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/materialrequest/' . $materialrequest['materialrequest_code']); ?>"
                                   class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to reject this MR details">Reject</a>
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
