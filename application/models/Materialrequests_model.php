<?php

class Materialrequests_model extends CI_Model
{
    public function __construct()
    {
        $this->load->database();
    }

    public function get_mr($mrid = NULL)
    {
        if ($mrid === NULL) {
            if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
                $this->db->where('location =', $this->session->userdata('user_location'));
                $query = $this->db->get('locations');
                $locationid = $query->row()->locations_table_id;
                $query = $this->db->query("CALL materialrequests_procedure($locationid)");
            } else {
                $query = $this->db->query("CALL admin_materialrequests_procedure()");
            }
            mysqli_next_result($this->db->conn_id);
            return $query->result_array();
        }

        if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location =', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL one_materialrequest_procedure($locationid, '$mrid')");
        } else {
            $query = $this->db->query("CALL admin_one_materialrequest_procedure('$mrid')");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_mr_for_unsaved_po($mrid = NULL)
    {        
        $query = $this->db->query("CALL materialrequests_for_unsaved_po()");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_mr_for_saved_po($mrid = NULL)
    {        
        $query = $this->db->query("CALL materialrequests_for_saved_po()");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }
    

    public function get_mr_for_item_issue_window($mrid = NULL)
    {
        
        $query = $this->db->query("CALL get_mr_for_item_issue()");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_mr_for_approval()
    {
        if ($this->session->userdata('user_type') == 1 || $this->session->userdata('user_type') == 5) {
            $query = $this->db->query("CALL admin_pending_materialrequests_for_approval_procedure()");
            mysqli_next_result($this->db->conn_id);
            return $query->result_array();
        }
    }

    public function get_mr_by_no()
    {
        $this->db->order_by('materialrequest_code', 'ASC');
        $query = $this->db->get('materialrequests');
        return $query->result_array();
    }

    public function get_pendingmr()
    {
        if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location =', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL pending_materialrequests_procedure($locationid)");
        } else {
            $query = $this->db->query("CALL admin_pending_materialrequests_procedure()");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_pendingmrcount()
    {
        if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location =', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL pending_materialrequests_procedure($locationid)");
        } else {
            $query = $this->db->query("CALL admin_pending_materialrequests_procedure()");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->num_rows();
    }

    public function get_pendingmrforapprovalcount()
    {
        if ($this->session->userdata('user_type') == 1 || $this->session->userdata('user_type') == 5) {
            $query = $this->db->query("CALL admin_pending_materialrequests_for_approval_procedure()");
            mysqli_next_result($this->db->conn_id);
            return $query->num_rows();
        }
    }

    public function get_mritems($mrid)
    {
        $query = $this->db->query("CALL materialrequests_items_procedure('$mrid')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_mritem($tableid)
    {
        $query = $this->db->query("CALL one_materialrequests_item_procedure($tableid)");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_destinationlocations($tableid)
    {
        $this->db->where('materialrequestitems_table_id', $tableid);
        $query = $this->db->get('materialrequestitems');
        $mrid = $query->row()->materialrequest_code;
        $mritemqty = $query->row()->balanced_quantity;
        $mritemcode = $query->row()->product_code;
        $this->db->where('materialrequest_code', $mrid);
        $query = $this->db->get('materialrequests');
        $locationid = $query->row()->requester_location_id;
        $query = $this->db->query("CALL destination_locations_procedure($mritemqty, $mritemcode, $locationid)");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_pendingmritems($mrid)
    {
        if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location =', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL pending_materialrequests_items_procedure($locationid, '$mrid')");
        } else {
            $this->db->where('materialrequest_code =', $mrid);
            $query = $this->db->get('materialrequests');
            $locationid = $query->row()->requester_location_id;
            $query = $this->db->query("CALL admin_pending_materialrequests_items_procedure($locationid, '$mrid')");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function is_approved_mr($mrid)
    {
        $this->db->where('materialrequest_code', $mrid);
        $query = $this->db->get('materialrequests');
        $status = $query->row()->approve_status;
        if($status == 1)
            return true;
        else
            return false;
    }

    public function save_mr()
    {
        $query = $this->db->get_where('materialrequests', array('materialrequest_code' => $this->input->post('MRCode')));
        $existcode = $query->row_array();
        if ($existcode == NULL) {

            $data = array(
                'materialrequest_code' => str_replace(' ', '', $this->input->post('MRCode')),
                'requester_id' => $this->input->post('MRRequester'),
                'requester_location_id' => $this->input->post('MRRequesterLocation'),
                'project_code' => $this->input->post('MRProject'),
                'request_datetime' => $this->input->post('MRDateTime'),
                'materialrequest_status' => "Pending",
                'approve_status' => false,
                'saved_user' => $this->session->userdata('user_id')
            );
            $this->db->insert('materialrequests', $data);
            return true;
        } else {
            return false;
        }
    }

    public function approve_mr($mrid)
    {
        $query = $this->db->get_where('materialrequests', array('materialrequest_code' => $mrid));
        $existcode = $query->row_array();
        if ($existcode != NULL) {
            $data = array(
                'approve_status' => true
            );
            $this->db->where('materialrequest_code', $mrid);
            $this->db->update('materialrequests', $data);
            return true;
        } else {
            return false;
        }
    }

    /*public function save_mritems(){
      $query = $this->db->get_where('materialrequests', array('materialrequest_code' => $this->input->post('MRCode')));
      $mrstatus = $query->row()->materialrequest_status;
      $query = $this->db->get_where('materialrequestitems', array('materialrequest_code' => $this->input->post('MRCode'), 'product_code' => $this->input->post('MRItems')));
      $existproduct = $query->result_array();
      if($existproduct == NULL && $mrstatus == "Pending"){
        $data = array(
          'materialrequest_code' => $this->input->post('MRCode'),
          'product_code' => $this->input->post('MRItems'),
          'requested_quantity' => $this->input->post('MRItemQty'),
          'issued_quantity' => 0,
          'balanced_quantity' => $this->input->post('MRItemQty'),
          'quantity_type' => $this->input->post('QuantityType'),
          'status' => "Pending",
          'saved_user' => $this->session->userdata('user_id')
        );
        $this->db->insert('materialrequestitems', $data);
        return true;
      }
      else {
        return false;
      }
    }*/

    public function save_mritems($relative_list)
    {

        for ($i = 0; $i < count($relative_list); $i++) {

            $query = $this->db->get_where('materialrequests', array('materialrequest_code' => $relative_list[$i]['MRCode']));
            $mrstatus = $query->row()->materialrequest_status;
            $query = $this->db->get_where('materialrequestitems', array('materialrequest_code' => $relative_list[$i]['MRCode'], 'product_code' => $relative_list[$i]['Product']));
            $existproduct = $query->result_array();

            if ($existproduct == NULL && $mrstatus == "Pending") {
                $data[] = array(
                    'materialrequest_code' => $relative_list[$i]['MRCode'],
                    'product_code' => $relative_list[$i]['Product'],
                    'requested_quantity' => $relative_list[$i]['MRItemQty'],
                    'issued_quantity' => 0,
                    'balanced_quantity' => $relative_list[$i]['MRItemQty'],
                    'quantity_type' => $relative_list[$i]['QuantityType'],
                    'status' => "Pending",
                    'saved_user' => $this->session->userdata('user_id')
                );
            } else {
                return 'failed';
            }

        }


        try {
            for ($x = 0; $x < count($relative_list); $x++) {
                $this->db->insert('materialrequestitems', $data[$x]);
            }
            return 'success';

        } catch (Exception $e) {
            return 'failed';
        }

    }

    public function delete_mr($mrid)
    {
        $this->db->where('materialrequest_code', $mrid);
        $query = $this->db->get('materialrequestitems');
        if ($query->num_rows() == 0) {
            $this->db->where('materialrequest_code', $mrid);
            $query = $this->db->get('purchaseorders');
            if ($query->num_rows() == 0) {
                $query = $this->db->query("CALL delete_materialrequest_procedure('$mrid')");
                mysqli_next_result($this->db->conn_id);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public function delete_mritem($tableid)
    {
        $this->db->where('materialrequestitems_table_id', $tableid);
        $query = $this->db->get('materialrequestitems');
        $mritem = $query->row_array();

        $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
        $query = $this->db->get('materialrequests');
        $status = $query->row()->approve_status;


        $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
        $query = $this->db->get('purchaseorders');

        if ($query->num_rows() == 0 && $status == 0) {
            $query = $this->db->query("CALL delete_materialrequestitem_procedure($tableid)");
            mysqli_next_result($this->db->conn_id);
            return true;
        } else {
            return false;
        }
    }

    /*
   public function request_po($tableid){
      $this->db->where('materialrequestitems_table_id', $tableid);
      $query = $this->db->get('materialrequestitems');
      $mritem = $query->row_array();
      $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
      $query = $this->db->get('materialrequests');
      $mr = $query->row_array();
      if($mritem != NULL && $mr != NULL){
        $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
        $this->db->where('product_code', $mritem['product_code']);
        $query = $this->db->get('purchaseorders');
        $po = $query->row_array();
        $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
        $this->db->where('product_code', $mritem['product_code']);
        $query = $this->db->get('sitetransfers');
        $st = $query->row_array();
        if($po == NULL && $st == NULL){
          $data = array(
            'purchaseorder_no' => "",
            'materialrequest_code' => $mritem['materialrequest_code'],
            'product_code' => $mritem['product_code'],
            'quantity' => $mritem['balanced_quantity'],
            'supplier_code' => 0,
            'delivery_location_id' => 0,
            'po_date' => "",
            'delivery_date' => "",
            'po_status' => "Pending",
            'poitem_status' => "Pending",
            'saved_user' => $this->session->userdata('user_id')
          );
          $this->db->insert('purchaseorders', $data);
          return true;
        }
        else{
          return false;
        }
      }
    }
*/

    public function request_po($tableids)
    {
        try {
            for ($i = 0; $i < count($tableids); $i++) {

                //$message = $tableids[$i]['table_id'];
                //echo "<script>console.log( 'Debug Objects: " . count($tableids) . "' );</script>";

                $this->db->where('materialrequestitems_table_id', $tableids[$i]['table_id']);
                $query = $this->db->get('materialrequestitems');
                $mritem = $query->row_array();
                $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
                $query = $this->db->get('materialrequests');
                $mr = $query->row_array();
                if ($mritem != NULL && $mr != NULL) {
                    $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
                    $this->db->where('product_code', $mritem['product_code']);
                    $query = $this->db->get('purchaseorders');
                    $po = $query->row_array();
                    $this->db->where('materialrequest_code', $mritem['materialrequest_code']);
                    $this->db->where('product_code', $mritem['product_code']);
                    $query = $this->db->get('sitetransfers');
                    $st = $query->row_array();
                    if ($po == NULL && $st == NULL) {
                        $data = array(
                            'purchaseorder_no' => "",
                            'materialrequest_code' => $mritem['materialrequest_code'],
                            'product_code' => $mritem['product_code'],
                            'quantity' => $mritem['balanced_quantity'],
                            'supplier_code' => 0,
                            'delivery_location_id' => 0,
                            'po_date' => "",
                            'delivery_date' => "",
                            'po_status' => "Pending",
                            'poitem_status' => "Pending",
                            'saved_user' => $this->session->userdata('user_id')
                        );
                        $this->db->insert('purchaseorders', $data);


                    } else {
                        return false;
                    }
                }
            }

            return true;
        } catch (Exception $e) {
            return false;
        }

    }

    public function request_st()
    {
        $this->db->where('materialrequest_code', $this->input->post('MRCode'));
        $this->db->where('product_code', $this->input->post('ProductCode'));
        $query = $this->db->get('sitetransfers');
        $st = $query->row_array();
        $this->db->where('materialrequest_code', $this->input->post('MRCode'));
        $this->db->where('product_code', $this->input->post('ProductCode'));
        $query = $this->db->get('purchaseorders');
        $po = $query->row_array();
        if ($po == NULL && $st == NULL) {
            $data = array(
                'materialrequest_code' => $this->input->post('MRCode'),
                'category_code' => $this->input->post('CategoryCode'),
                'subcategory_1_code' => $this->input->post('SubCategory1Code'),
                'subcategory_2_code' => $this->input->post('SubCategory2Code'),
                'subcategory_3_code' => $this->input->post('SubCategory3Code'),
                'product_code' => $this->input->post('ProductCode'),
                'requested_quantity' => $this->input->post('RequestingQty'),
                'transferred_quantity' => 0,
                'requested_location' => $this->input->post('RequestingLocationID'),
                'destination_location' => $this->input->post('DestinationLocation'),
                'saved_user' => $this->session->userdata('user_id')
            );
            $this->db->insert('sitetransfers', $data);
            return true;
        } else {
            return false;
        }
    }

    public function pending_mr_for_itemissue($mrid)
    {           
        $query = $this->db->query("CALL reports_item_issue('$mrid')");        
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }



}

?>
