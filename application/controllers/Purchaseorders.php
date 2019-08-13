<?php

class Purchaseorders extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                //$data['materialrequests'] = $this->Materialrequests_model->get_mr();
                $data['materialrequests'] = $this->Materialrequests_model->get_mr_for_saved_po();
                $this->load->view('template/header');
                $this->load->view('purchaseorders/index', $data);
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

    /*public function unsavedpo(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
        if ($permission){
          $data['purchaseorders'] = $this->Purchaseorders_model->get_unsavedpo();

          $this->load->view('template/header');
          $this->load->view('purchaseorders/unsavedpo', $data);
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
    }*/

    public function pounsaved($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) 
        {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['purchaseorders'] = $this->Purchaseorders_model->get_unsavedpo_by_mr($mrid);
                //$data['suppliers'] = $this->Suppliers_model->get_suppliers_productwise($tableid);
                $this->load->view('template/header');
                $this->load->view('purchaseorders/pounsaved', $data);
                $this->load->view('template/footer');
            } 
            else 
            {
                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");
                redirect(base_url());
            }
        } 
        else 
        {
            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");
            redirect('userlogin');
        }
    }

    /*public function pounsaved($tableid = NULL){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
        if ($permission){
          $data['purchaseorders'] = $this->Purchaseorders_model->get_unsavedpo();

          $data['purchaseorder'] = $this->Purchaseorders_model->get_po($tableid);
          $data['suppliers'] = $this->Suppliers_model->get_suppliers_productwise($tableid);
          $data['locations'] = $this->Locations_model->get_locations_by_name();


          $this->load->view('template/header');
          $this->load->view('purchaseorders/pounsaved', $data);
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
    }*/

    public function unsavedpo()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['materialrequests'] = $this->Materialrequests_model->get_mr_for_unsaved_po();
                $this->load->view('template/header');
                $this->load->view('purchaseorders/unsavedpo', $data);
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

    public function pendingpo()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['purchaseorders'] = $this->Purchaseorders_model->get_pendingpo();

                $this->load->view('template/header');
                $this->load->view('purchaseorders/pendingpo', $data);
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

    public function view($tableid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['purchaseorder'] = $this->Purchaseorders_model->get_po_details($tableid);

                $this->load->view('template/header');
                $this->load->view('purchaseorders/view', $data);
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

    public function viewgrn($poid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['goodreceivenotes'] = $this->Goodreceivenotes_model->get_po_grn($poid);
                $data['purchaseorder'] = $this->Purchaseorders_model->get_po_no($poid);

                $this->load->view('template/header');
                $this->load->view('purchaseorders/viewgrn', $data);
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

    public function save_purchaseorder($tableid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['purchaseorder'] = $this->Purchaseorders_model->get_po($tableid);
                $data['suppliers'] = $this->Suppliers_model->get_suppliers_productwise($tableid);
                $data['locations'] = $this->Locations_model->get_locations_by_name();

                $this->load->view('template/header');
                $this->load->view('purchaseorders/save', $data);
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

    public function getSuppliers($tableid = NULL)
    {
        $aSuppliers = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $aData = $this->Suppliers_model->get_suppliers_productwise($tableid);

                if ($aData) {
                    foreach ($aData as $sValue) {
                        $aCurrent = array(
                            'code' => $sValue['supplier_code'],
                            'supplier' => $sValue['supplier_name']
                        );

                        array_push($aSuppliers, $aCurrent);
                    }
                }
            }
        }

        echo json_encode($aSuppliers);
    }

    public function getPoSupplier()
    {      
        $po = $_POST['po_no'];
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $aData = $this->Suppliers_model->get_supplier_by_po($po);
                if ($aData) {
                    echo json_encode($aData);
                }
                
            }
        }        
    }


    public function getLocations()
    {
        $aLocations = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $aData = $this->Locations_model->get_locations_by_name();

                if ($aData) {
                    foreach ($aData as $sValue) {
                        $aCurrent = array(
                            'location_id' => $sValue['locations_table_id'],
                            'location' => $sValue['location']
                        );

                        array_push($aLocations, $aCurrent);
                    }
                }
            }
        }

        echo json_encode($aLocations);
    }

    /*public function save(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
        if ($permission){
          $success = $this->Purchaseorders_model->save_po();
          if($success){
            $this->session->set_flashdata('po_save_success',"Purchase order has been saved!!!");
            redirect('purchaseorders');
          }
          else{
            $this->session->set_flashdata('po_save_fail',"Purchase order number already exists!!!");
            redirect('purchaseorders');
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
    }*/

