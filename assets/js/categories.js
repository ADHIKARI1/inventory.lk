var LoadCategories = function () {

    return {
        init: function () {

            $('#CategoriesDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'categories/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "category_code"},
                        {"data": "category_name"},
                        {"data": "action"}
                    ]
                }
            );
        }
    }
}();

var LoadCategoryViewModal = function () {

    return {
        init: function () {
            this.viewPop();
        },

        getDetails: function (category_code) {
            $.ajax({
                url: BASE_URL + "categories/view/" + category_code,
                method: "POST",
                data: {},
                success: function (data) {
                    if (data) {
                        $('#view-category-name-header').html(data.category_name);
                        $('#view-category-code').html(data.category_code);
                        $('#view-category-name').html(data.category_name);
                        $('#view-category-description').html(data.category_description);
                    }
                }
            });
        },

        viewPop: function () {
            let context = this;
            var modal = $('#view-categories-modal');

            $(document).on('click', '#view-categories-btn', function () {
                var category_code = $(this).attr("data-category-code");
                modal.modal({
                    keyboard: false,
                    show: true,
                    backdrop: 'static'
                });
                context.getDetails(category_code);
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

var LoadCategorySaveModal = function () {

    return {
        init: function () {

            var addCategoryBtn = $('#add-categories-btn');
            var modal = $('#add-categories-modal');
            var form = $('#category-save-form');

            addCategoryBtn.on('click', function () {
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
                SaveCategory.init();
            });

            modal.on('hidden.bs.modal', function () {
                $('.form-group', form).removeClass('has-danger');
                $('.form-group', form).removeClass('has-success');
                $('.form-control', form).removeClass('is-invalid');
                $('.form-control', form).removeClass('is-valid');
                form.validate().resetForm();
            });
        }
    }
}();

var SaveCategory = function () {

    return {
        init: function () {
            var form = $('#category-save-form');
            var saveBtn = $('#category-save-btn', form);

            form.validate({
                doNotHideMessage: true,
                errorElement: 'span',
                errorClass: 'help-block invalid-feedback',
                focusInvalid: false,
                rules: {
                    category_name: {
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
                    var category_name = $('#category_name', form).val();
                    var category_description = $('#category_description', form).val();
                    $.ajax({
                        url: BASE_URL + "Categories/save",
                        method: "POST",
                        data: {
                            category_name: category_name,
                            category_description: category_description
                        },
                        success: function (data) {
                            var oResponse = JSON.parse(data);
                            if (oResponse.bResponse) {
                                form.trigger('reset');
                                form.validate().resetForm();
                                form.find('.has-danger').removeClass('has-danger');
                                $('#add-categories-modal').modal('toggle');
                                ReloadCategories.init();
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

var LoadCategoryEditModal = function () {

    return {
        init: function () {
            this.editModal();
        },

        getDetails: function (category_code) {
            $.ajax({
                url: BASE_URL + "categories/view/" + category_code,
                method: "POST",
                data: {},
                success: function (data) {
                    if (data) {
                        $('#edit-category-name-header').html(data.category_name);
                        $('#edit_category_code').val(data.category_code);
                        $('#edit_category_name').val(data.category_name);
                        $('#edit_category_description').val(data.category_description);
                    }
                }
            });
        },

        editModal: function () {
            let context = this;
            var modal = $('#edit-categories-modal');

            $(document).on('click', '#edit-categories-btn', function () {
                var category_code = $(this).attr("data-category-code");
                modal.modal({
                    keyboard: false,
                    show: true,
                    backdrop: 'static'
                });
                context.getDetails(category_code);
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

            var form = $('#category-update-form');
            var updateBtn = $('#category-update-btn');

            form.validate({
                doNotHideMessage: true,
                errorElement: 'span',
                errorClass: 'help-block invalid-feedback',
                focusInvalid: false,
                rules: {
                    category_name: {
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

            updateBtn.unbind().on('click', function () {
                if (form.valid()) {
                    var category_code = $('#edit_category_code', form).val();
                    var category_name = $('#edit_category_name', form).val();
                    var category_description = $('#edit_category_description', form).val();
                    $.ajax({
                        url: BASE_URL + "Categories/update",
                        method: "POST",
                        data: {
                            category_code: category_code,
                            category_name: category_name,
                            category_description: category_description
                        },
                        success: function (data) {
                            var oResponse = JSON.parse(data);
                            if (oResponse.bResponse) {
                                form.trigger('reset');
                                form.validate().resetForm();
                                form.find('.has-danger').removeClass('has-danger');
                                $('#edit-categories-modal').modal('toggle');
                                ReloadCategories.init();
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

var LoadCategoryDeleteModal = function () {
    return {
        init: function () {

            $(document).on('click', '#delete-categories-btn', function () {
                var category_code = $(this).attr("data-category-code");
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
                            url: BASE_URL + "Categories/delete/"+category_code,
                            method: "POST",
                            data: {},
                            success: function (data) {
                                var oResponse = JSON.parse(data);
                                if (oResponse.bResponse) {
                                    ReloadCategories.init();
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

var ReloadCategories = function () {
    return {
        init: function () {

            $('#CategoriesDataTable').DataTable().ajax.url(BASE_URL + 'categories/data').load(null, false);

        }
    }
}();

jQuery(document).ready(function () {

    LoadCategories.init();
    LoadCategoryViewModal.init();
    LoadCategorySaveModal.init();
    LoadCategoryEditModal.init();
    LoadCategoryDeleteModal.init();

});