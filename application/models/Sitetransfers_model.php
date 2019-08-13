<?php

class Sitetransfers_model extends CI_Model
{
    public function __construct()
    {
        $this->load->database();
    }

    public function get_sitetransfers()
    {
        if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL sitetransfers_procedure($locationid)");
        } else {
            $query = $this->db->query("CALL admin_sitetransfers_procedure()");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_pendingst()
    {
        if ($this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location =', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL pending_sitetransfers_procedure($locationid)");
        } else {
            $query = $this->db->query("CALL admin_pending_sitetransfers_procedure()");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_pendingstcount()
    {
        if ($this->session->userdata('user_type') != null && $this->session->userdata('user_type') != 1 && $this->session->userdata('user_type') != 4) {
            $this->db->where('location =', $this->session->userdata('user_location'));
            $query = $this->db->get('locations');
            $locationid = $query->row()->locations_table_id;
            $query = $this->db->query("CALL pending_sitetransfers_procedure($locationid)");
        } else {
            $query = $this->db->query("CALL admin_pending_sitetransfers_procedure()");
        }
        mysqli_next_result($this->db->conn_id);
        return $query->num_rows();
    }

    public function issue_items()
    {
        $this->db->where('sitetransfers_table_id', $this->input->post('SiteTranferNo'));
        $query = $this->db->get('sitetransfers');
        $st = $query->row_array();
        $query = $this->db->get_where('materialrequestitems', array('materialrequest_code' => $st['materialrequest_code'], 'product_code' => $st['product_code']));
        $mritem = $query->row_array();
        $balance = 0;
        $status = "Completed";
        if ($mritem != NULL) {
            $data = array(
                'issued_quantity' => $st['requested_quantity'],
                'balanced_quantity' => $balance,
                'status' => $status
            );

            $this->db->where('materialrequest_code', $st['materialrequest_code']);
            $this->db->where('product_code', $st['product_code']);
            $this->db->update('materialrequestitems', $data);

            $data = array(
                'gatepass_no' => $this->input->post('GatePassNo'),
                'product_code' => $st['product_code'],
                'quantity' => $st['requested_quantity'],
                'materialrequest_code' => $st['materialrequest_code'],
                'requestlocation_id' => $st['requested_location'],
                'destinationlocation_id' => $st['destination_location'],
                'description' => "Material Request Site Transfer Item Issue",
                'saved_user' => $this->session->userdata('user_id')
            );

            $this->db->insert('gatepasses', $data);

            $query = $this->db->get_where('stocks', array('product_code' => $st['product_code'], 'location_id' => $st['destination_location']));
            $stockitem = $query->row_array();
            $qty = $stockitem['quantity'] - $st['requested_quantity'];
            $data = array(
                'quantity' => $qty
            );

            $this->db->where('stocks_table_id', $stockitem['stocks_table_id']);
            $this->db->update('stocks', $data);

            $query = $this->db->get_where('stocks', array('product_code' => $st['product_code'], 'location_id' => $st['requested_location']));
            $stockitem = $query->row_array();
            $qty = $stockitem['quantity'] + $st['requested_quantity'];
            $data = array(
                'quantity' => $qty
            );

            $this->db->where('stocks_table_id', $stockitem['stocks_table_id']);
            $this->db->update('stocks', $data);

            $this->db->where('materialrequest_code', $st['materialrequest_code']);
            $this->db->where('status', "Pending");
            $query = $this->db->get('materialrequestitems');
            $pending = $query->row_array();
            if ($pending == NULL) {
                $status = "Completed";
            } else {
                $status = "Pending";
            }
            $data = array(
                'materialrequest_status' => $status
            );

            $this->db->where('materialrequest_code', $st['materialrequest_code']);
            $this->db->update('materialrequests', $data);

            $data = array(
                'transferred_quantity' => $st['requested_quantity']
            );

            $this->db->where('sitetransfers_table_id', $this->input->post('SiteTranferNo'));
            return $this->db->update('sitetransfers', $data);
        } else {
            return false;
        }
    }

    public function transfer_items()
    {
        $this->db->where('location', $this->session->userdata('user_location'));
        $query = $this->db->get('locations');
        $locationid = $query->row()->locations_table_id;
        $this->db->where('location_id', $locationid);
        $this->db->where('product_code', $this->input->post('STItems'));
        $query = $this->db->get('stocks');
        $existqty = $query->row()->quantity;
        if ($this->input->post('STItemQty') <= $existqty) {
            $this->db->where('product_code', $this->input->post('STItems'));
            $this->db->where('location_id', $this->input->post('DestinationLocation'));
            $query = $this->db->get('stocks');
            if ($query->num_rows() == 1) {
                $qty = $query->row()->quantity;
                $tot_qty = $qty + $this->input->post('STItemQty');
                $data = array(
                    'quantity' => $tot_qty
                );
                $this->db->where('product_code', $this->input->post('STItems'));
                $this->db->where('location_id', $this->input->post('DestinationLocation'));
                $this->db->update('stocks', $data);
            } else {
                $data = array(
                    'product_code' => $this->input->post('STItems'),
                    'quantity' => $this->input->post('STItemQty'),
                    'location_id' => $this->input->post('DestinationLocation')
                );
                $this->db->insert('stocks', $data);
            }

            $this->db->where('product_code', $this->input->post('STItems'));
            $this->db->where('location_id', $locationid);
            $query = $this->db->get('stocks');
            $qty = $query->row()->quantity;
            $tot_qty = $qty - $this->input->post('STItemQty');
            $data = array(
                'quantity' => $tot_qty
            );
            $this->db->where('product_code', $this->input->post('STItems'));
            $this->db->where('location_id', $locationid);
            $this->db->update('stocks', $data);

            $data = array(
                'materialrequest_code' => 0,
                'category_code' => $this->input->post('CategoryCode'),
                'subcategory_1_code' => $this->input->post('SubCategory1Code'),
                'subcategory_2_code' => $this->input->post('SubCategory2Code'),
                'subcategory_3_code' => $this->input->post('SubCategory3Code'),
                'product_code' => $this->input->post('STItems'),
                'requested_quantity' => $this->input->post('STItemQty'),
                'transferred_quantity' => $this->input->post('STItemQty'),
                'requested_location' => $locationid,
                'destination_location' => $this->input->post('DestinationLocation'),
                'approved_status' => 0,
                'saved_user' => $this->session->userdata('user_id')
            );
            return $this->db->insert('sitetransfers', $data);
        } else {
            return false;
        }
    }

    public function save_transfer_items() {
        $this->db->where('location', $this->session->userdata('user_location'));
        $query = $this->db->get('locations');
        $locationid = $query->row()->locations_table_id;
        $data = array(
            'gatepass_no' => $this->input->post('GatePassNo'),
            'product_code' => $this->input->post('STItems'),
            'quantity' => $this->input->post('STItemQty'),
            'materialrequest_code' => 0,
            'requestlocation_id' => $locationid,
            'destinationlocation_id' => $this->input->post('DestinationLocation'),
            'description' => "Site Transfer Item Transfer",
            'saved_user' => $this->session->userdata('user_id')
        );

        return $this->db->insert('gatepasses', $data);
    }

    public function approve_st($mrid)
    {
        $query = $this->db->get_where('sitetransfers', array('materialrequest_code' => $mrid));
        $existcode = $query->row_array();
        if ($existcode != NULL) {
            $data = array(
                'approve_status' => true
            );
            $this->db->where('materialrequest_code', $mrid);
            $this->db->update('sitetransfers', $data);
            return true;
        } else {
            return false;
        }
    }    
}

?>
