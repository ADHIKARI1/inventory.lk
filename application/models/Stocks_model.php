<?php
  class Stocks_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_stock($location = NULL){
      if ($location === NULL){
        $query = $this->db->query("CALL stocks_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $locationdata = $this->db->get_where('locations', array('location' => $location));
      $locationid = $locationdata->row()->locations_table_id;
      $query = $this->db->query("CALL stocks_procedure_to_location($locationid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->result_array();
    }

    public function get_stock_other_locations($location){
      $locationdata = $this->db->get_where('locations', array('location' => $location));
      $locationid = $locationdata->row()->locations_table_id;
      $query = $this->db->query("CALL stocks_procedure_not_to_location($locationid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->result_array();
    }

     public function get_stock_by_product_id($productid){
     $query = $this->db->query("CALL stock_by_product_code($productid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();    
    }

    public function get_stock_for_adjust($locationid){

      $query = $this->db->query("CALL stocks_procedure_to_location($locationid)");

      mysqli_next_result( $this->db->conn_id );

      return $query->result_array();

    }
  }
?>
