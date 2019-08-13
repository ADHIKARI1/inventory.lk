<?php
  class Userpermissions extends CI_Controller{
    public function index(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 15);
        if ($permission){
          $data['users'] = $this->Useraccounts_model->get_users();

          $this->load->view('template/header');
          $this->load->view('userpermissions/index', $data);
          $this->load->view('template/footer');
        }
        else{
          $this->session->set_flashdata('access_denied',"You don't have permission to this module!!!");
          redirect(base_url());
        }
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect('userlogin');
      }
    }

    public function view($userid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 15);
        if ($permission){
          $data['user'] = $this->Useraccounts_model->get_users($userid);
          $data['userpermissions'] = $this->Userpermissions_model->get_userpermissions($userid);

          $this->load->view('template/header');
          $this->load->view('userpermissions/view', $data);
          $this->load->view('template/footer');
        }
        else{
          $this->session->set_flashdata('access_denied',"You don't have permission to this module!!!");
          redirect(base_url());
        }
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect('userlogin');
      }
    }

    public function create($userid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 15);
        if ($permission){
          $data['user'] = $this->Useraccounts_model->get_users($userid);
          $data['permissions'] = $this->Userpermissions_model->get_permissions_by_name();

          $this->load->view('template/header');
          $this->load->view('userpermissions/create', $data);
          $this->load->view('template/footer');
        }
        else{
          $this->session->set_flashdata('access_denied',"You don't have permission to this module!!!");
          redirect(base_url());
        }
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect('userlogin');
      }
    }

    public function savepermission(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 15);
        if ($permission){
          $success = $this->Userpermissions_model->save_user_permission();
          if($success){
            $this->session->set_flashdata('userpermission_create_success',"User permissions have been saved!!!");
            redirect('userpermissions');
          }
          else{
            $this->session->set_flashdata('userpermission_create_fail',"User permissions save have been failed!!!");
            redirect('userpermissions');
          }
        }
        else{
          $this->session->set_flashdata('access_denied',"You don't have permission to this module!!!");
          redirect(base_url());
        }
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect('userlogin');
      }
    }

    public function deletepermission($tableid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 15);
        if ($permission){
          $success = $this->Userpermissions_model->delete_userpermission($tableid);
          if($success){
            $this->session->set_flashdata('userpermission_delete_success',"User permission has been removed!!!");
            redirect('userpermissions');
          }
          else{
            $this->session->set_flashdata('userpermission_delete_fail',"User permission remove has been failed!!!");
            redirect('userpermissions');
          }
        }
        else{
          $this->session->set_flashdata('access_denied',"You don't have permission to this module!!!");
          redirect(base_url());
        }
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect('userlogin');
      }
    }
  }
 ?>
