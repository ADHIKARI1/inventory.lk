<?php

class Subcategory3 extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('subcategory3/index');
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

    public function subcategoryThreeIndexData()
    {
        $aSubcategoryThreeData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aData = $this->Subcategory3_model->get_subcategories();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "subcategory_3_code" => $aValue["subcategory_3_code"],
                        "subcategory_3_name" => $aValue["subcategory_3_name"],
                        "category_name" => $aValue["category_name"],
                        "subcategory_1_name" => $aValue["subcategory_1_name"],
                        "subcategory_2_name" => $aValue["subcategory_2_name"]
                    );

                    array_push($aSubcategoryThreeData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aSubcategoryThreeData);
    }

    public function view($subcategoryid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $data['subcategory'] = $this->Subcategory3_model->get_subcategories($subcategoryid);

                $this->load->view('template/header');
                $this->load->view('subcategory3/view', $data);
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

    public function create()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();

                $this->load->view('template/header');
                $this->load->view('subcategory3/create', $data);
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

    public function save()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $success = $this->Subcategory3_model->save_subcategory();
                if ($success) {
                    $this->session->set_flashdata('subcategory3_save_success', "Sub category 3 has been saved!!!");
                    redirect('subcategory3');
                } else {
                    $this->session->set_flashdata('subcategory3_save_fail', "Sub catgory 3 name already exists!!!");
                    redirect('subcategory3/create');
                }
            } else {
                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");
                redirect(base_url());
            }
        } else {
            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");
            redirect('userlogin');
        }
    }

    public function edit($subcategoryid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();
                $data['subcategory3'] = $this->Subcategory3_model->get_subcategories($subcategoryid);

                $this->load->view('template/header');
                $this->load->view('subcategory3/edit', $data);
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
                $success = $this->Subcategory3_model->update_subcategory();
                if ($success) {
                    $this->session->set_flashdata('subcategory3_update_success', "Sub category 3 has been updated!!!");
                    redirect('subcategory3');
                } else {
                    $this->session->set_flashdata('subcategory3_update_fail', "Sub category 3 name already exists!!!");
                    redirect('subcategory3');
                }
            } else {
                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");
                redirect(base_url());
            }
        } else {
            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");
            redirect('userlogin');
        }
    }

    public function delete($subcategoryid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $success = $this->Subcategory3_model->delete_subcategory($subcategoryid);
                if ($success) {
                    $this->session->set_flashdata('subcategory3_delete_success', "Sub category 3 has been deleted!!!");
                    redirect('subcategory3');
                } else {
                    $this->session->set_flashdata('subcategory3_delete_fail', "This sub category has already been used for products or supplier products!!!");
                    redirect('subcategory3');
                }
            } else {
                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");
                redirect(base_url());
            }
        } else {
            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");
            redirect('userlogin');
        }
    }
}

?>
