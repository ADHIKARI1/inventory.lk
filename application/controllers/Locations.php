<?php

class Locations extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('locations/index');
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

    public function locationIndexData()
    {
        $aLocationsData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {
                $aData = $this->Locations_model->get_locations();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "locations_table_id" => $aValue["locations_table_id"],
                        "location" => $aValue["location"]
                    );

                    array_push($aLocationsData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aLocationsData);
    }

    public function create()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {

                $this->load->view('template/header');
                $this->load->view('locations/create');
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {
                $success = $this->Locations_model->save_location();
                if ($success) {
                    $this->session->set_flashdata('location_save_success', "Location has been saved!!!");
                    redirect('locations');
                } else {
                    $this->session->set_flashdata('location_save_fail', "Location already exists!!!");
                    redirect('locations/create');
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

    public function edit($locationid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {
                $data['location'] = $this->Locations_model->get_locations($locationid);

                $this->load->view('template/header');
                $this->load->view('locations/edit', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {
                $success = $this->Locations_model->update_location();
                if ($success) {
                    $this->session->set_flashdata('location_update_success', "Location has been updated!!!");
                    redirect('locations');
                } else {
                    $this->session->set_flashdata('location_update_fail', "Location already exists!!!");
                    redirect('locations');
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

    public function delete($locationid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 4);
            if ($permission) {
                $success = $this->Locations_model->delete_location($locationid);
                if ($success) {
                    $this->session->set_flashdata('location_delete_success', "Location has been deleted!!!");
                    redirect('locations');
                } else {
                    $this->session->set_flashdata('location_delete_fail', "This location has already been used for projects, user accounts, purchase orders or site stock!!!");
                    redirect('locations');
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
