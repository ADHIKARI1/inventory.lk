<?php

class Materialrequests extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('materialrequest/index');
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

    public function materialRequestIndexData()
    {
        $aMaterialRequestData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $aData = $this->Materialrequests_model->get_mr();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "materialrequest_code" => $aValue["materialrequest_code"],
                        "system_user_name" => $aValue["system_user_name"],
                        "request_datetime" => $aValue["request_datetime"],
                        "materialrequest_status" => ($aValue["materialrequest_status"] == "Pending") ? "<span class='text-danger'>".$aValue["materialrequest_status"]."</span>" : "<span class='text-success'>".$aValue["materialrequest_status"]."</span>"
                    );

                    array_push($aMaterialRequestData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aMaterialRequestData);
    }

    public function approve_materialrequests()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 19);
            if ($permission) {
                $data['materialrequests'] = $this->Materialrequests_model->get_mr_for_approval();

                $this->load->view('template/header');
                $this->load->view('materialrequest/approve_mr', $data);
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

    public function view_pendingmr()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequests'] = $this->Materialrequests_model->get_pendingmr();

                $this->load->view('template/header');
                $this->load->view('materialrequest/pendingmr', $data);
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

    public function view($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);

                $this->load->view('template/header');
                $this->load->view('materialrequest/view', $data);
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

    public function viewmritems($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);
                $data['mr_item_count'] = count($this->Materialrequests_model->get_mritems($mrid));
                $data['status'] = $this->Materialrequests_model->is_approved_mr($mrid);

                $this->load->view('template/header');
                $this->load->view('materialrequest/view_items', $data);
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

    public function viewmritemsforapproval($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);
                 $data['materialrequestitems'] = $this->Materialrequests_model->get_mritems($mrid);

                $this->load->view('template/header');
                $this->load->view('materialrequest/view_items_for_approval', $data);
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

    public function materialRequestItemsIndexData($mrid = NULL) {
        $aMaterialRequestItemsData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $aData = $this->Materialrequests_model->get_mritems($mrid);

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "product_name" => $aValue["product_name"],
                        "category_name" => $aValue["category_name"],
                        "subcategory_1_name" => $aValue["subcategory_1_name"],
                        "subcategory_2_name" => $aValue["subcategory_2_name"],
                        "subcategory_3_name" => $aValue["subcategory_3_name"],
                        "requested_quantity" => $aValue["quantity_type"].' '.$aValue["requested_quantity"],
                        "balanced_quantity" => $aValue["quantity_type"].' '.$aValue["balanced_quantity"],
                        "status" => ($aValue["status"] == "Pending") ? "<span class='text-danger'>".$aValue['status']."</span>" : "<span class='text-success'>".$aValue['status']."</span>",
                        "materialrequestitems_table_id" => $aValue["materialrequestitems_table_id"],
                    );

                    array_push($aMaterialRequestItemsData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aMaterialRequestItemsData);
    }

    public function create()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['users'] = $this->Useraccounts_model->get_users_by_name();
                $data['projects'] = $this->Projects_model->get_projects_by_name();
                $data['locations'] = $this->Locations_model->get_locations_by_name();

                $this->load->view('template/header');
                $this->load->view('materialrequest/create', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $success = $this->Materialrequests_model->save_mr();
                if ($success) {
                    $this->session->set_flashdata('mr_save_success', "Material request has been saved!!!");
                    redirect('materialrequests');
                } else {
                    $this->session->set_flashdata('mr_save_fail', "MR code already exists!!!");
                    redirect('materialrequest/create');
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

    public function approve($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 19);
            if ($permission) {
                $success = $this->Materialrequests_model->approve_mr($mrid);
                if ($success) {
                    $this->session->set_flashdata('mr_approve_success', "Material request has been approved!!!");
                    redirect('approvematerialrequests');
                } else {
                    $this->session->set_flashdata('mr_approve_fail', "Material request approve has been failed!!!");
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

    public function edit($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);
                $data['users'] = $this->Useraccounts_model->get_users_by_name();
                $data['projects'] = $this->Projects_model->get_projects_by_name();
                $data['locations'] = $this->Locations_model->get_locations_by_name();

                $this->load->view('template/header');
                $this->load->view('materialrequest/edit', $data);
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

    public function mritems($mrid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequest'] = $this->Materialrequests_model->get_mr($mrid);
                $data['materialrequestitems'] = $this->Materialrequests_model->get_mritems($mrid);
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();
                $data['subcategories3'] = $this->Subcategory3_model->get_subcategories_by_name();
                $data['products'] = $this->Products_model->get_products_by_name();

                $this->load->view('template/header');
                $this->load->view('materialrequest/add_items', $data);
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

    /*public function savemritems(){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
        if ($permission){
          $success = $this->Materialrequests_model->save_mritems();
          if($success){
            $this->session->set_flashdata('mritems_save_success',"Material request items have been saved!!!");
            redirect('materialrequests');
          }
          else{
            $this->session->set_flashdata('mritems_save_fail',"Requesting item already exists in this MR or you can't add items to an already completed MR!!!");
            redirect('materialrequests');
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

    public function savemritems()
    {
        if ($this->session->userdata('logged_in')) {

            $relative_data = $this->input->post('data_table');
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            $this->output->set_content_type("application/json");
            if ($permission) {
                $success = $this->Materialrequests_model->save_mritems($relative_data);
                if ($success == 'success')
                    echo json_encode(array('type' => 'success', 'message' => 'Material request items have been saved!!!'));
                else
                    echo json_encode(array('type' => 'error', 'message' => 'Requesting item already exists in this MR or you can"t add items to an already completed MR!!!'));
            } else
                echo json_encode(array('type' => 'error', 'message' => 'You don"t have permission to this module!!!'));

        }

        /*if ($this->session->userdata('logged_in')){
          $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
          if ($permission){
            $success = $this->Materialrequests_model->save_mritems();
            if($success){
              $this->session->set_flashdata('mritems_save_success',"Material request items have been saved!!!");
              redirect('materialrequests');
            }
            else{
              $this->session->set_flashdata('mritems_save_fail',"Requesting item already exists in this MR or you can't add items to an already completed MR!!!");
              redirect('materialrequests');
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
        }*/
    }

    public function delete($mrid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $success = $this->Materialrequests_model->delete_mr($mrid);
                if ($success) {
                    $this->session->set_flashdata('mr_delete_success', "MR has been deleted!!!");
                    redirect('materialrequests');
                } else {
                    $this->session->set_flashdata('mr_delete_fail', "This material request has already been used for material request products or purchase orders!!!");
                    redirect('materialrequests');
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

    public function deleteitem($tableid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $success = $this->Materialrequests_model->delete_mritem($tableid);
                if ($success) {
                    $this->session->set_flashdata('mritem_delete_success', "Item has been removed from this MR!!!");
                    redirect('materialrequests');
                } else {
                    $this->session->set_flashdata('mritem_delete_fail', "This material request has already approved or item has already been used for purchase orders!!!");
                    redirect('materialrequests');
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

    /*public function requestpo($tableid){
      if ($this->session->userdata('logged_in')){
        $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
        if ($permission){
          $success = $this->Materialrequests_model->request_po($tableid);
          if($success){
            $this->session->set_flashdata('po_request_success',"PO request has been sent!!!");
            redirect('materialrequests');
          }
          else{
            $this->session->set_flashdata('po_request_fail',"PO request already sent or site transfer has already been saved for this item!!!");
            redirect('materialrequests');
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

    public function requestpo()
    {
        if ($this->session->userdata('logged_in')) {
            $relative_data = $this->input->post('data_table');
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            $this->output->set_content_type("application/json");
            if ($permission) {
                $success = $this->Materialrequests_model->request_po($relative_data);
                if ($success)
                    echo json_encode(array('type' => 'success', 'message' => 'Purchased order request have been sent!!!'));
                else
                    echo json_encode(array('type' => 'error', 'message' => 'PO request already sent or site transfer has already been saved for this item!!!'));
            } else
                echo json_encode(array('type' => 'error', 'message' => 'You don"t have permission to this module!!!'));
        }
    }

    public function sitetransfer($tableid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $data['materialrequest'] = $this->Materialrequests_model->get_mritem($tableid);
                $data['locations'] = $this->Materialrequests_model->get_destinationlocations($tableid);

                $this->load->view('template/header');
                $this->load->view('materialrequest/sitetransfer', $data);
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

    public function savesitetransfer()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 6);
            if ($permission) {
                $success = $this->Materialrequests_model->request_st();
                if ($success) {
                    $this->session->set_flashdata('st_request_success', "Site transfer request has been sent!!!");
                    redirect('materialrequests');
                } else {
                    $this->session->set_flashdata('st_request_fail', "Site transfer request already sent or purchase order has already been saved for this item!!!");
                    redirect('materialrequests');
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
