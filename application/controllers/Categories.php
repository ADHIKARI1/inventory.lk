<?php

class Categories extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 1);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('categories/index');
                $this->load->view('template/footer');
            } else {
                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");
                redirect(base_url());
            }
        } else {
            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");
            redirect('userlogin');
        }
    }

    public function categoryIndexData()
    {
        $aCategoryData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 1);
            if ($permission) {
                $aData = $this->Categories_model->get_categories();

                $i = 1;
                foreach ($aData as $aValue) {

                    $sAction = "<div class='bs-component'>".
                                "<a href='javascript:;' id='view-categories-btn' class='btn btn-sm btn-primary mb-2 mr-4' data-category-code=".$aValue["category_code"].">View</a>".
                                "<a href='javascript:;' id='edit-categories-btn' class='btn btn-sm btn-success mb-2 mr-4' data-category-code=".$aValue["category_code"].">Edit</a>".
                                "<a href='javascript:;' id='delete-categories-btn' class='btn btn-sm btn-danger mb-2' data-category-code=".$aValue["category_code"].">Delete</a>".
                                "</div>";

                    $aCurrentRow = array(
                        "id" => $i,
                        "category_table_id" => $aValue["categories_table_id"],
                        "category_code" => $aValue["category_code"],
                        "category_name" => $aValue["category_name"],
                        "action" => $sAction
                    );

                    array_push($aCategoryData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aCategoryData);
    }

    public function view($categoryid = NULL)
    {
        $aCategoryDetails = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 1);
            if ($permission) {
                $aData = $this->Categories_model->get_categories($categoryid);
                $aCategoryDetails = array(
                    "category_code" => $aData["category_code"],
                    "category_name" => $aData["category_name"],
                    "category_description" => $aData["category_description"]
                );
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aCategoryDetails);
    }

    public function save()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 1);
            if ($permission) {
                $aFormData = array(
                    'category_name' => $_POST['category_name'],
                    'category_description' => (isset($_POST['category_description'])) ? $_POST['category_description'] : ''
                );
                $aResponse = $this->Categories_model->save_category($aFormData);
                if ($aResponse["bResponseStatus"]) {
                    $aMessage = array(
                        'bResponse' => $aResponse["bResponseStatus"],
                        'sMessage' => $aResponse["sResponseMessage"]
                    );
                } else {
                    $aMessage = array(
                        'bResponse' => $aResponse["bResponseStatus"],
                        'sMessage' => $aResponse["sResponseMessage"]
                    );
                }
            } else {
                $aMessage = array(
                    'bResponse' => false,
                    'sMessage' => "You don't have permission to this module!!!"
                );
            }
        } else {
            $aMessage = array(
                'bResponse' => false,
                'sMessage' => "Please login before access this module!!!"
            );
        }

        echo json_encode($aMessage);
    }

    public function update()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 1);
            if ($permission) {
                $aFormData = array(
                    'category_code' => $_POST['category_code'],
                    'category_name' => $_POST['category_name'],
                    'category_description' => (isset($_POST['category_description'])) ? $_POST['category_description'] : ''
                );
                $aResponse = $this->Categories_model->update_category($aFormData);
                if ($aResponse["bResponseStatus"]) {
                    $aMessage = array(
                        'bResponse' => $aResponse["bResponseStatus"],
                        'sMessage' => $aResponse["sResponseMessage"]
                    );
                } else {
                    $aMessage = array(
                        'bResponse' => $aResponse["bResponseStatus"],
                        'sMessage' => $aResponse["sResponseMessage"]
                    );
                }
            } else {
                $aMessage = array(
                    'bResponse' => false,
                    'sMessage' => "You don't have permission to this module!!!"
                );
            }
        } else {
            $aMessage = array(
                'bResponse' => false,
                'sMessage' => "Please login before access this module!!!"
            );
        }

        echo json_encode($aMessage);
    }

    public function delete($categoryid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 1);
            if ($permission) {
                $aResponse = $this->Categories_model->delete_category($categoryid);
                if ($aResponse["bResponseStatus"]) {
                    $aMessage = array(
                        'bResponse' => $aResponse["bResponseStatus"],
                        'sMessage' => $aResponse["sResponseMessage"]
                    );
                } else {
                    $aMessage = array(
                        'bResponse' => $aResponse["bResponseStatus"],
                        'sMessage' => $aResponse["sResponseMessage"]
                    );
                }
            } else {
                $aMessage = array(
                    'bResponse' => false,
                    'sMessage' => "You don't have permission to this module!!!"
                );
            }
        } else {
            $aMessage = array(
                'bResponse' => false,
                'sMessage' => "Please login before access this module!!!"
            );
        }

        echo json_encode($aMessage);
    }
}

?>
