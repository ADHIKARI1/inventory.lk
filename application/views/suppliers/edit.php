<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $supplier['supplier_name']; ?></h2>
        <hr>
        <div class="col-md-6 py-2">
            <div class="card rounded-0">
                <div class="card-body">
                    <?php $attribute = array('onsubmit' => "return confirm('Are you sure, you want to update this supplier details?')") ?>
                    <?php echo form_open('Suppliers/update', $attribute); ?>
                    <div class="form-group">
                        <label>Supplier Code</label>
                        <input type="text" class="form-control" name="SupplierCode" placeholder="Supplier Code"
                               value="<?php echo $supplier['supplier_code']; ?>" readonly="">
                    </div>
                    <div class="form-group">
                        <label>Supplier Name</label>
                        <input type="text" class="form-control" name="SupplierName" placeholder="Supplier Name"
                               value="<?php echo $supplier['supplier_name']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Supplier Address</label>
                        <textarea class="form-control" name="SupplierAddress" placeholder="Supplier Address"
                                  required><?php echo $supplier['supplier_address']; ?></textarea>
                    </div>
                    <div class="form-group">
                        <label>Supplier Contact Number 1</label>
                        <input type="text" class="form-control" name="SupplierContact1"
                               placeholder="Supplier Contact Number 1" pattern="(?=.*\d).{10}"
                               title="Must contain numbers only, and the length is 10"
                               value="<?php echo $supplier['supplier_contact_no1']; ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Supplier Contact Number 2</label>
                        <input type="text" class="form-control" name="SupplierContact2"
                               placeholder="Supplier Contact Number 2" pattern="(?=.*\d).{10}"
                               title="Must contain numbers only, and the length is 10"
                               value="<?php echo $supplier['supplier_contact_no2']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Supplier Email 1</label>
                        <input type="email" class="form-control" name="SupplierEmail1" placeholder="Supplier Email 1"
                               value="<?php echo $supplier['supplier_email1']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Supplier Email 2</label>
                        <input type="email" class="form-control" name="SupplierEmail2" placeholder="Supplier Email 2"
                               value="<?php echo $supplier['supplier_email2']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Supplier Fax Number 1</label>
                        <input type="text" class="form-control" name="SupplierFax1" placeholder="Supplier Fax Number 1"
                               pattern="(?=.*\d).{10}" title="Must contain numbers only, and the length is 10"
                               value="<?php echo $supplier['supplier_fax_no1']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Supplier Fax Number 2</label>
                        <input type="text" class="form-control" name="SupplierFax2" placeholder="Supplier Fax Number 2"
                               pattern="(?=.*\d).{10}" title="Must contain numbers only, and the length is 10"
                               value="<?php echo $supplier['supplier_fax_no2']; ?>">
                    </div>
                    <div class="form-group">
                        <label>Supplier Description</label>
                        <textarea class="form-control" name="SupplierDescription" rows="5"
                                  placeholder="Supplier Description"
                                  required><?php echo $supplier['supplier_description']; ?></textarea>
                    </div>
                    <div class="form-group">
                        <div class="bs-component">
                            <input type="submit" class="form-control btn btn-primary" value="Save Changes"
                                   data-toggle="tooltip" data-placement="bottom" title=""
                                   data-original-title="Click to update this supplier details">
                        </div>
                    </div>
                    <?php echo form_close(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
