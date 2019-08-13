<?php
  class Userlogin_model extends CI_Model{
    public function __construct(){
      $this->load->database();
    }

    public function login($username, $password){
      $this->db->join('locations', 'locations.locations_table_id = useraccounts.location_id');
      $this->db->where('user_name', $username);
      $this->db->where('password', $password);
      $result = $this->db->get('useraccounts');
      if($result->num_rows() == 1){
        return $result->row_array();
      }
      else{
        return false;
      }
    }
  }
?>
