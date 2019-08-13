<?php
  class Productlocations_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_productlocations($productlocationid = NULL){
      if ($productlocationid === NULL){
        $query = $this->db->query("CALL productlocations_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_productlocation_procedure($productlocationid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_productlocations_by_name(){
      $this->db->order_by('productlocation','ASC');
      $query = $this->db->get('productlocations');
      return $query->result_array();
    }

    public function save_productlocation(){
      $query = $this->db->get_where('productlocations', array('productlocation' => $this->input->post('ProductLocationName')));
      $existlocation = $query->row_array();
      if($existlocation == NULL){
        $data = array(
          'productlocation' => $this->input->post('ProductLocationName'),
          'saved_user' => $this->session->userdata('user_id')
        );
        $this->db->insert('productlocations', $data);
        return true;
      }
      else{
        return false;
      }
    }

    public function update_productlocation(){
      $this->db->where('productlocation', $this->input->post('ProductLocationName'));
      $this->db->where('productlocations_table_id !=', $this->input->post('ProductLocationID'));
      $query = $this->db->get('productlocations');
      $existlocation = $query->row_array();
      if($existlocation == NULL){
        $data = array(
          'productlocation' =>$this->input->post('ProductLocationName')
        );
        $this->db->where('productlocations_table_id', $this->input->post('ProductLocationID'));
        $this->db->update('productlocations', $data);
        return true;
      }
      else{
        return false;
      }
    }

    public function delete_productlocation($productlocationid){
      $this->db->where('product_location_id', $productlocationid);
      $query = $this->db->get('products');
      if($query->num_rows() == 0){
        $query = $this->db->query("CALL delete_productlocation_procedure($productlocationid)");
        mysqli_next_result( $this->db->conn_id );
        return true;
      }
      else{
        return false;
      }
    }
  }
?>
