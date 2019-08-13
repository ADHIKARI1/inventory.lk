<div class="white-background">
    <div class="minimum-height">
        <h2>Create New Material Request</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to create this material request?')") ?>
                    <?php echo form_open('Materialrequests/save', $attribute); ?>
                    <div class="form-group">
                        <label>Material Request Code</label>
                        <input type="text" class="form-control" name="MRCode" placeholder="Material Request Code"
                               required>
                    </div>
                    <div class="form-group">
                        <label>Select Project</label>
                        <select class="form-control" name="MRProject">
                            <?php foreach ($projects as $project) : ?>
                                <option value="<?php echo $project['project_code']; ?>"><?php echo $project['project_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Requester Name</label>
                        <select class="form-control" name="MRRequester">
                            <?php foreach ($users as $user) : ?>
                                <option value="<?php echo $user['useraccounts_table_id']; ?>" <?php if ($this->session->userdata('user_name') === $user['system_user_name']) echo 'selected="selected"' ?>><?php echo $user['system_user_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Select Requester Location</label>
                        <select class="form-control" name="MRRequesterLocation">
                            <?php foreach ($locations as $location) : ?>
                                <option value="<?php echo $location['locations_table_id']; ?>" <?php if ($this->session->userdata('user_location') === $location['location']) echo 'selected="selected"' ?>><?php echo $location['location']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Request Date & Time</label>
                        <input type="datetime-local" class="form-control" name="MRDateTime"
                               placeholder="Request Date & Time" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" id="btnSubmit" class="form-control btn btn-primary" value="Submit"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to submit this MR details">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="reset" class="form-control btn btn-secondary" value="Clear"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to clear all this MR details"
                                   onclick="return confirm('Are you sure, you want to clear this material request details?')">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
