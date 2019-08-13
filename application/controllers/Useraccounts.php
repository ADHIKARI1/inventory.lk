<?php
  class Useraccounts extends CI_Controller{
    public function index(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $data['users'] = $this->Useraccounts_model->get_users();

          $this->load->view('template/header');
          $this->load->view('useraccounts/index', $data);
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

    public function view($userid = 0){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $data['user'] = $this->Useraccounts_model->get_users($userid);

          $this->load->view('template/header');
          $this->load->view('useraccounts/view', $data);
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

    public function create(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $data['designations'] = $this->Useraccounts_model->get_designations();
          $data['usertypes'] = $this->Useraccounts_model->get_usertypes();
          $data['locations'] = $this->Locations_model->get_locations_by_name();

          $this->load->view('template/header');
          $this->load->view('useraccounts/create',$data);
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

    public function save(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $enc_password = md5($this->input->post('Password'));

          $config['upload_path'] = './assets/images/users';
          $config['allowed_types'] = 'gif|jpg|png';
          $config['max_size'] = '20414';
          $config['max_width'] = '600';
          $config['max_height'] = '600';
          $this->load->library('upload', $config);
          if(!$this->upload->do_upload()){
            $system_user_image = 'noimage.jpg';
          }
          else{
            $data = array('upload_data' => $this->upload->data());
            $system_user_image = $_FILES['userfile']['name'];
          }

          $success = $this->Useraccounts_model->create_user($system_user_image,$enc_password);
          if($success){
            $this->session->set_flashdata('user_create_success',"User has been saved!!!");
            redirect('useraccounts');
          }
          else{
            $this->session->set_flashdata('user_create_fail',"User name already taken!!!");
            redirect('useraccounts/create');
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

    public function edit($userid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $data['user'] = $this->Useraccounts_model->get_users($userid);
          $data['designations'] = $this->Useraccounts_model->get_designations();
          $data['usertypes'] = $this->Useraccounts_model->get_usertypes();
          $data['locations'] = $this->Locations_model->get_locations_by_name();

          $this->load->view('template/header');
          $this->load->view('useraccounts/edit', $data);
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

    public function edit_image($userid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $data['user'] = $this->Useraccounts_model->get_users($userid);

          $this->load->view('template/header');
          $this->load->view('useraccounts/edit_image', $data);
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

    public function edit_password($userid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $data['user'] = $this->Useraccounts_model->get_users($userid);

          $this->load->view('template/header');
          $this->load->view('useraccounts/edit_password', $data);
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

    public function update(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $success = $this->Useraccounts_model->update_user();
          if($success){
            $this->session->set_flashdata('user_detail_update_success',"User details has been updated!!!");
            redirect('useraccounts');
          }
          else{
            $this->session->set_flashdata('user_detail_update_fail',"User name already taken!!!");
            redirect('useraccounts');
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

    public function update_image(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $config['upload_path'] = './assets/images/users';
          $config['allowed_types'] = 'gif|jpg|png';
          $config['max_size'] = '20414';
          $config['max_width'] = '600';
          $config['max_height'] = '600';
          $this->load->library('upload', $config);

          if(!$this->upload->do_upload()){
            $system_user_image = $this->input->post('OldSystemUserImage');
          }
          else{
            $data = array('upload_data' => $this->upload->data());
            $system_user_image = $_FILES['userfile']['name'];
          }

          $success = $this->Useraccounts_model->update_user_image($system_user_image);
          if($success){
            $this->session->set_flashdata('user_image_update_success',"User image has been updated!!!");
            redirect('useraccounts');
          }
          else{
            $this->session->set_flashdata('user_image_update_fail',"User image update has been failed!!!");
            redirect('useraccounts');
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

    public function update_password(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $enc_password = md5($this->input->post('NewPassword'));
          $enc_old_password = md5($this->input->post('OldPassword'));
          $success = $this->Useraccounts_model->update_user_password($enc_password, $enc_old_password);
          if($success){
            $this->session->set_flashdata('user_password_update_success',"User password has been updated!!!");
            redirect('useraccounts');
          }
          else{
            $this->session->set_flashdata('user_password_update_fail',"User old password is incorrect!!!");
            redirect('useraccounts');
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

    public function delete($userid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 14);
        if ($permission){
          $success = $this->Useraccounts_model->delete_user($userid);
          if($success){
            $this->session->set_flashdata('user_delete_success',"User has been deleted!!!");
            redirect('useraccounts');
          }
          else{
            $this->session->set_flashdata('user_delete_fail',"This user has already been used for material requests or permissions!!!");
            redirect('useraccounts');
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
