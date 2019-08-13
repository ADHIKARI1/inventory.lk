<?php

class Subcategory2 extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('subcategory2/index');
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

    public function subcategoryTwoIndexData()
    {
        $aSubcategoryTwoData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $aData = $this->Subcategory2_model->get_subcategories();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "subcategory_2_code" => $aValue["subcategory_2_code"],
                        "subcategory_2_name" => $aValue["subcategory_2_name"],
                        "category_name" => $aValue["category_name"],
                        "subcategory_1_name" => $aValue["subcategory_1_name"]
                    );

                    array_push($aSubcategoryTwoData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aSubcategoryTwoData);
    }

    public function view($subcategoryid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 2);
            if ($permission) {
                $data['subcategory'] = $this->Subcategory2_model->get_subcategories($subcategoryid);

                $this->load->view('template/header');
                $this->load->view('subcategory2/view', $data);
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
                $data['subcategories'] = $this->Subcategory1_model->get_subcategories_by_name();

                $this->load->view('template/header');
                $this->load->view('subcategory2/create', $data);
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
                $success = $this->Subcategory2_model->save_subcategory();
                if ($success) {
                    $this->session->set_flashdata('subcategory2_save_success', "Sub category 2 has been saved!!!");
                    redirect('subcategory2');
                } else {
                    $this->session->set_flashdata('subcategory2_save_fail', "Sub category 2 name already exists!!!");
                    redirect('subcategory2/create');
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
                $data['subcategories'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategory2'] = $this->Subcategory2_model->get_subcategories($subcategoryid);

                $this->load->view('template/header');
                $this->load->view('subcategory2/edit', $data);
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
                $success = $this->Subcategory2_model->update_subcategory();
                if ($success) {
                    $this->session->set_flashdata('subcategory2_update_success', "Sub category 2 has been updated!!!");
                    redirect('subcategory2');
                } else {
                    $this->session->set_flashdata('subcategory2_update_fail', "Sub category 2 name already exists!!!");
                    redirect('subcategory2');
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
                $success = $this->Subcategory2_model->delete_subcategory($subcategoryid);
                if ($success) {
                    $this->session->set_flashdata('subcategory2_delete_success', "Sub category 2 has been deleted!!!");
                    redirect('subcategory2');
                } else {
                    $this->session->set_flashdata('subcategory2_delete_fail', "This sub category has already been used for products, supplier products or sub category 3!!!");
                    redirect('subcategory2');
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
