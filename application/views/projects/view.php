<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $project['project_name']; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Project Code : </strong><?php echo $project['project_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Project Name : </strong><?php echo $project['project_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Project Location : </strong><?php echo $project['location']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Project Description : </strong><?php echo $project['project_description']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <a href="<?php echo base_url(); ?>Projects/edit/<?php echo $project['project_code']; ?>"
                       class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="Click to edit this project details">Edit</a><br>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this project?')") ?>
                    <?php echo form_open('/Projects/delete/' . $project['project_code'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this project" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
