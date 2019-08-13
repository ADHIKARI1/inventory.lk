<?php
  class Itemsissue_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function issue_items($tableid){
      $query = $this->db->get_where('materialrequestitems', array('materialrequestitems_table_id' => $tableid));
      $mritem = $query->row_array();
      $balance = $mritem['balanced_quantity'] - $this->input->post('IssuedQuantity');
      if($balance == 0){
        $status = "Completed";
      }
      else{
        $status = "Pending";
      }
      if($mritem != NULL){
        $data = array(
          'issued_quantity' => $mritem['issued_quantity'] + $this->input->post('IssuedQuantity'),
          'balanced_quantity' => $balance,
          'status' => $status
        );

        $this->db->where('materialrequestitems_table_id', $tableid);
        $this->db->update('materialrequestitems', $data);

        //modified 

        if($this->input->post('GatePassNo') == "" || $this->input->post('GatePassNo') === NULL)
          $gatePassNo = "None";
        else
          $gatePassNo = $this->input->post('GatePassNo');

        $data = array(
          'gatepass_no' => $gatePassNo,
          'product_code' => $mritem['product_code'],
          'quantity' => $this->input->post('IssuedQuantity'),
          'materialrequest_code' => $mritem['materialrequest_code'],
          'requestlocation_id' => 0,
          'destinationlocation_id' => 0,
          'description' => "Material Request Item Issue",
          'saved_user' => $this->session->userdata('user_id')
        );

        $this->db->insert('gatepasses', $data);       
        $gatepasses_tbl_id =  $this->db->insert_id(); 

        $locationdata = $this->db->get_where('locations', array('location' => $this->session->userdata('user_location')));
        $locationid = $locationdata->row_array();
        $query = $this->db->get_where('stocks', array('product_code' => $mritem['product_code'], 'location_id' => $locationid['locations_table_id']));
        $stockitem = $query->row_array();
        $qty = $stockitem['quantity'] - $this->input->post('IssuedQuantity');
        $data = array(
          'quantity' => $qty
        );

        $this->db->where('stocks_table_id', $stockitem['stocks_table_id']);
        $this->db->update('stocks', $data);

        $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
        $this->db->where('status', "Pending");
        $query = $this->db->get('materialrequestitems');
        $pending = $query->row_array();
        if($pending == NULL){
          $status = "Completed";
        }
        else{
          $status = "Pending";
        }
        $data = array(
          'materialrequest_status' => $status
        );

        $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
        $this->db->update('materialrequests', $data);

        //modified 
        $data = array(
          'materialrequest_code' => $mritem['materialrequest_code'],
          'product_code' => $mritem['product_code'],
          'requested_quantity' => $mritem['requested_quantity'],
          'issued_quantity' => $this->input->post('IssuedQuantity'),
          'balanced_quantity' => $balance,
          'quantity_type' => $mritem['quantity_type'],
          'status' => $status,
          'saved_user' => $this->session->userdata('user_id'),
          'gatepasses_table_id' => $gatepasses_tbl_id
        );
        $this->db->insert('issued_items', $data);


        return true;
      }
      else{
        return false;
      }
    }

    
  }
?>
