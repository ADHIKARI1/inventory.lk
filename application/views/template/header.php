<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SNK | Inventory Control System</title>
    <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/all.css">
    <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/style.css">
    <link rel="shortcut icon" href="<?php echo base_url(); ?>assets/favicon.png"/>
</head>
<body>
<!-- <div class="preloader"></div> -->
<input type="hidden" id="base_url" value="<?php echo base_url(); ?>">
<a href="javascript:" id="return-to-top"><i class="far fa-hand-point-up" aria-hidden="true"></i></a>
<nav class="navbar navbar-expand-xl navbar-dark sticky-top bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="<?php echo base_url(); ?>"><img class="company-logo"
                                                                      src="<?php echo base_url(); ?>assets/images/shinnippon.png"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01"
                aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarColor01">
            <ul class="navbar-nav mr-auto">
                <?php if ($this->session->userdata('logged_in')) : ?>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                           aria-haspopup="true" aria-expanded="false">Products Master</a>
                        <div class="dropdown-menu" x-placement="bottom-start"
                             style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="<?php echo base_url(); ?>categories">Categories</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>subcategory1">Sub Category 1</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>subcategory2">Sub Category 2</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>subcategory3">Sub Category 3</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>productlocations">Product
                                Locations</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>products">Products</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>suppliers">Suppliers</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                           aria-haspopup="true" aria-expanded="false">Projects Master</a>
                        <div class="dropdown-menu" x-placement="bottom-start"
                             style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="<?php echo base_url(); ?>locations">Locations</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>projects">Projects</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                           aria-haspopup="true" aria-expanded="false">MR</a>
                        <div class="dropdown-menu" x-placement="bottom-start"
                             style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="<?php echo base_url(); ?>materialrequests">Material
                                Requests</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>approvematerialrequests">
                                Material Requests For Approve</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>pendingmaterialrequests">Approved
                                Material Requests</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>itemsissue">Items Issue</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                           aria-haspopup="true" aria-expanded="false">PO</a>
                        <div class="dropdown-menu" x-placement="bottom-start"
                             style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="<?php echo base_url(); ?>purchaseorders">Saved Purchase Order</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>unsavedpurchaseorders">Unsaved Purchase Order</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>pendingpurchaseorders">Pending Purchase Order</a>
                            <!-- <a class="dropdown-item" href="<?php echo base_url(); ?>approvesitetransfer">Approve Site Transfer</a> -->
                            <a class="dropdown-item" href="<?php echo base_url(); ?>sitetransfers">Site To Site
                                Transfer</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>goodreceivenotes">GRN</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                           aria-haspopup="true" aria-expanded="false">Stock In</a>
                        <div class="dropdown-menu" x-placement="bottom-start"
                             style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="<?php echo base_url(); ?>stock-adjust">Stock Adjustments</a>
                            <a class="dropdown-item" href="<?php echo base_url(); ?>stock-in">Stock In</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>reports">Reports</a>
                    </li>
                <?php endif; ?>
            </ul>
            <ul class="navbar-nav navbar-right">
                <?php if ($this->session->userdata('user_type') == 1 && $this->session->userdata('logged_in')) : ?>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>useraccounts">User Accounts</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>userpermissions">User Permissions</a>
                    </li>
                <?php endif; ?>
                <?php if (!$this->session->userdata('logged_in')) : ?>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo base_url(); ?>userlogin">Login</a>
                    </li>
                <?php endif; ?>
                <?php if ($this->session->userdata('logged_in')) : ?>
                    <li class="nav-item dropdown">
                        <div class="btn-group">
                            <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false"><img class="index-img"
                                                                                    src="<?php echo site_url(); ?>assets/images/users/<?php echo $this->session->userdata('user_image'); ?>">
                            </button>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item">Hi <?php echo $this->session->userdata('user_name'); ?>!</a>
                                <a class="dropdown-item"><?php echo $this->session->userdata('user_location'); ?></a>
                                <a class="dropdown-item" href="<?php echo base_url(); ?>userlogin/logout">Log Out</a>
                            </div>
                        </div>
                    </li>
                <?php endif; ?>
            </ul>
        </div>
    </div>
