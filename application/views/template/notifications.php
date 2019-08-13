<?php if ($this->session->userdata('logged_in')) : ?>
    <div class="white-background">
        <div class="row mx-0">
            <?php if ($this->session->userdata('user_type') != 3) : ?>
                <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4">
                    <div class="bs-component">
                        <a href="<?php echo base_url(); ?>pendingmaterialrequests" class="notification-box"
                           data-toggle="tooltip" data-placement="bottom" title=""
                           data-original-title="Click to view pending material requests">
                          <div class="info-box">
                            <div class="col-xs-9">
                              <span class="info-box-icon bg-aqua">
                               <img class="img-fluid" style="width:80px; height:80px"
                                    src="<?php echo base_url(); ?>/assets/images/Pending MR.png">
                              </span>
                            </div>
                              <div class="col-xs-3">
                                <div class="info-box-content">
                                <span class="info-box-number">
                                  <?php echo $pendingmr; ?>
                                </span>
                                </div>
                                </div>
                          </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4">
                    <div class="bs-component">
                        <a href="<?php echo base_url(); ?>approvematerialrequests" class="notification-box"
                           data-toggle="tooltip" data-placement="bottom" title=""
                           data-original-title="Click to view pending material requests">
                            <div class="info-box">
                          <span class="info-box-icon bg-aqua">
                            <img class="img-fluid" style="width:150px; height:80px"
                                 src="<?php echo base_url(); ?>/assets/images/Approve MR.png">
                          </span>
                                <div class="info-box-content">
                                    <span class="info-box-number"><?php echo $pendingmrforapproval; ?></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4">
                    <div class="bs-component">
                        <a href="<?php echo base_url(); ?>pendingsitetransfers" class="notification-box"
                           data-toggle="tooltip" data-placement="bottom" title=""
                           data-original-title="Click to view pending site transfers">
                            <div class="info-box">
                        <span class="info-box-icon bg-aqua">
                         <img class="img-fluid" style="width:80px; height:80px"
                              src="<?php echo base_url(); ?>/assets/images/Pending Site Transfers.png">
                        </span>
                                <div class="info-box-content">
                                    <span class="info-box-number"><?php echo $pendingst; ?></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            <?php endif; ?>
            <?php if ($this->session->userdata('user_type') != 2) : ?>
                <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4">
                    <div class="bs-component">
                        <a href="<?php echo base_url(); ?>unsavedpurchaseorders" class="notification-box"
                           data-toggle="tooltip" data-placement="bottom" title=""
                           data-original-title="Click to view unsaved purchase orders">
                            <div class="info-box">
                        <span class="info-box-icon bg-aqua">
                          <img class="img-fluid" style="width:80px; height:80px"
                               src="<?php echo base_url(); ?>/assets/images/Unsaved PO.png">
                        </span>
                                <div class="info-box-content">
                                    <span class="info-box-number"><?php echo $unsavedpo; ?></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 col-xs-4">
                    <div class="bs-component">
                        <a href="<?php echo base_url(); ?>pendingpurchaseorders" class="notification-box"
                           data-toggle="tooltip" data-placement="bottom" title=""
                           data-original-title="Click to view pending purchase orders">
                            <div class="info-box">
                        <span class="info-box-icon bg-aqua">
                          <img class="img-fluid" style="width:80px; height:80px"
                               src="<?php echo base_url(); ?>/assets/images/Pending PO.png">
                        </span>
                                <div class="info-box-content">
                                    <span class="info-box-number"><?php echo $pendingpo; ?></span>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </div>
<?php endif; ?>
