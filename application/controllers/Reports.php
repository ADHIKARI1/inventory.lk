<?php
  class Reports extends CI_Controller{

    public function index(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          $data['reports'] = $this->Reports_model->get_reports();

          $this->load->view('template/header');
          $this->load->view('reports/index', $data);
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

    public function view($reportsid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          if($reportsid == 1){
            $this->Reports_model->generate_products_report();
          }
          else if($reportsid == 2){
            $data['report'] = $this->Reports_model->get_report_by_id(2);
            $data['locations'] = $this->Locations_model->get_locations();

            $this->load->view('template/header');
            $this->load->view('reports/view_locations', $data);
            $this->load->view('template/footer');
          }
          else if($reportsid == 3){
            $data['projects'] = $this->Projects_model->get_projects_by_name();

            $this->load->view('template/header');
            $this->load->view('reports/po_report_filter', $data);
            $this->load->view('template/footer');
          }
          else if($reportsid == 4){
            $data['projects'] = $this->Projects_model->get_projects_by_name();

            $this->load->view('template/header');
            $this->load->view('reports/grn_report_filter', $data);
            $this->load->view('template/footer');
          }
          else if($reportsid == 5){
            $data['pendingpos'] = $this->Purchaseorders_model->get_pendingpo_for_report();
            $this->load->view('reports/pending_purchase_orders', $data);
          }
          else if($reportsid == 6){
           // $data['materialrequests'] = $this->Materialrequests_model->get_mr();  
            $data['materialrequests'] = $this->Materialrequests_model->get_mr_for_item_issue_window();            

            $this->load->view('template/header');
            $this->load->view('reports/view_mr_items', $data);
            $this->load->view('template/footer');
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

    public function location_wise_stock($locationid){

      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          $this->Reports_model->generate_location_wise_stock_report($locationid);
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

    public function printgrnreport(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          if ($this->input->post('ProjectCode') != '0'){
            $data['projectname'] = $this->Projects_model->get_projects($this->input->post('ProjectCode'));
            $data['grns'] = $this->Goodreceivenotes_model->get_grn_by_project($this->input->post('FromDate'), $this->input->post('ToDate'), $this->input->post('ProjectCode'));
            $data['fromdate'] = $this->input->post('FromDate');
            $data['todate'] = $this->input->post('ToDate');
          }
          else{
            $data['projectname'] = "";
            $data['grns'] = $this->Goodreceivenotes_model->get_grn_by_date($this->input->post('FromDate'), $this->input->post('ToDate'));
            $data['fromdate'] = $this->input->post('FromDate');
            $data['todate'] = $this->input->post('ToDate');
          }

          $this->load->view('reports/good_received_notes', $data);
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

    public function printporeport(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          if ($this->input->post('ProjectCode') != '0'){
            $data['projectname'] = $this->Projects_model->get_projects($this->input->post('ProjectCode'));
            $data['purchaseorders'] = $this->Purchaseorders_model->get_po_by_project($this->input->post('FromDate'), $this->input->post('ToDate'), $this->input->post('ProjectCode'));
            $data['fromdate'] = $this->input->post('FromDate');
            $data['todate'] = $this->input->post('ToDate');
          }
          else{
            $data['projectname'] = "";
            $data['purchaseorders'] = $this->Purchaseorders_model->get_po_by_date($this->input->post('FromDate'), $this->input->post('ToDate'));
            $data['fromdate'] = $this->input->post('FromDate');
            $data['todate'] = $this->input->post('ToDate');
          }

          $this->load->view('reports/purchase_orders', $data);
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

    public function printgrndata(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          $data['grns'] = $this->Goodreceivenotes_model->get_grn_by_grn_no($this->input->post('rptGrnNo'));
          $this->load->view('reports/good_received_notes_details', $data);
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

    public function printitemsissuedata($mrid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 18);
        if ($permission){
          $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);
          //$data['materialrequestitems'] = $this->Materialrequests_model->get_pendingmritems($mrid); 
          $data['materialrequestitems'] = $this->Materialrequests_model->pending_mr_for_itemissue($mrid);          

          $this->load->view('reports/items_issue_details', $data);
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
