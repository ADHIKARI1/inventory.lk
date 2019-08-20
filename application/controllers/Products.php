<?php

class Products extends CI_Controller
{
    public function index()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $this->load->view('template/header');
                $this->load->view('products/index');
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

    public function productIndexData()
    {
        $aProductData['data'] = array();
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $aData = $this->Products_model->get_products();

                $i = 1;
                foreach ($aData as $aValue) {
                    $aCurrentRow = array(
                        "id" => $i,
                        "product_code" => $aValue["product_code"],
                        "product_name" => $aValue["product_name"],
                        "category_name" => $aValue["category_name"],
                        "subcategory_1_name" => $aValue["subcategory_1_name"],
                        "subcategory_2_name" => $aValue["subcategory_2_name"],
                        "subcategory_3_name" => $aValue["subcategory_3_name"],
                        "productlocation" => $aValue["productlocation"],
                        "quantity" => $aValue["quantity"]
                    );

                    array_push($aProductData['data'], $aCurrentRow);
                    $i++;
                }
            }
        }

        header('Content-Type: application/json');
        echo json_encode($aProductData);
    }

    public function view($productid = NULL)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $data['product'] = $this->Products_model->get_products($productid);
                $data['stock'] = $this->Stocks_model->get_stock_by_product_id($productid);

                $this->load->view('template/header');
                $this->load->view('products/view', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();
                $data['subcategories3'] = $this->Subcategory3_model->get_subcategories_by_name();
                $data['productlocations'] = $this->Productlocations_model->get_productlocations_by_name();
                $data['locations'] = $this->Locations_model->get_locations();

                $this->load->view('template/header');
                $this->load->view('products/create', $data);
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
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $success = $this->Products_model->save_product();
                if ($success) {
                    $this->session->set_flashdata('product_save_success', "Product has been saved!!!");
                    redirect('products');
                } else {
                    $this->session->set_flashdata('product_save_fail', "Product name already exists!!!");
                    redirect('products/create');
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

    public function edit($productid = NULL)
    {
        if ($this->session->userdata('logged_in')) 
        {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $data['categories'] = $this->Categories_model->get_categories_by_name();
                $data['subcategories1'] = $this->Subcategory1_model->get_subcategories_by_name();
                $data['subcategories2'] = $this->Subcategory2_model->get_subcategories_by_name();
                $data['subcategories3'] = $this->Subcategory3_model->get_subcategories_by_name();
                $data['productlocations'] = $this->Productlocations_model->get_productlocations_by_name();
                $data['locations'] = $this->Locations_model->get_locations();
                $data['product'] = $this->Products_model->get_products($productid);
                $data['stock'] = $this->Stocks_model->get_stock_by_product_id($productid);

                $this->load->view('template/header');
                $this->load->view('products/edit', $data);
                $this->load->view('template/footer');
            } else {
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

    public function update()
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $success = $this->Products_model->update_product();
                if ($success) {
                    $this->session->set_flashdata('product_update_success', "Product has been updated!!!");
                    redirect('products');
                } else {
                    $this->session->set_flashdata('product_update_fail', "Product name already exists!!!");
                    redirect('products');
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

    public function delete($productid)
    {
        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 3);
            if ($permission) {
                $success = $this->Products_model->delete_product($productid);
                if ($success) {
                    $this->session->set_flashdata('product_delete_success', "Product has been deleted!!!");
                    redirect('products');
                } else {
                    $this->session->set_flashdata('product_delete_fail', "This product has already been used for material requests, purchase orders or site stock!!!");
                    redirect('products');
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
