var LoadSubcategoriesOne = function () {

    return {
        init: function () {

            $('#SubcategoriesOneDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'subcategory1/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "subcategory_1_code"},
                        {"data": "subcategory_1_name"},
                        {"data": "category_name"},
                        {"data": "action"}
                    ]
                }
            );
        }
    }
}();

var LoadSubcategoriesOneViewModal = function () {

    return {
        init: function () {
            this.viewPop();
        },

        getDetails: function (subcategory_one_code) {
            $.ajax({
                url: BASE_URL + "subcategory1/view/" + subcategory_one_code,
                method: "POST",
                data: {},
                success: function (data) {
                    if (data) {
                        $('#view-subcategory-one-name-header').html(data.subcategory_1_name);
                        $('#view-subcategory-one-code').html(data.subcategory_1_code);
                        $('#view-category-name').html(data.category_name);
                        $('#view-subcategory-one-name').html(data.subcategory_1_name);
                        $('#view-subcategory-one-description').html(data.subcategory_1_description);
                    }
                }
            });
        },

        viewPop: function () {
            let context = this;
            var modal = $('#view-subcategories-one-modal');

            $(document).on('click', '#view-subcategories-one-btn', function () {
                var subcategory_one_code = $(this).attr("data-subcategory-one-code");
                modal.modal({
                    keyboard: false,
                    show: true,
                    backdrop: 'static'
                });
                context.getDetails(subcategory_one_code);
            });

            modal.on('show.bs.modal', function () {
            });

            modal.on('shown.bs.modal', function () {
            });

            modal.on('hidden.bs.modal', function () {
            });
        }
    }
}();

var LoadSubcategoriesOneSaveModal = function () {

    return {
        init: function () {

            var addSubcategoryOneBtn = $('#add-subcategories-one-btn');
            var modal = $('#add-subcategories-one-modal');
            var form = $('#subcategory-one-save-form');

            addSubcategoryOneBtn.on('click', function () {
                categories();
                modal.modal({
                    keyboard: false,
                    show: true,
                    backdrop: 'static'
                });
            });

            modal.on('show.bs.modal', function () {
                $('.form-group', form).removeClass('has-danger');
                $('.form-group', form).removeClass('has-success');
                $('.form-control', form).removeClass('is-invalid');
                $('.form-control', form).removeClass('is-valid');
            });

            modal.on('shown.bs.modal', function () {
                SaveSubcategoryOne.init();
            });

            modal.on('hidden.bs.modal', function () {
                $('.form-group', form).removeClass('has-danger');
                $('.form-group', form).removeClass('has-success');
                $('.form-control', form).removeClass('is-invalid');
                $('.form-control', form).removeClass('is-valid');
                form.validate().resetForm();
            });

            function categories() {
                var categories = [];
                $.ajax({
                    url: BASE_URL + "subcategory1/create",
                    method: "POST",
                    data: {},
                    success: function (data) {
                        categories = data;
                        $.each(categories, function (index, value) {
                            $('#category_code', form).append($("<option></option>").attr("value", value["category_code"]).text(value["category_name"]));
                        });
                    }
                });
            }
        }
    }
}();

var SaveSubcategoryOne = function () {

    return {
        init: function () {
            var form = $('#subcategory-one-save-form');
            var saveBtn = $('#subcategory-one-save-btn', form);

            form.validate({
                doNotHideMessage: true,
                errorElement: 'span',
                errorClass: 'help-block invalid-feedback',
                focusInvalid: false,
                rules: {
                    subcategory_1_name: {
                        required: true,
                    }
                },

                highlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-success').addClass('has-danger');
                    $(element).closest('.form-control').removeClass('is-valid').addClass('is-invalid');
                },

                unhighlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-danger');
                    $(element).closest('.form-control').removeClass('is-invalid');
                },

                success: function (label) {
                    label.addClass('has-success').closest('.form-group').removeClass('has-danger').addClass('has-success');
                    label.addClass('is-valid').closest('.form-control').removeClass('is-invalid').addClass('is-valid');
                }

            });

            saveBtn.unbind().on('click', function () {
                if (form.valid()) {
                    var category_code = $('#category_code option:selected', form).val();
                    var subcategory_1_name = $('#subcategory_1_name', form).val();
                    var subcategory_1_description = $('#subcategory_1_description', form).val();
                    $.ajax({
                        url: BASE_URL + "Subcategory1/save",
                        method: "POST",
                        data: {
                            category_code: category_code,
                            subcategory_1_name: subcategory_1_name,
                            subcategory_1_description: subcategory_1_description
                        },
                        success: function (data) {
                            var oResponse = JSON.parse(data);
                            if (oResponse.bResponse) {
                                form.trigger('reset');
                                form.validate().resetForm();
                                form.find('.has-danger').removeClass('has-danger');
                                $('#add-subcategories-one-modal').modal('toggle');
                                ReloadSubcategoriesOne.init();
                                swal("", oResponse.sMessage, "success");
                            } else {
                                swal("", oResponse.sMessage, "error");
                            }
                        }
                    });
                }
            })
        }
    }
}();

