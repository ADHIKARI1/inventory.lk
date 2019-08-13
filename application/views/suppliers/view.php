<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $supplier['supplier_name']; ?></h2>
        <hr>
        <div class="list-group">
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Code : </strong><?php echo $supplier['supplier_code']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Name : </strong><?php echo $supplier['supplier_name']; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Address
                    : </strong><?php if ($supplier['supplier_address'] != NULL) : ?><?php echo $supplier['supplier_address']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Contact Number 1
                    : </strong><?php if ($supplier['supplier_contact_no1'] != NULL) : ?><?php echo $supplier['supplier_contact_no1']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Contact Number 2
                    : </strong><?php if ($supplier['supplier_contact_no2'] != NULL) : ?><?php echo $supplier['supplier_contact_no2']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Email 1
                    : </strong><?php if ($supplier['supplier_email1'] != NULL) : ?><?php echo $supplier['supplier_email1']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Email 2
                    : </strong><?php if ($supplier['supplier_email2'] != NULL) : ?><?php echo $supplier['supplier_email2']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Fax Number 1
                    : </strong><?php if ($supplier['supplier_fax_no1'] != NULL) : ?><?php echo $supplier['supplier_fax_no1']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Fax Number 2
                    : </strong><?php if ($supplier['supplier_fax_no2'] != NULL) : ?><?php echo $supplier['supplier_fax_no2']; ?><?php else : ?> NOT AVAILABLE <?php endif; ?>
            </div>
            <div class="list-group-item list-group-item-action">
                <strong>Supplier Description : </strong><?php echo $supplier['supplier_description']; ?>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <a href="<?php echo base_url(); ?>Suppliers/edit/<?php echo $supplier['supplier_code']; ?>"
                       class="btn btn-success btn-block" data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="Click to edit this supplier details">Edit</a><br>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bs-component">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to delete this supplier?')") ?>
                    <?php echo form_open('/Suppliers/delete/' . $supplier['supplier_code'], $attribute); ?>
                    <input type="submit" class="btn btn-danger btn-block" data-toggle="tooltip" data-placement="bottom"
                           title="" data-original-title="Click to delete this supplier" value="Delete"><br>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
