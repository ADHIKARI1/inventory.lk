</div>
</div>
</div>
<footer class="bg-primary">
    <div class="text-center">
        Licensed To : Shin Nippon Lanka (Pvt) Ltd <br> Powered By Victory Information (Pvt) Ltd <br> Version 1.0.0 <br>
        &copy <?php echo date("Y"); ?> - All Rights Reserved
    </div>
</footer>
<script src="<?php echo base_url(); ?>assets/js/jquery-3.3.1.slim.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/jquery.validate.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/popper.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/bootstrap.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/jquery.dataTables.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/filterselect.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/sweetalert.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/custom.js"></script>
<script type="text/javascript">
    var BASE_URL = "<?php echo base_url(); ?>";
</script>
<script src="<?php echo base_url(); ?>assets/js/<?php echo strtolower($this->router->fetch_class()); ?>.js"></script>
<script type="text/javascript">


    //var table = $('#data_table').DataTable();//End of create main table
    //var table = $('#data_table').DataTable();
    var table_len;
    var set_numbers = function () {
        table_len = $('#data_table tbody tr').length + 1;
    };

    set_numbers();


    function Clear() {
        // $('#MRCode').val('');
        $('#select-cat').val('00');
        $('#select-sub1').val('00');
        $('#select-sub2').val('00');
        $('#select-sub3').val('00');
        $('#select-product').val('');
        $('#MRItemQty').val('');
        //$('#QuantityType').val('');
    }


    $('#add_data').click(function () {

        function check_pro(product_id) {
            var aIsExist = [];
            var bIsExist = null;
            $('#data_table tr').each(function (row, tr) {

                if ($(tr).find('input[name=product_val]').val() === product_id) {
                    bIsExist = true;
                } else {
                    bIsExist = false;
                }
                aIsExist.push(bIsExist);


            });
            if (aIsExist.includes(true)) {
                return true;
            } else {
                return false;
            }
        }

        var MRCode = $('#MRCode').val();
        var CatVal = $('#select-cat').val();
        var Cat = $('#select-cat option:selected').text();
        var Sub1Val = $('#select-sub1').val();
        var Sub1 = $('#select-sub1 option:selected').text();
        var Sub2Val = $('#select-sub2').val();
        var Sub2 = $('#select-sub2 option:selected').text();
        var Sub3Val = $('#select-sub3').val();
        var Sub3 = $('#select-sub3 option:selected').text();
        var ProductVal = $('#select-product').val();
        var Product = $('#select-product option:selected').text();
        var MRItemQty = $('#MRItemQty').val();
        var QuantityType = $('#QuantityType').val();

        if (MRCode && Cat && Sub1 && Sub2 && Sub3 && Product && MRItemQty && QuantityType) {
            if (!check_pro(ProductVal)) {
                $('#data_table tbody:last-child').append(
                    '<tr>' +
                    '<td>' + MRCode + '</td>' +
                    '<td>' + Cat + ' <input type="hidden" name="cat_val" id="cat_val" value="' + CatVal + '"> </td>' +
                    '<td>' + Sub1 + ' <input type="hidden" name="sub1_val" id="sub1_val" value="' + Sub1Val + '"> </td>' +
                    '<td>' + Sub2 + ' <input type="hidden" name="sub2_val" id="sub2_val" value="' + Sub2Val + '"> </td>' +
                    '<td>' + Sub3 + ' <input type="hidden" name="sub3_val" id="sub3_val" value="' + Sub3Val + '"> </td>' +
                    '<td>' + Product + ' <input type="hidden" name="product_val" id="product_val" value="' + ProductVal + '"> </td>' +
                    '<td>' + MRItemQty + '</td>' +
                    '<td>' + QuantityType + '</td>' +
                    '<td> <input type="submit" id="remove_btn' + table_len + '" class="btn btn-danger" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Click here to remove this record!" value="X"></td>' +
                    '<tr>'
                );
            }
            //Clear();
        }
        $('#remove_btn' + table_len).on('click', function (e) {
            e.preventDefault();
            $(this).parents('tr').remove();
        });
        set_numbers();
        //reset Form
        $('#addItemForm')[0].reset();  

    });


    $('#save_added_data').click(function () {
        if (table_len > 1) {
            var table_data = [];

            $('#data_table tr').each(function (row, tr) {

                function check() {
                    if ($(tr).find('td:eq(0)').text() == "" || $(tr).find('td:eq(0)').text() === undefined)
                        return false;
                    if ($(tr).find('input[name=cat_val]').val() == "" || $(tr).find('input[name=cat_val]').val() === undefined)
                        return false;
                    if ($(tr).find('input[name=product_val]').val() == "" || $(tr).find('input[name=product_val]').val() === undefined || $(tr).find('input[name=product_val]').val() == "0000000000")
                        return false;

                    return true;
                }

                if (check()) {
                    var sub = {
                        'MRCode': $(tr).find('td:eq(0)').text(),
                        'Cat': $(tr).find('input[name=cat_val]').val(),
                        'Sub1': $(tr).find('input[name=sub1_val]').val(),
                        'Sub2': $(tr).find('input[name=sub2_val]').val(),
                        'Sub3': $(tr).find('input[name=sub3_val]').val(),
                        'Product': $(tr).find('input[name=product_val]').val(),
                        'MRItemQty': $(tr).find('td:eq(6)').text(),
                        'QuantityType': $(tr).find('td:eq(7)').text()
                    };
                    table_data.push(sub);
                }
            });
            //console.log(table_data);

             //var debug_url = '?XDEBUG_SESSION_START={{session('9000')}}';

            var data = {'data_table': table_data};
            $.ajax({
                type: "POST",
                url: "<?php echo base_url('Materialrequests/savemritems'); ?>",
                data: data,
                crossOrigin: false,
                dataType: "json",
                success: function (response) {
                    //$('#data_table').DataTable().rows().remove().draw();
                    $('#data_table tbody tr').remove();
                    $('#error-alert').removeClass('d-none');
                    $('#success-alert').removeClass('d-none');
                    if (response['type'] === 'success') {
                        $('#success-alert').html(response['message']);
                        $('#error-alert').addClass('d-none');
                    } else {
                        $('#error-alert').html(response['message']);
                        $('#success-alert').addClass('d-none');
                    }
                    $("html, body").animate({scrollTop: 0}, 200);
                },
                error: function (error) {
                     $('#data_table tbody tr').remove();
                    $('#error-alert').removeClass('d-none');
                    $('#success-alert').removeClass('d-none');
                    $('#error-alert').html(response['message']);
                    $('#success-alert').addClass('d-none');
                    $('#error-alert').addClass('d-block');
                    $("html, body").animate({scrollTop: 0}, 200);
                }
            });


        }
    });

