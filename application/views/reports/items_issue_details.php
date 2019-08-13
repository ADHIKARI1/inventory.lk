<?php
TCPDF();
$obj_pdf = new TCPDF('L', PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
$obj_pdf->SetCreator(PDF_CREATOR);
$title = "SNK | Inventory Control System";
$obj_pdf->SetTitle($title);
$obj_pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);
$obj_pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
$obj_pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
$obj_pdf->SetDefaultMonospacedFont('helvetica');
$obj_pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$obj_pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
$obj_pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
$obj_pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
$obj_pdf->SetFont('helvetica', '', 8);
$obj_pdf->setFontSubsetting(false);
$obj_pdf->AddPage();
ob_start();
// we can have any view part here like HTML, PHP etc
$content .= '<h2 align="center">Items Issue Report</h2>';
$content .= '<table border="0.5" style="padding:3;">';
$count = 1;
$content .= '<thead>';
$content .= '<tr align="center" style="font-weight: bold;">';
$content .= '<th>#</th>';
$content .= '<th>Gatepasses No/Item Issue No</th>';
$content .= '<th>MR Code</th>';
//$content .= '<th>Project Name</th>';
$content .= '<th>Product Name</th>';
$content .= '<th>Category Name</th>';
$content .= '<th>Subcategory 1 Name</th>';
$content .= '<th>Subcategory 2 Name</th>';
$content .= '<th>Subcategory 3 Name</th>';
$content .= '<th>Received Qty/Existing Qty</th>';
$content .= '<th>Balanaced Qty</th>';
$content .= '<th>Issued Qty</th>';
$content .= '<th>Issued Date</th>';
$content .= '</tr>';
//print_r($materialrequestitem);
//die();
foreach ($materialrequestitems as $materialrequestitem) :

    $content .= '<tr>';
    $content .= '<td>' . $count . '</td>';
    //$content .= '<td>' . $materialrequestitem['goodreceivenote_no'] . '</td>';
    //$content .= '<td>' . $materialrequestitem['purchaseorder_no'] . '</td>';
    if($materialrequestitem['gatepass_no'] == 'None')
        $content .= '<td>' . $materialrequestitem['itemsissue_table_id'] . '</td>';
    else
        $content .= '<td>' . $materialrequestitem['gatepass_no'] . '</td>';

    $content .= '<td>' . $materialrequestitem['materialrequest_code'] . '</td>';
    //$content .= '<td>' . $materialrequestitem['project_name'] . '</td>';
    $content .= '<td>' . $materialrequestitem['product_name'] . '</td>';
    $content .= '<td>' . $materialrequestitem['category_name'] . '</td>';
    $content .= '<td>' . $materialrequestitem['subcategory_1_name'] . '</td>';
    $content .= '<td>' . $materialrequestitem['subcategory_2_name'] . '</td>';
    $content .= '<td>' . $materialrequestitem['subcategory_3_name'] . '</td>';
    $content .= '<td>' . $materialrequestitem['quantity_type'] . ' '.$materialrequestitem['requested_quantity'].' / '.$materialrequestitem['quantity'].'</td>';
    $content .= '<td>' . $materialrequestitem['quantity_type'].' '.$materialrequestitem['balanced_quantity']. '</td>';
    $content .= '<td>' . $materialrequestitem['issued_quantity'] . '</td>';
    $content .= '<td>' . $materialrequestitem['issue_datetime'] . '</td>';
    $content .= '</tr>';
    $count++;
endforeach;
$content .= '</tbody>';
$content .= '</table>';

ob_end_clean();
$obj_pdf->writeHTML($content, true, false, true, false, '');
$obj_pdf->Output('ItemsIssueReport.pdf', 'I');
?>
