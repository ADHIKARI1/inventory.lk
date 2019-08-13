<?php
  class Userlogin extends CI_Controller{
    public function index(){
      $this->load->view('template/header');
      $this->load->view('userlogin/index');
      $this->load->view('template/footer');
    }

    public function login(){
      if (!$this->session->userdata('logged_in')){
        $username = $this->input->post('UserName');
        $password = md5($this->input->post('Password'));

        $userid = $this->Userlogin_model->login($username, $password);

        if($userid){
          $user_data = array(
            'user_id' => $userid['useraccounts_table_id'],
            'user_name' => $userid['system_user_name'],
            'user_type' => $userid['user_type'],
            'user_image' => $userid['system_user_image'],
            'user_location' => $userid['location'],
            'logged_in' => true
          );

          $this->session->set_userdata($user_data);

          $this->session->set_flashdata('login_success','Login succeed!!!');
          redirect(base_url());
        }
        else{
          $this->session->set_flashdata('login_fail','Bad user credentials, login failed!!!');
          redirect('userlogin');
        }
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect(base_url());
      }
    }

    public function logout(){
      if ($this->session->userdata('logged_in')){
        $this->session->unset_userdata('user_id');
        $this->session->unset_userdata('user_name');
        $this->session->unset_userdata('user_type');
        $this->session->unset_userdata('user_image');
        $this->session->unset_userdata('logged_in');

        $this->session->set_flashdata('logout_success','Logout Sucessed!!!');
        redirect('userlogin');
      }
      else{
        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
        redirect('userlogin');
      }
    }
  }
?>
