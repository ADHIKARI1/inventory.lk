<?php
  class Userpermissions_model extends CI_Model{
    public function __construct(){
      $this->load->database();
    }

    public function get_permissions_by_name(){
      $this->db->order_by('permission', 'ASC');
      $query = $this->db->get('permissions');
      return $query->result_array();
    }

    public function get_userpermissions($userid){
      $query = $this->db->query("CALL userpermissions_procedure($userid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->result_array();
    }

    public function get_usermodulepermissions($userid, $moduleid){
      $query = $this->db->get_where('userpermissions', array('useraccounts_table_id' => $userid, 'permissions_table_id' => $moduleid));
      if($query->num_rows() == 1){
        return true;
      }
      else {
        return false;
      }
    }

    public function save_user_permission(){
      for ($i=0; $i < count($this->input->post('UserPermission')); $i++) {
        $query = $this->db->get_where('userpermissions', array('useraccounts_table_id' => $this->input->post('UserID'), 'permissions_table_id' => $this->input->post('UserPermission')[$i]));
        $existpermission = $query->result_array();
        if($existpermission == NULL){
          $data = array(
            'useraccounts_table_id' => $this->input->post('UserID'),
            'permissions_table_id' => $this->input->post('UserPermission')[$i],
            'saved_user' => $this->session->userdata('user_id')
          );
          $this->db->insert('userpermissions', $data);
        }
      }
      return true;
    }

    public function delete_userpermission($tableid){
      $this->db->where('userpermissions_table_id', $tableid);
      $this->db->delete('userpermissions');
      return true;
    }
  }
?>
