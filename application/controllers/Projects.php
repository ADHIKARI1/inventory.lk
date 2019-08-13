<?php

class Projects extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('projects/index');
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

    public function projectIndexData()
    {
        $aProjectData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $aData = $this->Projects_model->get_projects();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "project_code" => $aValue["project_code"],
                        "project_name" => $aValue["project_name"],
                        "location" => $aValue["location"]
                    );

                    array_push($aProjectData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aProjectData);
    }

    public function view($projectid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $data['project'] = $this->Projects_model->get_projects($projectid);

                $this->load->view('template/header');
                $this->load->view('projects/view', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $data['locations'] = $this->Locations_model->get_locations_by_name();

                $this->load->view('template/header');
                $this->load->view('projects/create', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $success = $this->Projects_model->save_project();
                if ($success) {
                    $this->session->set_flashdata('project_save_success', "Project has been saved!!!");
                    redirect('projects');
                } else {
                    $this->session->set_flashdata('project_save_fail', "Project code or project name already exists!!!");
                    redirect('projects/create');
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

    public function edit($projectid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $data['locations'] = $this->Locations_model->get_locations();
                $data['project'] = $this->Projects_model->get_projects($projectid);

                $this->load->view('template/header');
                $this->load->view('projects/edit', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $success = $this->Projects_model->update_project();
                if ($success) {
                    $this->session->set_flashdata('project_update_success', "Project has been updated!!!");
                    redirect('projects');
                } else {
                    $this->session->set_flashdata('project_update_fail', "Project name already exists!!!");
                    redirect('projects');
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

    public function delete($projectid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 5);
            if ($permission) {
                $success = $this->Projects_model->delete_project($projectid);
                if ($success) {
                    $this->session->set_flashdata('project_delete_success', "Project has been deleted!!!");
                    redirect('projects');
                } else {
                    $this->session->set_flashdata('project_delete_fail', "This project has already been used for material requests!!!");
                    redirect('projects');
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
