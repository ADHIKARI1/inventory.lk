<?php

class Purchaseorders_model extends CI_Model
{
    public function __construct()
    {
        $this->load->database();
    }

    public function get_po($tableid = NULL)
    {
        if ($tableid === NULL) {
            $query = $this->db->query("CALL purchaseorders_procedure()");
            mysqli_next_result($this->db->conn_id);
            return $query->result_array();
        }

        $query = $this->db->query("CALL one_purchaseorder_procedure($tableid)");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_po_no($poid)
    {
        $query = $this->db->query("CALL one_purchaseorder_by_pono_procedure('$poid')");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_unsavedpocount()
    {
        $query = $this->db->query("CALL unsaved_purchaseorders_procedure()");
        mysqli_next_result($this->db->conn_id);
        return $query->num_rows();
    }

    public function get_unsavedpo()
    {
        $query = $this->db->query("CALL unsaved_purchaseorders_procedure()");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_unsavedpo_by_mr($mrcode)
    {
        $query = $this->db->query("CALL unsaved_purchaseorders_by_mrcode('$mrcode')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_pendingpocount()
    {
        $query = $this->db->query("CALL pending_purchaseorders_procedure()");
        mysqli_next_result($this->db->conn_id);
        return $query->num_rows();
    }

    public function get_pendingpo()
    {
        $query = $this->db->query("CALL pending_purchaseorders_procedure()");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_po_details($tableid)
    {
        $query = $this->db->query("CALL one_purchaseorder_procedure($tableid)");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_po_by_no()
    {
        $this->db->order_by('purchaseorder_no', 'ASC');
        $this->db->where('purchaseorder_no !=', '');
        $query = $this->db->get('purchaseorders');
        return $query->result_array();
    }

    public function get_po_nos()
    {       
        $this->db->distinct('purchaseorder_no');
        $this->db->select('purchaseorder_no');
        $query = $this->db->get('purchaseorders');
        $this->db->where('purchaseorder_no !=', '');
        return $query->result_array();
    }

    /*public function save_po(){
      $this->db->where('purchaseorder_no =', $this->input->post('PurchaseOrderNo'));
      $query = $this->db->get('purchaseorders');
      $existpo = $query->row_array();
      if($existpo == NULL){
        $data = array(
          'purchaseorder_no' => $this->input->post('PurchaseOrderNo'),
          'po_date' => $this->input->post('PODate'),
          'delivery_location_id' => $this->input->post('DeliveryLocation'),
          'supplier_code' => $this->input->post('SupplierCode'),
          'delivery_date' => $this->input->post('PODeliveryDate'),
          'po_status' => "Saved"
        );

        $this->db->where('purchaseorders_table_id', $this->input->post('PurchaseOrderTableNo'));
        return $this->db->update('purchaseorders', $data);
      }
      else{
        return false;
      }
    }*/

//    public function save_po($save_list){
//
//      $status = false;
//      for ($i=0; $i < count($save_list); $i++) {
//        $this->db->where('purchaseorder_no =', $save_list[$i]['purchaseorder_no']);
//        $query = $this->db->get('purchaseorders');
//        $existpo = $query->row_array();
//        if($existpo == NULL)
//        $status = true;
//      }
//
//      try {
//
//        if ($status)
//        {
//           for ($i=0; $i < count($save_list); $i++)
//           {
//             $data = array(
//              'purchaseorder_no' =>  $save_list[$i]['purchaseorder_no'],
//              'po_date' => $save_list[$i]['po_date'],
//              'delivery_location_id' => $save_list[$i]['delivery_location'],
//              'supplier_code' => $save_list[$i]['supplier_code'],
//              'delivery_date' => $save_list[$i]['delivery_date'],
//              'po_status' => "Saved"
//              );
//             $this->db->where('purchaseorders_table_id', $save_list[$i]['purchaseorders_table_id']);
//             $this->db->update('purchaseorders', $data);
//          }
//         return 'success';
//
//        }
//        else
//        {
//          return 'failed';
//        }
//
//      } catch (Exception $e) {
//        return 'failed';
//      }
//
//    }

    public function save_po($save_list)
    {

        $status = false;
        for ($i = 0; $i < count($save_list); $i++) {
            $this->db->where('purchaseorder_no =', $save_list[$i]['purchaseorder_no']);
            $query = $this->db->get('purchaseorders');
            $existpo = $query->row_array();
            if ($existpo == NULL)
                $status = true;
        }

        try {

            if ($status) {
                for ($i = 0; $i < count($save_list); $i++) {
                    $data = array(
                        'purchaseorder_no' => $save_list[$i]['purchaseorder_no'],
                        'po_date' => $save_list[$i]['po_date'],
                        'delivery_location_id' => $save_list[$i]['delivery_location'],
                        'supplier_code' => $save_list[$i]['supplier_code'],
                        'delivery_date' => $save_list[$i]['delivery_date'],
                        'po_status' => "Saved"
                    );
                    $this->db->where('purchaseorders_table_id', $save_list[$i]['purchaseorders_table_id']);
                    $this->db->update('purchaseorders', $data);
                }
                return 'success';

            } else {
                return 'failed';
            }

        } catch (Exception $e) {
            return 'failed';
        }

    }

    public function delete_po($tableid)
    {
        $this->db->where('purchaseorders_table_id', $tableid);
        $query = $this->db->get('purchaseorders');
        $po = $query->row_array();
        $this->db->where('purchaseorder_no', $po['purchaseorder_no']);
        $query = $this->db->get('goodreceivenotes');
        if ($query->num_rows() == 0 || $po['po_status'] == "Pending") {
            $query = $this->db->query("CALL delete_purchaseorder_procedure($tableid)");
            mysqli_next_result($this->db->conn_id);
            return true;
        } else {
            return false;
        }
    }

    public function get_po_by_date($FromDate, $ToDate)
    {
        $query = $this->db->query("CALL reports_purchase_orders_for_period('$FromDate', '$ToDate')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_po_by_project($FromDate, $ToDate, $ProjectID)
    {
        $query = $this->db->query("CALL reports_purchase_orders_for_project('$FromDate', '$ToDate', '$ProjectID')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_pendingpo_for_report()
    {
        $query = $this->db->query("CALL reports_pending_purchase_orders()");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_savedpo_by_mr($mrcode){
        $query = $this->db->query("CALL saved_purchase_orders_by_mr('$mrcode')");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
    }

    public function get_savedpo_by_pono($pono = NULL){
        $query = $this->db->query("CALL saved_purchaseorders_by_pono('$pono')");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
    }    
}

?>
