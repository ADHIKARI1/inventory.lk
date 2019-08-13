<?php
  class Projects_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_projects($projectid = NULL){
      if ($projectid === NULL){
        $query = $this->db->query("CALL projects_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_project_procedure('$projectid')");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_projects_by_name(){
      $this->db->order_by('project_name','ASC');
      $query = $this->db->get('projects');
      return $query->result_array();
    }

    public function save_project(){
      $query = $this->db->get_where('projects', array('project_code' => $this->input->post('ProjectCode')));
      $existcode = $query->row_array();
      $query = $this->db->get_where('projects', array('project_name' => $this->input->post('ProjectName')));
      $existname = $query->row_array();
      if($existcode == NULL && $existname == NULL){
        $data = array(
          'project_code' => $this->input->post('ProjectCode'),
          'project_name' => $this->input->post('ProjectName'),
          'project_description' =>$this->input->post('ProjectDescription'),
          'location_id' => $this->input->post('ProjectLocation'),
          'saved_user' => $this->session->userdata('user_id')
        );
        return $this->db->insert('projects', $data);
      }
      else{
        return false;
      }
    }

    public function update_project(){
      $this->db->where('project_name =', $this->input->post('ProjectName'));
      $this->db->where('project_code !=', $this->input->post('ProjectCode'));
      $query = $this->db->get('projects');
      $existname = $query->row_array();
      if($existname == NULL){
        $data = array(
          'project_name' =>$this->input->post('ProjectName'),
          'project_description' =>$this->input->post('ProjectDescription'),
          'location_id' => $this->input->post('ProjectLocation')
        );

        $this->db->where('project_code', $this->input->post('ProjectCode'));
        return $this->db->update('projects', $data);
      }
      else{
        return false;
      }
    }

    public function delete_project($projectid){
      $this->db->where('project_code', $projectid);
      $query = $this->db->get('materialrequests');
      if($query->num_rows() == 0){
        $query = $this->db->query("CALL delete_project_procedure('$projectid')");
        mysqli_next_result( $this->db->conn_id );
        return true;
      }
      else{
        return false;
      }
    }
  }
?>