//    //For Request PO Data Table
//    var table_1 = $('#DataTable').DataTable({
//        'columns': [
//            null,
//            null,
//            null,
//            null,
//            null,
//            null,
//            null,
//            null,
//            null,
//            null,
//            {'visible': false}
//        ]
//    });
//
//    $('#DataTable tbody').on('click', 'tr', function () {
//        $(this).toggleClass('selected');
//
//    });
//
//    $('#request_po').click(function () {
//        var po_table_data = [];
//        $.each(table_1.rows('.selected').data(), function (row, tr) {
//            var data_table = {
//                'table_id': tr[10]
//            };
//            po_table_data.push(data_table);
//        });
//
////console.log(po_table_data);
//
//
//        var data = {'data_table': po_table_data};
//        $.ajax({
//            type: "POST",
//            url: "<?php //echo base_url('Materialrequests/requestpo'); ?>//",
//            data: data,
//            crossOrigin: false,
//            dataType: "json",
//            success: function (response) {
//                $('#error-alert').removeClass('d-none');
//                $('#success-alert').removeClass('d-none');
//                if (response['type'] === 'success') {
//                    $('#success-alert').html(response['message']);
//                    $('#error-alert').addClass('d-none');
//                } else {
//                    $('#error-alert').html(response['message']);
//                    $('#success-alert').addClass('d-none');
//                }
//                $("html, body").animate({scrollTop: 0}, 200);
//            },
//            error: function (error) {
//                $('#error-alert').removeClass('d-none');
//                $('#success-alert').removeClass('d-none');
//                $('#error-alert').html(error['message']);
//                $('#success-alert').addClass('d-none');
//                $('#error-alert').addClass('d-block');
//                $("html, body").animate({scrollTop: 0}, 200);
//            }
//
//
//        });
//
//    });


</script>

<script type="text/javascript">

    function ClearText() {
        $("#CategoryName").val("");
    }


</script>


</body>
</html>
