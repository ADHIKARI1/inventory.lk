<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	https://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
|	$route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['pages/currentlocationstock/data'] = 'Pages/getCurrentLocationStock';
$route['pages/otherlocationstock/data'] = 'Pages/getOtherLocationStock';

$route['notifications'] = 'Notifications/index';

$route['categories'] = 'Categories/index';
$route['categories/data'] = 'Categories/categoryIndexData';
$route['categories/(:any)'] = 'Categories/view/$1';

$route['subcategory1'] = 'Subcategory1/index';
$route['subcategory1/data'] = 'Subcategory1/subcategoryOneIndexData';
$route['subcategory1/create'] = 'Subcategory1/create';
$route['subcategory1/(:any)'] = 'Subcategory1/view/$1';

$route['subcategory2'] = 'Subcategory2/index';
$route['subcategory2/data'] = 'Subcategory2/subcategoryTwoIndexData';
$route['subcategory2/create'] = 'Subcategory2/create';
$route['subcategory2/(:any)'] = 'Subcategory2/view/$1';

$route['subcategory3'] = 'Subcategory3/index';
$route['subcategory3/data'] = 'Subcategory3/subcategoryThreeIndexData';
$route['subcategory3/create'] = 'Subcategory3/create';
$route['subcategory3/(:any)'] = 'Subcategory3/view/$1';

$route['productlocations'] = 'Productlocations/index';
$route['productlocations/data'] = 'Productlocations/productLocationsData';

$route['products'] = 'Products/index';
$route['products/data'] = 'Products/productIndexData';
$route['products/create'] = 'Products/create';
$route['products/(:any)'] = 'Products/view/$1';

$route['locations'] = 'Locations/index';
$route['locations/data'] = 'Locations/locationIndexData';
$route['locations/create'] = 'Locations/create';

$route['projects'] = 'Projects/index';
$route['projects/data'] = 'Projects/projectIndexData';
$route['projects/create'] = 'Projects/create';
$route['projects/(:any)'] = 'Projects/view/$1';

$route['suppliers/addproducts/(:any)'] = 'Suppliers/addsupplierproducts/$1';
$route['suppliers/products/(:any)'] = 'Suppliers/supplierproducts/$1';
$route['suppliers'] = 'Suppliers/index';
$route['suppliers/data'] = 'Suppliers/supplierIndexData';
$route['suppliers/create'] = 'Suppliers/create';
$route['suppliers/products/data/(:any)'] = 'Suppliers/supplierProductsData/$1';
$route['suppliers/(:any)'] = 'Suppliers/view/$1';

$route['materialrequests'] = 'Materialrequests/index';
$route['materialrequests/data'] = 'Materialrequests/materialRequestIndexData';
$route['materialrequest/create'] = 'Materialrequests/create';
$route['materialrequest/materialrequestitems/(:any)'] = 'Materialrequests/viewmritems/$1';
$route['materialrequest/materialrequestitemsapp/(:any)'] = 'Materialrequests/viewmritemsforapproval/$1';
$route['approvematerialrequests'] = 'Materialrequests/approve_materialrequests';
$route['pendingmaterialrequests'] = 'Materialrequests/view_pendingmr';
$route['materialrequest/materialrequestitems/data/(:any)'] = 'Materialrequests/materialRequestItemsIndexData/$1';
$route['materialrequest/addmaterialrequestitems/(:any)'] = 'Materialrequests/mritems/$1';
$route['materialrequest/requestsitetransfer/(:any)'] = 'Materialrequests/sitetransfer/$1';
$route['materialrequest/(:any)'] = 'Materialrequests/view/$1';
$route['materialrequest/approve/(:any)'] = 'Materialrequests/approve/$1';
$route['materialrequest/reject/(:any)'] = 'Materialrequests/reject/$1';

$route['itemsissue'] = 'Itemsissue/index';
$route['itemsissue/(:any)'] = 'Itemsissue/view/$1';

$route['purchaseorders'] = 'Purchaseorders/index';
$route['unsavedpurchaseorders'] = 'Purchaseorders/unsavedpo';
//$route['purchaseordersunsaved'] = 'Purchaseorders/pounsaved';
$route['purchaseordersunsaved/(:any)'] = 'Purchaseorders/pounsaved/$1';
$route['pendingpurchaseorders'] = 'Purchaseorders/pendingpo';
$route['purchaseorders/details/(:any)'] = 'Purchaseorders/view/$1';
$route['purchaseorders/goodreceivednotes/(:any)'] = 'Purchaseorders/viewgrn/$1';
$route['purchaseorders/(:any)'] = 'Purchaseorders/save_purchaseorder/$1';
$route['purchaseorderssaved/(:any)'] = 'Purchaseorders/savedpo/$1';
$route['purchaseorders/data/(:any)'] = 'Purchaseorders/getsavedpo/$1';

$route['goodreceivenotes'] = 'Goodreceivenotes/index';

$route['sitetransfers'] = 'Sitetransfers/index';
$route['pendingsitetransfers'] = 'Sitetransfers/pending_st';
$route['approvesitetransfer'] = 'Sitetransfers/pending_st_approve';

$route['stock-in'] = 'Stock/stock_in';
$route['stock-adjust'] = 'Stock/stock_adjust';
$route['stock-adjust/(:any)'] = 'Stock/view_products/$1';

$route['reports'] = 'Reports/index';
$route['reports/locationwisestock/(:any)'] = 'Reports/location_wise_stock/$1';
$route['reports/(:any)'] = 'Reports/view/$1';

$route['useraccounts'] = 'Useraccounts/index';
$route['useraccounts/create'] = 'Useraccounts/create';
$route['useraccounts/update'] = 'Useraccounts/update';
$route['useraccounts/update_password'] = 'Useraccounts/update_password';
$route['useraccounts/update_image'] = 'Useraccounts/update_image';
$route['useraccounts/(:any)'] = 'Useraccounts/view/$1';

$route['userpermissions'] = 'Userpermissions/index';
$route['userpermissions/savepermission'] = 'Userpermissions/savepermission';
$route['userpermissions/addpermissions/(:any)'] = 'Userpermissions/create/$1';
$route['userpermissions/(:any)'] = 'Userpermissions/view/$1';

$route['userlogin'] = 'Userlogin/index';
$route['userlogin/logout'] = 'Userlogin/logout';

$route['default_controller'] = 'Pages/view';
$route['(:any)'] = 'Pages/view/$1';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;
