<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $report['report']; ?></h2>
        <div class="table-responsive">
            <table id="ViewLocationDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Location Name</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($locations as $location) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $location['location']; ?></td>
                        <td>
                            <div class="bs-component">
                                <a href="<?php echo site_url('/reports/locationwisestock/' . $location['locations_table_id']); ?>"
                                   class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="bottom"
                                   title="" data-original-title="Click to get this report">Get Report</a>
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
