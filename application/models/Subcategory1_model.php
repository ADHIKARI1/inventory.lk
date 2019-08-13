<?php

class Subcategory1_model extends CI_Model
{
    public function __construct()
    {
        $this->load->database();
    }

    public function get_subcategories($subcategoryid = NULL)
    {
        if ($subcategoryid === NULL) {
            $query = $this->db->query("CALL subcategories_1_procedure()");
            mysqli_next_result($this->db->conn_id);
            return $query->result_array();
        }

        $query = $this->db->query("CALL one_subcategory_1_procedure($subcategoryid)");
        mysqli_next_result($this->db->conn_id);
        return $query->row_array();
    }

    public function get_subcategories_by_name()
    {
        $this->db->order_by('subcategory_1_name', 'ASC');
        $query = $this->db->get('subcategories_1');
        return $query->result_array();
    }

    public function save_subcategory($aFormData)
    {
        try {
            $query = $this->db->get_where('subcategories_1', array('subcategory_1_name' => $aFormData['subcategory_1_name']));
            $existname = $query->row_array();
            if ($existname == NULL) {
                $this->db->select_max('subcategory_1_code');
                $this->db->where('category_code =', $aFormData['category_code']);
                $query = $this->db->get('subcategories_1');
                $maxid = $query->row()->subcategory_1_code + 1;
                $data = array(
                    'category_code' => $aFormData['category_code'],
                    'subcategory_1_code' => $maxid,
                    'subcategory_1_name' => $aFormData['subcategory_1_name'],
                    'subcategory_1_description' => $aFormData['subcategory_1_description'],
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('subcategories_1', $data);

                $data = array(
                    'category_code' => $aFormData['category_code'],
                    'subcategory_1_code' => $maxid,
                    'subcategory_2_code' => $maxid . "0000",
                    'subcategory_2_name' => ' NOT AVAILABLE',
                    'subcategory_2_description' => ' NOT AVAILABLE',
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('subcategories_2', $data);

                $data = array(
                    'category_code' => $aFormData['category_code'],
                    'subcategory_1_code' => $maxid,
                    'subcategory_2_code' => $maxid . "0000",
                    'subcategory_3_code' => $maxid . "0000000",
                    'subcategory_3_name' => ' NOT AVAILABLE',
                    'subcategory_3_description' => ' NOT AVAILABLE',
                    'saved_user' => $this->session->userdata('user_id')
                );
                $this->db->insert('subcategories_3', $data);

                $aResponse = array(
                    'bResponseStatus' => true,
                    'sResponseMessage' => "Subcategory 1 has been saved!!!"
                );
            } else {
                $aResponse = array(
                    'bResponseStatus' => false,
                    'sResponseMessage' => "Subcategory 1 name already exists!!!"
                );
            }

            return $aResponse;
        } catch (Exception $e) {
            $aResponse = array(
                'bResponseStatus' => false,
                'sResponseMessage' => "Subcategory 1 save has been failed!!!"
            );

            return $aResponse;
        }
    }

    public function update_subcategory($aFormData)
    {
        try {
            $this->db->where('subcategory_1_name = ', $aFormData["subcategory_1_name"]);
            $this->db->where('subcategory_1_code != ', $aFormData["subcategory_1_code"]);
            $query = $this->db->get('subcategories_1');
            $existname = $query->row_array();
            if ($existname == NULL) {
                $data = array(
                    'category_code' => $aFormData["category_code"],
                    'subcategory_1_name' => $aFormData["subcategory_1_name"],
                    'subcategory_1_description' => $aFormData["subcategory_1_description"]
                );

                $this->db->where('subcategory_1_code', $aFormData["subcategory_1_code"]);
                $this->db->update('subcategories_1', $data);

                $aResponse = array(
                        'bResponseStatus' => true,
                        'sResponseMessage' => "Subcategory 1 has been updated!!!"
                    );
            } else {
                $aResponse = array(
                    'bResponseStatus' => false,
                    'sResponseMessage' => "Subcategory 1 name already exists!!!"
                );
            }

            return $aResponse;
        } catch (Exception $e) {
            $aResponse = array(
                'bResponseStatus' => false,
                'sResponseMessage' => "Subcategory 1 update has been failed!!!"
            );

            return $aResponse;
        }
    }

    public function delete_subcategory($subcategoryid)
    {
        try {
            $this->db->where('subcategory_1_code', $subcategoryid);
            $query = $this->db->get('supplierproducts');
            if ($query->num_rows() == 0) {
                $this->db->where('subcategory_1_code', $subcategoryid);
                $query = $this->db->get('products');
                if ($query->num_rows() == 0) {
                    $this->db->where('subcategory_1_code', $subcategoryid);
                    $query = $this->db->get('subcategories_3');
                    if ($query->num_rows() == 1) {
                        $this->db->where('subcategory_1_code', $subcategoryid);
                        $query = $this->db->get('subcategories_2');
                        if ($query->num_rows() == 1) {
                            $query = $this->db->query("CALL delete_subcategory_1_procedure($subcategoryid)");
                            $aResponse = array(
                                'bResponseStatus' => true,
                                'sResponseMessage' => "Subcategory 1 has been deleted!!!"
                            );
                        } else {
                            $aResponse = array(
                                'bResponseStatus' => false,
                                'sResponseMessage' => "This subcategory 1 has been used in subcategory 2!!!"
                            );
                        }
                    } else {
                        $aResponse = array(
                            'bResponseStatus' => false,
                            'sResponseMessage' => "This subcategory 1 has been used in subcategory 3!!!"
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
                    'sResponseMessage' => "This subcategory 1 has been used in supplier products!!!"
                );
            }

            return $aResponse;
        }
        catch (Exception $e)
        {
            $aResponse = array(
                'bResponseStatus' => false,
                'sResponseMessage' => "Subcategory 1 delete has been failed!!!"
            );

            return $aResponse;
        }
    }
}

?>
