<div class="white-background">
    <div class="minimum-height">
        <h2>Reports</h2>
        <div class="table-responsive">
            <table id="ReportsDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Report Name</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($reports as $report) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $report['report']; ?></td>
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/reports/' . $report['reports_table_id']); ?>"
                                   class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title=""
                                   data-original-title="Click to get this report" <?php if ($report['reports_table_id'] == 5) echo 'target="_blank"'; ?>>Get
                                    Report</a>
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
