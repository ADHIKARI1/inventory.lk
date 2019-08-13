<?php
  class Reports_model extends CI_Model{
    public function __construct(){
        $this->load->database();
    }

    public function get_reports(){
      $query = $this->db->query("CALL reports_procedure()");
      mysqli_next_result( $this->db->conn_id );
      return $query->result_array();
    }

    public function get_report_by_id($reportsid){
      $query = $this->db->query("CALL one_report_procedure($reportsid)");
      mysqli_next_result( $this->db->conn_id );
      return $query->row_array();
    }

    public function generate_products_report(){
      require(APPPATH.'third_party/PHPExcel-1.8/Classes/PHPExcel.php');
      require(APPPATH.'third_party/PHPExcel-1.8/Classes/PHPExcel/Writer/Excel2007.php');

      $objPHPExcel = new PHPExcel();

      $objPHPExcel->setActiveSheetIndex(0);

      $objPHPExcel->getActiveSheet()->SetCellValue('A1', 'Product Code');
      $objPHPExcel->getActiveSheet()->SetCellValue('B1', 'Product Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('C1', 'Category Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('D1', 'Subcategory 1 Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('E1', 'Subcategory 2 Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('F1', 'Subcategory 3 Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('G1', 'Product Location');
      $objPHPExcel->getActiveSheet()->SetCellValue('H1', 'Stock Quantity');

      $query = $this->db->query("CALL products_procedure()");
      $products = $query->result_array();
      $row = 2;

      foreach ($products as $product) {
        $objPHPExcel->getActiveSheet()->SetCellValue('A'.$row, $product['product_code']);
        $objPHPExcel->getActiveSheet()->SetCellValue('B'.$row, $product['product_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('C'.$row, $product['category_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('D'.$row, $product['subcategory_1_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('E'.$row, $product['subcategory_2_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('F'.$row, $product['subcategory_3_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('G'.$row, $product['productlocation']);
        $objPHPExcel->getActiveSheet()->SetCellValue('H'.$row, $product['quantity']);
        $row++;
      }

      date_default_timezone_set("Asia/Colombo");
      $filename = "Products-Exported-On-".date('Y-m-d H-i-s').'.xlsx';

      header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      header('Content-Disposition: attachment;filename = "'.$filename.'"');
      header('Cache-Control: max-age=0');

      $writer = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
      $writer->save('php://output');
      exit;
    }

    public function generate_location_wise_stock_report($locationid){
      require(APPPATH.'third_party/PHPExcel-1.8/Classes/PHPExcel.php');
      require(APPPATH.'third_party/PHPExcel-1.8/Classes/PHPExcel/Writer/Excel2007.php');

      $objPHPExcel = new PHPExcel();

      $objPHPExcel->setActiveSheetIndex(0);

      $objPHPExcel->getActiveSheet()->SetCellValue('A1', 'Product Code');
      $objPHPExcel->getActiveSheet()->SetCellValue('B1', 'Product Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('C1', 'Category Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('D1', 'Subcategory 1 Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('E1', 'Subcategory 2 Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('F1', 'Subcategory 3 Name');
      $objPHPExcel->getActiveSheet()->SetCellValue('G1', 'Quantity');

      $query = $this->db->query("CALL one_location_procedure($locationid)");
      mysqli_next_result( $this->db->conn_id );
      $location = $query->row_array();
      $query = $this->db->query("CALL stocks_procedure_to_location($locationid)");
      mysqli_next_result( $this->db->conn_id );
      $stocks = $query->result_array();
      $row = 2;

      foreach ($stocks as $stock) {
        $objPHPExcel->getActiveSheet()->SetCellValue('A'.$row, $stock['product_code']);
        $objPHPExcel->getActiveSheet()->SetCellValue('B'.$row, $stock['product_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('C'.$row, $stock['category_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('D'.$row, $stock['subcategory_1_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('E'.$row, $stock['subcategory_2_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('F'.$row, $stock['subcategory_3_name']);
        $objPHPExcel->getActiveSheet()->SetCellValue('G'.$row, $stock['quantity']);
        $row++;
      }

      date_default_timezone_set("Asia/Colombo");
      $filename = $location['location']." Stock-Exported-On-".date('Y-m-d H-i-s').'.xlsx';

      header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      header('Content-Disposition: attachment;filename = "'.$filename.'"');
      header('Cache-Control: max-age=0');

      $writer = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
      $writer->save('php://output');
      exit;
    }
  }
 ?>
