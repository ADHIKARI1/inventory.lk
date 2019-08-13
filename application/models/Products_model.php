<?php
  class Products_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_products($productid = NULL){
      if ($productid === NULL){
        $query = $this->db->query("CALL products_procedure()");
        mysqli_next_result( $this->db->conn_id );
        return $query->result_array();
      }

      $query = $this->db->query("CALL one_product_procedure($productid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function get_products_by_name(){
      $this->db->order_by('product_name','ASC');
      $query = $this->db->get('products');
      return $query->result_array();
    }

    public function get_supplierproducts($supplierid){
      $query = $this->db->query("CALL supplier_products_procedure($supplierid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->result_array();
    }

    public function get_productlocations(){
      $this->db->order_by('productlocation','ASC');
      $query = $this->db->get('productlocations');
      return $query->result_array();
    }

    public function save_product(){

      try {

            $this->db->where('product_name', $this->input->post('ProductName'));
            $this->db->where('category_code', $this->input->post('CategoryCode'));
            $this->db->where('subcategory_1_code', $this->input->post('SubCategory1Code'));
            $this->db->where('subcategory_2_code', $this->input->post('SubCategory2Code'));
            $this->db->where('subcategory_3_code', $this->input->post('SubCategory3Code'));
            $query = $this->db->get('products');
            $existname = $query->row_array();

           /*$this->db->where('product_code =', $po['product_code']);
            $this->db->where('location_id =', $po['delivery_location_id']);
            $stockquery = $this->db->get('stocks');*/

            if($existname == NULL)
            {
                $this->db->select_max('product_code');
                $query = $this->db->get('products');
                $maxid = $query->row()->product_code + 1;
                $data = array(
                  'product_code' => $maxid,
                  'product_name' => $this->input->post('ProductName'),
                  'category_code' => $this->input->post('CategoryCode'),
                  'subcategory_1_code' => $this->input->post('SubCategory1Code'),
                  'subcategory_2_code' => $this->input->post('SubCategory2Code'),
                  'subcategory_3_code' => $this->input->post('SubCategory3Code'),
                  'product_location_id' => $this->input->post('ProductLocation'),
                  'product_description' =>$this->input->post('ProductDescription'),
                  'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('products', $data);

                $data = array(
                    'product_code' => $maxid,
                    'quantity' => $this->input->post('Quantity'),
                    'quantity_type' => $this->input->post('QuantityType'),
                    'location_id' => $this->input->post('ProductLocation')
                  );
                $this->db->insert('stocks', $data);
                return true;
            }
            else{
              return false;
            }
        
      } catch (Exception $e) {
            return false;
      }
    }

    public function update_product(){

      try {
            $this->db->where('product_name =', $this->input->post('ProductName'));
            $this->db->where('category_code =', $this->input->post('CategoryCode'));
            $this->db->where('subcategory_1_code =', $this->input->post('SubCategory1Code'));
            $this->db->where('product_code !=', $this->input->post('ProductCode'));
            $query = $this->db->get('products');
            $existname = $query->row_array();
            if($existname == NULL)
            {
                $data = array(
                  'product_name' => $this->input->post('ProductName'),
                  'category_code' => $this->input->post('CategoryCode'),
                  'subcategory_1_code' => $this->input->post('SubCategory1Code'),
                  'subcategory_2_code' => $this->input->post('SubCategory2Code'),
                  'subcategory_3_code' => $this->input->post('SubCategory3Code'),
                  'product_location_id' => $this->input->post('ProductLocation'),
                  'product_description' =>$this->input->post('ProductDescription')
                );

                $this->db->where('product_code =', $this->input->post('ProductCode'));
                $this->db->update('products', $data);

                $this->db->where('product_code =', $this->input->post('ProductCode'));
                $this->db->where('location_id =', $this->input->post('ProductLocation'));
                $stockquery = $this->db->get('stocks');

                if ($stockquery->num_rows() == 1) 
                {
                  $data = array(                  
                  'quantity' => $this->input->post('Quantity'),
                  'quantity_type' => $this->input->post('QuantityType')
                  );
                  $this->db->where('product_code =', $this->input->post('ProductCode'));
                  $this->db->where('location_id =', $this->input->post('ProductLocation'));
                  $this->db->update('stocks', $data);
                }
                else
                {
                  $this->db->where(['product_code'=>  $this->input->post('ProductCode')]);
                  $this->db->delete('stocks');

                  $data = array(
                  'product_code' => $this->input->post('ProductCode'),
                  'quantity' => $this->input->post('Quantity'),
                  'quantity_type' => $this->input->post('QuantityType'),
                  'location_id' => $this->input->post('ProductLocation')
                  );                
                  $this->db->insert('stocks', $data);
                }               
                return true;
            }
            else{
                return false;
            }
        
      } catch (Exception $e) {
            die($e);
            return false;
      }

    }

    public function delete_product($productid){
      $this->db->where('product_code', $productid);
      $query = $this->db->get('materialrequestitems');
      if($query->num_rows() == 0){
        $this->db->where('product_code', $productid);
        $query = $this->db->get('purchaseorders');
        if($query->num_rows() == 0){
          $this->db->where('product_code', $productid);
          $query = $this->db->get('stocks');
          if($query->row()->quantity == 0 || $query->num_rows() == 0){
            $query = $this->db->query("CALL delete_product_procedure($productid)");
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
      else {
        return false;
      }
    }

  }
?>
