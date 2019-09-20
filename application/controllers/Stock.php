<?php

class Stock extends CI_Controller
{

    public function stock_in()
    {

        if ($this->session->userdata('logged_in')) {
            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 13);

            if ($permission) 
            {

                $data['locations'] = $this->Locations_model->get_locations_by_name();


                $this->load->view('template/header');

                $this->load->view('stock/stock_in', $data);

                $this->load->view('template/footer');

            } 
            else 
            {

                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");

                redirect(base_url());

            }

        } else {
            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");
            redirect('userlogin');
        }
    }


    public function transferitems($locationid = NULL)
    { 

        if ($this->session->userdata('logged_in')) {

            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 13);

            if ($permission) {

                $success = $this->Stock_model->transfer_items($locationid);

                if ($success) {

                    $this->session->set_flashdata('products_transfer_success', "All products have been transferred to head office stock!!!");

                    redirect('stock-in');

                } else {

                    $this->session->set_flashdata('products_transfer_fail', "Already products have been transferred from this location to head office stock!!!");

                    redirect('stock-in');

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


    public function stock_adjust()
    {

        if ($this->session->userdata('logged_in')) {

            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 20);

            if ($permission) {

                $data['locations'] = $this->Locations_model->get_locations_by_name();


                $this->load->view('template/header');

                $this->load->view('stock/stock_adjust', $data);

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


    public function view_products($locationid = NULL)
    {

        if ($this->session->userdata('logged_in')) {

            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 20);

            if ($permission) {

                $data['title'] = $this->Locations_model->get_locations($locationid);

                $data['products'] = $this->Stocks_model->get_stock_for_adjust($locationid);


                $this->load->view('template/header');

                $this->load->view('stock/adjust_products', $data);

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


    /*public function saveadjustetdquantity($tableid)
    {

        if ($this->session->userdata('logged_in')) {

            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 20);

            if ($permission) {

                $success = $this->Stock_model->save_adjusted_items($tableid);

                if ($success) {

                    $this->session->set_flashdata('products_adjusted_success', "Product quantity change has been successed!!!");

                    redirect('stock-adjust');

                } else {

                    $this->session->set_flashdata('products_adjusted_fail', "Product quantity change has been failed!!!");

                    redirect('stock-adjust');

                }

            } else {

                $this->session->set_flashdata('access_denied', "You don't have permission to this module!!!");

                redirect(base_url());

            }

        } else {

            $this->session->set_flashdata('not_logged', "Please login before access this module!!!");

            redirect('userlogin');

        }

    }*/

    public function saveadjustetdquantity($id, $qty)
    {

        if ($this->session->userdata('logged_in')) {

            $permission = $this->Userpermissions_model->get_usermodulepermissions($this->session->userdata('user_id'), 20);

            if ($permission) 
            {                
               $success = $this->Stock_model->save_adjusted_items($id, $qty);
               if ($success)                    
                     echo json_encode(array('type' => 'success', 'message' => 'Product quantity change has been successed!!!'));
                 else
                    echo json_encode(array('type' => 'error', 'message' => 'Product quantity change has been failed!!!'));
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

