<?php

class Pages extends CI_Controller
{
    public function view($page = 'home')
    {
        if (!file_exists(APPPATH . 'views/pages/' . $page . '.php')) {
            show_404();
        }

        $this->load->view('template/header');
        $this->load->view('pages/' . $page);
        $this->load->view('template/footer');
    }

    public function getCurrentLocationStock()
    {
        $aCurrentLocationStockData['data'] = array();
        
        if ($this->session->userdata('logged_in')) {
            $aData = $this->Stocks_model->get_stock($this->session->userdata('user_location'));
        } else {
            $aData = $this->Stocks_model->get_stock();
        }

        $i = 1;
        foreach ($aData as $aValue) {
            $aCurrentRow = array(
                "id" => $i,
                "product_code" => $aValue["product_code"],
                "category_name" => $aValue["category_name"],
                "subcategory_1_name" => $aValue["subcategory_1_name"],
                "subcategory_2_name" => $aValue["subcategory_2_name"],
                "subcategory_3_name" => $aValue["subcategory_3_name"],
                "product_name" => $aValue["product_name"],
                "quantity" => $aValue["quantity_type"].' '.$aValue["quantity"],
                "productlocation" => $aValue["productlocation"]
            );

            array_push($aCurrentLocationStockData['data'], $aCurrentRow);
            $i++;
        }

        header('Content-Type: application/json');
        echo json_encode($aCurrentLocationStockData);
    }

    public function getAllLocationsStock()
    {
        $aOtherLocationStockData['data'] = array();

        $aData = $this->Stocks_model->get_stock();

        $i = 1;
        foreach ($aData as $aValue) {
            $aCurrentRow = array(
                "id" => $i,
                "product_code" => $aValue["product_code"],
                "category_name" => $aValue["category_name"],
                "subcategory_1_name" => $aValue["subcategory_1_name"],
                "subcategory_2_name" => $aValue["subcategory_2_name"],
                "subcategory_3_name" => $aValue["subcategory_3_name"],
                "product_name" => $aValue["product_name"],
                "quantity" => $aValue["quantity_type"].' '.$aValue["quantity"],
                "location" => $aValue["location"],
                "productlocation" => $aValue["productlocation"]
            );

            array_push($aOtherLocationStockData['data'], $aCurrentRow);
            $i++;
        }

        header('Content-Type: application/json');
        echo json_encode($aOtherLocationStockData);
    }

    public function getOtherLocationsStock()
    {
        $aOtherLocationStockData['data'] = array();

        $aData = $this->Stocks_model->get_stock_other_locations($this->session->userdata('user_location'));

        $i = 1;
        foreach ($aData as $aValue) {
            $aCurrentRow = array(
                "id" => $i,
                "product_code" => $aValue["product_code"],
                "category_name" => $aValue["category_name"],
                "subcategory_1_name" => $aValue["subcategory_1_name"],
                "subcategory_2_name" => $aValue["subcategory_2_name"],
                "subcategory_3_name" => $aValue["subcategory_3_name"],
                "product_name" => $aValue["product_name"],
                "quantity" => $aValue["quantity_type"].' '.$aValue["quantity"],
                "location" => $aValue["location"],
                "productlocation" => $aValue["productlocation"]
            );

            array_push($aOtherLocationStockData['data'], $aCurrentRow);
            $i++;
        }

        header('Content-Type: application/json');
        echo json_encode($aOtherLocationStockData);
    }
}

?>