</nav>
<?php if ($this->session->flashdata('not_logged')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('not_logged') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('login_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('login_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('login_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('login_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('access_denied')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('access_denied') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('category_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('category_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('category_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('category_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('category_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('category_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('category_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('category_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('category_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('category_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('category_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('category_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('subcategory1_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory1_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory1_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory1_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory1_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory1_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory1_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory1_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory1_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory1_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory1_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory1_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('subcategory2_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory2_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory2_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory2_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory2_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory2_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory2_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory2_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory2_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory2_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory2_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory2_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('subcategory3_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory3_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory3_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory3_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory3_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory3_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory3_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory3_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory3_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('subcategory3_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('subcategory3_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('subcategory3_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('productlocation_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('productlocation_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('productlocation_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('productlocation_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('productlocation_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('productlocation_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('productlocation_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('productlocation_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('productlocation_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('productlocation_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('productlocation_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('productlocation_delete_fail') . '</p>'; ?>
<?php endif; ?>


<?php if ($this->session->flashdata('products_transfer_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('products_transfer_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('products_transfer_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('products_transfer_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('products_adjusted_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('products_adjusted_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('products_adjusted_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('products_adjusted_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('product_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('product_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('product_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('product_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('product_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('product_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('product_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('product_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('product_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('product_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('product_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('product_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('supplier_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('supplier_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplier_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('supplier_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplier_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('supplier_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplier_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('supplier_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplierproducts_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('supplierproducts_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplierproducts_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('supplierproducts_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplier_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('supplier_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplier_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('supplier_delete_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplierproduct_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('supplierproduct_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('supplierproduct_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('supplierproduct_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('location_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('location_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('location_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('location_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('location_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('location_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('location_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('location_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('location_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('location_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('location_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('location_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('project_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('project_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('project_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('project_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('project_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('project_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('project_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('project_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('project_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('project_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('project_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('project_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('mr_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('mr_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('mr_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('mr_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('mritems_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('mritems_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('mritems_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('mritems_save_fail') . '</p>'; ?>
<?php endif; ?>
<p class="alert alert-success text-center d-none" id="success-alert"></p>
<p class="alert alert-danger text-center d-none" id="error-alert"></p>
<?php if ($this->session->flashdata('mr_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('mr_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('mr_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('mr_delete_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('mritem_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('mritem_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('mritem_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('mritem_delete_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('po_request_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('po_request_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('po_request_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('po_request_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('st_request_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('st_request_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('st_request_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('st_request_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('item_issue_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('item_issue_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('item_issue_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('item_issue_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('item_transferred_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('item_transferred_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('item_transferred_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('item_transferred_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('po_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('po_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('po_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('po_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('po_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('po_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('po_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('po_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('grn_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('grn_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('grn_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('grn_save_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('grn_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('grn_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('grn_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('grn_delete_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('deliverynote_save_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('deliverynote_save_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('deliverynote_save_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('deliverynote_save_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('user_create_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('user_create_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_create_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('user_create_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_detail_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('user_detail_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_detail_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('user_detail_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_image_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('user_image_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_image_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('user_image_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_password_update_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('user_password_update_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_password_update_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('user_password_update_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('user_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('user_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('user_delete_fail') . '</p>'; ?>
<?php endif; ?>

<?php if ($this->session->flashdata('userpermission_create_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('userpermission_create_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('userpermission_create_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('userpermission_create_fail') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('userpermission_delete_success')) : ?>
    <?php echo '<p class="alert alert-success text-center">' . $this->session->flashdata('userpermission_delete_success') . '</p>'; ?>
<?php endif; ?>
<?php if ($this->session->flashdata('userpermission_delete_fail')) : ?>
    <?php echo '<p class="alert alert-danger text-center">' . $this->session->flashdata('userpermission_delete_fail') . '</p>'; ?>
<?php endif; ?>
<div class="site-background">
    <div class="container-fluid">
        <div id="notification">
        </div>