var LoadSubcategoriesOneEditModal = function () {

    return {
        init: function () {
            this.getCategories();
            this.editModal();
        },

        getDetails: function (subcategory_one_code) {
            $.ajax({
                url: BASE_URL + "subcategory1/view/" + subcategory_one_code,
                method: "POST",
                data: {},
                success: function (data) {
                    if (data) {
                        $('#edit-subcategory-one-name-header').html(data.subcategory_1_name);
                        $('#edit_category_code').val(data.category_code);
                        $('#edit_subcategory_one_code').val(data.subcategory_1_code);
                        $('#edit_subcategory_one_name').val(data.subcategory_1_name);
                        $('#edit_subcategory_one_description').val(data.subcategory_1_description);
                    }
                }
            });
        },

        getCategories: function() {
            var form = $('#subcategory-one-update-form');

            $.ajax({
                    url: BASE_URL + "subcategory1/create",
                    method: "POST",
                    data: {},
                    success: function (data) {
                        categories = data;
                        $.each(categories, function (index, value) {
                            $('#edit_category_code', form).append($("<option></option>").attr("value", value["category_code"]).text(value["category_name"]));
                        });
                    }
                });
        },

        editModal: function () {
            let context = this;
            var modal = $('#edit-subcategories-one-modal');

            $(document).on('click', '#edit-subcategories-one-btn', function () {
                var subcategory_one_code = $(this).attr("data-subcategory-one-code");
                modal.modal({
                    keyboard: false,
                    show: true,
                    backdrop: 'static'
                });
                context.getDetails(subcategory_one_code);
            });

            modal.on('show.bs.modal', function () {
            });

            modal.on('shown.bs.modal', function () {
                UpdateCategory.init();
            });

            modal.on('hidden.bs.modal', function () {
            });
        }
    }
}();

var UpdateCategory = function () {

    return {
        init: function () {

            var form = $('#subcategory-one-update-form');
            var updateBtn = $('#subcategory-one-update-btn');

            form.validate({
                doNotHideMessage: true,
                errorElement: 'span',
                errorClass: 'help-block invalid-feedback',
                focusInvalid: false,
                rules: {
                    category_code: {
                        required: true
                    },
                    subcategory_one_name: {
                        required: true
                    }
                },

                highlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-success').addClass('has-danger');
                    $(element).closest('.form-control').removeClass('is-valid').addClass('is-invalid');
                },

                unhighlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-danger');
                    $(element).closest('.form-control').removeClass('is-invalid');
                },

                success: function (label) {
                    label.addClass('has-success').closest('.form-group').removeClass('has-danger').addClass('has-success');
                    label.addClass('is-valid').closest('.form-control').removeClass('is-invalid').addClass('is-valid');
                }

            });

            updateBtn.unbind().on('click', function () {
                if (form.valid()) {
                    var category_code = $('#edit_category_code option:selected', form).val();
                    var subcategory_1_code = $('#edit_subcategory_one_code', form).val();
                    var subcategory_1_name = $('#edit_subcategory_one_name', form).val();
                    var subcategory_1_description = $('#edit_subcategory_one_description', form).val();
                    console.log(category_code, subcategory_1_code, subcategory_1_name, subcategory_1_description);
                    $.ajax({
                        url: BASE_URL + "Subcategory1/update",
                        method: "POST",
                        data: {
                            category_code: category_code,
                            subcategory_1_code: subcategory_1_code,
                            subcategory_1_name: subcategory_1_name,
                            subcategory_1_description: subcategory_1_description
                        },
                        success: function (data) {
                            var oResponse = JSON.parse(data);
                            if (oResponse.bResponse) {
                                form.trigger('reset');
                                form.validate().resetForm();
                                form.find('.has-danger').removeClass('has-danger');
                                $('#edit-subcategories-one-modal').modal('toggle');
                                ReloadSubcategoriesOne.init();
                                swal("", oResponse.sMessage, "success");
                            } else {
                                swal("", oResponse.sMessage, "error");
                            }
                        }
                    });
                }
            })
        }
    }
}();

var LoadSubcategoriesOneDeleteModal = function () {
    return {
        init: function () {

            $(document).on('click', '#delete-subcategories-one-btn', function () {
                var subcategory_one_code = $(this).attr("data-subcategory-one-code");
                swal({
                    title: "Are you sure?",
                    text: "Once deleted, you will not be able to recover this category!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                    .then((willDelete) => {
                        if (willDelete) {
                            $.ajax({
                                url: BASE_URL + "Subcategory1/delete/"+subcategory_one_code,
                                method: "POST",
                                data: {},
                                success: function (data) {
                                    var oResponse = JSON.parse(data);
                                    if (oResponse.bResponse) {
                                        ReloadSubcategoriesOne.init();
                                        swal("", oResponse.sMessage, "success");
                                    } else {
                                        swal("", oResponse.sMessage, "error");
                                    }
                                }
                            });
                        }
                    });
            })
        }
    }
}();

var ReloadSubcategoriesOne = function () {
    return {
        init: function () {

            $('#SubcategoriesOneDataTable').DataTable().ajax.url(BASE_URL + 'subcategory1/data').load(null, false);

        }
    }
}();

jQuery(document).ready(function () {

    LoadSubcategoriesOne.init();
    LoadSubcategoriesOneViewModal.init();
    LoadSubcategoriesOneSaveModal.init();
    LoadSubcategoriesOneEditModal.init();
    LoadSubcategoriesOneDeleteModal.init();

});