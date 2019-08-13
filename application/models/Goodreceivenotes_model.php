<?php

class Goodreceivenotes_model extends CI_Model
{
    public function __construct()
    {
        $this->load->database();
    }

    public function get_grn($tableid = NULL)
    {
        if ($tableid === NULL) {
            $query = $this->db->query("CALL goodreceivenotes_procedure()");
            mysqli_next_result($this->db->conn_id);
            return $query->result_array();
        }

        $query = $this->db->query("CALL one_goodreceivenote_procedure($tableid)");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_po_grn($poid)
    {
        $query = $this->db->query("CALL purchaseorder_goodreceivenotes_procedure('$poid')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

//    public function save_grn(){
//      $this->db->where('goodreceivenote_no =', $this->input->post('GoodReceivedNoteNo'));
//      $query = $this->db->get('goodreceivenotes');
//      $existgrn = $query->row_array();
//      $this->db->where('purchaseorder_no =', $this->input->post('PurchaseOrderNo'));
//      $this->db->where('grn_status =', "Completed");
//      $query = $this->db->get('goodreceivenotes');
//      $completedgrn = $query->row_array();
//      if($existgrn == NULL && $completedgrn == NULL){
//        $this->db->where('purchaseorder_no =', $this->input->post('PurchaseOrderNo'));
//        $query = $this->db->get('goodreceivenotes');
//        $existpo = $query->row_array();
//        if($existpo == NULL){
//          $this->db->where('purchaseorder_no =', $this->input->post('PurchaseOrderNo'));
//          $query = $this->db->get('purchaseorders');
//          $qty = $query->row()->quantity;
//          $balancedquantity = $qty - $this->input->post('GoodReceivedQty');
//          if($balancedquantity >= 0){
//            if($balancedquantity == 0){
//              $status = "Completed";
//            }
//            else{
//              $status = "Pending";
//            }
//          }
//          else{
//            return false;
//          }
//        }
//        else{
//          $this->db->where('purchaseorder_no =', $this->input->post('PurchaseOrderNo'));
//          $this->db->select_min('balanced_quantity');
//          $query = $this->db->get('goodreceivenotes');
//          $qty = $query->row()->balanced_quantity;
//          $balancedquantity = $qty - $this->input->post('GoodReceivedQty');
//          if($balancedquantity >= 0){
//            if($balancedquantity == 0){
//              $status = "Completed";
//            }
//            else{
//              $status = "Pending";
//            }
//          }
//          else {
//            return false;
//          }
//        }
//        if ($this->input->post('GoodReceivedNoteNo') != null) {
//          $grn = $this->input->post('GoodReceivedNoteNo');
//        }
//        else {
//          $grn = "";
//        }
//        $data = array(
//          'goodreceivenote_no' => $grn,
//          'purchaseorder_no' => $this->input->post('PurchaseOrderNo'),
//          'goodreceived_date' => $this->input->post('GoodReceivedDate'),
//          'received_quantity' => $this->input->post('GoodReceivedQty'),
//          'balanced_quantity' => $balancedquantity,
//          'invoice_no' => $this->input->post('InvoiceNumber'),
//          'grn_status' => $status,
//          'saved_user' => $this->session->userdata('user_id')
//        );
//        $this->db->insert('goodreceivenotes', $data);
//
//        $data = array(
//          'poitem_status' => $status
//        );
//        $this->db->where('purchaseorder_no', $this->input->post('PurchaseOrderNo'));
//        $this->db->update('purchaseorders', $data);
//
//        $this->db->where('purchaseorder_no =', $this->input->post('PurchaseOrderNo'));
//        $query = $this->db->get('purchaseorders');
//        $po = $query->row_array();
//        $this->db->where('product_code =', $po['product_code']);
//        $this->db->where('location_id =', $po['delivery_location_id']);
//        $query = $this->db->get('stocks');
//        if ($query->num_rows() == 1){
//          $qty = $query->row()->quantity;
//          $tot_qty = $qty + $this->input->post('GoodReceivedQty');
//          $data = array(
//            'quantity' => $tot_qty
//          );
//          $this->db->where('product_code', $po['product_code']);
//          $this->db->where('location_id', $po['delivery_location_id']);
//          $this->db->update('stocks', $data);
//          return true;
//        }
//        else{
//          $data = array(
//            'product_code' => $po['product_code'],
//            'quantity' => $this->input->post('GoodReceivedQty'),
//            'location_id' => $po['delivery_location_id']
//          );
//          $this->db->insert('stocks', $data);
//          return true;
//        }
//      }
//      else{
//        return false;
//      }
//    }

    public function save_deliverynote()
    {
        $this->db->where('goodreceivenote_no =', $this->input->post('GoodReceivedNoteNo'));
        $query = $this->db->get('goodreceivenotes');
        $existgrn = $query->row_array();
        if ($existgrn == NULL) {
            $data = array(
                'goodreceivenote_no' => $this->input->post('GoodReceivedNoteNo')
            );

            $this->db->where('goodreceivenotes_table_id', $this->input->post('GoodreceivenoteTableNo'));
            $this->db->update('goodreceivenotes', $data);
            return true;
        } else {
            return false;
        }
    }

    public function get_grn_by_date($FromDate, $ToDate)
    {
        $query = $this->db->query("CALL reports_good_received_notes_for_period('$FromDate', '$ToDate')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_grn_by_grn_no($GrnNo)
    {
        $query = $this->db->query("CALL reports_good_received_notes_by_grn_no('$GrnNo')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function get_grn_by_project($FromDate, $ToDate, $ProjectID)
    {
        $query = $this->db->query("CALL reports_good_received_notes_for_project('$FromDate', '$ToDate', '$ProjectID')");
        mysqli_next_result($this->db->conn_id);
        return $query->result_array();
    }

    public function save_grn($save_list)
    {
        //Qty entered items
      $data = $save_list;
        // check  goodrecievenote no already exist
      $this->db->where('goodreceivenote_no', $data[0]['GoodReceivedNoteNo']);
      $query = $this->db->get('goodreceivenotes');
      $existgrn = $query->row_array();
      if ($existgrn != NULL)        
        return false;  
      $count = 0;
      //Start loop
      for ($i=0; $i < count($save_list); $i++) { 

        //check status complete for po - goodrecievenote        
        $this->db->where('purchaseorders_table_id =', $data[$i]['PurchaseordersTableId']);
        $this->db->where('grn_status =', "Completed");
        $query = $this->db->get('goodreceivenotes');
        $completedgrn = $query->row_array();

         //if not complete 
        if ($completedgrn === NULL) 
        {
              //check pono already exist - goodrecievednote
              $this->db->where('purchaseorders_table_id =', $data[$i]['PurchaseordersTableId']);        
              $query = $this->db->get('goodreceivenotes');
              $existpo = $query->row_array();

              //not exist
              if ($existpo === NULL)
              {
                  //get qty for pono - purchaseorders
                    $this->db->where('purchaseorders_table_id =', $data[$i]['PurchaseordersTableId']);
                    $query = $this->db->get('purchaseorders');
                    $qty = $query->row()->quantity;
                    //balance qty = qty - grn qty
                    $balancedquantity = $qty - $data[$i]['GoodReceivedQty'];
                    //balance qty >= 0
                    if($balancedquantity >= 0)
                    {
                      //balance qty == 0 ? completed : Pending
                      if($balancedquantity == 0)
                        $status = "Completed";
                      else
                        $status = "Pending";
                    }
                    else
                    {
                      return false;
                    }                    
                    
              }
              else
              {
                     //pono exists
                     $this->db->where('purchaseorders_table_id =', $data[$i]['PurchaseordersTableId']);
                     //get min balance qty
                     $this->db->select_min('balanced_quantity');
                     $query = $this->db->get('goodreceivenotes');
                     $qty = $query->row()->balanced_quantity;
                     $balancedquantity =  $qty - $data[$i]['GoodReceivedQty'];
                     if($balancedquantity >= 0)
                     {
                        //balance qty == 0 ? completed : Pending
                        if($balancedquantity == 0)
                          $status = "Completed";
                        else
                          $status = "Pending";
                     }
                     else
                     {
                        return false;
                     }                
              }

              if ($data[$i]['GoodReceivedNoteNo'] !== null) 
              {
                    $grn = $data[$i]['GoodReceivedNoteNo'];
              }
              else 
              {
                    $grn = "";
              }
              //save grn- goodecievenote
               $row = array(
                  'goodreceivenote_no' => $grn,
                  'purchaseorder_no' => $data[$i]['PurchaseOrderNo'],
                  'goodreceived_date' => $data[$i]['GoodReceivedDate'],
                  'received_quantity' => $data[$i]['GoodReceivedQty'],
                  'balanced_quantity' => $balancedquantity,
                  'invoice_no' => $data[$i]['InvoiceNumber'],
                  'grn_status' => $status,
                  'saved_user' => $this->session->userdata('user_id'),
                  'purchaseorders_table_id' => $data[$i]['PurchaseordersTableId']
              );              
              $this->db->insert('goodreceivenotes', $row);

              //update po table
              $row = array(
                'poitem_status' => $status
              );              
              $this->db->where('purchaseorders_table_id =', $data[$i]['PurchaseordersTableId']);
              $this->db->update('purchaseorders', $row);

              //get po details for get stock table
              $this->db->where('purchaseorders_table_id =', $data[$i]['PurchaseordersTableId']);
              $query = $this->db->get('purchaseorders');
              $po = $query->row_array();
              $this->db->where('product_code =', $po['product_code']);
              $this->db->where('location_id =', $po['delivery_location_id']);
              $query = $this->db->get('stocks');
              //update stock table or insert
              if ($query->num_rows() == 1)
              {
                  $qty = $query->row()->quantity;
                  $tot_qty = $qty + $data[$i]['GoodReceivedQty'];
                  $row = array(
                    'quantity' => $tot_qty
                  );
                  $this->db->where('product_code', $po['product_code']);
                  $this->db->where('location_id', $po['delivery_location_id']);
                  $this->db->update('stocks', $row);
                   
              }
              else
              {
                  $row = array(
                    'product_code' => $po['product_code'],
                    'quantity' => $data[$i]['GoodReceivedQty'],
                    'location_id' => $po['delivery_location_id']
                  );
                  $this->db->insert('stocks', $row);                  
              }                

        }
        else
        {
          return false;
        }       
        
      }   
      //End loop  
       return true;          
          
    }
 
}

?>
