<?php

class Suppliers extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {

                $this->load->view('template/header');
                $this->load->view('suppliers/index');
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

    public function supplierIndexData()
    {
        $aSupplierData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $aData = $this->Suppliers_model->get_suppliers();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "supplier_code" => $aValue["supplier_code"],
                        "supplier_name" => $aValue["supplier_name"],
                        "supplier_contact_no1" => ($aValue["supplier_contact_no1"]) ? $aValue["supplier_contact_no1"] : "NOT AVAILABLE",
                        "supplier_contact_no2" => ($aValue["supplier_contact_no2"]) ? $aValue["supplier_contact_no2"] : "NOT AVAILABLE",
                        "supplier_fax_no1" => ($aValue["supplier_fax_no1"]) ? $aValue["supplier_fax_no1"] : "NOT AVAILABLE",
                        "supplier_fax_no2" => ($aValue["supplier_fax_no2"]) ? $aValue["supplier_fax_no2"] : "NOT AVAILABLE",
                    );

                    array_push($aSupplierData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aSupplierData);
    }

    public function view($supplierid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $data['supplier'] = $this->Suppliers_model->get_suppliers($supplierid);

                $this->load->view('template/header');
                $this->load->view('suppliers/view', $data);
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

    public function supplierproducts($supplierid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $data['supplier'] = $this->Suppliers_model->get_suppliers($supplierid);

                $this->load->view('template/header');
                $this->load->view('suppliers/view_products', $data);
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

    public function supplierProductsData($supplierid = NULL)
    {
        $aSupplierData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $aData = $this->Products_model->get_supplierproducts($supplierid);

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "supplierproducts_table_id" => $aValue["supplierproducts_table_id"],
                        "category_name" => $aValue["category_name"],
                        "subcategory_1_name" => $aValue["subcategory_1_name"],
                        "subcategory_2_name" => $aValue["subcategory_2_name"],
                        "subcategory_3_name" => $aValue["subcategory_3_name"]
                    );

                    array_push($aSupplierData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aSupplierData);
    }

    public function create()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {

                $this->load->view('template/header');
                $this->load->view('suppliers/create');
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $success = $this->Suppliers_model->save_supplier();
                if ($success) {
                    $this->session->set_flashdata('supplier_save_success', "Supplier has been saved!!!");
                    redirect('suppliers');
                } else {
                    $this->session->set_flashdata('supplier_save_fail', "Supplier code or supplier name already exists!!!");
                    redirect('suppliers/create');
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

    public function edit($supplierid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $data['supplier'] = $this->Suppliers_model->get_suppliers($supplierid);

                $this->load->view('template/header');
                $this->load->view('suppliers/edit', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $success = $this->Suppliers_model->update_supplier();
                if ($success) {
                    $this->session->set_flashdata('supplier_update_success', "Supplier has been updated!!!");
                    redirect('suppliers');
                } else {
                    $this->session->set_flashdata('supplier_update_fail', "Supplier name already exists!!!");
                    redirect('suppliers');
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

    public function addsupplierproducts($supplierid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $data['supplier'] = $this->Suppliers_model->get_suppliers($supplierid);
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();
                $data['subcategories3'] = $this->Subcategory3_model->get_subcategories_by_name();
                $data['products'] = $this->Products_model->get_products_by_name();

                $this->load->view('template/header');
                $this->load->view('suppliers/add_products', $data);
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

    public function savesupplierproducts()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $success = $this->Suppliers_model->save_supplierproducts();
                if ($success) {
                    $this->session->set_flashdata('supplierproducts_save_success', "Supplier product has been saved!!!");
                    redirect('suppliers');
                } else {
                    $this->session->set_flashdata('supplierproducts_save_fail', "Supplier product save has been failed!!!");
                    redirect('suppliers');
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

    public function delete($supplierid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $success = $this->Suppliers_model->delete_supplier($supplierid);
                if ($success) {
                    $this->session->set_flashdata('supplier_delete_success', "Supplier has been deleted!!!");
                    redirect('suppliers');
                } else {
                    $this->session->set_flashdata('supplier_delete_fail', "This supplier has already been used for purchase orders or supplier products!!!");
                    redirect('suppliers');
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

    public function deleteproduct($tableid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) {
                $success = $this->Suppliers_model->delete_supplierproduct($tableid);
                if ($success) {
                    $this->session->set_flashdata('supplierproduct_delete_success', "Product has been removed from this supplier!!!");
                    redirect('suppliers');
                } else {
                    $this->session->set_flashdata('supplierproduct_delete_fail', "Product remove from this supplier has been failed!!!");
                    redirect('suppliers');
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

    public function deletebulkproducts()
    {        

        if ($this->session->userdata('logged_in')) 
        {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 16);
            if ($permission) 
            {
                if($this->input->post('table_ids'))
                {
                  // POST values
                  $table_ids = $this->input->post('table_ids');
                  // Delete records
                  $this->Suppliers_model->delete_bulk_supplierproducts($table_ids);                  
                  exit;
                  /*$id = $this->input->post('checkbox_value');
                   for($count = 0; $count < count($id); $count++)
                   {
                    $this->Suppliers_model->delete($id[$count]);
                   }*/
                }
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



}

?>
