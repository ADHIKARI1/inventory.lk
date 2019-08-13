<?php
  class Subcategory3_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_subcategories($subcategoryid = NULL){
      if ($subcategoryid === NULL){
        $query = $this->db->query("CALL subcategories_3_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_subcategory_3_procedure($subcategoryid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_subcategories_by_name(){
      $this->db->order_by('subcategory_3_name','ASC');
      $query = $this->db->get('subcategories_3');
      return $query->result_array();
    }

    public function save_subcategory(){
      $query = $this->db->get_where('subcategories_3', array('subcategory_3_name' => $this->input->post('SubCategory3Name')));
      $existname = $query->row_array();
      if($existname == NULL){
        $this->db->select_max('subcategory_3_code');
        $this->db->where('category_code =', $this->input->post('CategoryCode'));
        $this->db->where('SUBcategory_1_code =', $this->input->post('SubCategory1Code'));
        $this->db->where('SUBcategory_2_code =', $this->input->post('SubCategory2Code'));
        $query = $this->db->get('subcategories_3');
        $maxid = $query->row()->subcategory_3_code + 1;
        $data = array(
          'category_code' => $this->input->post('CategoryCode'),
          'subcategory_1_code' => $this->input->post('SubCategory1Code'),
          'subcategory_2_code' => $this->input->post('SubCategory2Code'),
          'subcategory_3_code' => $maxid,
          'subcategory_3_name' => $this->input->post('SubCategory3Name'),
          'subcategory_3_description' => $this->input->post('SubCategory3Description'),
          'saved_user' => $this->session->userdata('user_id')
        );
        return $this->db->insert('subcategories_3', $data);
      }
      else{
        return false;
      }
    }

    public function update_subcategory(){
      $this->db->where('subcategory_3_name =', $this->input->post('SubCategory3Name'));
      $this->db->where('subcategory_3_code !=', $this->input->post('SubCategory3Code'));
      $query = $this->db->get('subcategories_3');
      $existname = $query->row_array();
      if($existname == NULL){
        $data = array(
          'category_code' => $this->input->post('CategoryCode'),
          'subcategory_1_code' => $this->input->post('SubCategory1Code'),
          'subcategory_2_code' => $this->input->post('SubCategory2Code'),
          'subcategory_3_name' => $this->input->post('SubCategory3Name'),
          'subcategory_3_description' => $this->input->post('SubCategory3Description')
        );

        $this->db->where('subcategory_3_code', $this->input->post('SubCategory3Code'));
        return $this->db->update('subcategories_3', $data);
      }
      else{
        return false;
      }
    }

    public function delete_subcategory($subcategoryid){
      $this->db->where('subcategory_3_code', $subcategoryid);
      $query = $this->db->get('supplierproducts');
      if($query->num_rows() == 0){
        $this->db->where('subcategory_3_code', $subcategoryid);
        $query = $this->db->get('products');
        if($query->num_rows() == 0){
          $query = $this->db->query("CALL delete_subcategory_3_procedure($subcategoryid)");
          mysqli_next_result( $this->db->conn_id );
          return true;
        }
        else {
          return false;
        }
      }
      else {
        return false;
      }
    }
  }
?>
