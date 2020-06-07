<?php
  class Suppliers_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_suppliers($supplierid = NULL){
      if ($supplierid === NULL){
        $query = $this->db->query("CALL suppliers_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_supplier_procedure($supplierid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_suppliers_by_name(){
      $this->db->order_by('supplier_name','ASC');
      $query = $this->db->get('suppliers');
      return $query->result_array();
    }

    public function get_suppliers_productwise($tableid){

      $this->db->where('purchaseorders_table_id =', $tableid);
      $query = $this->db->get('purchaseorders');
      $productid = $query->row()->product_code;
      $this->db->where('product_code =', $productid);
      $query = $this->db->get('products');
      $categoryid = $query->row()->category_code;
      $subcategory1id = $query->row()->subcategory_1_code;
      $subcategory2id = $query->row()->subcategory_2_code;
      $subcategory3id = $query->row()->subcategory_3_code;
      $query = $this->db->query("CALL supplier_productwise_procedure($categoryid,$subcategory1id,$subcategory2id,$subcategory3id)");
      mysqli_next_result( $this->db->conn_id );
      return $query->result_array();
    }

    public function save_supplier(){
      $query = $this->db->get_where('suppliers', array('supplier_name' => $this->input->post('SupplierName')));
      $existname = $query->row_array();
      if($existname == NULL){
        $this->db->select_max('supplier_code');
        $query = $this->db->get('suppliers');
        $maxid = $query->row()->supplier_code + 1;
        $data = array(
          'supplier_code' => $maxid,
          'supplier_name' => $this->input->post('SupplierName'),
          'supplier_address' => $this->input->post('SupplierAddress'),
          'supplier_contact_no1' => $this->input->post('SupplierContact1'),
          'supplier_contact_no2' => $this->input->post('SupplierContact2'),
          'supplier_email1' => $this->input->post('SupplierEmail1'),
          'supplier_email2' => $this->input->post('SupplierEmail2'),
          'supplier_fax_no1' => $this->input->post('SupplierFax1'),
          'supplier_fax_no2' => $this->input->post('SupplierFax2'),
          'supplier_description' =>$this->input->post('SupplierDescription'),
          'saved_user' => $this->session->userdata('user_id')
        );
        return $this->db->insert('suppliers', $data);
      }
      else{
        return false;
      }
    }

    public function save_supplierproducts(){
      for ($i=0; $i < count($this->input->post('SubCategory1Code')) ; $i++) {
        $subcategory1code = $this->input->post('SubCategory1Code')[$i];
        $query = $this->db->get_where('subcategories_3', array('subcategory_1_code' => $subcategory1code));
        $array = $query->result_array();
        foreach ($array as $currentitem) {
          $query = $this->db->get_where('supplierproducts', array('supplier_code' => $this->input->post('SupplierCode'), 'category_code' => $currentitem['category_code'], 'subcategory_1_code' => $currentitem['subcategory_1_code'], 'subcategory_2_code' => $currentitem['subcategory_2_code'], 'subcategory_3_code' => $currentitem['subcategory_3_code']));
          $existproduct = $query->row_array();
          if($existproduct == NULL){
            $data = array(
              'supplier_code' => $this->input->post('SupplierCode'),
              'category_code' => $currentitem['category_code'],
              'subcategory_1_code' => $currentitem['subcategory_1_code'],
              'subcategory_2_code' => $currentitem['subcategory_2_code'],
              'subcategory_3_code' => $currentitem['subcategory_3_code'],
              'saved_user' => $this->session->userdata('user_id')
            );
            $this->db->insert('supplierproducts', $data);
          }
        }
      }

      return true;
    }

    public function update_supplier(){
      $this->db->where('supplier_name =', $this->input->post('SupplierName'));
      $this->db->where('supplier_code !=', $this->input->post('SupplierCode'));
      $query = $this->db->get('suppliers');
      $existname = $query->row_array();
      if($existname == NULL){
        $data = array(
          'supplier_name' => $this->input->post('SupplierName'),
          'supplier_address' => $this->input->post('SupplierAddress'),
          'supplier_contact_no1' => $this->input->post('SupplierContact1'),
          'supplier_contact_no2' => $this->input->post('SupplierContact2'),
          'supplier_email1' => $this->input->post('SupplierEmail1'),
          'supplier_email2' => $this->input->post('SupplierEmail2'),
          'supplier_fax_no1' => $this->input->post('SupplierFax1'),
          'supplier_fax_no2' => $this->input->post('SupplierFax2'),
          'supplier_description' =>$this->input->post('SupplierDescription')
        );

        $this->db->where('supplier_code', $this->input->post('SupplierCode'));
        return $this->db->update('suppliers', $data);
      }
      else{
        return false;
      }
    }

    public function delete_supplier($supplierid){
      $this->db->where('supplier_code', $supplierid);
      $query = $this->db->get('supplierproducts');
      if($query->num_rows() == 0){
        $this->db->where('supplier_code', $supplierid);
        $query = $this->db->get('purchaseorders');
        if($query->num_rows() == 0){
          $query = $this->db->query("CALL delete_supplier_procedure($supplierid)");
          mysqli_next_result( $this->db->conn_id );
          return true;
        }
        else {
          return false;
        }
      }
      else {
        return false;
      }
    }

    public function delete_supplierproduct($tableid){
      $this->db->where('supplierproducts_table_id', $tableid);
      $this->db->delete('supplierproducts');
      return true;
    }

    public function delete_bulk_supplierproducts($table_ids = array())
    {
        if(is_array($table_ids))
        {
          foreach($table_ids as $id){
             $this->db->delete('supplierproducts', array('supplierproducts_table_id' => $id));
          }
          return true;
        }        
        return false;
    }

    public function get_supplier_by_po($po = NULL)
    {
        $query = $this->db->query("CALL supplier_by_po_no('$po')");
        mysqli_next_result( $this->db->conn_id );
        return $query->row_array();
    }
  }
?>
