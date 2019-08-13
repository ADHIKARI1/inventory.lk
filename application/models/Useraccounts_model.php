<?php
  class Useraccounts_model extends CI_Model{
    public function __construct(){
      $this->load->database();
    }

    public function get_users($userid = 0){
      if ($userid === 0){
        $query = $this->db->query("CALL useraccounts_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_useraccount_procedure($userid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_users_by_name(){
      $this->db->order_by('system_user_name', 'ASC');
      $query = $this->db->get('useraccounts');
      return $query->result_array();
    }

    public function get_designations(){
      $this->db->order_by('designation', 'ASC');
      $query = $this->db->get('designations');
      return $query->result_array();
    }

    public function get_usertypes(){
      $this->db->order_by('usertype', 'ASC');
      $query = $this->db->get('usertypes');
      return $query->result_array();
    }

    public function create_user($system_user_image,$enc_password){
      $query = $this->db->get_where('useraccounts', array('user_name' => $this->input->post('UserName')));
      $existusername = $query->row_array();
      if($existusername == NULL){
        $data = array(
          'system_user_name' => $this->input->post('SystemUserName'),
          'designation_id' => $this->input->post('SystemUserDesignation'),
          'location_id' => $this->input->post('SystemUserLocation'),
          'system_user_mobile' => $this->input->post('SystemUserMobile'),
          'user_name' => $this->input->post('UserName'),
          'password' => $enc_password,
          'user_type' => $this->input->post('SystemUserType'),
          'system_user_image' => $system_user_image,
          'saved_user' => $this->session->userdata('user_id')
        );
        return $this->db->insert('useraccounts', $data);
      }
      else{
        return false;
      }
    }

    public function update_user(){
      $this->db->where('user_name',  $this->input->post('UserName'));
      $this->db->where('useraccounts_table_id !=', $this->input->post('SystemUserID'));
      $query = $this->db->get('useraccounts');
      $existusername = $query->row_array();
      if($existusername == NULL){
        $data = array(
          'system_user_name' => $this->input->post('SystemUserName'),
          'designation_id' => $this->input->post('SystemUserDesignation'),
          'location_id' => $this->input->post('SystemUserLocation'),
          'system_user_mobile' => $this->input->post('SystemUserMobile'),
          'user_name' => $this->input->post('UserName'),
          'user_type' => $this->input->post('SystemUserType')
        );
        $this->db->where('useraccounts_table_id', $this->input->post('SystemUserID'));
        return $this->db->update('useraccounts', $data);
      }
      else{
        return false;
      }
    }

    public function update_user_image($systemuserimage){
      $data = array(
        'system_user_image' => $systemuserimage
      );

      $this->db->where('useraccounts_table_id', $this->input->post('SystemUserID'));
      return $this->db->update('useraccounts', $data);
    }

    public function update_user_password($enc_password, $enc_old_password){
      $query = $this->db->get_where('useraccounts', array('password' => $enc_old_password, 'useraccounts_table_id' => $this->input->post('SystemUserID')));
      $existpassword = $query->row_array();
      if($existpassword != NULL){
        $data = array(
          'password' => $enc_password
        );
        $this->db->where('useraccounts_table_id', $this->input->post('SystemUserID'));
        return $this->db->update('useraccounts', $data);
      }
      else{
        return false;
      }
    }

    public function delete_user($userid){
      $this->db->where('useraccounts_table_id', $userid);
      $query = $this->db->get('userpermissions');
      if($query->num_rows() == 0){
        $this->db->where('requester_id', $userid);
        $query = $this->db->get('materialrequests');
        if($query->num_rows() == 0){
          $query = $this->db->query("CALL delete_user_procedure($userid)");
          mysqli_next_result( $this->db->conn_id );
          return true;
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
    }
  }
 ?>
