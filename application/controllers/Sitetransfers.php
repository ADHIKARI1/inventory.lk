<?php
  class Sitetransfers extends CI_Controller{
    public function index(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 11);
        if ($permission){
          $data['sitetransfers'] = $this->Sitetransfers_model->get_sitetransfers();

          $this->load->view('template/header');
          $this->load->view('sitetransfers/index', $data);
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

    public function pending_st(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 11);
        if ($permission){
          $data['sitetransfers'] = $this->Sitetransfers_model->get_pendingst();

          $this->load->view('template/header');
          $this->load->view('sitetransfers/pendingst', $data);
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

    public function issue(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 11);
        if ($permission){
          $success = $this->Sitetransfers_model->issue_items();
          if($success){
            $this->session->set_flashdata('item_issue_success',"Item has been issued!!!");
            redirect('sitetransfers');
          }
          else{
            $this->session->set_flashdata('item_issue_fail',"Item issue has been failed!!!");
            redirect('sitetransfers');
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

    public function create(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 11);
        if ($permission){
          $data['categories'] = $this->Categories_model->get_categories_by_name();
          $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
          $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();
          $data['subcategories3'] = $this->Subcategory3_model->get_subcategories_by_name();
          $data['products'] = $this->Products_model->get_products_by_name();
          $data['locations'] = $this->Locations_model->get_locations_by_name();

          $this->load->view('template/header');
          $this->load->view('sitetransfers/create', $data);
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

    public function savesitetransfer(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 11);
        if ($permission){
          $success = $this->Sitetransfers_model->transfer_items();
          if($success){
            $this->session->set_flashdata('item_transferred_success',"Item has been transferred!!!");
            redirect('sitetransfers');
          }
          else{
            $this->session->set_flashdata('item_transferred_fail',"Item transfer quantity is higher than existing quantity!!!");
            redirect('sitetransfers');
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

    public function pending_st_approve()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 11);
            if ($permission) {
                $data['sitetransfers'] = $this->Sitetransfers_model->get_pendingst();

                $this->load->view('template/header');
                $this->load->view('sitetransfers/approvest', $data);
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

    public function approve($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 19);
            if ($permission) {
                $success = $this->Sitetransfers_model->approve_st($mrid);
                if ($success) {
                    $this->session->set_flashdata('mr_approve_success', "Sitetransfer request has been approved!!!");
                    redirect('approvematerialrequests');
                } else {
                    $this->session->set_flashdata('mr_approve_fail', "Sitetransfer request approve has been failed!!!");
                    redirect('approvematerialrequests');
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