//    public function save()
//    {
//        if ($this->session->userdata('logged_in')) {
//            $relative_data = $this->input->post('data_table');
//            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
//            $this->output->set_content_type("application/json");
//            if ($permission) {
//                $success = $this->Purchaseorders_model->save_po($relative_data);
//                if ($success)
//                    echo json_encode(array('type' => 'success', 'message' => 'Purchase order has been saved!!!'));
//                else
//                    echo json_encode(array('type' => 'error', 'message' => 'Purchase order number already exists!!!'));
//            } else
//                echo json_encode(array('type' => 'error', 'message' => 'You don"t have permission to this module!!!'));
//        }
//    }

    public function delete($tableid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $success = $this->Purchaseorders_model->delete_po($tableid);
                if ($success) {
                    $this->session->set_flashdata('po_delete_success', "Purchase order has been deleted!!!");
                    redirect('purchaseorders');
                } else {
                    $this->session->set_flashdata('po_delete_fail', "This purchase order has already been used for good received notes!!!");
                    redirect('purchaseorders');
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

    public function save()
    {
        if ($this->session->userdata('logged_in')) {
            $relative_data = $this->input->post('data_table');
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            $this->output->set_content_type("application/json");
            if ($permission) {
                $success = $this->Purchaseorders_model->save_po($relative_data);
                if ($success)
                    echo json_encode(array('type' => 'success', 'message' => 'Purchase order has been saved!!!'));
                else
                    echo json_encode(array('type' => 'error', 'message' => 'Purchase order number already exists!!!'));
            } else
                echo json_encode(array('type' => 'error', 'message' => 'You don"t have permission to this module!!!'));
        }
    }

    public function savedpo($mrid = NULL)
    {

        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $data['purchaseorders'] = $this->Purchaseorders_model->get_savedpo_by_mr($mrid);
                $this->load->view('template/header');
                $this->load->view('purchaseorders/savedpo', $data);
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

    public function getsavedpo($pono = NULL)
    {
        $aSavesPoData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 10);
            if ($permission) {
                $aData = $this->Purchaseorders_model->get_savedpo_by_pono($pono);

                $i = 1;
                foreach ($aData as $aKey) {
                    if($aKey["balanced_quantity"] == null || $aKey["balanced_quantity"] == "")
                        $aKey["balanced_quantity"] = 0;

                    $aCurrent = array(
                        "materialrequest_code" => $aKey["materialrequest_code"],
                        "product_name" => $aKey["product_name"],
                        "category_name" => $aKey["category_name"],
                        "subcategory_1_name" => $aKey["subcategory_1_name"],
                        "subcategory_2_name" => $aKey["subcategory_2_name"],
                        "subcategory_3_name" => $aKey["subcategory_3_name"],
                        "quantity" => $aKey["quantity"],
                        "balanced_quantity" => $aKey["balanced_quantity"],
                        "grn_status" => $aKey["grn_status"],
                        "purchaseorders_table_id" => $aKey["purchaseorders_table_id"]
                    );
                    array_push($aSavesPoData['data'], $aCurrent);
                    $i++;
                }
                echo json_encode($aSavesPoData);
            } else
                echo json_encode($aSavesPoData);
        } else
            echo json_encode($aSavesPoData);

    }
}

?>
