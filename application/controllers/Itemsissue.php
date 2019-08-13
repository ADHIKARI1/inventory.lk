<?php
  class Itemsissue extends CI_Controller{
    public function index(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 12);
        if ($permission){
          $data['materialrequests'] = $this->Materialrequests_model->get_pendingmr();

          $this->load->view('template/header');
          $this->load->view('itemsissue/index', $data);
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

    public function view($mrid = NULL){

      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 12);
        if ($permission){
          $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);
          $data['materialrequestitems'] = $this->Materialrequests_model->get_pendingmritems($mrid);

          $this->load->view('template/header');
          $this->load->view('itemsissue/view', $data);
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

    public function issueitems($tableid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 12);
        if ($permission){
          $success = $this->Itemsissue_model->issue_items($tableid);
          if($success){
            $this->session->set_flashdata('item_issue_success',"Item has been issued!!!");
            redirect('itemsissue');
          }
          else{
            $this->session->set_flashdata('item_issue_fail',"Item issue has been failed!!!");
            redirect('itemsissue');
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
