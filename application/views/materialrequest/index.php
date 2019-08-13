<div class="white-background">
    <div class="minimum-height">
        <div class="bs-component">
            <a href="<?php echo site_url('materialrequest/create'); ?>" class="btn btn-lg btn-secondary"
               data-toggle="tooltip" data-placement="bottom" title=""
               data-original-title="Click to add a new material request">+ Add New</a>
        </div>
        <hr>
        <h2>Material Requests</h2>
        <div class="table-responsive">
            <table id="MaterialRequestsDataTable" class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">MR Code</th>
                    <th scope="col">Requester Name</th>
                    <th scope="col">Request Date & Time</th>
                    <th scope="col">Status</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
