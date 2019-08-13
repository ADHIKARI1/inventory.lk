<div class="white-background">
    <div class="minimum-height">
        <h2>Good Received Notes Report</h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = 'target="_blank"'; ?>
                    <?php echo form_open('Reports/printgrnreport', $attribute); ?>
                    <div class="form-group">
                        <label>Select Project</label>
                        <select class="form-control" name="ProjectCode">
                            <option value="0">--- Select Project ---</option>
                            <?php foreach ($projects as $project) : ?>
                                <option value="<?php echo $project['project_code']; ?>"><?php echo $project['project_name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>From Date</label>
                        <input type="date" name="FromDate" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>To Date</label>
                        <input type="date" name="ToDate" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Get Report"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to save this new category">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
