<?php

class Goodreceivenotes extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 7);
            if ($permission) {
                $data['goodreceivenotes'] = $this->Goodreceivenotes_model->get_grn();

                $this->load->view('template/header');
                $this->load->view('goodreceivenotes/index', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 7);
            if ($permission) {
                $data['purchaseorders'] = $this->Purchaseorders_model->get_po_nos();

                $this->load->view('template/header');
                $this->load->view('goodreceivenotes/create', $data);
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

//    public function save(){
//      if ($this->session->userdata('logged_in')){
//        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 7);
//        if ($permission){
//          $success = $this->Goodreceivenotes_model->save_grn();
//          if($success){
//            $this->session->set_flashdata('grn_save_success',"GRN has been saved!!!");
//            redirect('goodreceivenotes');
//          }
//          else{
//            $this->session->set_flashdata('grn_save_fail',"GRN code already exists, you are trying to already completed GRN or received quantity is higher than balanced quantity!!!");
//            redirect('goodreceivenotes/create');
//          }
//        }
//        else{
//          $this->session->set_flashdata('access_denied',"You don't have permission to this module!!!");
//          redirect(base_url());
//        }
//      }
//      else{
//        $this->session->set_flashdata('not_logged',"Please login before access this module!!!");
//        redirect('userlogin');
//      }
//    }
    public function save()
    {        
        if ($this->session->userdata('logged_in')) {
            $relative_data = $this->input->post('table_grn');               
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 7);
            $this->output->set_content_type("application/json");
            if ($permission) {
                $success = $this->Goodreceivenotes_model->save_grn($relative_data);
                if ($success) {
                    echo json_encode(array('type' => 'success', 'message' => 'GRN has been saved!!!'));
                } else
                    echo json_encode(array('type' => 'error', 'message' => 'GRN code already exists, you are trying to already completed GRN or received quantity is higher than balanced quantity!!!'));
            } else
                echo json_encode(array('type' => 'error', 'message' => 'You don"t have permission to this module!!!'));
        }
    }

    public function saveasgrn($tableid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 7);
            if ($permission) {
                $data['goodreceivenote'] = $this->Goodreceivenotes_model->get_grn($tableid);

                $this->load->view('template/header');
                $this->load->view('goodreceivenotes/save', $data);
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

    public function savedeliverynote()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 7);
            if ($permission) {
                $success = $this->Goodreceivenotes_model->save_deliverynote();
                if ($success) {
                    $this->session->set_flashdata('deliverynote_save_success', "Delivery note has been saved as GRN!!!");
                    redirect('goodreceivenotes');
                } else {
                    $this->session->set_flashdata('deliverynote_save_fail', "GRN code already exists!!!");
                    redirect('goodreceivenotes');
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
