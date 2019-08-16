<div class="white-background">
    <div class="minimum-height">
        <h2><?php echo $title['location']; ?></h2>
        <hr>
        <div class="table-responsive">
            <table id="AdjustProductsDataTable" class="table table-hover">
                <?php $count = 1; ?>
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Product Code</th>
                    <th scope="col">Category Name</th>
                    <th scope="col">Subcategory1 Name</th>
                    <th scope="col">Subcategory2 Name</th>
                    <th scope="col">Subcategory3 Name</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Existing Quantity</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($products as $product) : ?>
                    <tr>
                        <td><?php echo $count; ?>.</td>
                        <td><?php echo $product['product_code']; ?></td>
                        <td><?php echo $product['category_name']; ?></td>
                        <td><?php echo $product['subcategory_1_name']; ?></td>
                        <td><?php echo $product['subcategory_2_name']; ?></td>
                        <td><?php echo $product['subcategory_3_name']; ?></td>
                        <td><?php echo $product['product_name']; ?></td>
                        <td><?php echo $product['quantity_type']; ?><?php echo $product['quantity']; ?></td>
                        <td>                            
                            <div class="form-group">
                                <input type="number" name="<?php echo $count; ?>Quantity" step="0.01" value="0.00" class="form-control"
                                       min="0">                                
                            </div>
                            <div class="form-group">
                                <div class="bs-component">
                                    <input type="submit"  id="<?php echo $product['stocks_table_id']; ?>" data-count = "<?php echo $count; ?>"  class="form-control btn btn-primary btn-stock-adjust"
                                           value="Adjust" data-toggle="tooltip" data-placement="bottom" title=""
                                           data-original-title="Click to adjust this product quantity">
                                </div>
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

