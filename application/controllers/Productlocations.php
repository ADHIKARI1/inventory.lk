<?php

class Productlocations extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('productlocations/index');
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

    public function productLocationsData()
    {
        $aProductionLocationsData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {
                $aData = $this->Productlocations_model->get_productlocations();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "productlocations_table_id" => $aValue["productlocations_table_id"],
                        "productlocation" => $aValue["productlocation"]
                    );

                    array_push($aProductionLocationsData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aProductionLocationsData);
    }

    public function create()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {

                $this->load->view('template/header');
                $this->load->view('productlocations/create');
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {
                $success = $this->Productlocations_model->save_productlocation();
                if ($success) {
                    $this->session->set_flashdata('productlocation_save_success', "Product location has been saved!!!");
                    redirect('productlocations');
                } else {
                    $this->session->set_flashdata('productlocation_save_fail', "Product location already exists!!!");
                    redirect('productlocations/create');
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

    public function edit($productlocationid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {
                $data['productlocation'] = $this->Productlocations_model->get_productlocations($productlocationid);

                $this->load->view('template/header');
                $this->load->view('productlocations/edit', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {
                $success = $this->Productlocations_model->update_productlocation();
                if ($success) {
                    $this->session->set_flashdata('productlocation_update_success', "Product location has been updated!!!");
                    redirect('productlocations');
                } else {
                    $this->session->set_flashdata('productlocation_update_fail', "Product location already exists!!!");
                    redirect('productlocations');
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

    public function delete($productlocationid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 17);
            if ($permission) {
                $success = $this->Productlocations_model->delete_productlocation($productlocationid);
                if ($success) {
                    $this->session->set_flashdata('productlocation_delete_success', "Product location has been deleted!!!");
                    redirect('productlocations');
                } else {
                    $this->session->set_flashdata('productlocation_delete_fail', "Please delete products of this product location!!!");
                    redirect('productlocations');
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
