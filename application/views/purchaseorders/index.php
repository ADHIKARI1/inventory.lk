<div class="white-background">
    <div class="minimum-height">

        <hr>
        <h2>Saved Purchase Orders - MR's</h2>
        <div class="table-responsive">
            <table id="PurchaseOrdersDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">MR Code</th>
                    <th scope="col">Requester Name</th>
                    <th scope="col">Request Date & Time</th>
                    <th scope="col">Status</th>
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
                        <td><?php if($materialrequest['materialrequest_status'] == "Pending") : ?><span class="text-danger"><?php echo $materialrequest['materialrequest_status']; ?></span><?php else : ?><span class="text-success"><?php echo $materialrequest['materialrequest_status']; ?></span><?php endif; ?></td>

                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/purchaseorderssaved/'.$materialrequest['materialrequest_code']) ?>" class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to view this MR items">View MR Items</a>
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