<?php
  class Notifications extends CI_Controller{
    public function index(){
      $headerdata['pendingmr'] = $this->Materialrequests_model->get_pendingmrcount();
      $headerdata['pendingmrforapproval'] = $this->Materialrequests_model->get_pendingmrforapprovalcount();
      $headerdata['pendingst'] = $this->Sitetransfers_model->get_pendingstcount();
      $headerdata['unsavedpo'] = $this->Purchaseorders_model->get_unsavedpocount();
      $headerdata['pendingpo'] = $this->Purchaseorders_model->get_pendingpocount();

      $this->load->view('template/notifications', $headerdata);
    }
  }
 ?>
