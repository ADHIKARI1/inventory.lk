<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $materialrequest['materialrequest_code']; ?>
            - <?php echo $materialrequest['project_name']; ?></h2>
        <hr>        
        <br>
        <div class="table-responsive">           
            <table id="DataTable" class="table table-hover">
             <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory 1 Name</th>
                    <th scope="col">Subcategory 2 Name</th>
                    <th scope="col">Subcategory 3 Name</th>
                    <th scope="col">Existing Quantity</th>
                    <th scope="col">Requested Quantity</th>
                    <th scope="col">Balanced Quantity</th>
                    <th scope="col">Status</th>                    
                </tr>
                </thead>
                <tbody>
                  <?php foreach($materialrequestitems as $materialrequestitem) : ?>
                    <tr>
                      <td><?php echo $count; ?>. </td>                      
                      <td><?php echo $materialrequestitem['product_name']; ?></td>
                      <td><?php echo $materialrequestitem['category_name']; ?></td>
                      <td><?php echo $materialrequestitem['subcategory_1_name']; ?></td>
                      <td><?php echo $materialrequestitem['subcategory_2_name']; ?></td>
                      <td><?php echo $materialrequestitem['subcategory_3_name']; ?></td>
                       <td><?php echo $materialrequestitem['stock_qty']; ?></td>
                      <td><?php echo $materialrequestitem['quantity_type']; ?> <?php echo $materialrequestitem['requested_quantity']; ?></td>
                      <td><?php echo $materialrequestitem['quantity_type']; ?> <?php echo $materialrequestitem['balanced_quantity']; ?></td>
                      <td>
                        <?php if($materialrequestitem['status'] == "Pending") : ?>
                        <span class="text-danger"><?php echo $materialrequestitem['status']; ?></span><?php else : ?>
                        <span class="text-success"><?php echo $materialrequestitem['status']; ?></span><?php endif; ?>                        
                      </td>          
                                    
                    </tr>
                    <?php $count++; ?>
                  <?php endforeach; ?>
                </tbody>
            </table>            
        </div>
    </div>
</div>


