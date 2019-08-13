<div class="white-background">
    <div class="minimum-height">
        <h1 class="text-center">Shin Nippon Lanka (Pvt) Ltd - Inventory Control System</h1>
        <hr>
        <?php if ($this->session->userdata('logged_in')) : ?>
            <div class="index-page">
                <h2>Current Stock - <?php echo $this->session->userdata('user_location'); ?></h2>
                <div class="table-responsive">
                    <table id="CurrentLocationStockDataTable" class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Product Code</th>
                            <th scope="col">Category Name</th>
                            <th scope="col">Subcategory1 Name</th>
                            <th scope="col">Subcategory2 Name</th>
                            <th scope="col">Subcategory3 Name</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Product Location</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="index-page">
                <h2>Current Stock - All Locations</h2>
                <div class="table-responsive">
                    <table id="OtherLocationsStockDataTable" class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Product Code</th>
                            <th scope="col">Category Name</th>
                            <th scope="col">Subcategory1 Name</th>
                            <th scope="col">Subcategory2 Name</th>
                            <th scope="col">Subcategory3 Name</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Location</th>
                            <th scope="col">Product Location</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        <?php else : ?>
            <h2>Current Stock - All Locations</h2>
            <div class="table-responsive">
                <table id="AllLocationsStockDataTable" class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Product Code</th>
                        <th scope="col">Category Name</th>
                        <th scope="col">Subcategory1 Name</th>
                        <th scope="col">Subcategory2 Name</th>
                        <th scope="col">Subcategory3 Name</th>
                        <th scope="col">Product Name</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Location</th>
                        <th scope="col">Product Location</th>
                    </tr>
                    </thead>
                </table>
            </div>
        <?php endif; ?>
    </div>
</div>
