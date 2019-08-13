<?php
  class Locations_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_locations($locationid = NULL){
      if ($locationid === NULL){
        $query = $this->db->query("CALL locations_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_location_procedure($locationid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_locations_by_name(){
      $this->db->order_by('location','ASC');
      $query = $this->db->get('locations');
      return $query->result_array();
    }

    public function save_location(){
      $query = $this->db->get_where('locations', array('location' => $this->input->post('LocationName')));
      $existlocation = $query->row_array();
      if($existlocation == NULL){
        $data = array(
          'location' => $this->input->post('LocationName'),
          'saved_user' => $this->session->userdata('user_id')
        );
        $this->db->insert('locations', $data);
        return true;
      }
      else{
        return false;
      }
    }

    public function update_location(){
      $this->db->where('location', $this->input->post('LocationName'));
      $this->db->where('locations_table_id !=', $this->input->post('LocationID'));
      $query = $this->db->get('locations');
      $existlocation = $query->row_array();
      if($existlocation == NULL){
        $data = array(
          'location' =>$this->input->post('LocationName')
        );
        $this->db->where('locations_table_id', $this->input->post('LocationID'));
        $this->db->update('locations', $data);
        return true;
      }
      else{
        return false;
      }
    }

    public function delete_location($locationid){
      $this->db->where('location_id', $locationid);
      $query = $this->db->get('projects');
      if($query->num_rows() == 0){
        $this->db->where('location_id', $locationid);
        $query = $this->db->get('useraccounts');
        if($query->num_rows() == 0){
          $this->db->where('delivery_location_id', $locationid);
          $query = $this->db->get('purchaseorders');
          if($query->num_rows() == 0){
            $this->db->where('location_id', $locationid);
            $query = $this->db->get('stocks');
            if($query->num_rows() == 0){
              $query = $this->db->query("CALL delete_location_procedure($locationid)");
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
