<?php

class Categories_model extends CI_Model
{
    public function __construct()
    {
        $this->load->database();
    }

    public function get_categories($categoryid = NULL)
    {
        if ($categoryid === NULL) {
            $query = $this->db->query("CALL categories_procedure()");
            mysqli_next_result($this->db->conn_id);
            return $query->result_array();
        }

        $query = $this->db->query("CALL one_category_procedure($categoryid)");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_categories_by_name()
    {
        $this->db->order_by('category_name', 'ASC');
        $query = $this->db->get('categories');
        return $query->result_array();
    }

    public function save_category($aFormData)
    {
        try {
            $query = $this->db->get_where('categories', array('category_name' => $aFormData['category_name']));
            $existname = $query->row_array();
            if ($existname == NULL) {
                $this->db->select_max('category_code');
                $query = $this->db->get('categories');
                $maxid = $query->row()->category_code + 1;
                $data = array(
                    'category_code' => $maxid,
                    'category_name' => $aFormData['category_name'],
                    'category_description' => $aFormData['category_description'],
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('categories', $data);

                $data = array(
                    'category_code' => $maxid,
                    'subcategory_1_code' => $maxid . "0000",
                    'subcategory_1_name' => ' NOT AVAILABLE',
                    'subcategory_1_description' => ' NOT AVAILABLE',
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('subcategories_1', $data);

                $data = array(
                    'category_code' => $maxid,
                    'subcategory_1_code' => $maxid . "0000",
                    'subcategory_2_code' => $maxid . "00000000",
                    'subcategory_2_name' => ' NOT AVAILABLE',
                    'subcategory_2_description' => ' NOT AVAILABLE',
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('subcategories_2', $data);

                $data = array(
                    'category_code' => $maxid,
                    'subcategory_1_code' => $maxid . "0000",
                    'subcategory_2_code' => $maxid . "00000000",
                    'subcategory_3_code' => $maxid . "000000000000",
                    'subcategory_3_name' => ' NOT AVAILABLE',
                    'subcategory_3_description' => ' NOT AVAILABLE',
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('subcategories_3', $data);

                $aResponse = array(
                    'bResponseStatus' => true,
                    'sResponseMessage' => "Category has been saved!!!"
                );
            } else {
                $aResponse = array(
                    'bResponseStatus' => false,
                    'sResponseMessage' => "Category name already exists!!!"
                );
            }

            return $aResponse;
        } catch (Exception $e) {
            $aResponse = array(
                'bResponseStatus' => false,
                'sResponseMessage' => "Category save has been failed!!!"
            );

            return $aResponse;
        }
    }

    public function update_category($aFormData)
    {
        try {
            $this->db->where('category_name =', $aFormData['category_name']);
            $this->db->where('category_code !=', $aFormData['category_code']);
            $query = $this->db->get('categories');
            $existname = $query->row_array();
            if ($existname == NULL) {
                $data = array(
                    'category_name' => $aFormData['category_name'],
                    'category_description' => $aFormData['category_description']
                );

                $this->db->where('category_code', $aFormData['category_code']);
                $this->db->update('categories', $data);

                $aResponse = array(
                    'bResponseStatus' => true,
                    'sResponseMessage' => "Category has been updated!!!"
                );
            } else {
                $aResponse = array(
                    'bResponseStatus' => false,
                    'sResponseMessage' => "Category name already exists!!!"
                );
            }

            return $aResponse;
        } catch (Exception $e) {
            $aResponse = array(
                'bResponseStatus' => false,
                'sResponseMessage' => "Category save has been failed!!!"
            );

            return $aResponse;
        }
    }

    public function delete_category($categoryid)
    {
        try {
            $this->db->where('category_code', $categoryid);
            $query = $this->db->get('supplierproducts');
            if ($query->num_rows() == 0) {
                $this->db->where('category_code', $categoryid);
                $query = $this->db->get('products');
                if ($query->num_rows() == 0) {
                    $this->db->where('category_code', $categoryid);
                    $query = $this->db->get('subcategories_3');
                    if ($query->num_rows() == 1) {
                        $this->db->where('category_code', $categoryid);
                        $query = $this->db->get('subcategories_2');
                        if ($query->num_rows() == 1) {
                            $this->db->where('category_code', $categoryid);
                            $query = $this->db->get('subcategories_1');
                            if ($query->num_rows() == 1) {
                                $query = $this->db->query("CALL delete_category_procedure($categoryid)");

                                $aResponse = array(
                                    'bResponseStatus' => true,
                                    'sResponseMessage' => "Category has been deleted!!!"
                                );
                            } else {
                                $aResponse = array(
                                    'bResponseStatus' => false,
                                    'sResponseMessage' => "This category has been used in subcategory 1!!!"
                                );
                            }
                        } else {
                            $aResponse = array(
                                'bResponseStatus' => false,
                                'sResponseMessage' => "This category has been used in subcategory 2!!!"
                            );
                        }
                    } else {
                        $aResponse = array(
                            'bResponseStatus' => false,
                            'sResponseMessage' => "This category has been used in subcategory 3!!!"
                        );
                    }
                } else {
                    $aResponse = array(
                        'bResponseStatus' => false,
                        'sResponseMessage' => "This category has been used in products!!!"
                    );
                }
            } else {
                $aResponse = array(
                    'bResponseStatus' => false,
                    'sResponseMessage' => "This category has been used in supplier products!!!"
                );
            }

            return $aResponse;
        }
        catch (Exception $e) {
            $aResponse = array(
                'bResponseStatus' => false,
                'sResponseMessage' => "Category delete has been failed!!!"
            );

            return $aResponse;
        }
    }
}

?>
