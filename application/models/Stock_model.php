<?php

  class Stock_model extends CI_Model{

    public function __construct(){

        $this->load->database();

    }



    public function transfer_items($locationid){

      $query = $this->db->query("CALL stocks_procedure_to_location($locationid)");

      mysqli_next_result( $this->db->conn_id );

      $noofproducts = $query->num_rows();

      if($noofproducts > 0) {

        $products = $query->result_array();

        foreach ($products as $product) {

          $this->db->where('product_code', $product['product_code']);

          $this->db->where('location_id', 1);

          $query = $this->db->get('stocks');

          $product_exist = $query->num_rows();

          if ($product_exist == 1) {

            $existitem = $query->row_array();

            $tot_qty = $product['quantity'] + $existitem['quantity'];

            $data = array(

              'quantity' => $tot_qty

            );



            $this->db->where('product_code', $product['product_code']);

            $this->db->where('location_id', 1);

            $this->db->update('stocks', $data);

          }

          else {

            $data = array(

              'product_code' => $product['product_code'],

              'quantity' => $tot_qty,

              'quantity_type' => $product['quantity_type'],

              'location_id' => 1

            );



            $this->db->insert('stocks', $data);

          }

        }

        $this->db->where('location_id', $locationid);

        $this->db->delete('stocks');

        return true;

      }

      return false;

    }



    /*public function save_adjusted_items($tableid) {

      date_default_timezone_set('Asia/Colombo');

      $this->db->where('stocks_table_id', $tableid);

      $query = $this->db->get('stocks');

      $existedqty = $query->row_array();



      $data = array(

        'product_code' => $existedqty['product_code'],

        'existed_quantity' => $existedqty['quantity'],

        'changed_quantity' => $this->input->post('Quantity'),

        'location_id' => $existedqty['location_id'],

        'saved_date' => date('Y-m-d'),

        'saved_user' => $this->session->userdata('user_id')

      );

      $this->db->insert('adjusted_stocks', $data);



      $data = array(

        'quantity' => $this->input->post('Quantity')

      );

      $this->db->where('stocks_table_id', $tableid);

      $this->db->update('stocks', $data);

      return true;

    }*/

    public function save_adjusted_items($tableid, $qty) {

      date_default_timezone_set('Asia/Colombo');

      $this->db->where('stocks_table_id', $tableid);

      $query = $this->db->get('stocks');

      $existedqty = $query->row_array();



      $data = array(

        'product_code' => $existedqty['product_code'],

        'existed_quantity' => $existedqty['quantity'],

        'changed_quantity' => $qty,

        'location_id' => $existedqty['location_id'],

        'saved_date' => date('Y-m-d'),

        'saved_user' => $this->session->userdata('user_id')

      );

      $this->db->insert('adjusted_stocks', $data);



      $data = array(

        'quantity' => $qty

      );

      $this->db->where('stocks_table_id', $tableid);

      $this->db->update('stocks', $data);

      return true;

    }




    public function get_ias_data($locationid, $productid, $fromdate, $todate) {

      $query = $this->db->query("CALL reports_inventory_adjustment_summary($locationid, $productid, '$fromdate', '$todate')");

      mysqli_next_result( $this->db->conn_id );

      return $query->result_array();

    }



    public function get_iom_data($locationid, $productid) {

      $query = $this->db->query("CALL stocks_over_max_procedure($locationid, $productid)");

      mysqli_next_result( $this->db->conn_id );

      return $query->result_array();

    }



    public function get_ibm_data($locationid, $productid) {

      $query = $this->db->query("CALL stocks_below_min_procedure($locationid, $productid)");

      mysqli_next_result( $this->db->conn_id );

      return $query->result_array();

    }



    public function get_iebr_data($locationid, $productid) {

      $query = $this->db->query("CALL stocks_equal_below_reorder_procedure($locationid, $productid)");

      mysqli_next_result( $this->db->conn_id );

      return $query->result_array();

    }

  }

 ?>

