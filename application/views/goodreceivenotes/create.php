<div class="white-background">
        <div class="minimum-height">
         
            <h2>Create New Good Received Note</h2>
            <hr>
            <div class="row">                        
            <div class="col-md-4 py-2">
              <div class="card rounded-0">
                <div class="card-body">
                 
                    <div class="form-group">
                      <label>Good Receieved Note Number</label>
                      <input id = "GoodReceivedNoteNo" type="text" class="form-control" name="GoodReceivedNoteNo" placeholder="Good Receieved Note Number">
                    </div>
                    <div class="form-group">
                      <label>Select Purchase Order Number</label>
                      <select id = "GrnPurchaseOrderNo" class="form-control" name="PurchaseOrderNo">
                        <option value="">--- Select PO Number ---</option>
                        <?php foreach ($purchaseorders as $purchaseorder) : ?>
                          <option value="<?php echo $purchaseorder['purchaseorder_no']; ?>"><?php echo $purchaseorder['purchaseorder_no']; ?></option>
                        <?php endforeach; ?>
                      </select>
                    </div>
                    <div class="form-group">
                      <label>Supplier Name</label>
                      <input id = "SupplierName" type="text" class="form-control" name="SupplierName" placeholder="SupplierName" readonly>
                    </div>
                    <div class="form-group">
                      <label>Good Received Date</label>
                      <input id = "GoodReceivedDate" type="date" class="form-control" name="GoodReceivedDate" placeholder="Good Received Date" required>
                    </div>
                    <!--
                    <div class="form-group">
                      <label>Good Received Quantity</label>
                      <input type="number" class="form-control" name="GoodReceivedQty" placeholder="Good Received Quantity" required>
                    </div> -->
                    <div class="form-group">
                      <label>Invoice Number</label>
                      <input id = "InvoiceNumber" type="text" class="form-control" name="InvoiceNumber" placeholder="Invoice Number">
                    </div>
                    <div class="form-group">
                      <div class="bs-component">
                        <input type="submit" id = "saveGrnData" class="form-control btn btn-primary" value="Save" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to save this new GRN">
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="bs-component">
                        <input type="reset" class="form-control btn btn-secondary" value="Clear" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to clear GRN details" onclick="return confirm('Are you sure, you want to clear this good received notes details?')">
                      </div>
                    </div>                 
                </div>
              </div>
            </div>
            <div class="col-md-8" >
            <div class="table-responsive">
              <table id="PoItemsDataTable" class="table table-hover">
                <thead>
                  <tr>                               
                    <th scope="col">MR Code</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory 1 Name</th>
                    <th scope="col">Subcategory 2 Name</th>
                    <th scope="col">Subcategory 3 Name</th> 
                    <th scope="col">Requested Qty</th> 
                    <th scope="col">Balanced Qty</th>   
                    <th scope="col">Recieved Qty</th> 
                    <th class="d-none" scope="col">Table Id</th>                    
                  </tr>
                </thead>               
              </table>
            </div>
            <?php $attribute = 'target="_blank"'; ?>
            <?php echo form_open('Reports/printgrndata', $attribute); ?>
                <div class="form-group">
                  <div class="bs-component">
                    <input type="hidden" id="rptGrnNo" name= "rptGrnNo" >
                    <input type="submit" id = "printGrnData" class="btn btn-success " value="Print" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click to print this new GRN" disabled>
                  </div>
                </div>
                <?php echo form_close(); ?>
            </div>
            </div>    
           
        
        </div>
</div>
