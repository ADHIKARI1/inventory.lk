var LoadProjects = function () {

    return {
        init: function () {

            $('#ProjectsDataTable').DataTable(
                {
                    "pageLength": 50,
                    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                    "ajax": {
                        "url": BASE_URL + 'projects/data',
                    },
                    "columns": [
                        {"data": "id"},
                        {"data": "project_code"},
                        {"data": "project_name"},
                        {"data": "location"},
                        {
                            "render": function (data, type, full) {
                                return "<div class='bs-component'>" +
                                    "<a href=" + BASE_URL + 'projects/' + full['project_code'] + " class='btn btn-primary btn-block' data-toggle='tooltip' data-placement='bottom' title='' data-original-title='Click to view this project'>View</a>" +
                                    "</div>";
                            }
                        }
                    ]
                }
            );
        }
    }
}();

jQuery(document).ready(function () {

    LoadProjects.init();

});