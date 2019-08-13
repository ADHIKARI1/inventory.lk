<?php
  class Subcategory2_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_subcategories($subcategoryid = NULL){
      if ($subcategoryid === NULL){
        $query = $this->db->query("CALL subcategories_2_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_subcategory_2_procedure($subcategoryid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_subcategories_by_name(){
      $this->db->order_by('subcategory_2_name','ASC');
      $query = $this->db->get('subcategories_2');
      return $query->result_array();
    }

    public function save_subcategory(){
      $query = $this->db->get_where('subcategories_2', array('subcategory_2_name' => $this->input->post('SubCategory2Name')));
      $existname = $query->row_array();
      if($existname == NULL){
        $this->db->select_max('subcategory_2_code');
        $this->db->where('category_code =', $this->input->post('CategoryCode'));
        $this->db->where('SUBcategory_1_code =', $this->input->post('SubCategory1Code'));
        $query = $this->db->get('subcategories_2');
        $maxid = $query->row()->subcategory_2_code + 1;
        $data = array(
          'category_code' => $this->input->post('CategoryCode'),
          'subcategory_1_code' => $this->input->post('SubCategory1Code'),
          'subcategory_2_code' => $maxid,
          'subcategory_2_name' => $this->input->post('SubCategory2Name'),
          'subcategory_2_description' => $this->input->post('SubCategory2Description'),
          'saved_user' => $this->session->userdata('user_id')
        );
        $this->db->insert('subcategories_2', $data);

        $data = array(
          'category_code' => $this->input->post('CategoryCode'),
          'subcategory_1_code' => $this->input->post('SubCategory1Code'),
          'subcategory_2_code' => $maxid,
          'subcategory_3_code' => $maxid."0000",
          'subcategory_3_name' => ' NOT AVAILABLE',
          'subcategory_3_description' => ' NOT AVAILABLE',
          'saved_user' => $this->session->userdata('user_id')
        );
        $this->db->insert('subcategories_3', $data);

        return true;
      }
      else{
        return false;
      }
    }

    public function update_subcategory(){
      $this->db->where('subcategory_2_name =', $this->input->post('SubCategory2Name'));
      $this->db->where('subcategory_2_code !=', $this->input->post('SubCategory2Code'));
      $query = $this->db->get('subcategories_2');
      $existname = $query->row_array();
      if($existname == NULL){
        $data = array(
          'category_code' => $this->input->post('CategoryCode'),
          'subcategory_1_code' => $this->input->post('SubCategory1Code'),
          'subcategory_2_name' => $this->input->post('SubCategory2Name'),
          'subcategory_2_description' => $this->input->post('SubCategory2Description')
        );

        $this->db->where('subcategory_2_code', $this->input->post('SubCategory2Code'));
        return $this->db->update('subcategories_2', $data);
      }
      else{
        return false;
      }
    }

    public function delete_subcategory($subcategoryid){
      $this->db->where('subcategory_2_code', $subcategoryid);
      $query = $this->db->get('supplierproducts');
      if($query->num_rows() == 0){
        $this->db->where('subcategory_2_code', $subcategoryid);
        $query = $this->db->get('products');
        if($query->num_rows() == 0){
          $this->db->where('subcategory_2_code', $subcategoryid);
          $query = $this->db->get('subcategories_3');
          if($query->num_rows() == 1){
            $query = $this->db->query("CALL delete_subcategory_2_procedure($subcategoryid)");
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
      else {
        return false;
      }
    }
  }
?>
