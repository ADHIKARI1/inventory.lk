<?php

class Subcategory1 extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('subcategory1/index');
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

    public function subcategoryOneIndexData()
    {
        $aSubcategoryOneData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aData = $this->Subcategory1_model->get_subcategories();

                $i = 1;
                foreach ($aData as $aValue) {

                    $sAction = "<div class='bs-component'>".
                        "<a href='javascript:;' id='view-subcategories-one-btn' class='btn btn-sm btn-primary mb-2 mr-4' data-subcategory-one-code=".$aValue["subcategory_1_code"].">View</a>".
                        "<a href='javascript:;' id='edit-subcategories-one-btn' class='btn btn-sm btn-success mb-2 mr-4' data-subcategory-one-code=".$aValue["subcategory_1_code"].">Edit</a>".
                        "<a href='javascript:;' id='delete-subcategories-one-btn' class='btn btn-sm btn-danger mb-2' data-subcategory-one-code=".$aValue["subcategory_1_code"].">Delete</a>".
                        "</div>";

                    $aCurrentRow = array(
                        "id" => $i,
                        "subcategory_1_code" => $aValue["subcategory_1_code"],
                        "subcategory_1_name" => $aValue["subcategory_1_name"],
                        "category_name" => $aValue["category_name"],
                        "action" => $sAction
                    );

                    array_push($aSubcategoryOneData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aSubcategoryOneData);
    }

    public function view($subcategoryid = NULL)
    {
        $aSubcategoryOneDetails = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aData = $this->Subcategory1_model->get_subcategories($subcategoryid);

                $aSubcategoryOneDetails = array(
                    "category_code" => $aData["category_code"],
                    "category_name" => $aData["category_name"],
                    "subcategory_1_code" => $aData["subcategory_1_code"],
                    "subcategory_1_name" => $aData["subcategory_1_name"],
                    "subcategory_1_description" => $aData["subcategory_1_description"]
                );
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aSubcategoryOneDetails);
    }

    public function create()
    {
        $aCategoryDetails = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aData = $this->Categories_model->get_categories_by_name();

                foreach ($aData as $aRow) {
                    $aCategory = array(
                        "category_code" => $aRow["category_code"],
                        "category_name" => $aRow["category_name"]
                    );

                    array_push($aCategoryDetails, $aCategory);
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aCategoryDetails);
    }

    public function save()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aFormData = array(
                    'category_code' => $_POST['category_code'],
                    'subcategory_1_name' => $_POST['subcategory_1_name'],
                    'subcategory_1_description' => (isset($_POST['subcategory_1_description'])) ? $_POST['subcategory_1_description'] : ''
                );
                $aResponse = $this->Subcategory1_model->save_subcategory($aFormData);
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

    public function edit($subcategoryid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategory'] = $this->Subcategory1_model->get_subcategories($subcategoryid);

                $this->load->view('template/header');
                $this->load->view('subcategory1/edit', $data);
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

    public function update()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aFormData = array(
                    'category_code' => $_POST['category_code'],
                    'subcategory_1_code' => $_POST['subcategory_1_code'],
                    'subcategory_1_name' => $_POST['subcategory_1_name'],
                    'subcategory_1_description' => (isset($_POST['subcategory_1_description'])) ? $_POST['subcategory_1_description'] : ''
                );
                $aResponse = $this->Subcategory1_model->update_subcategory($aFormData);
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

    public function delete($subcategoryid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aResponse = $this->Subcategory1_model->delete_subcategory($subcategoryid);
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
