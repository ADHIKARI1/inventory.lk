-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 15, 2019 at 05:21 AM
-- Server version: 5.7.23
-- PHP Version: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `snk_2`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `admin_materialrequests_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_materialrequests_procedure` ()  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
ORDER BY materialrequests.materialrequests_table_id DESC$$

DROP PROCEDURE IF EXISTS `admin_one_materialrequest_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_one_materialrequest_procedure` (IN `mr_id` VARCHAR(255))  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.materialrequest_code = mr_id$$

DROP PROCEDURE IF EXISTS `admin_pending_materialrequests_for_approval_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_pending_materialrequests_for_approval_procedure` ()  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.materialrequest_status = "Pending" AND materialrequests.approve_status = false
ORDER BY materialrequests.materialrequests_table_id DESC$$

DROP PROCEDURE IF EXISTS `admin_pending_materialrequests_items_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_pending_materialrequests_items_procedure` (IN `location_id` INT, IN `mr_id` VARCHAR(255))  NO SQL
SELECT 
  	materialrequestitems.materialrequestitems_table_id,
    materialrequestitems.requested_quantity,
    materialrequestitems.issued_quantity,
    materialrequestitems.balanced_quantity,
    materialrequestitems.quantity_type,
    materialrequests.materialrequest_code,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    stocks.quantity
FROM materialrequestitems
LEFT JOIN materialrequests ON materialrequestitems.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN products ON materialrequestitems.product_code = products.product_code
LEFT JOIN stocks ON products.product_code = stocks.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE materialrequestitems.materialrequest_code = mr_id AND stocks.location_id = location_id AND materialrequestitems.status = "Pending"$$

DROP PROCEDURE IF EXISTS `admin_pending_materialrequests_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_pending_materialrequests_procedure` ()  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.materialrequest_status = "Pending" AND materialrequests.approve_status = true
ORDER BY materialrequests.materialrequests_table_id DESC$$

DROP PROCEDURE IF EXISTS `admin_pending_sitetransfers_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_pending_sitetransfers_procedure` ()  NO SQL
SELECT 
	sitetransfers.sitetransfers_table_id,
	sitetransfers.materialrequest_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	sitetransfers.requested_quantity,
  	sitetransfers.transferred_quantity,
    locations.location
FROM sitetransfers
LEFT JOIN products ON sitetransfers.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN locations ON sitetransfers.requested_location = locations.locations_table_id
WHERE sitetransfers.materialrequest_code != '0' AND sitetransfers.transferred_quantity = 0
ORDER BY sitetransfers.sitetransfers_table_id DESC$$

DROP PROCEDURE IF EXISTS `admin_sitetransfers_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_sitetransfers_procedure` ()  NO SQL
SELECT 
	sitetransfers.sitetransfers_table_id,
	sitetransfers.materialrequest_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	sitetransfers.requested_quantity,
  	sitetransfers.transferred_quantity,
    locations.location
FROM sitetransfers
LEFT JOIN products ON sitetransfers.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN locations ON sitetransfers.requested_location = locations.locations_table_id
ORDER BY sitetransfers.sitetransfers_table_id DESC$$

DROP PROCEDURE IF EXISTS `categories_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `categories_procedure` ()  NO SQL
SELECT 
    categories.categories_table_id,
    categories.category_code,
    categories.category_name,
    categories.category_description
FROM categories 
WHERE category_name <> ' NOT AVAILABLE' 
ORDER BY categories_table_id DESC$$

DROP PROCEDURE IF EXISTS `delete_category_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_category_procedure` (IN `category_id` INT)  NO SQL
BEGIN
    DELETE FROM subcategories_3 WHERE subcategories_3.category_code = category_id;
    DELETE FROM subcategories_2 WHERE subcategories_2.category_code = category_id;
    DELETE FROM subcategories_1 WHERE subcategories_1.category_code = category_id;
    DELETE FROM categories WHERE categories.category_code = category_id;
END$$

DROP PROCEDURE IF EXISTS `delete_location_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_location_procedure` (IN `location_id` INT)  NO SQL
BEGIN
    DELETE FROM locations WHERE locations.locations_table_id = location_id;
END$$

DROP PROCEDURE IF EXISTS `delete_materialrequestitem_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_materialrequestitem_procedure` (IN `mritem_id` INT)  NO SQL
BEGIN
    DELETE FROM materialrequestitems WHERE materialrequestitems.materialrequestitems_table_id = mritem_id;
END$$

DROP PROCEDURE IF EXISTS `delete_materialrequest_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_materialrequest_procedure` (IN `mr_id` VARCHAR(255))  NO SQL
BEGIN
    DELETE FROM materialrequests WHERE materialrequests.materialrequest_code = mr_id;
END$$

DROP PROCEDURE IF EXISTS `delete_productlocation_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_productlocation_procedure` (IN `location_id` INT)  NO SQL
BEGIN
    DELETE FROM productlocations WHERE productlocations.productlocations_table_id = location_id;
END$$

DROP PROCEDURE IF EXISTS `delete_product_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_product_procedure` (IN `product_id` INT)  NO SQL
BEGIN
	DELETE FROM products WHERE products.product_code = product_id;
END$$

DROP PROCEDURE IF EXISTS `delete_project_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_project_procedure` (IN `project_id` VARCHAR(255))  NO SQL
BEGIN
	DELETE FROM projects WHERE projects.project_code = project_id;
END$$

DROP PROCEDURE IF EXISTS `delete_purchaseorder_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_purchaseorder_procedure` (IN `po_id` INT)  NO SQL
BEGIN
	DELETE FROM purchaseorders WHERE purchaseorders.purchaseorders_table_id = po_id;
END$$

DROP PROCEDURE IF EXISTS `delete_subcategory_1_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_subcategory_1_procedure` (IN `subcategory_id` INT)  NO SQL
BEGIN
    DELETE FROM subcategories_3 WHERE subcategories_3.subcategory_1_code = subcategory_id;
    DELETE FROM subcategories_2 WHERE subcategories_2.subcategory_1_code = subcategory_id;
    DELETE FROM subcategories_1 WHERE subcategories_1.subcategory_1_code = subcategory_id;
END$$

DROP PROCEDURE IF EXISTS `delete_subcategory_2_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_subcategory_2_procedure` (IN `subcategory_id` INT)  NO SQL
BEGIN
    DELETE FROM subcategories_3 WHERE subcategories_3.subcategory_2_code = subcategory_id;
    DELETE FROM subcategories_2 WHERE subcategories_2.subcategory_2_code = subcategory_id;
END$$

DROP PROCEDURE IF EXISTS `delete_subcategory_3_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_subcategory_3_procedure` (IN `subcategory_id` BIGINT)  NO SQL
BEGIN
    DELETE FROM subcategories_3 WHERE subcategories_3.subcategory_3_code = subcategory_id;
END$$

DROP PROCEDURE IF EXISTS `delete_supplier_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_supplier_procedure` (IN `supplier_id` INT)  NO SQL
BEGIN
	DELETE FROM suppliers WHERE suppliers.supplier_code = supplier_id;
END$$

DROP PROCEDURE IF EXISTS `delete_user_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user_procedure` (IN `user_id` INT)  NO SQL
BEGIN
	DELETE FROM useraccounts WHERE useraccounts.useraccounts_table_id = user_id;
END$$

DROP PROCEDURE IF EXISTS `destination_locations_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `destination_locations_procedure` (IN `qty` DECIMAL(10,2), IN `product_id` INT, IN `location_id` INT)  NO SQL
SELECT 
  	stocks.quantity,
  	stocks.quantity_type,
    locations.locations_table_id,
    locations.location
FROM stocks
LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
WHERE stocks.product_code = product_id AND stocks.location_id != location_id AND stocks.quantity >= qty
ORDER BY locations.location$$

DROP PROCEDURE IF EXISTS `goodreceivenotes_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `goodreceivenotes_procedure` ()  NO SQL
SELECT
	goodreceivenotes.goodreceivenotes_table_id,
    goodreceivenotes.goodreceivenote_no,
    goodreceivenotes.purchaseorder_no,
    goodreceivenotes.goodreceived_date,
    goodreceivenotes.received_quantity,
    goodreceivenotes.balanced_quantity,
    goodreceivenotes.invoice_no,
    goodreceivenotes.grn_status,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    purchaseorders.quantity
FROM goodreceivenotes
LEFT JOIN purchaseorders ON goodreceivenotes.purchaseorder_no = purchaseorders.purchaseorder_no
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
ORDER BY goodreceivenotes.goodreceivenotes_table_id DESC$$

DROP PROCEDURE IF EXISTS `locations_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `locations_procedure` ()  NO SQL
SELECT 
	locations.locations_table_id,
	locations.location
FROM locations
ORDER BY locations.locations_table_id DESC$$

DROP PROCEDURE IF EXISTS `materialrequests_items_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `materialrequests_items_procedure` (IN `mr_id` VARCHAR(255))  NO SQL
SELECT 
  	materialrequestitems.materialrequestitems_table_id,
    materialrequestitems.requested_quantity,
    materialrequestitems.issued_quantity,
    materialrequestitems.balanced_quantity,
    materialrequestitems.quantity_type,
    materialrequestitems.status,
    materialrequests.materialrequest_code,
    products.product_code,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name
FROM materialrequestitems
LEFT JOIN materialrequests ON materialrequestitems.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN products ON materialrequestitems.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE materialrequestitems.materialrequest_code = mr_id$$

DROP PROCEDURE IF EXISTS `materialrequests_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `materialrequests_procedure` (IN `location_id` INT)  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.requester_location_id = location_id
ORDER BY materialrequests.materialrequests_table_id DESC$$

DROP PROCEDURE IF EXISTS `one_category_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_category_procedure` (IN `category_id` INT)  NO SQL
SELECT 
	categories.category_code,
    categories.category_name,
    categories.category_description
FROM categories 
WHERE category_code = category_id$$

DROP PROCEDURE IF EXISTS `one_goodreceivenote_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_goodreceivenote_procedure` (IN `grn_id` INT)  NO SQL
SELECT
	goodreceivenotes.goodreceivenotes_table_id,
    goodreceivenotes.goodreceivenote_no,
    goodreceivenotes.purchaseorder_no,
    goodreceivenotes.goodreceived_date,
    goodreceivenotes.received_quantity,
    goodreceivenotes.balanced_quantity,
    goodreceivenotes.invoice_no,
    goodreceivenotes.grn_status,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    purchaseorders.quantity
FROM goodreceivenotes
LEFT JOIN purchaseorders ON goodreceivenotes.purchaseorder_no = purchaseorders.purchaseorder_no
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE goodreceivenotes.goodreceivenotes_table_id = grn_id$$

DROP PROCEDURE IF EXISTS `one_location_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_location_procedure` (IN `location_id` INT)  NO SQL
SELECT
	locations.locations_table_id,
	locations.location
FROM locations
WHERE locations.locations_table_id = location_id$$

DROP PROCEDURE IF EXISTS `one_materialrequests_item_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_materialrequests_item_procedure` (IN `mritem_id` INT)  NO SQL
SELECT 
  	materialrequestitems.materialrequestitems_table_id,
    materialrequestitems.requested_quantity,
    materialrequestitems.issued_quantity,
    materialrequestitems.balanced_quantity,
    materialrequestitems.quantity_type,
    materialrequestitems.status,
    materialrequests.materialrequest_code,
    locations.locations_table_id,
    locations.location,
    products.product_code,
    products.product_name,
    categories.category_code,
    categories.category_name,
    subcategories_1.subcategory_1_code,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_code,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_code,
    subcategories_3.subcategory_3_name
FROM materialrequestitems
LEFT JOIN materialrequests ON materialrequestitems.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN products ON materialrequestitems.product_code = products.product_code
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE materialrequestitems.materialrequestitems_table_id = mritem_id$$

DROP PROCEDURE IF EXISTS `one_materialrequest_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_materialrequest_procedure` (IN `location_id` INT, IN `mr_id` VARCHAR(255))  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.requester_location_id = location_id AND materialrequests.materialrequest_code = mr_id$$

DROP PROCEDURE IF EXISTS `one_productlocation_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_productlocation_procedure` (IN `location_id` INT)  NO SQL
SELECT
	productlocations.productlocations_table_id,
	productlocations.productlocation
FROM productlocations
WHERE productlocations.productlocations_table_id = location_id$$

DROP PROCEDURE IF EXISTS `one_product_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_product_procedure` (IN `product_id` INT)  NO SQL
SELECT 
  	products.product_code,
  	products.product_name,
    products.product_description,
    products.category_code,
    products.subcategory_1_code,
    products.subcategory_2_code,
    products.subcategory_3_code,
    products.product_location_id,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	productlocations.productlocation
FROM products
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
WHERE products.product_code = product_id$$

DROP PROCEDURE IF EXISTS `one_project_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_project_procedure` (IN `project_id` VARCHAR(255))  NO SQL
SELECT
	projects.project_code,
    projects.project_name,
    projects.project_description,
    projects.location_id,
    locations.location
FROM projects
LEFT JOIN locations on projects.location_id = locations.locations_table_id
WHERE projects.project_code = project_id$$

DROP PROCEDURE IF EXISTS `one_purchaseorder_by_pono_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_purchaseorder_by_pono_procedure` (IN `po_id` VARCHAR(255))  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
WHERE purchaseorders.purchaseorder_no = po_id$$

DROP PROCEDURE IF EXISTS `one_purchaseorder_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_purchaseorder_procedure` (IN `po_id` INT)  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
WHERE purchaseorders.purchaseorders_table_id = po_id$$

DROP PROCEDURE IF EXISTS `one_report_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_report_procedure` (IN `report_id` INT)  NO SQL
SELECT 
	reports.reports_table_id,
    reports.report
FROM reports 
WHERE reports.reports_table_id = report_id$$

DROP PROCEDURE IF EXISTS `one_subcategory_1_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_subcategory_1_procedure` (IN `subcategory_id` INT)  NO SQL
SELECT
	subcategories_1.subcategory_1_code,
    subcategories_1.subcategory_1_name,
    subcategories_1.subcategory_1_description,
    subcategories_1.category_code,
    categories.category_name
FROM subcategories_1
LEFT JOIN categories on subcategories_1.category_code = categories.category_code
WHERE subcategories_1.subcategory_1_code = subcategory_id$$

DROP PROCEDURE IF EXISTS `one_subcategory_2_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_subcategory_2_procedure` (IN `subcategory_id` BIGINT)  NO SQL
SELECT
	subcategories_2.subcategory_2_code,
    subcategories_2.subcategory_2_name,
    subcategories_2.subcategory_2_description,
    subcategories_2.category_code,
    subcategories_2.subcategory_1_code,
    categories.category_name,
    subcategories_1.subcategory_1_name
FROM subcategories_2
LEFT JOIN categories on subcategories_2.category_code = categories.category_code
LEFT JOIN subcategories_1 on subcategories_2.subcategory_1_code = subcategories_1.subcategory_1_code
WHERE subcategories_2.subcategory_2_code = subcategory_id$$

DROP PROCEDURE IF EXISTS `one_subcategory_3_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_subcategory_3_procedure` (IN `subcategory_id` BIGINT)  NO SQL
SELECT
	subcategories_3.subcategory_3_code,
    subcategories_3.subcategory_3_name,
    subcategories_3.subcategory_3_description,
    subcategories_3.category_code,
    subcategories_3.subcategory_1_code,
    subcategories_3.subcategory_2_code,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name
FROM subcategories_3
LEFT JOIN categories on subcategories_3.category_code = categories.category_code
LEFT JOIN subcategories_1 on subcategories_3.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 on subcategories_3.subcategory_2_code = subcategories_2.subcategory_2_code
WHERE subcategories_3.subcategory_3_code = subcategory_id$$

DROP PROCEDURE IF EXISTS `one_supplier_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_supplier_procedure` (IN `supplier_id` INT)  NO SQL
SELECT
	suppliers.supplier_code,
    suppliers.supplier_name,
    suppliers.supplier_address,
    suppliers.supplier_contact_no1,
    suppliers.supplier_contact_no2,
    suppliers.supplier_email1,
    suppliers.supplier_email2,
    suppliers.supplier_fax_no1,
    suppliers.supplier_fax_no2,
    suppliers.supplier_description
FROM suppliers
WHERE suppliers.supplier_code = supplier_id$$

DROP PROCEDURE IF EXISTS `one_useraccount_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `one_useraccount_procedure` (IN `user_id` INT)  NO SQL
SELECT 
  	useraccounts.useraccounts_table_id,
    useraccounts.system_user_name,
    useraccounts.system_user_image,
    useraccounts.designation_id,
    useraccounts.location_id,
    useraccounts.user_type,
    designations.designation,
    locations.location,
    useraccounts.system_user_mobile,
    useraccounts.user_name,
    usertypes.usertype
FROM useraccounts
LEFT JOIN designations ON useraccounts.designation_id = designations.designations_table_id
LEFT JOIN locations ON useraccounts.location_id = locations.locations_table_id
LEFT JOIN usertypes ON useraccounts.user_type = usertypes.usertypes_table_id
WHERE useraccounts.useraccounts_table_id = user_id$$

DROP PROCEDURE IF EXISTS `pending_materialrequests_items_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pending_materialrequests_items_procedure` (IN `location_id` INT, IN `mr_id` VARCHAR(255))  NO SQL
SELECT 
  	materialrequestitems.materialrequestitems_table_id,
    materialrequestitems.requested_quantity,
    materialrequestitems.issued_quantity,
    materialrequestitems.balanced_quantity,
    materialrequestitems.quantity_type,
    materialrequests.materialrequest_code,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    stocks.quantity
FROM materialrequestitems
LEFT JOIN materialrequests ON materialrequestitems.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN products ON materialrequestitems.product_code = products.product_code
LEFT JOIN stocks ON products.product_code = stocks.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE materialrequestitems.materialrequest_code = mr_id AND stocks.location_id = location_id AND materialrequests.requester_location_id = location_id AND materialrequestitems.status = "Pending"$$

DROP PROCEDURE IF EXISTS `pending_materialrequests_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pending_materialrequests_procedure` (IN `location_id` INT)  NO SQL
SELECT
	materialrequests.materialrequest_code,
    materialrequests.request_datetime,
    materialrequests.materialrequest_status,
    useraccounts.system_user_name,
    locations.location,
    projects.project_name
FROM materialrequests
LEFT JOIN useraccounts ON materialrequests.requester_id = useraccounts.useraccounts_table_id
LEFT JOIN locations ON materialrequests.requester_location_id = locations.locations_table_id
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.requester_location_id = location_id AND materialrequests.materialrequest_status = "Pending"
ORDER BY materialrequests.materialrequests_table_id DESC$$

DROP PROCEDURE IF EXISTS `pending_purchaseorders_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pending_purchaseorders_procedure` ()  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
WHERE purchaseorders.po_status = 'Saved' AND purchaseorders.poitem_status = 'Pending'
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `pending_sitetransfers_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pending_sitetransfers_procedure` (IN `location_id` INT)  NO SQL
SELECT 
	sitetransfers.sitetransfers_table_id,
	sitetransfers.materialrequest_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	sitetransfers.requested_quantity,
  	sitetransfers.transferred_quantity,
    locations.location
FROM sitetransfers
LEFT JOIN products ON sitetransfers.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN locations ON sitetransfers.requested_location = locations.locations_table_id
WHERE sitetransfers.destination_location = location_id AND sitetransfers.materialrequest_code != '0' AND sitetransfers.transferred_quantity = 0
ORDER BY sitetransfers.sitetransfers_table_id DESC$$

DROP PROCEDURE IF EXISTS `productlocations_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `productlocations_procedure` ()  NO SQL
SELECT 
	productlocations.productlocations_table_id,
	productlocations.productlocation
FROM productlocations
ORDER BY productlocations.productlocations_table_id DESC$$

DROP PROCEDURE IF EXISTS `products_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `products_procedure` ()  NO SQL
SELECT 
  	products.product_code,
  	products.product_name,
    products.product_description,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	productlocations.productlocation
FROM products
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
ORDER BY products.products_table_id DESC$$

DROP PROCEDURE IF EXISTS `projects_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `projects_procedure` ()  NO SQL
SELECT
	projects.project_code,
    projects.project_name,
    projects.project_description,
    locations.location
FROM projects
LEFT JOIN locations on projects.location_id = locations.locations_table_id
ORDER BY projects.projects_table_id DESC$$

DROP PROCEDURE IF EXISTS `purchaseorders_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `purchaseorders_procedure` ()  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `purchaseorder_goodreceivenotes_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `purchaseorder_goodreceivenotes_procedure` (IN `po_id` VARCHAR(255))  NO SQL
SELECT
	goodreceivenotes.goodreceivenotes_table_id,
    goodreceivenotes.goodreceivenote_no,
    goodreceivenotes.purchaseorder_no,
    goodreceivenotes.goodreceived_date,
    goodreceivenotes.received_quantity,
    goodreceivenotes.balanced_quantity,
    goodreceivenotes.invoice_no,
    goodreceivenotes.grn_status,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    purchaseorders.quantity
FROM goodreceivenotes
LEFT JOIN purchaseorders ON goodreceivenotes.purchaseorder_no = purchaseorders.purchaseorder_no
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE goodreceivenotes.purchaseorder_no = po_id
ORDER BY goodreceivenotes.goodreceivenotes_table_id DESC$$

DROP PROCEDURE IF EXISTS `reports_good_received_notes_for_period`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reports_good_received_notes_for_period` (IN `fromdate` DATE, IN `todate` DATE)  NO SQL
SELECT
	goodreceivenotes.goodreceivenotes_table_id,
    goodreceivenotes.goodreceivenote_no,
    goodreceivenotes.purchaseorder_no,
    goodreceivenotes.goodreceived_date,
    goodreceivenotes.received_quantity,
    goodreceivenotes.balanced_quantity,
    goodreceivenotes.invoice_no,
    goodreceivenotes.grn_status,
    materialrequests.materialrequest_code,
    projects.project_code,
    projects.project_name,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    purchaseorders.quantity
FROM goodreceivenotes
LEFT JOIN purchaseorders ON goodreceivenotes.purchaseorder_no = purchaseorders.purchaseorder_no
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN materialrequests ON purchaseorders.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE goodreceivenotes.goodreceived_date BETWEEN fromdate AND todate
ORDER BY goodreceivenotes.goodreceivenotes_table_id DESC$$

DROP PROCEDURE IF EXISTS `reports_good_received_notes_for_project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reports_good_received_notes_for_project` (IN `fromdate` DATE, IN `todate` DATE, IN `projectid` VARCHAR(255))  NO SQL
SELECT
	goodreceivenotes.goodreceivenotes_table_id,
    goodreceivenotes.goodreceivenote_no,
    goodreceivenotes.purchaseorder_no,
    goodreceivenotes.goodreceived_date,
    goodreceivenotes.received_quantity,
    goodreceivenotes.balanced_quantity,
    goodreceivenotes.invoice_no,
    goodreceivenotes.grn_status,
    materialrequests.materialrequest_code,
    projects.project_code,
    projects.project_name,
    products.product_name,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name,
    subcategories_3.subcategory_3_name,
    purchaseorders.quantity
FROM goodreceivenotes
LEFT JOIN purchaseorders ON goodreceivenotes.purchaseorder_no = purchaseorders.purchaseorder_no
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN materialrequests ON purchaseorders.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.project_code = projectid AND goodreceivenotes.goodreceived_date BETWEEN fromdate AND todate
ORDER BY goodreceivenotes.goodreceivenotes_table_id DESC$$

DROP PROCEDURE IF EXISTS `reports_pending_purchase_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reports_pending_purchase_orders` ()  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location,
    projects.project_name
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
LEFT JOIN materialrequests ON purchaseorders.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE purchaseorders.poitem_status = 'Pending'
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `reports_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reports_procedure` ()  NO SQL
SELECT 
	reports.reports_table_id,
    reports.report
FROM reports 
ORDER BY reports.reports_table_id DESC$$

DROP PROCEDURE IF EXISTS `reports_purchase_orders_for_period`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reports_purchase_orders_for_period` (IN `fromdate` DATE, IN `todate` DATE)  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location,
    projects.project_name
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
LEFT JOIN materialrequests ON purchaseorders.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE purchaseorders.po_date BETWEEN fromdate AND todate
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `reports_purchase_orders_for_project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reports_purchase_orders_for_project` (IN `fromdate` DATE, IN `todate` DATE, IN `projectid` VARCHAR(255))  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location,
    projects.project_name
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
LEFT JOIN materialrequests ON purchaseorders.materialrequest_code = materialrequests.materialrequest_code
LEFT JOIN projects ON materialrequests.project_code = projects.project_code
WHERE materialrequests.project_code = projectid AND purchaseorders.po_date BETWEEN fromdate AND todate
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `sitetransfers_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sitetransfers_procedure` (IN `location_id` INT)  NO SQL
SELECT 
	sitetransfers.sitetransfers_table_id,
	sitetransfers.materialrequest_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	sitetransfers.requested_quantity,
  	sitetransfers.transferred_quantity,
    locations.location
FROM sitetransfers
LEFT JOIN products ON sitetransfers.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN locations ON sitetransfers.requested_location = locations.locations_table_id
WHERE sitetransfers.destination_location = location_id OR (sitetransfers.materialrequest_code = '0' AND sitetransfers.requested_location = location_id)
ORDER BY sitetransfers.sitetransfers_table_id DESC$$

DROP PROCEDURE IF EXISTS `stocks_below_min_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_below_min_procedure` (IN `locationid` INT, IN `productid` INT)  NO SQL
BEGIN
	IF (locationid = 0 AND productid = 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
		  	subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity < products.min_quantity;
        
	ELSEIF (locationid <> 0 AND productid = 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity < products.min_quantity AND stocks.location_id = locationid;
        
        ELSEIF (locationid = 0 AND productid <> 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity < products.min_quantity AND stocks.product_code = productid;
        
        ELSEIF (locationid <> 0 AND productid <> 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity < products.min_quantity AND stocks.location_id = locationid AND stocks.product_code = productid;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `stocks_equal_below_reorder_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_equal_below_reorder_procedure` (IN `locationid` INT, IN `productid` INT)  NO SQL
BEGIN
	IF (locationid = 0 AND productid = 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
		  	subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity <= products.reorder_quantity;
        
	ELSEIF (locationid <> 0 AND productid = 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity <= products.reorder_quantity AND stocks.location_id = locationid;
        
        ELSEIF (locationid = 0 AND productid <> 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity <= products.reorder_quantity AND stocks.product_code = productid;
        
        ELSEIF (locationid <> 0 AND productid <> 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity <= products.reorder_quantity AND stocks.location_id = locationid AND stocks.product_code = productid;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `stocks_over_max_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_over_max_procedure` (IN `locationid` INT, IN `productid` INT)  NO SQL
BEGIN
	IF (locationid = 0 AND productid = 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
		  	subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity > products.max_quantity;
        
	ELSEIF (locationid <> 0 AND productid = 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity > products.max_quantity AND stocks.location_id = locationid;
        
        ELSEIF (locationid = 0 AND productid <> 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity > products.max_quantity AND stocks.product_code = productid;
        
        ELSEIF (locationid <> 0 AND productid <> 0) THEN
    	SELECT 
  			products.product_code,
  			products.product_name,
  			categories.category_name,
  			subcategories_1.subcategory_1_name,
  			subcategories_2.subcategory_2_name,
  			subcategories_3.subcategory_3_name,
    		stocks.stocks_table_id,
  			stocks.quantity,
  			stocks.quantity_type,
    		productlocations.productlocation,
    		locations.location,
    		products.max_quantity,
    		products.min_quantity,
    		products.reorder_quantity
		FROM stocks
		LEFT JOIN products ON stocks.product_code = products.product_code
		LEFT JOIN categories ON products.category_code = categories.category_code
		LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
		LEFT JOIN subcategories_2 ON products.subcategory_2_code = 	subcategories_2.subcategory_2_code
		LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
		LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
		LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
        WHERE stocks.quantity > products.max_quantity AND stocks.location_id = locationid AND stocks.product_code = productid;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `stocks_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_procedure` ()  NO SQL
SELECT 
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	stocks.quantity,
  	stocks.quantity_type,
    productlocations.productlocation,
    locations.location
FROM stocks
LEFT JOIN products ON stocks.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
LEFT JOIN locations ON stocks.location_id = locations.locations_table_id$$

DROP PROCEDURE IF EXISTS `stocks_procedure_not_to_location`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_procedure_not_to_location` (IN `location_id` INT)  NO SQL
SELECT 
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	stocks.quantity,
  	stocks.quantity_type,
    productlocations.productlocation,
    locations.location
FROM stocks
LEFT JOIN products ON stocks.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
WHERE stocks.location_id <> location_id$$

DROP PROCEDURE IF EXISTS `stocks_procedure_to_location`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_procedure_to_location` (IN `location_id` INT)  NO SQL
SELECT 
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
  	stocks.quantity,
  	stocks.quantity_type,
    productlocations.productlocation,
    locations.location
FROM stocks
LEFT JOIN products ON stocks.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN productlocations ON products.product_location_id = productlocations.productlocations_table_id
LEFT JOIN locations ON stocks.location_id = locations.locations_table_id
WHERE stocks.location_id = location_id$$

DROP PROCEDURE IF EXISTS `subcategories_1_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `subcategories_1_procedure` ()  NO SQL
SELECT
	subcategories_1.subcategory_1_code,
    subcategories_1.subcategory_1_name,
    subcategories_1.subcategory_1_description,
    categories.category_name
FROM subcategories_1
LEFT JOIN categories on subcategories_1.category_code = categories.category_code
WHERE subcategories_1.subcategory_1_name <> ' NOT AVAILABLE'
ORDER BY subcategories_1.subcategories_1_table_id DESC$$

DROP PROCEDURE IF EXISTS `subcategories_2_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `subcategories_2_procedure` ()  NO SQL
SELECT
	subcategories_2.subcategory_2_code,
    subcategories_2.subcategory_2_name,
    subcategories_2.subcategory_2_description,
    categories.category_name,
    subcategories_1.subcategory_1_name
FROM subcategories_2
LEFT JOIN categories on subcategories_2.category_code = categories.category_code
LEFT JOIN subcategories_1 on subcategories_2.subcategory_1_code = subcategories_1.subcategory_1_code
WHERE subcategories_2.subcategory_2_name <> ' NOT AVAILABLE'
ORDER BY subcategories_2.subcategories_2_table_id DESC$$

DROP PROCEDURE IF EXISTS `subcategories_3_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `subcategories_3_procedure` ()  NO SQL
SELECT
	subcategories_3.subcategory_3_code,
    subcategories_3.subcategory_3_name,
    subcategories_3.subcategory_3_description,
    categories.category_name,
    subcategories_1.subcategory_1_name,
    subcategories_2.subcategory_2_name
FROM subcategories_3
LEFT JOIN categories on subcategories_3.category_code = categories.category_code
LEFT JOIN subcategories_1 on subcategories_3.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 on subcategories_3.subcategory_2_code = subcategories_2.subcategory_2_code
WHERE subcategories_3.subcategory_3_name <> ' NOT AVAILABLE'
ORDER BY subcategories_3.subcategories_3_table_id DESC$$

DROP PROCEDURE IF EXISTS `suppliers_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `suppliers_procedure` ()  NO SQL
SELECT
	suppliers.supplier_code,
    suppliers.supplier_name,
    suppliers.supplier_address,
    suppliers.supplier_contact_no1,
    suppliers.supplier_contact_no2,
    suppliers.supplier_email1,
    suppliers.supplier_email2,
    suppliers.supplier_fax_no1,
    suppliers.supplier_fax_no2,
    suppliers.supplier_description
FROM suppliers
WHERE suppliers.supplier_name <> ' NOT AVAILABLE'
ORDER BY suppliers.suppliers_table_id DESC$$

DROP PROCEDURE IF EXISTS `supplier_products_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_products_procedure` (IN `supplier_id` INT)  NO SQL
SELECT 
	supplierproducts.supplierproducts_table_id,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name
FROM supplierproducts
LEFT JOIN categories ON supplierproducts.category_code = categories.category_code
LEFT JOIN subcategories_1 ON supplierproducts.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON supplierproducts.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON supplierproducts.subcategory_3_code = subcategories_3.subcategory_3_code
WHERE supplierproducts.supplier_code = supplier_id
ORDER BY supplierproducts.supplierproducts_table_id DESC$$

DROP PROCEDURE IF EXISTS `supplier_productwise_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_productwise_procedure` (IN `category_id` INT, IN `subcategory1_id` INT, IN `subcategory2_id` BIGINT, IN `subcategory3_id` BIGINT)  NO SQL
SELECT
	suppliers.supplier_code,
    suppliers.supplier_name
FROM suppliers
LEFT JOIN supplierproducts ON supplierproducts.supplier_code = suppliers.supplier_code
WHERE supplierproducts.category_code = category_id AND supplierproducts.subcategory_1_code = subcategory1_id AND supplierproducts.subcategory_2_code = subcategory2_id AND supplierproducts.subcategory_3_code = subcategory3_id
ORDER BY suppliers.supplier_name$$

DROP PROCEDURE IF EXISTS `unsaved_purchaseorders_by_mrcode`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `unsaved_purchaseorders_by_mrcode` (IN `mrcode` VARCHAR(255))  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
    categories.category_code,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location 
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
WHERE purchaseorders.po_status = 'Pending'
AND purchaseorders.materialrequest_code = mrcode
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `unsaved_purchaseorders_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `unsaved_purchaseorders_procedure` ()  NO SQL
SELECT
	purchaseorders.purchaseorders_table_id,
    purchaseorders.purchaseorder_no,
    purchaseorders.materialrequest_code,
    purchaseorders.quantity,
    purchaseorders.po_date,
    purchaseorders.delivery_date,
    purchaseorders.po_status,
    purchaseorders.poitem_status,
  	products.product_code,
  	products.product_name,
  	categories.category_name,
  	subcategories_1.subcategory_1_name,
  	subcategories_2.subcategory_2_name,
  	subcategories_3.subcategory_3_name,
    suppliers.supplier_name,
  	locations.location
FROM purchaseorders
LEFT JOIN products ON purchaseorders.product_code = products.product_code
LEFT JOIN categories ON products.category_code = categories.category_code
LEFT JOIN subcategories_1 ON products.subcategory_1_code = subcategories_1.subcategory_1_code
LEFT JOIN subcategories_2 ON products.subcategory_2_code = subcategories_2.subcategory_2_code
LEFT JOIN subcategories_3 ON products.subcategory_3_code = subcategories_3.subcategory_3_code
LEFT JOIN suppliers ON purchaseorders.supplier_code = suppliers.supplier_code
LEFT JOIN locations ON purchaseorders.delivery_location_id = locations.locations_table_id
WHERE purchaseorders.po_status = 'Pending'
ORDER BY purchaseorders.purchaseorders_table_id DESC$$

DROP PROCEDURE IF EXISTS `useraccounts_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `useraccounts_procedure` ()  NO SQL
SELECT 
  	useraccounts.useraccounts_table_id,
    useraccounts.system_user_name,
    useraccounts.system_user_image,
    designations.designation,
    locations.location,
    useraccounts.system_user_mobile,
    useraccounts.user_name,
    usertypes.usertype
FROM useraccounts
LEFT JOIN designations ON useraccounts.designation_id = designations.designations_table_id
LEFT JOIN locations ON useraccounts.location_id = locations.locations_table_id
LEFT JOIN usertypes ON useraccounts.user_type = usertypes.usertypes_table_id
ORDER BY useraccounts.useraccounts_table_id DESC$$

DROP PROCEDURE IF EXISTS `userpermissions_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `userpermissions_procedure` (IN `user_id` INT)  NO SQL
SELECT 
  	userpermissions.userpermissions_table_id,
    useraccounts.useraccounts_table_id,
    permissions.permission
FROM userpermissions
LEFT JOIN useraccounts ON userpermissions.useraccounts_table_id = useraccounts.useraccounts_table_id
LEFT JOIN permissions ON userpermissions.permissions_table_id = permissions.permissions_table_id
WHERE userpermissions.useraccounts_table_id = user_id
ORDER BY userpermissions.userpermissions_table_id DESC$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adjusted_stocks`
--

DROP TABLE IF EXISTS `adjusted_stocks`;
CREATE TABLE IF NOT EXISTS `adjusted_stocks` (
  `adjusted_stocks_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `existed_quantity` decimal(10,2) NOT NULL,
  `changed_quantity` decimal(10,2) NOT NULL,
  `location_id` int(11) NOT NULL,
  `saved_date` date NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`adjusted_stocks_table_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categories_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `category_description` text NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`categories_table_id`),
  KEY `category_code` (`category_code`),
  KEY `saved_user` (`saved_user`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categories_table_id`, `category_code`, `category_name`, `category_description`, `saved_datetime`, `saved_user`) VALUES
(1, 0001, 'PVC PIPE & FITTINGS', 'PVC PIPE & FITTINGS', '2019-05-23 17:55:50', 1),
(2, 0002, 'GI PIPE & FITTINGS WELDING TYPE ', 'GI PIPE & FITTINGS WELDING TYPE ', '2019-05-23 17:55:50', 1),
(3, 0003, 'GI PIPE & FITTINGS THREAD  TYPE ', 'GI PIPE & FITTINGS THREAD  TYPE ', '2019-05-23 17:55:50', 1),
(4, 0004, 'BI PIPE & FITTINGS WELDING TYPE ', 'BI PIPE & FITTINGS WELDING TYPE ', '2019-05-23 17:55:50', 1),
(5, 0005, 'BI PIPE & FITTINGS THREAD  TYPE ', 'BI PIPE & FITTINGS THREAD  TYPE ', '2019-05-23 17:55:50', 1),
(6, 0006, 'PPR PIPE & FITTINGS', 'PPR PIPE & FITTINGS', '2019-05-23 17:55:51', 1),
(7, 0007, 'ACOUSTIC PIPE & FITTINGS', 'ACOUSTIC PIPE & FITTINGS', '2019-05-23 17:55:51', 1),
(8, 0008, 'HDPE PIPE FITTINGS', 'HDPE PIPE FITTINGS', '2019-05-23 17:55:51', 1),
(9, 0009, 'COPPER PIPE & FITTINGS', 'COPPER PIPE & FITTINGS', '2019-05-23 17:55:51', 1),
(10, 0010, 'GI CONDUITE & ACCESSORIES', 'GI CONDUITE & ACCESSORIES', '2019-05-23 17:55:51', 1),
(11, 0011, 'PVC CONDUITE & ACCESSORIES', 'PVC CONDUITE & ACCESSORIES', '2019-05-23 17:55:51', 1),
(12, 0012, 'GROOVED FITTINGS', 'GROOVED FITTINGS', '2019-05-23 17:55:52', 1),
(13, 0013, 'STAINLESS STEEL', 'STAINLESS STEEL', '2019-05-23 17:55:52', 1),
(14, 0014, 'VALVE & ACCESSORIES', 'VALVE & ACCESSORIES', '2019-05-23 17:55:52', 1),
(15, 0015, 'CABLE TRAY & ACCESSORIES', 'CABLE TRAY & ACCESSORIES', '2019-05-23 17:55:52', 1),
(16, 0016, 'SANITARY FITTINGS', 'SANITARY FITTINGS', '2019-05-23 17:55:52', 1),
(17, 0017, 'INSULATION MATERIALS', 'INSULATION MATERIALS', '2019-05-23 17:55:52', 1),
(18, 0018, 'BOLT & NUT', 'BOLT & NUT', '2019-05-23 17:55:52', 1),
(19, 0019, 'MISCELLANEOUS ITEMS', 'MISCELLANEOUS ITEMS', '2019-05-23 17:55:53', 1),
(20, 0020, 'ELECTRICAL ACCESSORIES', 'WIRING ACCESSORIES', '2019-05-23 17:55:53', 1),
(21, 0021, 'SWITCH SOCKET OUTLET', 'SWITCH SOCKET OUTLET', '2019-05-23 17:55:53', 1),
(22, 0022, 'GRILL & DIFFUCERS', 'GRILL & DIFFUCERS', '2019-05-23 17:55:53', 1),
(23, 0023, 'FANS', 'FANS', '2019-05-23 17:55:53', 1),
(24, 0024, 'PUMPS', 'PUMPS', '2019-05-23 17:55:53', 1),
(25, 0025, 'LIGHTING FITTINGS', 'LIGHTING FITTINGS', '2019-05-23 17:55:53', 1),
(26, 0026, 'CABLES', 'CABLES', '2019-05-23 17:55:54', 1),
(27, 0027, 'LIGHTING PROTECTION MATERIALS', 'LIGHTING PROTECTION MATERIALS', '2019-05-23 17:55:54', 1),
(28, 0028, 'FIRE PROTECTION / DETECTION ', 'FIRE PROTECTION / DETECTION ', '2019-05-23 17:55:54', 1),
(29, 0029, 'PA & DATA SYSTEM  MATERIALS', 'PA & DATA SYSTEM  MATERIALS', '2019-05-23 17:55:54', 1),
(30, 0030, 'STATIONERY - ACCOUNT INVENTORY', 'STATIONERY - ACCOUNT INVENTORY', '2019-05-23 17:55:54', 1),
(31, 0031, 'MATERIALS - ACCOUNT INVENTORY', 'MATERIALS - ACCOUNT INVENTORY', '2019-05-23 17:55:54', 1);

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

DROP TABLE IF EXISTS `designations`;
CREATE TABLE IF NOT EXISTS `designations` (
  `designations_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) NOT NULL,
  PRIMARY KEY (`designations_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`designations_table_id`, `designation`) VALUES
(5, 'IT Executive');

-- --------------------------------------------------------

--
-- Table structure for table `gatepasses`
--

DROP TABLE IF EXISTS `gatepasses`;
CREATE TABLE IF NOT EXISTS `gatepasses` (
  `gatepasses_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `gatepass_no` varchar(255) NOT NULL,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `materialrequest_code` varchar(255) NOT NULL,
  `requestlocation_id` int(11) NOT NULL,
  `destinationlocation_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`gatepasses_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `goodreceivenotes`
--

DROP TABLE IF EXISTS `goodreceivenotes`;
CREATE TABLE IF NOT EXISTS `goodreceivenotes` (
  `goodreceivenotes_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `goodreceivenote_no` varchar(255) NOT NULL,
  `purchaseorder_no` varchar(255) NOT NULL,
  `goodreceived_date` date NOT NULL,
  `received_quantity` decimal(10,2) NOT NULL,
  `balanced_quantity` decimal(10,2) NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `grn_status` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`goodreceivenotes_table_id`),
  KEY `purchaseorder_no` (`purchaseorder_no`),
  KEY `saved_user` (`saved_user`),
  KEY `goodreceivenote_no` (`goodreceivenote_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `locations_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`locations_table_id`),
  KEY `saved_user` (`saved_user`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`locations_table_id`, `location`, `saved_datetime`, `saved_user`) VALUES
(1, 'Welisara Main Branch', '2019-05-25 01:52:58', 1),
(2, 'ERM', '2019-05-25 02:02:10', 1),
(3, 'ERM-1', '2019-05-25 02:02:20', 1),
(4, 'ST1', '2019-05-25 02:02:36', 1),
(5, 'ER', '2019-05-25 02:02:49', 1),
(6, 'ER/ST1', '2019-05-25 02:03:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `materialrequestitems`
--

DROP TABLE IF EXISTS `materialrequestitems`;
CREATE TABLE IF NOT EXISTS `materialrequestitems` (
  `materialrequestitems_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `materialrequest_code` varchar(255) NOT NULL,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `requested_quantity` decimal(10,2) NOT NULL,
  `issued_quantity` decimal(10,2) NOT NULL,
  `balanced_quantity` decimal(10,2) NOT NULL,
  `quantity_type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`materialrequestitems_table_id`),
  KEY `materialrequest_code` (`materialrequest_code`),
  KEY `product_code` (`product_code`),
  KEY `saved_user` (`saved_user`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `materialrequestitems`
--

INSERT INTO `materialrequestitems` (`materialrequestitems_table_id`, `materialrequest_code`, `product_code`, `requested_quantity`, `issued_quantity`, `balanced_quantity`, `quantity_type`, `status`, `saved_datetime`, `saved_user`) VALUES
(8, 'MR009999', 0000000780, '2.00', '0.00', '2.00', 'Nos', 'Pending', '2019-06-06 04:28:33', 1),
(9, 'MR009999', 0000000642, '5.00', '0.00', '5.00', 'Nos', 'Pending', '2019-06-06 04:29:03', 1),
(11, 'MR009999', 0000001393, '2.00', '0.00', '2.00', 'Nos', 'Pending', '2019-06-07 09:25:47', 1),
(12, 'MR009999', 0000001244, '0.00', '0.00', '0.00', 'Nos', 'Pending', '2019-06-10 04:24:15', 1),
(13, 'MR009999', 0000001733, '5.00', '0.00', '5.00', 'Nos', 'Pending', '2019-06-10 04:24:48', 1);

-- --------------------------------------------------------

--
-- Table structure for table `materialrequests`
--

DROP TABLE IF EXISTS `materialrequests`;
CREATE TABLE IF NOT EXISTS `materialrequests` (
  `materialrequests_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `materialrequest_code` varchar(255) NOT NULL,
  `requester_id` int(11) NOT NULL,
  `requester_location_id` int(11) NOT NULL,
  `project_code` varchar(255) NOT NULL,
  `request_datetime` datetime NOT NULL,
  `materialrequest_status` varchar(255) NOT NULL,
  `approve_status` tinyint(1) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`materialrequests_table_id`),
  KEY `materialrequest_code` (`materialrequest_code`),
  KEY `requester_id` (`requester_id`),
  KEY `requester_location_id` (`requester_location_id`),
  KEY `project_code` (`project_code`),
  KEY `saved_user` (`saved_user`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `materialrequests`
--

INSERT INTO `materialrequests` (`materialrequests_table_id`, `materialrequest_code`, `requester_id`, `requester_location_id`, `project_code`, `request_datetime`, `materialrequest_status`, `approve_status`, `saved_datetime`, `saved_user`) VALUES
(1, 'MRT000128', 1, 4, 'ERR01', '2019-06-05 04:05:00', 'Pending', 0, '2019-06-04 07:17:35', 1),
(2, 'MRT00189', 1, 4, 'ERR01', '2019-06-04 19:08:00', 'Pending', 0, '2019-06-04 09:36:18', 1),
(3, 'MRT0099', 1, 4, 'ERR01', '2019-06-05 16:02:00', 'Pending', 0, '2019-06-05 01:10:43', 1),
(4, 'MR009999', 1, 4, 'ERR01', '2019-06-05 08:09:00', 'Pending', 0, '2019-06-05 01:26:12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `permissions_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`permissions_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permissions_table_id`, `permission`) VALUES
(1, 'Categories'),
(2, 'Sub Categories'),
(3, 'Products'),
(4, 'Locations'),
(5, 'Projects'),
(6, 'Material Requests'),
(7, 'Good Received Note'),
(10, 'Purchase Orders'),
(11, 'Site To Site Transfer'),
(12, 'Items Issue'),
(13, 'Stock In'),
(14, 'User Accounts'),
(15, 'User Permissions'),
(16, 'Suppliers'),
(17, 'Product Locations'),
(18, 'Reports'),
(19, 'Approve Material Requests'),
(20, 'Stock Adjustment');

-- --------------------------------------------------------

--
-- Table structure for table `productlocations`
--

DROP TABLE IF EXISTS `productlocations`;
CREATE TABLE IF NOT EXISTS `productlocations` (
  `productlocations_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `productlocation` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`productlocations_table_id`),
  KEY `saved_user` (`saved_user`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productlocations`
--

INSERT INTO `productlocations` (`productlocations_table_id`, `productlocation`, `saved_datetime`, `saved_user`) VALUES
(1, 'Welisara Main Branch', '2018-05-24 22:46:28', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `products_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_description` text NOT NULL,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_code` int(8) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_2_code` bigint(12) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_3_code` bigint(16) UNSIGNED ZEROFILL NOT NULL,
  `product_location_id` int(11) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`products_table_id`),
  KEY `product_code` (`product_code`),
  KEY `category_code` (`category_code`),
  KEY `product_location_id` (`product_location_id`),
  KEY `saved_user` (`saved_user`),
  KEY `subcategory_1_code` (`subcategory_1_code`),
  KEY `subcategory_2_code` (`subcategory_2_code`),
  KEY `subcategory_3_code` (`subcategory_3_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2032 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`products_table_id`, `product_code`, `product_name`, `product_description`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `product_location_id`, `saved_datetime`, `saved_user`) VALUES
(1, 0000000001, '20mm x 20mm PVC TEE', '20mm x 20mm PVC TEE', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(2, 0000000002, '25mm x 20mm PVC TEE', '25mm x 20mm PVC TEE', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(3, 0000000003, '25mm x 25mm PVC TEE', '25mm x 25mm PVC TEE', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(4, 0000000004, '32mm x 20mm PVC TEE', '32mm x 20mm PVC TEE', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(5, 0000000005, '32mm x 25mm PVC TEE', '32mm x 25mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(6, 0000000006, '32mm x 32mm PVC TEE', '32mm x 32mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(7, 0000000007, '40mm x 20mm PVC TEE', '40mm x 20mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(8, 0000000008, '40mm x 25mm PVC TEE', '40mm x 25mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(9, 0000000009, '40mm x 32mm PVC TEE', '40mm x 32mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(10, 0000000010, '40mm x 40mm PVC TEE', '40mm x 40mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(11, 0000000011, '50mm x 20mm PVC TEE', '50mm x 20mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(12, 0000000012, '50mm x 25mm PVC TEE', '50mm x 25mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(13, 0000000013, '50mm x 32mm PVC TEE', '50mm x 32mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(14, 0000000014, '50mm x 40mm PVC TEE', '50mm x 40mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(15, 0000000015, '50mm x 50mm PVC TEE', '50mm x 50mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(16, 0000000016, '63mm x 20mm PVC TEE', '63mm x 20mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(17, 0000000017, '63mm x 25mm PVC TEE', '63mm x 25mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(18, 0000000018, '63mm x 32mm PVC TEE', '63mm x 32mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(19, 0000000019, '63mm x 40mm PVC TEE', '63mm x 40mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(20, 0000000020, '63mm x 50mm PVC TEE', '63mm x 50mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(21, 0000000021, '63mm x 63mm PVC TEE', '63mm x 63mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(22, 0000000022, '75mm x 32mm PVC TEE', '75mm x 32mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(23, 0000000023, '75mm x 40mm PVC TEE', '75mm x 40mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(24, 0000000024, '75mm x 50mm PVC TEE', '75mm x 50mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(25, 0000000025, '75mm x 63mm PVC TEE', '75mm x 63mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:08', 1),
(26, 0000000026, '75mm x 75mm PVC TEE', '75mm x 75mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(27, 0000000027, '90mm x 50mm PVC TEE', '90mm x 50mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(28, 0000000028, '90mm x 63mm PVC TEE', '90mm x 63mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(29, 0000000029, '90mm x 75mm PVC TEE', '90mm x 75mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(30, 0000000030, '90mm x 90mm PVC TEE', '90mm x 90mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(31, 0000000031, '110mm x 50mm PVC TEE', '110mm x 50mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(32, 0000000032, '110mm x 63mm PVC TEE', '110mm x 63mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(33, 0000000033, '110mm x 75mm PVC TEE', '110mm x 75mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(34, 0000000034, '110mm x 90mm PVC TEE', '110mm x 90mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(35, 0000000035, '110mm x 110mm PVC TEE', '110mm x 110mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(36, 0000000036, '125mm x 90mm PVC TEE', '125mm x 90mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(37, 0000000037, '125mm x 110mm PVC TEE', '125mm x 110mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(38, 0000000038, '125mm x 125mm PVC TEE', '125mm x 125mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(39, 0000000039, '160mm x 90mm PVC TEE', '160mm x 90mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(40, 0000000040, '160mm x 110mm PVC TEE', '160mm x 110mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(41, 0000000041, '160mm x 160mm PVC TEE', '160mm x 160mm', 0001, 00010001, 000100010000, 0001000100000000, 1, '2019-05-24 21:41:09', 1),
(42, 0000000042, '20mm x 90\'  PVC ELBOW 90\'', '20mm x 90\'  PVC ELBOW 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(43, 0000000043, '25mm x 90\' PVC ELBOW 90\'', '25mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(44, 0000000044, '32mm x 90\' PVC ELBOW 90\'', '32mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(45, 0000000045, '40mm x 90\' PVC ELBOW 90\'', '40mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(46, 0000000046, '50mm x 90\' PVC ELBOW 90\'', '50mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(47, 0000000047, '63mm x 90\' PVC ELBOW 90\'', '63mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(48, 0000000048, '75mm x 90\' PVC ELBOW 90\'', '75mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(49, 0000000049, '90mm x 90\' PVC ELBOW 90\'', '90mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(50, 0000000050, '110mm x 90\' PVC ELBOW 90\'', '110mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(51, 0000000051, '125mm x 90\' PVC ELBOW 90\'', '125mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(52, 0000000052, '160mm x 90\' PVC ELBOW 90\'', '160mm x 90\'', 0001, 00010002, 000100020000, 0001000200000000, 1, '2019-05-24 21:41:09', 1),
(53, 0000000053, '20mm x 45\' PVC ELBOW 45\'', '20mm x 45\' PVC ELBOW 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:09', 1),
(54, 0000000054, '25mm x 45\' PVC ELBOW 45\'', '25mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:09', 1),
(55, 0000000055, '32mm x 45\' PVC ELBOW 45\'', '32mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(56, 0000000056, '40mm x 45\' PVC ELBOW 45\'', '40mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(57, 0000000057, '50mm x 45\' PVC ELBOW 45\'', '50mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(58, 0000000058, '63mm x 45\' PVC ELBOW 45\'', '63mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(59, 0000000059, '75mm x 45\' PVC ELBOW 45\'', '75mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(60, 0000000060, '90mm x 45\' PVC ELBOW 45\'', '90mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(61, 0000000061, '110mm x 45\' PVC ELBOW 45\'', '110mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(62, 0000000062, '125mm x 45\' PVC ELBOW 45\'', '125mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(63, 0000000063, '160mm x 45\' PVC ELBOW 45\'', '160mm x 45\'', 0001, 00010003, 000100030000, 0001000300000000, 1, '2019-05-24 21:41:10', 1),
(64, 0000000064, '25mm x 20mm PVC REDUCER', '25mm x 20mm PVC REDUCER', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:10', 1),
(65, 0000000065, '32mm x 20mm PVC REDUCER', '32mm x 20mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:10', 1),
(66, 0000000066, '32mm x 25mm PVC REDUCER', '32mm x 25mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:10', 1),
(67, 0000000067, '40mm x 20mm PVC REDUCER', '40mm x 20mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:10', 1),
(68, 0000000068, '40mm x 25mm PVC REDUCER', '40mm x 25mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:10', 1),
(69, 0000000069, '40mm x 32mm PVC REDUCER', '40mm x 32mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:10', 1),
(70, 0000000070, '50mm x 20mm PVC REDUCER', '50mm x 20mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(71, 0000000071, '50mm x 25mm PVC REDUCER', '50mm x 25mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(72, 0000000072, '50mm x 32mm PVC REDUCER', '50mm x 32mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(73, 0000000073, '50mm x 40mm PVC REDUCER', '50mm x 40mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(74, 0000000074, '63mm x 20mm PVC REDUCER', '63mm x 20mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(75, 0000000075, '63mm x 25mm PVC REDUCER', '63mm x 25mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(76, 0000000076, '63mm x 32mm PVC REDUCER', '63mm x 32mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(77, 0000000077, '63mm x 40mm PVC REDUCER', '63mm x 40mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(78, 0000000078, '63mm x 50mm PVC REDUCER', '63mm x 50mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(79, 0000000079, '75mm x 32mm PVC REDUCER', '75mm x 32mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(80, 0000000080, '75mm x 40mm PVC REDUCER', '75mm x 40mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(81, 0000000081, '75mm x 50mm PVC REDUCER', '75mm x 50mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(82, 0000000082, '75mm x 63mm PVC REDUCER', '75mm x 63mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(83, 0000000083, '90mm x 50mm PVC REDUCER', '90mm x 50mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(84, 0000000084, '90mm x 63mm PVC REDUCER', '90mm x 63mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(85, 0000000085, '90mm x 75mm PVC REDUCER', '90mm x 75mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(86, 0000000086, '110mm x 63mm PVC REDUCER', '110mm x 63mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(87, 0000000087, '110mm x 75mm PVC REDUCER', '110mm x 75mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(88, 0000000088, '110mm x 90mm PVC REDUCER', '110mm x 90mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(89, 0000000089, '160mm x 110mm PVC REDUCER', '160mm x 110mm', 0001, 00010004, 000100040000, 0001000400000000, 1, '2019-05-24 21:41:11', 1),
(90, 0000000090, '20mm PVC SOCKET', '20mm PVC SOCKET', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:11', 1),
(91, 0000000091, '25mm PVC SOCKET', '25mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:11', 1),
(92, 0000000092, '32mm PVC SOCKET', '32mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:11', 1),
(93, 0000000093, '40mm PVC SOCKET', '40mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:11', 1),
(94, 0000000094, '50mm PVC SOCKET', '50mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:12', 1),
(95, 0000000095, '63mm PVC SOCKET', '63mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:12', 1),
(96, 0000000096, '75mm PVC SOCKET', '75mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:12', 1),
(97, 0000000097, '90mm PVC SOCKET', '90mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:12', 1),
(98, 0000000098, '110mm PVC SOCKET', '110mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:12', 1),
(99, 0000000099, '160mm PVC SOCKET', '160mm', 0001, 00010005, 000100050000, 0001000500000000, 1, '2019-05-24 21:41:12', 1),
(100, 0000000100, '40mm x 40mm PVC Y-JOINT', '40mm x 40mm PVC Y-JOINT', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(101, 0000000101, '50mm x 50mm PVC Y-JOINT', '50mm x 50mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(102, 0000000102, '63mm x 50mm PVC Y-JOINT', '63mm x 50mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(103, 0000000103, '63mm x 63mm PVC Y-JOINT', '63mm x 63mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(104, 0000000104, '75mm x 40mm PVC Y-JOINT', '75mm x 40mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(105, 0000000105, '75mm x 50mm PVC Y-JOINT', '75mm x 50mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(106, 0000000106, '75mm x 75mm PVC Y-JOINT', '75mm x 75mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(107, 0000000107, '90mm x 63mm PVC Y-JOINT', '90mm x 63mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(108, 0000000108, '90mm x 75mm PVC Y-JOINT', '90mm x 75mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(109, 0000000109, '90mm x 90mm PVC Y-JOINT', '90mm x 90mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(110, 0000000110, '110mm x 50mm PVC Y-JOINT', '110mm x 50mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(111, 0000000111, '110mm x 63mm PVC Y-JOINT', '110mm x 63mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(112, 0000000112, '110mm x 75mm PVC Y-JOINT', '110mm x 75mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(113, 0000000113, '110mm x 90mm PVC Y-JOINT', '110mm x 90mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(114, 0000000114, '110mm x 110mm PVC Y-JOINT', '110mm x 110mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(115, 0000000115, '160mm x 110mm PVC Y-JOINT', '160mm x 110mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(116, 0000000116, '160mm x 160mm PVC Y-JOINT', '160mm x 160mm', 0001, 00010006, 000100060000, 0001000600000000, 1, '2019-05-24 21:41:12', 1),
(117, 0000000117, '63mm x 63mm PVC SWEEP TEE', '63mm x 63mm PVC SWEEP TEE', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:12', 1),
(118, 0000000118, '75mm x 63mm PVC SWEEP TEE', '75mm x 63mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(119, 0000000119, '75mm x 75mm PVC SWEEP TEE', '75mm x 75mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(120, 0000000120, '90mm x 90mm PVC SWEEP TEE', '90mm x 90mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(121, 0000000121, '110mm x 50mm PVC SWEEP TEE', '110mm x 50mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(122, 0000000122, '110mm x 63mm PVC SWEEP TEE', '110mm x 63mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(123, 0000000123, '110mm x 75mm PVC SWEEP TEE', '110mm x 75mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(124, 0000000124, '110mm x 110mm PVC SWEEP TEE', '110mm x 110mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(125, 0000000125, '160mm x 110mm PVC SWEEP TEE', '160mm x 110mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(126, 0000000126, '160mm x 160mm PVC SWEEP TEE', '160mm x 160mm', 0001, 00010007, 000100070000, 0001000700000000, 1, '2019-05-24 21:41:13', 1),
(127, 0000000127, '20mm  PVC VALVE SOCKET', '20mm  PVC VALVE SOCKET', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(128, 0000000128, '25mm PVC VALVE SOCKET', '25mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(129, 0000000129, '32mm PVC VALVE SOCKET', '32mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(130, 0000000130, '40mm PVC VALVE SOCKET', '40mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(131, 0000000131, '50mm PVC VALVE SOCKET', '50mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(132, 0000000132, '63mm PVC VALVE SOCKET', '63mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(133, 0000000133, '75mm PVC VALVE SOCKET', '75mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(134, 0000000134, '90mm PVC VALVE SOCKET', '90mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(135, 0000000135, '110mm PVC VALVE SOCKET', '110mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(136, 0000000136, '160mm PVC VALVE SOCKET', '160mm', 0001, 00010008, 000100080000, 0001000800000000, 1, '2019-05-24 21:41:13', 1),
(137, 0000000137, '20mm  PVC FAUCET SOCKET', '20mm  PVC FAUCET SOCKET', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:13', 1),
(138, 0000000138, '25mm PVC FAUCET SOCKET', '25mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:13', 1),
(139, 0000000139, '32mm PVC FAUCET SOCKET', '32mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:13', 1),
(140, 0000000140, '40mm PVC FAUCET SOCKET', '40mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:13', 1),
(141, 0000000141, '50mm PVC FAUCET SOCKET', '50mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:13', 1),
(142, 0000000142, '63mm PVC FAUCET SOCKET', '63mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:13', 1),
(143, 0000000143, '75mm PVC FAUCET SOCKET', '75mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:14', 1),
(144, 0000000144, '90mm PVC FAUCET SOCKET', '90mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:14', 1),
(145, 0000000145, '110mm PVC FAUCET SOCKET', '110mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:14', 1),
(146, 0000000146, '160mm PVC FAUCET SOCKET', '160mm', 0001, 00010009, 000100090000, 0001000900000000, 1, '2019-05-24 21:41:14', 1),
(147, 0000000147, '20mm  PVC END CAP', '20mm  PVC END CAP', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(148, 0000000148, '25mm PVC END CAP', '25mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(149, 0000000149, '32mm PVC END CAP', '32mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(150, 0000000150, '40mm PVC END CAP', '40mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(151, 0000000151, '50mm PVC END CAP', '50mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(152, 0000000152, '63mm PVC END CAP', '63mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(153, 0000000153, '75mm PVC END CAP', '75mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(154, 0000000154, '90mm PVC END CAP', '90mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(155, 0000000155, '110mm PVC END CAP', '110mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(156, 0000000156, '160mm PVC END CAP', '160mm', 0001, 00010010, 000100100000, 0001001000000000, 1, '2019-05-24 21:41:14', 1),
(157, 0000000157, '50mm PVC CLEANOUT', '50mm PVC CLEANOUT', 0001, 00010011, 000100110000, 0001001100000000, 1, '2019-05-24 21:41:14', 1),
(158, 0000000158, '63mm PVC CLEANOUT', '63mm', 0001, 00010011, 000100110000, 0001001100000000, 1, '2019-05-24 21:41:14', 1),
(159, 0000000159, '75mm PVC CLEANOUT', '75mm', 0001, 00010011, 000100110000, 0001001100000000, 1, '2019-05-24 21:41:14', 1),
(160, 0000000160, '90mm PVC CLEANOUT', '90mm', 0001, 00010011, 000100110000, 0001001100000000, 1, '2019-05-24 21:41:14', 1),
(161, 0000000161, '110mm PVC CLEANOUT', '110mm', 0001, 00010011, 000100110000, 0001001100000000, 1, '2019-05-24 21:41:14', 1),
(162, 0000000162, '160mm PVC CLEANOUT', '160mm', 0001, 00010011, 000100110000, 0001001100000000, 1, '2019-05-24 21:41:14', 1),
(163, 0000000163, '20mm  PVC UNION', '20mm  PVC UNION', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:14', 1),
(164, 0000000164, '25mm PVC UNION', '25mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:14', 1),
(165, 0000000165, '32mm PVC UNION', '32mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:14', 1),
(166, 0000000166, '40mm PVC UNION', '40mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:14', 1),
(167, 0000000167, '50mm PVC UNION', '50mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:14', 1),
(168, 0000000168, '63mm PVC UNION', '63mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:15', 1),
(169, 0000000169, '75mm PVC UNION', '75mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:15', 1),
(170, 0000000170, '90mm PVC UNION', '90mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:15', 1),
(171, 0000000171, '110mm PVC UNION', '110mm', 0001, 00010012, 000100120000, 0001001200000000, 1, '2019-05-24 21:41:15', 1),
(172, 0000000172, '32mm PVC FLANGE', '32mm PVC FLANGE', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(173, 0000000173, '40mm PVC FLANGE', '40mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(174, 0000000174, '50mm PVC FLANGE', '50mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(175, 0000000175, '63mm PVC FLANGE', '63mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(176, 0000000176, '75mm PVC FLANGE', '75mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(177, 0000000177, '90mm PVC FLANGE', '90mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(178, 0000000178, '110mm PVC FLANGE', '110mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(179, 0000000179, '160mm PVC FLANGE', '160mm', 0001, 00010013, 000100130000, 0001001300000000, 1, '2019-05-24 21:41:15', 1),
(180, 0000000180, '20mm PVC TEST PLUG', '20mm PVC TEST PLUG', 0001, 00010014, 000100140000, 0001001400000000, 1, '2019-05-24 21:41:15', 1),
(181, 0000000181, '25mm PVC TEST PLUG', '25mm', 0001, 00010014, 000100140000, 0001001400000000, 1, '2019-05-24 21:41:15', 1),
(182, 0000000182, '32mm PVC TEST PLUG', '32mm', 0001, 00010014, 000100140000, 0001001400000000, 1, '2019-05-24 21:41:15', 1),
(183, 0000000183, '40mm PVC TEST PLUG', '40mm', 0001, 00010014, 000100140000, 0001001400000000, 1, '2019-05-24 21:41:15', 1),
(184, 0000000184, '50mm PVC TEST PLUG', '50mm', 0001, 00010014, 000100140000, 0001001400000000, 1, '2019-05-24 21:41:15', 1),
(185, 0000000185, '63mm PVC TEST PLUG', '63mm', 0001, 00010014, 000100140000, 0001001400000000, 1, '2019-05-24 21:41:15', 1),
(186, 0000000186, '32mm x 25mm PVC REDUCING BUSH', '32mm x 25mm PVC REDUCING BUSH', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(187, 0000000187, '40mm x 20mm PVC REDUCING BUSH', '40mm x 20mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(188, 0000000188, '40mm x 25mm PVC REDUCING BUSH', '40mm x 25mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(189, 0000000189, '40mm x 32mm PVC REDUCING BUSH', '40mm x 32mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(190, 0000000190, '50mm x 20mm PVC REDUCING BUSH', '50mm x 20mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(191, 0000000191, '50mm x 25mm PVC REDUCING BUSH', '50mm x 25mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(192, 0000000192, '50mm x 32mm PVC REDUCING BUSH', '50mm x 32mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(193, 0000000193, '50mm x 40mm PVC REDUCING BUSH', '50mm x 40mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:15', 1),
(194, 0000000194, '63mm x 20mm PVC REDUCING BUSH', '63mm x 20mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(195, 0000000195, '63mm x 25mm PVC REDUCING BUSH', '63mm x 25mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(196, 0000000196, '63mm x 32mm PVC REDUCING BUSH', '63mm x 32mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(197, 0000000197, '63mm x 40mm PVC REDUCING BUSH', '63mm x 40mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(198, 0000000198, '63mm x 50mm PVC REDUCING BUSH', '63mm x 50mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(199, 0000000199, '75mm x 32mm PVC REDUCING BUSH', '75mm x 32mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(200, 0000000200, '75mm x 40mm PVC REDUCING BUSH', '75mm x 40mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(201, 0000000201, '75mm x 50mm PVC REDUCING BUSH', '75mm x 50mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(202, 0000000202, '75mm x 63mm PVC REDUCING BUSH', '75mm x 63mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(203, 0000000203, '90mm x 50mm PVC REDUCING BUSH', '90mm x 50mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(204, 0000000204, '90mm x 63mm PVC REDUCING BUSH', '90mm x 63mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(205, 0000000205, '90mm x 75mm PVC REDUCING BUSH', '90mm x 75mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(206, 0000000206, '110mm x 63mm PVC REDUCING BUSH', '110mm x 63mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(207, 0000000207, '110mm x 75mm PVC REDUCING BUSH', '110mm x 75mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(208, 0000000208, '110mm x 90mm PVC REDUCING BUSH', '110mm x 90mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(209, 0000000209, '160mm x 110mm PVC REDUCING BUSH', '160mm x 110mm', 0001, 00010015, 000100150000, 0001001500000000, 1, '2019-05-24 21:41:16', 1),
(210, 0000000210, '160mm x 20mm PVC CLAMP SADDLE', '160mm x 20mm PVC CLAMP SADDLE', 0001, 00010016, 000100160000, 0001001600000000, 1, '2019-05-24 21:41:16', 1),
(211, 0000000211, '140mm x 20mm', '140mm x 20mm', 0001, 00010016, 000100160000, 0001001600000000, 1, '2019-05-24 21:41:16', 1),
(212, 0000000212, '125mm x 20mm', '125mm x 20mm', 0001, 00010016, 000100160000, 0001001600000000, 1, '2019-05-24 21:41:16', 1),
(213, 0000000213, '110mm x 20mm', '110mm x 20mm', 0001, 00010016, 000100160000, 0001001600000000, 1, '2019-05-24 21:41:16', 1),
(214, 0000000214, '90mm x 20mm', '90mm x 20mm', 0001, 00010016, 000100160000, 0001001600000000, 1, '2019-05-24 21:41:16', 1),
(215, 0000000215, '75mm x 20mm', '75mm x 20mm', 0001, 00010016, 000100160000, 0001001600000000, 1, '2019-05-24 21:41:16', 1),
(216, 0000000216, '20mm PVC PIPE PN-11', '20mm PVC PIPE PN-11', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(217, 0000000217, '25mm', '25mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(218, 0000000218, '32mm', '32mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(219, 0000000219, '40mm', '40mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(220, 0000000220, '50mm', '50mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(221, 0000000221, '63mm', '63mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(222, 0000000222, '75mm', '75mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(223, 0000000223, '90mm', '90mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(224, 0000000224, '110mm', '110mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:16', 1),
(225, 0000000225, '160mm', '160mm', 0001, 00010017, 000100170001, 0001001700010000, 1, '2019-05-24 21:41:17', 1),
(226, 0000000226, '20mm PVC PIPE PN-07', '20mm PVC PIPE PN-07', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(227, 0000000227, '25mm', '25mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(228, 0000000228, '32mm', '32mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(229, 0000000229, '40mm', '40mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(230, 0000000230, '50mm', '50mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(231, 0000000231, '63mm', '63mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(232, 0000000232, '75mm', '75mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(233, 0000000233, '90mm', '90mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(234, 0000000234, '110mm', '110mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(235, 0000000235, '160mm', '160mm', 0001, 00010017, 000100170002, 0001001700020000, 1, '2019-05-24 21:41:17', 1),
(236, 0000000236, '63mm PVC PIPE T-400', '63mm PVC PIPE T-400', 0001, 00010017, 000100170003, 0001001700030000, 1, '2019-05-24 21:41:17', 1),
(237, 0000000237, '75mm', '75mm', 0001, 00010017, 000100170003, 0001001700030000, 1, '2019-05-24 21:41:17', 1),
(238, 0000000238, '90mm', '90mm', 0001, 00010017, 000100170003, 0001001700030000, 1, '2019-05-24 21:41:17', 1),
(239, 0000000239, '110mm', '110mm', 0001, 00010017, 000100170003, 0001001700030000, 1, '2019-05-24 21:41:17', 1),
(240, 0000000240, '160mm', '160mm', 0001, 00010017, 000100170003, 0001001700030000, 1, '2019-05-24 21:41:17', 1),
(241, 0000000241, '63mm PVC PIPE DRAINAGE', '63mm PVC PIPE DRAINAGE', 0001, 00010017, 000100170004, 0001001700040000, 1, '2019-05-24 21:41:17', 1),
(242, 0000000242, '75mm', '75mm', 0001, 00010017, 000100170004, 0001001700040000, 1, '2019-05-24 21:41:17', 1),
(243, 0000000243, '90mm', '90mm', 0001, 00010017, 000100170004, 0001001700040000, 1, '2019-05-24 21:41:17', 1),
(244, 0000000244, '110mm', '110mm', 0001, 00010017, 000100170004, 0001001700040000, 1, '2019-05-24 21:41:17', 1),
(245, 0000000245, '160mm', '160mm', 0001, 00010017, 000100170004, 0001001700040000, 1, '2019-05-24 21:41:17', 1),
(246, 0000000246, '15mm x 15mm GI TEE W/T', '15mm x 15mm GI TEE W/T', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(247, 0000000247, '20mm x 15mm', '20mm x 15mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(248, 0000000248, '25mm x 15mm', '25mm x 15mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(249, 0000000249, '25mm x 25mm', '25mm x 25mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(250, 0000000250, '32mm x 15mm', '32mm x 15mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(251, 0000000251, '32mm x 25mm', '32mm x 25mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(252, 0000000252, '50mm x 15mm', '50mm x 15mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(253, 0000000253, '50mm x 32mm', '50mm x 32mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(254, 0000000254, '50mm x 50mm', '50mm x 50mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(255, 0000000255, '65mm x 25mm', '65mm x 25mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(256, 0000000256, '65mm x 32mm', '65mm x 32mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(257, 0000000257, '65mm x 40mm', '65mm x 40mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(258, 0000000258, '65mm x 50mm', '65mm x 50mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:17', 1),
(259, 0000000259, '65mm x 65mm', '65mm x 65mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(260, 0000000260, '75mm x 25mm', '75mm x 25mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(261, 0000000261, '75mm x 32mm', '75mm x 32mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(262, 0000000262, '75mm x 40mm', '75mm x 40mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(263, 0000000263, '75mm x 50mm', '75mm x 50mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(264, 0000000264, '75mm x 65mm', '75mm x 65mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(265, 0000000265, '100mm x 25mm', '100mm x 25mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(266, 0000000266, '100mm x 32mm', '100mm x 32mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(267, 0000000267, '100mm x 40mm', '100mm x 40mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(268, 0000000268, '100mm x 65mm', '100mm x 65mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(269, 0000000269, '100mm x 75mm', '100mm x 75mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(270, 0000000270, '100mm x 100mm', '100mm x 100mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(271, 0000000271, '125mm x 75mm', '125mm x 75mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(272, 0000000272, '125mm x 125mm', '125mm x 125mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(273, 0000000273, '150mm x 40mm', '150mm x 40mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(274, 0000000274, '150mm x 50mm', '150mm x 50mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(275, 0000000275, '150mm x 65mm', '150mm x 65mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(276, 0000000276, '150mm x 75mm', '150mm x 75mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(277, 0000000277, '150mm x 100mm', '150mm x 100mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(278, 0000000278, '150mm x 125mm', '150mm x 125mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(279, 0000000279, '150mm x 150mm', '150mm x 150mm', 0002, 00020001, 000200010000, 0002000100000000, 1, '2019-05-24 21:41:18', 1),
(280, 0000000280, '200mm x 150mm', '200mm x 150mm', 0002, 00020001, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:18', 1),
(281, 0000000281, '20mm x 15mm GI REDUCER W/T', '20mm x 15mm GI REDUCER W/T', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:18', 1),
(282, 0000000282, '25mm x 15mm', '25mm x 15mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:18', 1),
(283, 0000000283, '25mm x 20mm', '25mm x 20mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:18', 1),
(284, 0000000284, '32mm x 15mm', '32mm x 15mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:18', 1),
(285, 0000000285, '32mm x 20mm', '32mm x 20mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(286, 0000000286, '32mm x 25mm', '32mm x 25mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(287, 0000000287, '50mm x 25mm', '50mm x 25mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(288, 0000000288, '50mm x 32mm', '50mm x 32mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(289, 0000000289, '65mm x 25mm', '65mm x 25mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(290, 0000000290, '65mm x 32mm', '65mm x 32mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(291, 0000000291, '65mm x 40mm', '65mm x 40mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(292, 0000000292, '75mm x 25mm', '75mm x 25mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(293, 0000000293, '75mm x 32mm', '75mm x 32mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(294, 0000000294, '75mm x 50mm', '75mm x 50mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(295, 0000000295, '75mm x 65mm', '75mm x 65mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(296, 0000000296, '100mm x 50mm', '100mm x 50mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(297, 0000000297, '100mm x 65mm', '100mm x 65mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(298, 0000000298, '125mm x 100mm', '125mm x 100mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(299, 0000000299, '150mm x 75mm', '150mm x 75mm', 0002, 00020002, 000200020000, 0002000200000000, 1, '2019-05-24 21:41:19', 1),
(300, 0000000300, '150mm x 100mm', '150mm x 100mm', 0002, 00020002, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(301, 0000000301, '15mm GI ELBOW 90\' W/T', '15mm GI ELBOW 90\' W/T', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(302, 0000000302, '25mm', '25mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(303, 0000000303, '32mm', '32mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(304, 0000000304, '50mm', '50mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(305, 0000000305, '65mm', '65mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(306, 0000000306, '75mm', '75mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(307, 0000000307, '125mm', '125mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(308, 0000000308, '150mm', '150mm', 0002, 00020003, 000200030000, 0002000300000000, 1, '2019-05-24 21:41:19', 1),
(309, 0000000309, '200mm', '200mm', 0002, 00020003, 000200040000, 0002000400000000, 1, '2019-05-24 21:41:19', 1),
(310, 0000000310, '50mm GI ELBOW 45\' W/T', '50mm GI ELBOW 45\' W/T', 0002, 00020004, 000200040000, 0002000400000000, 1, '2019-05-24 21:41:19', 1),
(311, 0000000311, '65mm', '65mm', 0002, 00020004, 000200040000, 0002000400000000, 1, '2019-05-24 21:41:19', 1),
(312, 0000000312, '75mm', '75mm', 0002, 00020004, 000200040000, 0002000400000000, 1, '2019-05-24 21:41:19', 1),
(313, 0000000313, '100mm', '100mm', 0002, 00020004, 000200040000, 0002000400000000, 1, '2019-05-24 21:41:20', 1),
(314, 0000000314, '150mm', '150mm', 0002, 00020004, 000200040000, 0002000400000000, 1, '2019-05-24 21:41:20', 1),
(315, 0000000315, '250mm', '250mm', 0002, 00020004, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(316, 0000000316, '20mm GI SOCKET W/T', '20mm GI SOCKET W/T', 0002, 00020005, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(317, 0000000317, '25mm', '25mm', 0002, 00020005, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(318, 0000000318, '32mm', '32mm', 0002, 00020005, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(319, 0000000319, '40mm', '40mm', 0002, 00020005, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(320, 0000000320, '50mm', '50mm', 0002, 00020005, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(321, 0000000321, '63mm', '63mm', 0002, 00020005, 000200050000, 0002000500000000, 1, '2019-05-24 21:41:20', 1),
(322, 0000000322, '75mm', '75mm', 0002, 00020005, 000200060000, 0002000600000000, 1, '2019-05-24 21:41:20', 1),
(323, 0000000323, '50mm GI END CAP W/T', '50mm GI END CAP W/T', 0002, 00020006, 000200060000, 0002000600000000, 1, '2019-05-24 21:41:20', 1),
(324, 0000000324, '75mm', '75mm', 0002, 00020006, 000200060000, 0002000600000000, 1, '2019-05-24 21:41:20', 1),
(325, 0000000325, '100mm', '100mm', 0002, 00020006, 000200060000, 0002000600000000, 1, '2019-05-24 21:41:20', 1),
(326, 0000000326, '150mm', '150mm', 0002, 00020006, 000200070000, 0002000700000000, 1, '2019-05-24 21:41:20', 1),
(327, 0000000327, '65mm GI BLIND FLANGE ', '65mm GI BLIND FLANGE ', 0002, 00020007, 000200070001, 0002000700010000, 1, '2019-05-24 21:41:20', 1),
(328, 0000000328, '75mm', '75mm', 0002, 00020007, 000200070001, 0002000700010000, 1, '2019-05-24 21:41:20', 1),
(329, 0000000329, '100mm', '100mm', 0002, 00020007, 000200070001, 0002000700010000, 1, '2019-05-24 21:41:20', 1),
(330, 0000000330, '125mm', '125mm', 0002, 00020007, 000200070001, 0002000700010000, 1, '2019-05-24 21:41:20', 1),
(331, 0000000331, '150mm', '150mm', 0002, 00020007, 000200070001, 0002000700010000, 1, '2019-05-24 21:41:20', 1),
(332, 0000000332, '200mm', '200mm', 0002, 00020007, 000200070001, 0002000700010000, 1, '2019-05-24 21:41:20', 1),
(333, 0000000333, '65mm GI BLIND FLANGE ', '65mm GI BLIND FLANGE ', 0002, 00020007, 000200070002, 0002000700020000, 1, '2019-05-24 21:41:20', 1),
(334, 0000000334, '75mm', '75mm', 0002, 00020007, 000200070002, 0002000700020000, 1, '2019-05-24 21:41:20', 1),
(335, 0000000335, '100mm', '100mm', 0002, 00020007, 000200070002, 0002000700020000, 1, '2019-05-24 21:41:20', 1),
(336, 0000000336, '125mm', '125mm', 0002, 00020007, 000200070002, 0002000700020000, 1, '2019-05-24 21:41:20', 1),
(337, 0000000337, '150mm', '150mm', 0002, 00020007, 000200070002, 0002000700020000, 1, '2019-05-24 21:41:20', 1),
(338, 0000000338, '200mm', '200mm', 0002, 00020007, 000200070002, 0002000700020000, 1, '2019-05-24 21:41:20', 1),
(339, 0000000339, '32mm GI FLANGE W/T', '32mm GI FLANGE W/T', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:20', 1),
(340, 0000000340, '40mm', '40mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(341, 0000000341, '50mm', '50mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(342, 0000000342, '65mm', '65mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(343, 0000000343, '75mm', '75mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(344, 0000000344, '100mm', '100mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(345, 0000000345, '125mm', '125mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(346, 0000000346, '150mm', '150mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(347, 0000000347, '200mm', '200mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(348, 0000000348, '250mm', '250mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(349, 0000000349, '300mm', '300mm', 0002, 00020008, 000200080001, 0002000800010000, 1, '2019-05-24 21:41:21', 1),
(350, 0000000350, '32mm GI FLANGE W/T', '32mm GI FLANGE W/T', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(351, 0000000351, '40mm', '40mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(352, 0000000352, '50mm', '50mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(353, 0000000353, '65mm', '65mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(354, 0000000354, '75mm', '75mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(355, 0000000355, '100mm', '100mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(356, 0000000356, '125mm', '125mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(357, 0000000357, '150mm', '150mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(358, 0000000358, '200mm', '200mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(359, 0000000359, '250mm', '250mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(360, 0000000360, '300mm', '300mm', 0002, 00020008, 000200080002, 0002000800020000, 1, '2019-05-24 21:41:21', 1),
(361, 0000000361, '32mm GI FLANGE W/T', '32mm GI FLANGE W/T', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(362, 0000000362, '40mm', '40mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(363, 0000000363, '50mm', '50mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(364, 0000000364, '65mm', '65mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(365, 0000000365, '75mm', '75mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(366, 0000000366, '100mm', '100mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(367, 0000000367, '125mm', '125mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(368, 0000000368, '150mm', '150mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(369, 0000000369, '200mm', '200mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:21', 1),
(370, 0000000370, '250mm', '250mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:22', 1),
(371, 0000000371, '300mm', '300mm', 0002, 00020008, 000200080003, 0002000800030000, 1, '2019-05-24 21:41:22', 1),
(372, 0000000372, '32mm GI FLANGE W/T', '32mm GI FLANGE W/T', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(373, 0000000373, '40mm', '40mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(374, 0000000374, '50mm', '50mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(375, 0000000375, '65mm', '65mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(376, 0000000376, '75mm', '75mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(377, 0000000377, '100mm', '100mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(378, 0000000378, '125mm', '125mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(379, 0000000379, '150mm', '150mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(380, 0000000380, '200mm', '200mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(381, 0000000381, '250mm', '250mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(382, 0000000382, '300mm', '300mm', 0002, 00020008, 000200080004, 0002000800040000, 1, '2019-05-24 21:41:22', 1),
(383, 0000000383, '32mm GI FLANGE W/T', '32mm GI FLANGE W/T', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(384, 0000000384, '40mm', '40mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(385, 0000000385, '50mm', '50mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(386, 0000000386, '65mm', '65mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(387, 0000000387, '75mm', '75mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(388, 0000000388, '100mm', '100mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(389, 0000000389, '125mm', '125mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(390, 0000000390, '150mm', '150mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(391, 0000000391, '200mm', '200mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(392, 0000000392, '250mm', '250mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1),
(393, 0000000393, '300mm', '300mm', 0002, 00020008, 000200080005, 0002000800050000, 1, '2019-05-24 21:41:22', 1);
INSERT INTO `products` (`products_table_id`, `product_code`, `product_name`, `product_description`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `product_location_id`, `saved_datetime`, `saved_user`) VALUES
(394, 0000000394, '15mm GI PIPE', '15mm GI PIPE', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(395, 0000000395, '20mm', '20mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(396, 0000000396, '25mm', '25mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(397, 0000000397, '32mm', '32mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(398, 0000000398, '40mm', '40mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(399, 0000000399, '50mm', '50mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(400, 0000000400, '65mm', '65mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(401, 0000000401, '75mm', '75mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:22', 1),
(402, 0000000402, '100mm', '100mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:23', 1),
(403, 0000000403, '125mm', '125mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:23', 1),
(404, 0000000404, '150mm', '150mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:23', 1),
(405, 0000000405, '200mm', '200mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:23', 1),
(406, 0000000406, '250mm', '250mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:23', 1),
(407, 0000000407, '300mm', '300mm', 0002, 00020009, 000200090001, 0002000900010000, 1, '2019-05-24 21:41:23', 1),
(408, 0000000408, '15mm GI PIPE', '15mm GI PIPE', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(409, 0000000409, '20mm', '20mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(410, 0000000410, '25mm', '25mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(411, 0000000411, '32mm', '32mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(412, 0000000412, '40mm', '40mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(413, 0000000413, '50mm', '50mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(414, 0000000414, '65mm', '65mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(415, 0000000415, '75mm', '75mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(416, 0000000416, '100mm', '100mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(417, 0000000417, '125mm', '125mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(418, 0000000418, '150mm', '150mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(419, 0000000419, '200mm', '200mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(420, 0000000420, '250mm', '250mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(421, 0000000421, '300mm', '300mm', 0002, 00020009, 000200090002, 0002000900020000, 1, '2019-05-24 21:41:23', 1),
(422, 0000000422, '15mm x 15mm GI TEE T/T', '15mm x 15mm GI TEE T/T', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(423, 0000000423, '20mm x 15mm', '20mm x 15mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(424, 0000000424, '20mm x 20mm', '20mm x 20mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(425, 0000000425, '25mm x 06mm', '25mm x 06mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(426, 0000000426, '25mm x 09mm', '25mm x 09mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(427, 0000000427, '25mm x 15mm', '25mm x 15mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(428, 0000000428, '25mm x 20mm', '25mm x 20mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(429, 0000000429, '25mm x 25mm', '25mm x 25mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:23', 1),
(430, 0000000430, '32mm x 15mm', '32mm x 15mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(431, 0000000431, '32mm x 20mm', '32mm x 20mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(432, 0000000432, '32mm x 25mm', '32mm x 25mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(433, 0000000433, '32mm x 32mm', '32mm x 32mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(434, 0000000434, '40mm x 15mm', '40mm x 15mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(435, 0000000435, '40mmx 20mm', '40mmx 20mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(436, 0000000436, '40mm x 25mm', '40mm x 25mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(437, 0000000437, '40mm x 32mm', '40mm x 32mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(438, 0000000438, '40mm x 40mm', '40mm x 40mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(439, 0000000439, '50mm x 15mm', '50mm x 15mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(440, 0000000440, '50mmx 20mm', '50mmx 20mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(441, 0000000441, '50mm x 25mm', '50mm x 25mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(442, 0000000442, '50mm x 32mm', '50mm x 32mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(443, 0000000443, '50mm x 40mm', '50mm x 40mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(444, 0000000444, '50mm x 50mm', '50mm x 50mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(445, 0000000445, '65mm x 15mm', '65mm x 15mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(446, 0000000446, '65mm x 25mm', '65mm x 25mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(447, 0000000447, '65mm x 50mm', '65mm x 50mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(448, 0000000448, '65mm x 65mm', '65mm x 65mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(449, 0000000449, '75mm x 25mm', '75mm x 25mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(450, 0000000450, '75mm x 40mm', '75mm x 40mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(451, 0000000451, '75mm x 50mm', '75mm x 50mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(452, 0000000452, '75mm x 65mm', '75mm x 65mm', 0003, 00030001, 000300010000, 0003000100000000, 1, '2019-05-24 21:41:24', 1),
(453, 0000000453, '15mm GI ELBOW 90\' T/T', '15mm GI ELBOW 90\' T/T', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:24', 1),
(454, 0000000454, '20mm', '20mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:24', 1),
(455, 0000000455, '25mm', '25mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:24', 1),
(456, 0000000456, '32mm', '32mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:25', 1),
(457, 0000000457, '40mm', '40mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:25', 1),
(458, 0000000458, '50mm', '50mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:25', 1),
(459, 0000000459, '65mm', '65mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:25', 1),
(460, 0000000460, '75mm', '75mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:25', 1),
(461, 0000000461, '100mm', '100mm', 0003, 00030002, 000300020000, 0003000200000000, 1, '2019-05-24 21:41:25', 1),
(462, 0000000462, '15mm GI ELBOW  45\' T/T', '15mm GI ELBOW  45\' T/T', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(463, 0000000463, '20mm', '20mm', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(464, 0000000464, '25mm', '25mm', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(465, 0000000465, '32mm', '32mm', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(466, 0000000466, '40mm', '40mm', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(467, 0000000467, '50mm', '50mm', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(468, 0000000468, '65mm', '65mm', 0003, 00030003, 000300030000, 0003000300000000, 1, '2019-05-24 21:41:25', 1),
(469, 0000000469, '20mm x 15mm GI REDUCER T/T', '20mm x 15mm GI REDUCER T/T', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(470, 0000000470, '25mm x 15mm', '25mm x 15mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(471, 0000000471, '25mm x 20mm', '25mm x 20mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(472, 0000000472, '32mm x 15mm', '32mm x 15mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(473, 0000000473, '32mm x 20mm', '32mm x 20mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(474, 0000000474, '32mm x 25mm', '32mm x 25mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(475, 0000000475, '40mm x 15mm', '40mm x 15mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(476, 0000000476, '40mm x 32mm', '40mm x 32mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(477, 0000000477, '50mm x 20mm', '50mm x 20mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(478, 0000000478, '50mm x 25mm', '50mm x 25mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(479, 0000000479, '50mm x 32mm', '50mm x 32mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:25', 1),
(480, 0000000480, '50mm x 40mm', '50mm x 40mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:26', 1),
(481, 0000000481, '65mm x 25mm', '65mm x 25mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:26', 1),
(482, 0000000482, '65mm x 50mm', '65mm x 50mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:26', 1),
(483, 0000000483, '75mm x 50mm', '75mm x 50mm', 0003, 00030004, 000300040000, 0003000400000000, 1, '2019-05-24 21:41:26', 1),
(484, 0000000484, '15mm GI UNION', '15mm GI UNION', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(485, 0000000485, '20mm', '20mm', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(486, 0000000486, '25mm', '25mm', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(487, 0000000487, '32mm', '32mm', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(488, 0000000488, '40mm', '40mm', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(489, 0000000489, '50mm', '50mm', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(490, 0000000490, '65mm', '65mm', 0003, 00030005, 000300050000, 0003000500000000, 1, '2019-05-24 21:41:26', 1),
(491, 0000000491, '15mm GI SOCKET T/T', '15mm GI SOCKET T/T', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(492, 0000000492, '20mm', '20mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(493, 0000000493, '25mm', '25mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(494, 0000000494, '32mm', '32mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(495, 0000000495, '40mm', '40mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(496, 0000000496, '50mm', '50mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(497, 0000000497, '65mm', '65mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(498, 0000000498, '75mm', '75mm', 0003, 00030006, 000300060000, 0003000600000000, 1, '2019-05-24 21:41:26', 1),
(499, 0000000499, '15mm x 6mm REDUCING BUSH T/T', '15mm x 6mm REDUCING BUSH T/T', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:26', 1),
(500, 0000000500, '15mm x 9mm', '15mm x 9mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:26', 1),
(501, 0000000501, '20mm x 9mm', '20mm x 9mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(502, 0000000502, '20mm x 15mm', '20mm x 15mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(503, 0000000503, '25mm x 15mm', '25mm x 15mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(504, 0000000504, '25mm x 20mm', '25mm x 20mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(505, 0000000505, '32mm x 20mm', '32mm x 20mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(506, 0000000506, '32mm x 25mm', '32mm x 25mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(507, 0000000507, '40mm x32mm', '40mm x32mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(508, 0000000508, '50mm x 32mm', '50mm x 32mm', 0003, 00030007, 000300070000, 0003000700000000, 1, '2019-05-24 21:41:27', 1),
(509, 0000000509, '15mm GI PLUG', '15mm GI PLUG', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(510, 0000000510, '20mm', '20mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(511, 0000000511, '25mm', '25mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(512, 0000000512, '32mm', '32mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(513, 0000000513, '40mm', '40mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(514, 0000000514, '50mm', '50mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(515, 0000000515, '65mm', '65mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(516, 0000000516, '75mm', '75mm', 0003, 00030008, 000300080000, 0003000800000000, 1, '2019-05-24 21:41:27', 1),
(517, 0000000517, '15mm GI NIPPLE', '15mm GI NIPPLE', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(518, 0000000518, '20mm', '20mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(519, 0000000519, '25mm', '25mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(520, 0000000520, '32mm', '32mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(521, 0000000521, '40mm', '40mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(522, 0000000522, '65mm', '65mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(523, 0000000523, '75mm', '75mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(524, 0000000524, '100mm', '100mm', 0003, 00030009, 000300090000, 0003000900000000, 1, '2019-05-24 21:41:27', 1),
(525, 0000000525, '20mm GI END CAP T/', '20mm GI END CAP T/', 0003, 00030010, 000300100000, 0003001000000000, 1, '2019-05-24 21:41:27', 1),
(526, 0000000526, '25mm', '25mm', 0003, 00030010, 000300100000, 0003001000000000, 1, '2019-05-24 21:41:27', 1),
(527, 0000000527, '32mm', '32mm', 0003, 00030010, 000300100000, 0003001000000000, 1, '2019-05-24 21:41:27', 1),
(528, 0000000528, '40mm', '40mm', 0003, 00030010, 000300100000, 0003001000000000, 1, '2019-05-24 21:41:28', 1),
(529, 0000000529, '50mm', '50mm', 0003, 00030010, 000300100000, 0003001000000000, 1, '2019-05-24 21:41:28', 1),
(530, 0000000530, '100mm', '100mm', 0003, 00030010, 000300100000, 0003001000000000, 1, '2019-05-24 21:41:28', 1),
(531, 0000000531, '20mm x 15mm BI TEE W/T', '20mm x 15mm BI TEE W/T', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(532, 0000000532, '20mm x 20mm', '20mm x 20mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(533, 0000000533, '25mm x 15mm', '25mm x 15mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(534, 0000000534, '25mm x 20mm', '25mm x 20mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(535, 0000000535, '25mm x 25mm', '25mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(536, 0000000536, '32mm x 20mm', '32mm x 20mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(537, 0000000537, '32mm x 25mm', '32mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(538, 0000000538, '32mm x 32mm', '32mm x 32mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(539, 0000000539, '40mm x 20mm', '40mm x 20mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(540, 0000000540, '40mm x 25mm', '40mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(541, 0000000541, '40mm x 32mm', '40mm x 32mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(542, 0000000542, '40mm x 40mm', '40mm x 40mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(543, 0000000543, '50mm x 20mm', '50mm x 20mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(544, 0000000544, '50mm x 25mm', '50mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(545, 0000000545, '50mm x 32mm', '50mm x 32mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(546, 0000000546, '50mm x 50mm', '50mm x 50mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(547, 0000000547, '65mm x 15mm', '65mm x 15mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(548, 0000000548, '65mm x 20mm', '65mm x 20mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(549, 0000000549, '65mm x 25mm', '65mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:28', 1),
(550, 0000000550, '65mm x 32mm', '65mm x 32mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(551, 0000000551, '65mm x 40mm', '65mm x 40mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(552, 0000000552, '65mm x 50mm', '65mm x 50mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(553, 0000000553, '65mm x 65mm', '65mm x 65mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(554, 0000000554, '75mm x 25mm', '75mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(555, 0000000555, '75mm x 32mm', '75mm x 32mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(556, 0000000556, '75mm x 40mm', '75mm x 40mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(557, 0000000557, '75mm x 65mm', '75mm x 65mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(558, 0000000558, '75mm x 75mm', '75mm x 75mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(559, 0000000559, '100mm x 25mm', '100mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(560, 0000000560, '100mm x 40mm', '100mm x 40mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(561, 0000000561, '100mm x 50mm', '100mm x 50mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(562, 0000000562, '100mm x 65mm', '100mm x 65mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(563, 0000000563, '100mm x 75mm', '100mm x 75mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(564, 0000000564, '100mm x 100mm', '100mm x 100mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(565, 0000000565, '125mm x 50mm', '125mm x 50mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(566, 0000000566, '125mm x 65mm', '125mm x 65mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(567, 0000000567, '125mm x 75mm', '125mm x 75mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(568, 0000000568, '125mm x 100mm', '125mm x 100mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(569, 0000000569, '150mm x 25mm', '150mm x 25mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(570, 0000000570, '150mm x 50mm', '150mm x 50mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(571, 0000000571, '150mm x 65mm', '150mm x 65mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:29', 1),
(572, 0000000572, '150mm x 75mm', '150mm x 75mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(573, 0000000573, '150mm x 100mm', '150mm x 100mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(574, 0000000574, '150mm x 125mm', '150mm x 125mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(575, 0000000575, '150mm x 150mm', '150mm x 150mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(576, 0000000576, '200mm x 75mm', '200mm x 75mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(577, 0000000577, '200mm x 100mm', '200mm x 100mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(578, 0000000578, '200mm x 125mm', '200mm x 125mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(579, 0000000579, '200mm x 150mm', '200mm x 150mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(580, 0000000580, '200mm x 200mm', '200mm x 200mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(581, 0000000581, '250mm x 250mm', '250mm x 250mm', 0004, 00040001, 000400010000, 0004000100000000, 1, '2019-05-24 21:41:30', 1),
(582, 0000000582, '25mm x 15mm BI REDUCER W/T', '25mm x 15mm BI REDUCER W/T', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(583, 0000000583, '25mm x 20mm', '25mm x 20mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(584, 0000000584, '32mm x 20mm', '32mm x 20mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(585, 0000000585, '32mm x 25mm', '32mm x 25mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(586, 0000000586, '40mm x 20mm', '40mm x 20mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(587, 0000000587, '40mm x 25mm', '40mm x 25mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(588, 0000000588, '40mm x 32mm', '40mm x 32mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(589, 0000000589, '50mm x 15mm', '50mm x 15mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(590, 0000000590, '50mm x 20mm', '50mm x 20mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(591, 0000000591, '50mm x 25mm', '50mm x 25mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(592, 0000000592, '50mm x 40mm', '50mm x 40mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(593, 0000000593, '65mm x 15mm', '65mm x 15mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(594, 0000000594, '65mm x 20mm', '65mm x 20mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:30', 1),
(595, 0000000595, '65mm x 32mm', '65mm x 32mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(596, 0000000596, '65mm x 40mm', '65mm x 40mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(597, 0000000597, '75mm x 25mm', '75mm x 25mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(598, 0000000598, '75mm x 40mm', '75mm x 40mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(599, 0000000599, '75mm x 50mm', '75mm x 50mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(600, 0000000600, '75mm x 65mm', '75mm x 65mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(601, 0000000601, '100mm x 25mm', '100mm x 25mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(602, 0000000602, '100mm x 50mm', '100mm x 50mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(603, 0000000603, '100mm x 65mm', '100mm x 65mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(604, 0000000604, '100mm x 75mm', '100mm x 75mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(605, 0000000605, '125mm x 65mm', '125mm x 65mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(606, 0000000606, '125mm x 75mm', '125mm x 75mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(607, 0000000607, '125mm x 100mm', '125mm x 100mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(608, 0000000608, '150mm x 65mm', '150mm x 65mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(609, 0000000609, '150mm x 75mm', '150mm x 75mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(610, 0000000610, '150mm x 125mm', '150mm x 125mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(611, 0000000611, '200mm x 150mm', '200mm x 150mm', 0004, 00040002, 000400020000, 0004000200000000, 1, '2019-05-24 21:41:31', 1),
(612, 0000000612, '15mm BI ELBOW 90\' W/T', '15mm BI ELBOW 90\' W/T', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:31', 1),
(613, 0000000613, '20mm', '20mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:31', 1),
(614, 0000000614, '25mm', '25mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:31', 1),
(615, 0000000615, '32mm', '32mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:31', 1),
(616, 0000000616, '40mm', '40mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:31', 1),
(617, 0000000617, '50mm', '50mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:31', 1),
(618, 0000000618, '65mm', '65mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:32', 1),
(619, 0000000619, '125mm', '125mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:32', 1),
(620, 0000000620, '150mm', '150mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:32', 1),
(621, 0000000621, '200mm', '200mm', 0004, 00040003, 000400030000, 0004000300000000, 1, '2019-05-24 21:41:32', 1),
(622, 0000000622, '25mm BI ELBOW 45\' W/T', '25mm BI ELBOW 45\' W/T', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(623, 0000000623, '32mm', '32mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(624, 0000000624, '40mm', '40mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(625, 0000000625, '50mm', '50mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(626, 0000000626, '65mm', '65mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(627, 0000000627, '75mm', '75mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(628, 0000000628, '100mm', '100mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(629, 0000000629, '125mm', '125mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(630, 0000000630, '200mm', '200mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(631, 0000000631, '250mm', '250mm', 0004, 00040004, 000400040000, 0004000400000000, 1, '2019-05-24 21:41:32', 1),
(632, 0000000632, '9mm BI SOCKET W/T', '9mm BI SOCKET W/T', 0004, 00040005, 000400050000, 0004000500000000, 1, '2019-05-24 21:41:32', 1),
(633, 0000000633, '20mm', '20mm', 0004, 00040005, 000400050000, 0004000500000000, 1, '2019-05-24 21:41:32', 1),
(634, 0000000634, '25mm', '25mm', 0004, 00040005, 000400050000, 0004000500000000, 1, '2019-05-24 21:41:32', 1),
(635, 0000000635, '32mm', '32mm', 0004, 00040005, 000400050000, 0004000500000000, 1, '2019-05-24 21:41:32', 1),
(636, 0000000636, '40mm', '40mm', 0004, 00040005, 000400050000, 0004000500000000, 1, '2019-05-24 21:41:32', 1),
(637, 0000000637, '100mm BI END CAP W/T', '100mm BI END CAP W/T', 0004, 00040006, 000400060000, 0004000600000000, 1, '2019-05-24 21:41:32', 1),
(638, 0000000638, '125mm', '125mm', 0004, 00040006, 000400060000, 0004000600000000, 1, '2019-05-24 21:41:32', 1),
(639, 0000000639, '150mm', '150mm', 0004, 00040006, 000400060000, 0004000600000000, 1, '2019-05-24 21:41:32', 1),
(640, 0000000640, '250mm BI BLIND FLANGE', '250mm BI BLIND FLANGE', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:32', 1),
(641, 0000000641, '200mm', '200mm', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:33', 1),
(642, 0000000642, '100mm', '100mm', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:33', 1),
(643, 0000000643, '80mm', '80mm', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:33', 1),
(644, 0000000644, '50mm', '50mm', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:33', 1),
(645, 0000000645, '20mm', '20mm', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:33', 1),
(646, 0000000646, '15mm', '15mm', 0004, 00040007, 000400070001, 0004000700010000, 1, '2019-05-24 21:41:33', 1),
(647, 0000000647, '250mm BI BLIND FLANGE', '250mm BI BLIND FLANGE', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(648, 0000000648, '200mm', '200mm', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(649, 0000000649, '100mm', '100mm', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(650, 0000000650, '80mm', '80mm', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(651, 0000000651, '50mm', '50mm', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(652, 0000000652, '20mm', '20mm', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(653, 0000000653, '15mm', '15mm', 0004, 00040007, 000400070002, 0004000700020000, 1, '2019-05-24 21:41:33', 1),
(654, 0000000654, '15mm BI FLANGE W/T', '15mm BI FLANGE W/T', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(655, 0000000655, '20mm', '20mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(656, 0000000656, '25mm', '25mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(657, 0000000657, '32mm', '32mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(658, 0000000658, '40mm', '40mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(659, 0000000659, '50mm', '50mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(660, 0000000660, '65mm', '65mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(661, 0000000661, '75mm', '75mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(662, 0000000662, '100mm', '100mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(663, 0000000663, '125mm', '125mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(664, 0000000664, '150mm', '150mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(665, 0000000665, '200mm', '200mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(666, 0000000666, '250mm', '250mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(667, 0000000667, '300mm', '300mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(668, 0000000668, '400mm', '400mm', 0004, 00040008, 000400080001, 0004000800010000, 1, '2019-05-24 21:41:33', 1),
(669, 0000000669, '15mm BI FLANGE W/T', '15mm BI FLANGE W/T', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:33', 1),
(670, 0000000670, '20mm', '20mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:33', 1),
(671, 0000000671, '25mm', '25mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(672, 0000000672, '32mm', '32mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(673, 0000000673, '40mm', '40mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(674, 0000000674, '50mm', '50mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(675, 0000000675, '65mm', '65mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(676, 0000000676, '75mm', '75mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(677, 0000000677, '100mm', '100mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(678, 0000000678, '125mm', '125mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(679, 0000000679, '150mm', '150mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(680, 0000000680, '200mm', '200mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(681, 0000000681, '250mm', '250mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(682, 0000000682, '300mm', '300mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(683, 0000000683, '400mm', '400mm', 0004, 00040008, 000400080002, 0004000800020000, 1, '2019-05-24 21:41:34', 1),
(684, 0000000684, '15mm BI FLANGE W/T', '15mm BI FLANGE W/T', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(685, 0000000685, '20mm', '20mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(686, 0000000686, '25mm', '25mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(687, 0000000687, '32mm', '32mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(688, 0000000688, '40mm', '40mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(689, 0000000689, '50mm', '50mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(690, 0000000690, '65mm', '65mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(691, 0000000691, '75mm', '75mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:34', 1),
(692, 0000000692, '100mm', '100mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(693, 0000000693, '125mm', '125mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(694, 0000000694, '150mm', '150mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(695, 0000000695, '200mm', '200mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(696, 0000000696, '250mm', '250mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(697, 0000000697, '300mm', '300mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(698, 0000000698, '400mm', '400mm', 0004, 00040008, 000400080003, 0004000800030000, 1, '2019-05-24 21:41:35', 1),
(699, 0000000699, '15mm BI FLANGE W/T', '15mm BI FLANGE W/T', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(700, 0000000700, '20mm', '20mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(701, 0000000701, '25mm', '25mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(702, 0000000702, '32mm', '32mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(703, 0000000703, '40mm', '40mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(704, 0000000704, '50mm', '50mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(705, 0000000705, '65mm', '65mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(706, 0000000706, '75mm', '75mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(707, 0000000707, '100mm', '100mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(708, 0000000708, '125mm', '125mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(709, 0000000709, '150mm', '150mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(710, 0000000710, '200mm', '200mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(711, 0000000711, '250mm', '250mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(712, 0000000712, '300mm', '300mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(713, 0000000713, '400mm', '400mm', 0004, 00040008, 000400080004, 0004000800040000, 1, '2019-05-24 21:41:35', 1),
(714, 0000000714, '15mm BI FLANGE W/T', '15mm BI FLANGE W/T', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:35', 1),
(715, 0000000715, '20mm', '20mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:35', 1),
(716, 0000000716, '25mm', '25mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:35', 1),
(717, 0000000717, '32mm', '32mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(718, 0000000718, '40mm', '40mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(719, 0000000719, '50mm', '50mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(720, 0000000720, '65mm', '65mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(721, 0000000721, '75mm', '75mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(722, 0000000722, '100mm', '100mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(723, 0000000723, '125mm', '125mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(724, 0000000724, '150mm', '150mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(725, 0000000725, '200mm', '200mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(726, 0000000726, '250mm', '250mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(727, 0000000727, '300mm', '300mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(728, 0000000728, '400mm', '400mm', 0004, 00040008, 000400080005, 0004000800050000, 1, '2019-05-24 21:41:36', 1),
(729, 0000000729, '15mm BI PIPE HEAVY DUTY', '15mm BI PIPE HEAVY DUTY', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(730, 0000000730, '20mm', '20mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(731, 0000000731, '25mm', '25mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(732, 0000000732, '32mm', '32mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(733, 0000000733, '40mm', '40mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(734, 0000000734, '50mm', '50mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(735, 0000000735, '65mm', '65mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(736, 0000000736, '75mm', '75mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(737, 0000000737, '100mm', '100mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(738, 0000000738, '125mm', '125mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(739, 0000000739, '150mm', '150mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(740, 0000000740, '200mm', '200mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(741, 0000000741, '250mm', '250mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:36', 1),
(742, 0000000742, '300mm', '300mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:37', 1),
(743, 0000000743, '400mm', '400mm', 0004, 00040009, 000400090001, 0004000900010000, 1, '2019-05-24 21:41:37', 1),
(744, 0000000744, '15mm BI PIPE MEDIUM DUTY', '15mm BI PIPE MEDIUM DUTY', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(745, 0000000745, '20mm', '20mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(746, 0000000746, '25mm', '25mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(747, 0000000747, '32mm', '32mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(748, 0000000748, '40mm', '40mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(749, 0000000749, '50mm', '50mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(750, 0000000750, '65mm', '65mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(751, 0000000751, '75mm', '75mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(752, 0000000752, '100mm', '100mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(753, 0000000753, '125mm', '125mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(754, 0000000754, '150mm', '150mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(755, 0000000755, '200mm', '200mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(756, 0000000756, '250mm', '250mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(757, 0000000757, '300mm', '300mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(758, 0000000758, '400mm', '400mm', 0004, 00040009, 000400090002, 0004000900020000, 1, '2019-05-24 21:41:37', 1),
(759, 0000000759, '20mm x 15mm BI TEE T/T', '20mm x 15mm BI TEE T/T', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(760, 0000000760, '20mm x 20mm', '20mm x 20mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(761, 0000000761, '25mm x 15mm', '25mm x 15mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(762, 0000000762, '25mm x 20mm', '25mm x 20mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(763, 0000000763, '25mm x 25mm', '25mm x 25mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(764, 0000000764, '32mm x 15mm', '32mm x 15mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(765, 0000000765, '32mm x 20mm', '32mm x 20mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(766, 0000000766, '32mm x 25mm', '32mm x 25mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(767, 0000000767, '40mm x 15mm', '40mm x 15mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(768, 0000000768, '40mm x 25mm', '40mm x 25mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(769, 0000000769, '40mm x 32mm', '40mm x 32mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(770, 0000000770, '40mm x 40mm', '40mm x 40mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:37', 1),
(771, 0000000771, '50mm x 25mm', '50mm x 25mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:38', 1),
(772, 0000000772, '50mm x 32mm', '50mm x 32mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:38', 1),
(773, 0000000773, '50mm x 40mm', '50mm x 40mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:38', 1),
(774, 0000000774, '50mm x 50mm', '50mm x 50mm', 0005, 00050001, 000500010000, 0005000100000000, 1, '2019-05-24 21:41:38', 1),
(775, 0000000775, '9mm BI ELBOW 90\' T/T', '9mm BI ELBOW 90\' T/T', 0005, 00050002, 000500020000, 0005000200000000, 1, '2019-05-24 21:41:38', 1),
(776, 0000000776, '15mm', '15mm', 0005, 00050002, 000500020000, 0005000200000000, 1, '2019-05-24 21:41:38', 1),
(777, 0000000777, '20mm', '20mm', 0005, 00050002, 000500020000, 0005000200000000, 1, '2019-05-24 21:41:38', 1),
(778, 0000000778, '25mm', '25mm', 0005, 00050002, 000500020000, 0005000200000000, 1, '2019-05-24 21:41:38', 1),
(779, 0000000779, '50mm', '50mm', 0005, 00050002, 000500020000, 0005000200000000, 1, '2019-05-24 21:41:38', 1),
(780, 0000000780, '32mm BI ELBOW 45\' T/T', '32mm BI ELBOW 45\' T/T', 0005, 00050003, 000500030000, 0005000300000000, 1, '2019-05-24 21:41:38', 1),
(781, 0000000781, '50mm', '50mm', 0005, 00050003, 000500030000, 0005000300000000, 1, '2019-05-24 21:41:38', 1),
(782, 0000000782, '20mm x 15mm BI REDUCER T/T', '20mm x 15mm BI REDUCER T/T', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(783, 0000000783, '25mm x 15mm', '25mm x 15mm', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(784, 0000000784, '25mm x 20mm', '25mm x 20mm', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(785, 0000000785, '32mm x 20mm', '32mm x 20mm', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(786, 0000000786, '32mm x 25mm', '32mm x 25mm', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(787, 0000000787, '40mm x 25mm', '40mm x 25mm', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(788, 0000000788, '50mm x 40mm', '50mm x 40mm', 0005, 00050004, 000500040000, 0005000400000000, 1, '2019-05-24 21:41:38', 1),
(789, 0000000789, '15mm BI UNION ', '15mm BI UNION ', 0005, 00050005, 000500050000, 0005000500000000, 1, '2019-05-24 21:41:38', 1),
(790, 0000000790, '20mm', '20mm', 0005, 00050005, 000500050000, 0005000500000000, 1, '2019-05-24 21:41:38', 1),
(791, 0000000791, '25mm', '25mm', 0005, 00050005, 000500050000, 0005000500000000, 1, '2019-05-24 21:41:38', 1),
(792, 0000000792, '32mm', '32mm', 0005, 00050005, 000500050000, 0005000500000000, 1, '2019-05-24 21:41:38', 1),
(793, 0000000793, '40mm', '40mm', 0005, 00050005, 000500050000, 0005000500000000, 1, '2019-05-24 21:41:38', 1),
(794, 0000000794, '15mm BI SOCKET T/T', '15mm BI SOCKET T/T', 0005, 00050006, 000500060000, 0005000600000000, 1, '2019-05-24 21:41:38', 1),
(795, 0000000795, '20mm', '20mm', 0005, 00050006, 000500060000, 0005000600000000, 1, '2019-05-24 21:41:38', 1),
(796, 0000000796, '25mm', '25mm', 0005, 00050006, 000500060000, 0005000600000000, 1, '2019-05-24 21:41:38', 1),
(797, 0000000797, '32mm', '32mm', 0005, 00050006, 000500060000, 0005000600000000, 1, '2019-05-24 21:41:38', 1),
(798, 0000000798, '40mm', '40mm', 0005, 00050006, 000500060000, 0005000600000000, 1, '2019-05-24 21:41:39', 1),
(799, 0000000799, '50mm', '50mm', 0005, 00050006, 000500060000, 0005000600000000, 1, '2019-05-24 21:41:39', 1),
(800, 0000000800, '20mm x 15mm BI RUDUCING BUSH T/T', '20mm x 15mm BI RUDUCING BUSH T/T', 0005, 00050007, 000500070000, 0005000700000000, 1, '2019-05-24 21:41:39', 1),
(801, 0000000801, '25mm x 15mm', '25mm x 15mm', 0005, 00050007, 000500070000, 0005000700000000, 1, '2019-05-24 21:41:39', 1),
(802, 0000000802, '25mm x 20mm', '25mm x 20mm', 0005, 00050007, 000500070000, 0005000700000000, 1, '2019-05-24 21:41:39', 1),
(803, 0000000803, '32mm x 20mm', '32mm x 20mm', 0005, 00050007, 000500070000, 0005000700000000, 1, '2019-05-24 21:41:39', 1),
(804, 0000000804, '15mm BI PLUG', '15mm BI PLUG', 0005, 00050008, 000500080000, 0005000800000000, 1, '2019-05-24 21:41:39', 1),
(805, 0000000805, '20mm', '20mm', 0005, 00050008, 000500080000, 0005000800000000, 1, '2019-05-24 21:41:39', 1),
(806, 0000000806, '25mm', '25mm', 0005, 00050008, 000500080000, 0005000800000000, 1, '2019-05-24 21:41:39', 1),
(807, 0000000807, '50mm', '50mm', 0005, 00050008, 000500080000, 0005000800000000, 1, '2019-05-24 21:41:39', 1),
(808, 0000000808, '65mm', '65mm', 0005, 00050008, 000500080000, 0005000800000000, 1, '2019-05-24 21:41:39', 1),
(809, 0000000809, '15mm BI NIPPLE', '15mm BI NIPPLE', 0005, 00050009, 000500090000, 0005000900000000, 1, '2019-05-24 21:41:39', 1),
(810, 0000000810, '20mm', '20mm', 0005, 00050009, 000500090000, 0005000900000000, 1, '2019-05-24 21:41:39', 1),
(811, 0000000811, '25mm', '25mm', 0005, 00050009, 000500090000, 0005000900000000, 1, '2019-05-24 21:41:39', 1),
(812, 0000000812, '50mm', '50mm', 0005, 00050009, 000500090000, 0005000900000000, 1, '2019-05-24 21:41:39', 1);
INSERT INTO `products` (`products_table_id`, `product_code`, `product_name`, `product_description`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `product_location_id`, `saved_datetime`, `saved_user`) VALUES
(813, 0000000813, '15mm BI END CAP T/T', '15mm BI END CAP T/T', 0005, 00050010, 000500100000, 0005001000000000, 1, '2019-05-24 21:41:39', 1),
(814, 0000000814, '20mm', '20mm', 0005, 00050010, 000500100000, 0005001000000000, 1, '2019-05-24 21:41:39', 1),
(815, 0000000815, '25mm', '25mm', 0005, 00050010, 000500100000, 0005001000000000, 1, '2019-05-24 21:41:39', 1),
(816, 0000000816, '20mm PPR EBLOW 90\'', '20mm PPR EBLOW 90\'', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:39', 1),
(817, 0000000817, '25mm', '25mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:39', 1),
(818, 0000000818, '32mm', '32mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:39', 1),
(819, 0000000819, '40mm', '40mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:39', 1),
(820, 0000000820, '50mm', '50mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:39', 1),
(821, 0000000821, '63mm', '63mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:40', 1),
(822, 0000000822, '75mm', '75mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:40', 1),
(823, 0000000823, '90mm', '90mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:40', 1),
(824, 0000000824, '110mm', '110mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:40', 1),
(825, 0000000825, '125mm', '125mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:40', 1),
(826, 0000000826, '160mm', '160mm', 0006, 00060001, 000600010000, 0006000100000000, 1, '2019-05-24 21:41:40', 1),
(827, 0000000827, '20mm PPR EBLOW 45\'', '20mm PPR EBLOW 45\'', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(828, 0000000828, '32mm', '32mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(829, 0000000829, '40mm', '40mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(830, 0000000830, '50mm', '50mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(831, 0000000831, '63mm', '63mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(832, 0000000832, '75mm', '75mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(833, 0000000833, '90mm', '90mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(834, 0000000834, '110mm', '110mm', 0006, 00060002, 000600020000, 0006000200000000, 1, '2019-05-24 21:41:40', 1),
(835, 0000000835, '25mm PPR SOCKET', '25mm PPR SOCKET', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(836, 0000000836, '32mm', '32mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(837, 0000000837, '40mm', '40mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(838, 0000000838, '50mm', '50mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(839, 0000000839, '63mm', '63mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(840, 0000000840, '75mm', '75mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(841, 0000000841, '90mm', '90mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(842, 0000000842, '110mm', '110mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:40', 1),
(843, 0000000843, '125mm', '125mm', 0006, 00060003, 000600030000, 0006000300000000, 1, '2019-05-24 21:41:41', 1),
(844, 0000000844, '20mm x 20mm PPR TEE', '20mm x 20mm PPR TEE', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(845, 0000000845, '25mm x 20mm', '25mm x 20mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(846, 0000000846, '25mm x 25mm', '25mm x 25mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(847, 0000000847, '32mm x 20mm', '32mm x 20mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(848, 0000000848, '32mm x 25mm', '32mm x 25mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(849, 0000000849, '32mmx 32mm', '32mmx 32mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(850, 0000000850, '40mm x 20mm', '40mm x 20mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(851, 0000000851, '40mm x 25mm', '40mm x 25mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(852, 0000000852, '40mm x 32mm', '40mm x 32mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(853, 0000000853, '40mm x 40mm', '40mm x 40mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(854, 0000000854, '50mm x 20mm', '50mm x 20mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(855, 0000000855, '50mm x 25mm', '50mm x 25mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(856, 0000000856, '50mm x 32mm', '50mm x 32mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(857, 0000000857, '50mm x 40mm', '50mm x 40mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(858, 0000000858, '50mm x 50mm', '50mm x 50mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(859, 0000000859, '63mm x 20mm', '63mm x 20mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(860, 0000000860, '63mm x 25mm', '63mm x 25mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(861, 0000000861, '63mm x 40mm', '63mm x 40mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(862, 0000000862, '63mm x 50mm', '63mm x 50mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(863, 0000000863, '63mm x 63mm', '63mm x 63mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(864, 0000000864, '75mm x 32mm', '75mm x 32mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:41', 1),
(865, 0000000865, '75mm x 40mm', '75mm x 40mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(866, 0000000866, '75mm x 50mm', '75mm x 50mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(867, 0000000867, '75mm x 63mm', '75mm x 63mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(868, 0000000868, '75mm x 75mm', '75mm x 75mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(869, 0000000869, '90mm x 63mm', '90mm x 63mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(870, 0000000870, '90mm x 75mm', '90mm x 75mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(871, 0000000871, '90mm x 90mm', '90mm x 90mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(872, 0000000872, '110mm x 90mm', '110mm x 90mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(873, 0000000873, '125mm x 125mm', '125mm x 125mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(874, 0000000874, '160mm x 160mm', '160mm x 160mm', 0006, 00060004, 000600040000, 0006000400000000, 1, '2019-05-24 21:41:42', 1),
(875, 0000000875, '25mm  x 16mm PPR REDUCER', '25mm  x 16mm PPR REDUCER', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(876, 0000000876, '25mm x 20mm', '25mm x 20mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(877, 0000000877, '32mm x 20mm', '32mm x 20mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(878, 0000000878, '40mm x 20mm', '40mm x 20mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(879, 0000000879, '40mm x 25mm', '40mm x 25mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(880, 0000000880, '40mm x 32mm', '40mm x 32mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(881, 0000000881, '50mm x 32mm', '50mm x 32mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(882, 0000000882, '50mm x 40mm', '50mm x 40mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(883, 0000000883, '63mm x 25mm', '63mm x 25mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(884, 0000000884, '63mm x 32mm', '63mm x 32mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(885, 0000000885, '63mm x 40mm', '63mm x 40mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(886, 0000000886, '63mm x 50mm', '63mm x 50mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(887, 0000000887, '75mm x 40mm', '75mm x 40mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:42', 1),
(888, 0000000888, '75mm x 50mm', '75mm x 50mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(889, 0000000889, '75mmx 63mm', '75mmx 63mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(890, 0000000890, '90mm x 50mm', '90mm x 50mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(891, 0000000891, '90mm x 63mm', '90mm x 63mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(892, 0000000892, '90mm x 75mm', '90mm x 75mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(893, 0000000893, '110mm x 63mm', '110mm x 63mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(894, 0000000894, '110mm x 75mm', '110mm x 75mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(895, 0000000895, '110mm x 90mm', '110mm x 90mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(896, 0000000896, '125mm x 110mm', '125mm x 110mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(897, 0000000897, '160mm x 110mm', '160mm x 110mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(898, 0000000898, '160mm x 125mm', '160mm x 125mm', 0006, 00060005, 000600050000, 0006000500000000, 1, '2019-05-24 21:41:43', 1),
(899, 0000000899, '50mm PPR FLANGE ADEPTOR', '50mm PPR FLANGE ADEPTOR', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(900, 0000000900, '63mm', '63mm', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(901, 0000000901, '75mm', '75mm', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(902, 0000000902, '90mm', '90mm', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(903, 0000000903, '110mm', '110mm', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(904, 0000000904, '125mm', '125mm', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(905, 0000000905, '160mm', '160mm', 0006, 00060006, 000600060000, 0006000600000000, 1, '2019-05-24 21:41:43', 1),
(906, 0000000906, '20 x 1/2\" PPR MALE ADEPTOR', '20 x 1/2\" PPR MALE ADEPTOR', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:43', 1),
(907, 0000000907, '24 x 1/2\"', '24 x 1/2\"', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:43', 1),
(908, 0000000908, '25 x 3/4\"', '25 x 3/4\"', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:44', 1),
(909, 0000000909, '32 x 3/4\"', '32 x 3/4\"', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:44', 1),
(910, 0000000910, '32 x 1\"', '32 x 1\"', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:44', 1),
(911, 0000000911, '40 x 1-1/4\"', '40 x 1-1/4\"', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:44', 1),
(912, 0000000912, '75 x 2-1/2\"', '75 x 2-1/2\"', 0006, 00060007, 000600070000, 0006000700000000, 1, '2019-05-24 21:41:44', 1),
(913, 0000000913, '20 x 1/2\" PPR FEMALE ADEPTOR', '20 x 1/2\" PPR FEMALE ADEPTOR', 0006, 00060008, 000600080000, 0006000800000000, 1, '2019-05-24 21:41:44', 1),
(914, 0000000914, '32mm', '32mm', 0006, 00060008, 000600080000, 0006000800000000, 1, '2019-05-24 21:41:44', 1),
(915, 0000000915, '40mm', '40mm', 0006, 00060008, 000600080000, 0006000800000000, 1, '2019-05-24 21:41:44', 1),
(916, 0000000916, '50mm', '50mm', 0006, 00060008, 000600080000, 0006000800000000, 1, '2019-05-24 21:41:44', 1),
(917, 0000000917, '20mm PPR END CAP', '20mm PPR END CAP', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(918, 0000000918, '25mm', '25mm', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(919, 0000000919, '32mm', '32mm', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(920, 0000000920, '40mm', '40mm', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(921, 0000000921, '63mm', '63mm', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(922, 0000000922, '75mm', '75mm', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(923, 0000000923, '90mm', '90mm', 0006, 00060009, 000600090000, 0006000900000000, 1, '2019-05-24 21:41:44', 1),
(924, 0000000924, '25mm PPR UNION', '25mm PPR UNION', 0006, 00060010, 000600100000, 0006001000000000, 1, '2019-05-24 21:41:44', 1),
(925, 0000000925, '40mm', '40mm', 0006, 00060010, 000600100000, 0006001000000000, 1, '2019-05-24 21:41:44', 1),
(926, 0000000926, '50mm', '50mm', 0006, 00060010, 000600100000, 0006001000000000, 1, '2019-05-24 21:41:44', 1),
(927, 0000000927, '110mm x 32mm PPR SADDLE', '110mm x 32mm PPR SADDLE', 0006, 00060011, 000600110000, 0006001100000000, 1, '2019-05-24 21:41:45', 1),
(928, 0000000928, '75mm x 32mm', '75mm x 32mm', 0006, 00060011, 000600110000, 0006001100000000, 1, '2019-05-24 21:41:45', 1),
(929, 0000000929, '20mm PPR PIPE PN-10', '20mm PPR PIPE PN-10', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(930, 0000000930, '25mm', '25mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(931, 0000000931, '32mm', '32mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(932, 0000000932, '40mm', '40mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(933, 0000000933, '50mm', '50mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(934, 0000000934, '65mm', '65mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(935, 0000000935, '75mm', '75mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(936, 0000000936, '90mm', '90mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(937, 0000000937, '100mm', '100mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(938, 0000000938, '125mm', '125mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(939, 0000000939, '110mm', '110mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(940, 0000000940, '160mm', '160mm', 0006, 00060012, 000600120001, 0006001200010000, 1, '2019-05-24 21:41:45', 1),
(941, 0000000941, '20mm PPR PIPE PN-16', '20mm PPR PIPE PN-16', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(942, 0000000942, '25mm', '25mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(943, 0000000943, '32mm', '32mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(944, 0000000944, '40mm', '40mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(945, 0000000945, '50mm', '50mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(946, 0000000946, '65mm', '65mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(947, 0000000947, '75mm', '75mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(948, 0000000948, '90mm', '90mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(949, 0000000949, '100mm', '100mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(950, 0000000950, '125mm', '125mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(951, 0000000951, '110mm', '110mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:45', 1),
(952, 0000000952, '160mm', '160mm', 0006, 00060012, 000600120002, 0006001200020000, 1, '2019-05-24 21:41:46', 1),
(953, 0000000953, '20mm PPR PIPE PN-25', '20mm PPR PIPE PN-25', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(954, 0000000954, '25mm', '25mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(955, 0000000955, '32mm', '32mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(956, 0000000956, '40mm', '40mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(957, 0000000957, '50mm', '50mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(958, 0000000958, '65mm', '65mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(959, 0000000959, '75mm', '75mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(960, 0000000960, '90mm', '90mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(961, 0000000961, '100mm', '100mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(962, 0000000962, '125mm', '125mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(963, 0000000963, '110mm', '110mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(964, 0000000964, '160mm', '160mm', 0006, 00060012, 000600120003, 0006001200030000, 1, '2019-05-24 21:41:46', 1),
(965, 0000000965, '56mm x 56mm ACOUSTIC Y', '56mm x 56mm ACOUSTIC Y', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(966, 0000000966, '70mm x 56mm', '70mm x 56mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(967, 0000000967, '70mm x 70mm', '70mm x 70mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(968, 0000000968, '100mm x 56mm', '100mm x 56mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(969, 0000000969, '100mm x 70mm', '100mm x 70mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(970, 0000000970, '100mm x 100mm', '100mm x 100mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(971, 0000000971, '150mm x 100mm', '150mm x 100mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(972, 0000000972, '150mm x 150mm', '150mm x 150mm', 0007, 00070001, 000700010000, 0007000100000000, 1, '2019-05-24 21:41:47', 1),
(973, 0000000973, '200mm x 200mm', '200mm x 200mm', 0007, 00070001, 000700020000, 0007000200000000, 1, '2019-05-24 21:41:47', 1),
(974, 0000000974, '56 x 56 ACOUSTIC TEE', '56 x 56 ACOUSTIC TEE', 0007, 00070002, 000700020000, 0007000200000000, 1, '2019-05-24 21:41:47', 1),
(975, 0000000975, '70 x 70', '70 x 70', 0007, 00070002, 000700020000, 0007000200000000, 1, '2019-05-24 21:41:47', 1),
(976, 0000000976, '100 x 56', '100 x 56', 0007, 00070002, 000700020000, 0007000200000000, 1, '2019-05-24 21:41:47', 1),
(977, 0000000977, '100 x 70', '100 x 70', 0007, 00070002, 000700020000, 0007000200000000, 1, '2019-05-24 21:41:47', 1),
(978, 0000000978, '100  x 100', '100  x 100', 0007, 00070002, 000700030000, 0007000300000000, 1, '2019-05-24 21:41:47', 1),
(979, 0000000979, '56mm ACOUSTIC CLEANOUT', '56mm ACOUSTIC CLEANOUT', 0007, 00070003, 000700030000, 0007000300000000, 1, '2019-05-24 21:41:47', 1),
(980, 0000000980, '70mm', '70mm', 0007, 00070003, 000700030000, 0007000300000000, 1, '2019-05-24 21:41:47', 1),
(981, 0000000981, '100mm', '100mm', 0007, 00070003, 000700040000, 0007000400000000, 1, '2019-05-24 21:41:47', 1),
(982, 0000000982, '56 x 45\' ACOUSTIC ELBOW 45\'', '56 x 45\' ACOUSTIC ELBOW 45\'', 0007, 00070004, 000700040000, 0007000400000000, 1, '2019-05-24 21:41:48', 1),
(983, 0000000983, '70 x 45\'', '70 x 45\'', 0007, 00070004, 000700040000, 0007000400000000, 1, '2019-05-24 21:41:48', 1),
(984, 0000000984, '100 x 45\'', '100 x 45\'', 0007, 00070004, 000700040000, 0007000400000000, 1, '2019-05-24 21:41:48', 1),
(985, 0000000985, '150 x 45\'', '150 x 45\'', 0007, 00070004, 000700050000, 0007000500000000, 1, '2019-05-24 21:41:48', 1),
(986, 0000000986, '56 x 67\' ACOUSTIC ELBOW 67\'', '56 x 67\' ACOUSTIC ELBOW 67\'', 0007, 00070005, 000700050000, 0007000500000000, 1, '2019-05-24 21:41:48', 1),
(987, 0000000987, '70 x 67\'', '70 x 67\'', 0007, 00070005, 000700050000, 0007000500000000, 1, '2019-05-24 21:41:48', 1),
(988, 0000000988, '100 x 67\'', '100 x 67\'', 0007, 00070005, 000700050000, 0007000500000000, 1, '2019-05-24 21:41:48', 1),
(989, 0000000989, '150 x 67\'', '150 x 67\'', 0007, 00070005, 000700060000, 0007000600000000, 1, '2019-05-24 21:41:48', 1),
(990, 0000000990, '56 x 87\' ACOUSTIC ELBOW 87\'', '56 x 87\' ACOUSTIC ELBOW 87\'', 0007, 00070006, 000700060000, 0007000600000000, 1, '2019-05-24 21:41:48', 1),
(991, 0000000991, '70 x 87\'', '70 x 87\'', 0007, 00070006, 000700060000, 0007000600000000, 1, '2019-05-24 21:41:48', 1),
(992, 0000000992, '100 x 87\'', '100 x 87\'', 0007, 00070006, 000700060000, 0007000600000000, 1, '2019-05-24 21:41:48', 1),
(993, 0000000993, '150 x 87\'', '150 x 87\'', 0007, 00070006, 000700070000, 0007000700000000, 1, '2019-05-24 21:41:48', 1),
(994, 0000000994, '100 x 70 x 56 ACOUSTIC FLOOR TRAP', '100 x 70 x 56 ACOUSTIC FLOOR TRAP', 0007, 00070007, 000700080000, 0007000800000000, 1, '2019-05-24 21:41:48', 1),
(995, 0000000995, '56mm ACOUSTIC SOCKET', '56mm ACOUSTIC SOCKET', 0007, 00070008, 000700080000, 0007000800000000, 1, '2019-05-24 21:41:48', 1),
(996, 0000000996, '70mm', '70mm', 0007, 00070008, 000700080000, 0007000800000000, 1, '2019-05-24 21:41:48', 1),
(997, 0000000997, '100mm', '100mm', 0007, 00070008, 000700080000, 0007000800000000, 1, '2019-05-24 21:41:48', 1),
(998, 0000000998, '150mm', '150mm', 0007, 00070008, 000700090000, 0007000900000000, 1, '2019-05-24 21:41:48', 1),
(999, 0000000999, '70 x 56 ACOUSTIC REDUCER', '70 x 56 ACOUSTIC REDUCER', 0007, 00070009, 000700090000, 0007000900000000, 1, '2019-05-24 21:41:48', 1),
(1000, 0000001000, '100 x 56', '100 x 56', 0007, 00070009, 000700090000, 0007000900000000, 1, '2019-05-24 21:41:48', 1),
(1001, 0000001001, '100 x 70', '100 x 70', 0007, 00070009, 000700090000, 0007000900000000, 1, '2019-05-24 21:41:48', 1),
(1002, 0000001002, '150 x 100', '150 x 100', 0007, 00070009, 000700090000, 0007000900000000, 1, '2019-05-24 21:41:48', 1),
(1003, 0000001003, '200 x 150', '200 x 150', 0007, 00070009, 000700100000, 0007001000000000, 1, '2019-05-24 21:41:48', 1),
(1004, 0000001004, '100mm ACOUSTIC ACCESS QUADRATE', '100mm ACOUSTIC ACCESS QUADRATE', 0007, 00070010, 000700100000, 0007001000000000, 1, '2019-05-24 21:41:49', 1),
(1005, 0000001005, '150mm', '150mm', 0007, 00070010, 000700110000, 0007001100000000, 1, '2019-05-24 21:41:49', 1),
(1006, 0000001006, '56mm ACOUSTIC END CAP', '56mm ACOUSTIC END CAP', 0007, 00070011, 000700110000, 0007001100000000, 1, '2019-05-24 21:41:49', 1),
(1007, 0000001007, '70mm', '70mm', 0007, 00070011, 000700120000, 0007001200000000, 1, '2019-05-24 21:41:49', 1),
(1008, 0000001008, '56mm ACOUSTIC PIPE', '56mm ACOUSTIC PIPE', 0007, 00070012, 000700120000, 0007001200000000, 1, '2019-05-24 21:41:49', 1),
(1009, 0000001009, '70mm', '70mm', 0007, 00070012, 000700120000, 0007001200000000, 1, '2019-05-24 21:41:49', 1),
(1010, 0000001010, '100mm', '100mm', 0007, 00070012, 000700120000, 0007001200000000, 1, '2019-05-24 21:41:49', 1),
(1011, 0000001011, '150mm', '150mm', 0007, 00070012, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1012, 0000001012, '225mm x 225mm HDPE TEE BUTT WELD', '225mm x 225mm HDPE TEE BUTT WELD', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1013, 0000001013, '225mm x 160mm', '225mm x 160mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1014, 0000001014, '160mm x 160mm', '160mm x 160mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1015, 0000001015, '160mm x 110mm', '160mm x 110mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1016, 0000001016, '160mm x 90mm', '160mm x 90mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1017, 0000001017, '160mm x 63mm', '160mm x 63mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1018, 0000001018, '110mm x 110mm', '110mm x 110mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1019, 0000001019, '110mm x 90mm', '110mm x 90mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1020, 0000001020, '110mm x 75mm', '110mm x 75mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:49', 1),
(1021, 0000001021, '90mm x 75mm', '90mm x 75mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:50', 1),
(1022, 0000001022, '90mm x 63mm', '90mm x 63mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:50', 1),
(1023, 0000001023, '75mm x 75mm', '75mm x 75mm', 0008, 00080001, 000800010000, 0008000100000000, 1, '2019-05-24 21:41:50', 1),
(1024, 0000001024, '63mm x 50mm', '63mm x 50mm', 0008, 00080001, 000800020000, 0008000200000000, 1, '2019-05-24 21:41:50', 1),
(1025, 0000001025, '110mm x 110mm HDPE TEE ELECTRO FUSTION', '110mm x 110mm HDPE TEE ELECTRO FUSTION', 0008, 00080002, 000800020000, 0008000200000000, 1, '2019-05-24 21:41:50', 1),
(1026, 0000001026, '90mm x 90mm', '90mm x 90mm', 0008, 00080002, 000800020000, 0008000200000000, 1, '2019-05-24 21:41:50', 1),
(1027, 0000001027, '75mm x 75mm', '75mm x 75mm', 0008, 00080002, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1028, 0000001028, '280mm x 90\' HDPE ELBOW BUTT WELD', '280mm x 90\' HDPE ELBOW BUTT WELD', 0008, 00080003, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1029, 0000001029, '225mm x 90\'', '225mm x 90\'', 0008, 00080003, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1030, 0000001030, '160mm x 90\'', '160mm x 90\'', 0008, 00080003, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1031, 0000001031, '110mm x 90\'  (2 TYPE)', '110mm x 90\'  (2 TYPE)', 0008, 00080003, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1032, 0000001032, '90mm x 90\'', '90mm x 90\'', 0008, 00080003, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1033, 0000001033, '75mm x 90\'', '75mm x 90\'', 0008, 00080003, 000800030000, 0008000300000000, 1, '2019-05-24 21:41:50', 1),
(1034, 0000001034, '32mm x 90\'', '32mm x 90\'', 0008, 00080003, 000800040000, 0008000400000000, 1, '2019-05-24 21:41:50', 1),
(1035, 0000001035, '160mm x 90\' HDPE ELBOW ELECTROF FUSTION', '160mm x 90\' HDPE ELBOW ELECTROF FUSTION', 0008, 00080004, 000800040000, 0008000400000000, 1, '2019-05-24 21:41:50', 1),
(1036, 0000001036, '110mm x 90\'', '110mm x 90\'', 0008, 00080004, 000800040000, 0008000400000000, 1, '2019-05-24 21:41:50', 1),
(1037, 0000001037, '90mm x 90\'', '90mm x 90\'', 0008, 00080004, 000800040000, 0008000400000000, 1, '2019-05-24 21:41:50', 1),
(1038, 0000001038, '63mm x 90\'', '63mm x 90\'', 0008, 00080004, 000800050000, 0008000500000000, 1, '2019-05-24 21:41:50', 1),
(1039, 0000001039, '250mm x 45\' HDPE ELBOW BUTT WELD', '250mm x 45\' HDPE ELBOW BUTT WELD', 0008, 00080005, 000800050000, 0008000500000000, 1, '2019-05-24 21:41:50', 1),
(1040, 0000001040, '110mm x 45\'', '110mm x 45\'', 0008, 00080005, 000800050000, 0008000500000000, 1, '2019-05-24 21:41:50', 1),
(1041, 0000001041, '75mm x 45\'', '75mm x 45\'', 0008, 00080005, 000800050000, 0008000500000000, 1, '2019-05-24 21:41:50', 1),
(1042, 0000001042, '63mm x 45\'', '63mm x 45\'', 0008, 00080005, 000800060000, 0008000600000000, 1, '2019-05-24 21:41:50', 1),
(1043, 0000001043, '160mm x 45\' HDPE ELBOW ELECTROF FUSTION', '160mm x 45\' HDPE ELBOW ELECTROF FUSTION', 0008, 00080006, 000800060000, 0008000600000000, 1, '2019-05-24 21:41:51', 1),
(1044, 0000001044, '110mm x 45\'', '110mm x 45\'', 0008, 00080006, 000800060000, 0008000600000000, 1, '2019-05-24 21:41:51', 1),
(1045, 0000001045, '75mm x 45\'', '75mm x 45\'', 0008, 00080006, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1046, 0000001046, '250mm x 200mm HDPE REDUCER BUTT WELD', '250mm x 200mm HDPE REDUCER BUTT WELD', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1047, 0000001047, '160mm x 90mm', '160mm x 90mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1048, 0000001048, '110mm x 90mm', '110mm x 90mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1049, 0000001049, '110mm x 75mm', '110mm x 75mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1050, 0000001050, '110mm x 63mm', '110mm x 63mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1051, 0000001051, '90mm x 75mm', '90mm x 75mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1052, 0000001052, '90mm x 63mm', '90mm x 63mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1053, 0000001053, '90mm x 50mm', '90mm x 50mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1054, 0000001054, '75mm x 63mm', '75mm x 63mm', 0008, 00080007, 000800070000, 0008000700000000, 1, '2019-05-24 21:41:51', 1),
(1055, 0000001055, '63mm x 50mm', '63mm x 50mm', 0008, 00080007, 000800080000, 0008000800000000, 1, '2019-05-24 21:41:51', 1),
(1056, 0000001056, '40mm x 32mm HDPE REDUCER ELECTRO FUSTION', '40mm x 32mm HDPE REDUCER ELECTRO FUSTION', 0008, 00080008, 000800090000, 0008000900000000, 1, '2019-05-24 21:41:51', 1),
(1057, 0000001057, '160mm HDPE SOCKET ELECTRO FUSTION', '160mm HDPE SOCKET ELECTRO FUSTION', 0008, 00080009, 000800090000, 0008000900000000, 1, '2019-05-24 21:41:51', 1),
(1058, 0000001058, '110mm', '110mm', 0008, 00080009, 000800090000, 0008000900000000, 1, '2019-05-24 21:41:51', 1),
(1059, 0000001059, '90mm', '90mm', 0008, 00080009, 000800090000, 0008000900000000, 1, '2019-05-24 21:41:51', 1),
(1060, 0000001060, '75mm', '75mm', 0008, 00080009, 000800090000, 0008000900000000, 1, '2019-05-24 21:41:51', 1),
(1061, 0000001061, '63mm', '63mm', 0008, 00080009, 000800100000, 0008001000000000, 1, '2019-05-24 21:41:52', 1),
(1062, 0000001062, '200mm HDPE FLANGE ADEPTOR', '200mm HDPE FLANGE ADEPTOR', 0008, 00080010, 000800100000, 0008001000000000, 1, '2019-05-24 21:41:52', 1),
(1063, 0000001063, '110mm  ', '110mm  ', 0008, 00080010, 000800100000, 0008001000000000, 1, '2019-05-24 21:41:52', 1),
(1064, 0000001064, '75mm', '75mm', 0008, 00080010, 000800100000, 0008001000000000, 1, '2019-05-24 21:41:52', 1),
(1065, 0000001065, '63mm', '63mm', 0008, 00080010, 000800100000, 0008001000000000, 1, '2019-05-24 21:41:52', 1),
(1066, 0000001066, '50mm', '50mm', 0008, 00080010, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1067, 0000001067, '160mm HDPE FLANGE', '160mm HDPE FLANGE', 0008, 00080011, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1068, 0000001068, '110mm', '110mm', 0008, 00080011, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1069, 0000001069, '90mm', '90mm', 0008, 00080011, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1070, 0000001070, '75mm', '75mm', 0008, 00080011, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1071, 0000001071, '63mm', '63mm', 0008, 00080011, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1072, 0000001072, '50mm', '50mm', 0008, 00080011, 000800110000, 0008001100000000, 1, '2019-05-24 21:41:52', 1),
(1073, 0000001073, '40mm', '40mm', 0008, 00080011, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1074, 0000001074, '280mm  PN/10 HDPE PIPE', '280mm  PN/10 HDPE PIPE', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1075, 0000001075, '225mm  PN/10', '225mm  PN/10', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1076, 0000001076, '160mm  PN/10', '160mm  PN/10', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1077, 0000001077, '110mm  PN/10', '110mm  PN/10', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1078, 0000001078, '90mm  PN/10', '90mm  PN/10', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1079, 0000001079, '160mm  PN/16', '160mm  PN/16', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1080, 0000001080, '63mm  PN/16', '63mm  PN/16', 0008, 00080012, 000800120000, 0008001200000000, 1, '2019-05-24 21:41:52', 1),
(1081, 0000001081, '50mm  PN/16', '50mm  PN/16', 0008, 00080012, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:52', 1),
(1082, 0000001082, '6mm COPPER PIPE', '6mm COPPER PIPE', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:52', 1),
(1083, 0000001083, '20mm', '20mm', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:53', 1),
(1084, 0000001084, '25mm', '25mm', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:53', 1),
(1085, 0000001085, '32mm', '32mm', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:53', 1),
(1086, 0000001086, '40mm', '40mm', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:53', 1),
(1087, 0000001087, '50mm', '50mm', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:53', 1),
(1088, 0000001088, '65mm', '65mm', 0009, 00090001, 000900010000, 0009000100000000, 1, '2019-05-24 21:41:53', 1),
(1089, 0000001089, '100mm', '100mm', 0009, 00090001, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1090, 0000001090, '6mm x 90\' COPPER ELBOW 90\'', '6mm x 90\' COPPER ELBOW 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1091, 0000001091, '10mm x 90\'  (Soft Copper)', '10mm x 90\'  (Soft Copper)', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1092, 0000001092, '10mm x 90\'   ', '10mm x 90\'   ', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1093, 0000001093, '16mm x 90\'', '16mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1094, 0000001094, '18mm x 90\'', '18mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1095, 0000001095, '20mm x 90\'', '20mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1096, 0000001096, '25mm x 90\'', '25mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1097, 0000001097, '28mm x 90\'', '28mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1098, 0000001098, '32mm x 90\'', '32mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1099, 0000001099, '40mm x 90\'', '40mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1100, 0000001100, '50mm x 90\'', '50mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:53', 1),
(1101, 0000001101, '65mm x 90\'', '65mm x 90\'', 0009, 00090002, 000900020000, 0009000200000000, 1, '2019-05-24 21:41:54', 1),
(1102, 0000001102, '100mm x 90\'', '100mm x 90\'', 0009, 00090002, 000900030000, 0009000300000000, 1, '2019-05-24 21:41:54', 1),
(1103, 0000001103, '16mm x 45\' COPPER ELBOW 45\'', '16mm x 45\' COPPER ELBOW 45\'', 0009, 00090003, 000900030000, 0009000300000000, 1, '2019-05-24 21:41:54', 1),
(1104, 0000001104, '20mm x 45\'', '20mm x 45\'', 0009, 00090003, 000900030000, 0009000300000000, 1, '2019-05-24 21:41:54', 1),
(1105, 0000001105, '28mm x 45\'', '28mm x 45\'', 0009, 00090003, 000900030000, 0009000300000000, 1, '2019-05-24 21:41:54', 1),
(1106, 0000001106, '100mm x 45\'', '100mm x 45\'', 0009, 00090003, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1107, 0000001107, '6mm COPPER SOCKET', '6mm COPPER SOCKET', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1108, 0000001108, '10mm', '10mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1109, 0000001109, '16mm', '16mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1110, 0000001110, '18mm', '18mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1111, 0000001111, '20mm', '20mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1112, 0000001112, '22mm', '22mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1113, 0000001113, '25mm', '25mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1114, 0000001114, '28mm', '28mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1115, 0000001115, '32mm', '32mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1116, 0000001116, '40mm', '40mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1117, 0000001117, '50mm', '50mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1118, 0000001118, '65mm', '65mm', 0009, 00090004, 000900040000, 0009000400000000, 1, '2019-05-24 21:41:54', 1),
(1119, 0000001119, '100mm', '100mm', 0009, 00090004, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1120, 0000001120, '16mm x 10mm COPPER REDUCER', '16mm x 10mm COPPER REDUCER', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1121, 0000001121, '18mm x 10mm', '18mm x 10mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1122, 0000001122, '18mm x 16mm', '18mm x 16mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1123, 0000001123, '20mm x 18mm', '20mm x 18mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1124, 0000001124, '22mm x 16mm', '22mm x 16mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1125, 0000001125, '22mm x 18mm', '22mm x 18mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:54', 1),
(1126, 0000001126, '22mm x 20mm', '22mm x 20mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1127, 0000001127, '28mm x 10mm', '28mm x 10mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1128, 0000001128, '28mm x 16mm', '28mm x 16mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1129, 0000001129, '28mm x 18mm', '28mm x 18mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1130, 0000001130, '28mm x 22mm', '28mm x 22mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1131, 0000001131, '32mm x 16mm', '32mm x 16mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1132, 0000001132, '32mm x 25mm', '32mm x 25mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1133, 0000001133, '32mm x 28mm', '32mm x 28mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1134, 0000001134, '40mm x 28mm', '40mm x 28mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1135, 0000001135, '40mm x 32mm', '40mm x 32mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1136, 0000001136, '50mm x 16mm', '50mm x 16mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1137, 0000001137, '50mm x 28mm', '50mm x 28mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1138, 0000001138, '50mm x 40mm', '50mm x 40mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1139, 0000001139, '65mm x 28mm', '65mm x 28mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1140, 0000001140, '65mm x 40mm', '65mm x 40mm', 0009, 00090005, 000900050000, 0009000500000000, 1, '2019-05-24 21:41:55', 1),
(1141, 0000001141, '65mm x 50mm', '65mm x 50mm', 0009, 00090005, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:55', 1),
(1142, 0000001142, '16mm x 10mm COPPER TEE', '16mm x 10mm COPPER TEE', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:55', 1),
(1143, 0000001143, '16mm x 16mm', '16mm x 16mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:55', 1),
(1144, 0000001144, '18mm x 10mm', '18mm x 10mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1145, 0000001145, '18mm x 16mm', '18mm x 16mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1146, 0000001146, '18mm x 18mm', '18mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1147, 0000001147, '20mm x 20mm', '20mm x 20mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1148, 0000001148, '22mm x 10mm', '22mm x 10mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1149, 0000001149, '22mm x 16mm', '22mm x 16mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1150, 0000001150, '22mm x 18mm', '22mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1151, 0000001151, '22mm x 22mm', '22mm x 22mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1152, 0000001152, '28mm x 16mm', '28mm x 16mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1153, 0000001153, '28mm x 18mm', '28mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1154, 0000001154, '28mm x 20mm', '28mm x 20mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1155, 0000001155, '28mm x 28mm', '28mm x 28mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1156, 0000001156, '32mm x 16mm', '32mm x 16mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1157, 0000001157, '32mm x 20mm', '32mm x 20mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1158, 0000001158, '32mm x 22mm', '32mm x 22mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1159, 0000001159, '32mm x 28mm', '32mm x 28mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1160, 0000001160, '34mm x 15mm', '34mm x 15mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:56', 1),
(1161, 0000001161, '34mm x 18mm', '34mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1162, 0000001162, '34mm x 34mm', '34mm x 34mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1163, 0000001163, '40mm x 18mm', '40mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1164, 0000001164, '40mm x 28mm', '40mm x 28mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1165, 0000001165, '40mm x 32mm', '40mm x 32mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1166, 0000001166, '40mm x 40mm', '40mm x 40mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1167, 0000001167, '42mm x 18mm', '42mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1168, 0000001168, '42mm x 34mm', '42mm x 34mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1169, 0000001169, '42mm x 42mm', '42mm x 42mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1170, 0000001170, '50mm x 18mm', '50mm x 18mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1171, 0000001171, '50mm x 28mm', '50mm x 28mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1172, 0000001172, '50mm x 32mm', '50mm x 32mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1173, 0000001173, '50mm x 50mm', '50mm x 50mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1174, 0000001174, '65mm x 28mm', '65mm x 28mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1175, 0000001175, '65mm x 32mm', '65mm x 32mm', 0009, 00090006, 000900060000, 0009000600000000, 1, '2019-05-24 21:41:57', 1),
(1176, 0000001176, '65mm x 65mm', '65mm x 65mm', 0009, 00090006, 000900070000, 0009000700000000, 1, '2019-05-24 21:41:57', 1),
(1177, 0000001177, '16mm COPPER MALE ADEPTOR', '16mm COPPER MALE ADEPTOR', 0009, 00090007, 000900070000, 0009000700000000, 1, '2019-05-24 21:41:57', 1),
(1178, 0000001178, '20mm', '20mm', 0009, 00090007, 000900070000, 0009000700000000, 1, '2019-05-24 21:41:57', 1),
(1179, 0000001179, '28mm', '28mm', 0009, 00090007, 000900070000, 0009000700000000, 1, '2019-05-24 21:41:57', 1),
(1180, 0000001180, '32mm', '32mm', 0009, 00090007, 000900080000, 0009000800000000, 1, '2019-05-24 21:41:58', 1),
(1181, 0000001181, '20mm COPPER FEMALE ADEPTOR', '20mm COPPER FEMALE ADEPTOR', 0009, 00090008, 000900080000, 0009000800000000, 1, '2019-05-24 21:41:58', 1),
(1182, 0000001182, '32mm', '32mm', 0009, 00090008, 001000010000, 0010000100000000, 1, '2019-05-24 21:41:58', 1),
(1183, 0000001183, '20mm GI CONDUITE', '20mm GI CONDUITE', 0010, 00100001, 001000010000, 0010000100000000, 1, '2019-05-24 21:41:58', 1),
(1184, 0000001184, '25mm', '25mm', 0010, 00100001, 001000010000, 0010000100000000, 1, '2019-05-24 21:41:58', 1),
(1185, 0000001185, '32mm', '32mm', 0010, 00100001, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1186, 0000001186, '20mm  4 Way  GI JUNCTION BOX', '20mm  4 Way  GI JUNCTION BOX', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1187, 0000001187, '20mm  3 Way', '20mm  3 Way', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1188, 0000001188, '20mm  2 WAY  Angle', '20mm  2 WAY  Angle', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1189, 0000001189, '20mm  2 WAY  Straight', '20mm  2 WAY  Straight', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1190, 0000001190, '20mm   End', '20mm   End', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1191, 0000001191, '25mm  4 Way', '25mm  4 Way', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1192, 0000001192, '25mm  3 Way', '25mm  3 Way', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1193, 0000001193, '25mm  2 WAY  Angle', '25mm  2 WAY  Angle', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1194, 0000001194, '25mm  2 WAY  Straight', '25mm  2 WAY  Straight', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1195, 0000001195, '25mm  End', '25mm  End', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1196, 0000001196, '32mm  4 Way', '32mm  4 Way', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1197, 0000001197, '32mm  3 Way', '32mm  3 Way', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1198, 0000001198, '32mm  2 WAY  Angle', '32mm  2 WAY  Angle', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1199, 0000001199, '32mm  2 WAY  Straight', '32mm  2 WAY  Straight', 0010, 00100002, 001000020000, 0010000200000000, 1, '2019-05-24 21:41:58', 1),
(1200, 0000001200, '32mm  End', '32mm  End', 0010, 00100002, 001000030000, 0010000300000000, 1, '2019-05-24 21:41:58', 1),
(1201, 0000001201, '20mm GI CONDUITE BEND', '20mm GI CONDUITE BEND', 0010, 00100003, 001000030000, 0010000300000000, 1, '2019-05-24 21:41:58', 1),
(1202, 0000001202, '25mm', '25mm', 0010, 00100003, 001000030000, 0010000300000000, 1, '2019-05-24 21:41:58', 1),
(1203, 0000001203, '32mm', '32mm', 0010, 00100003, 001000040000, 0010000400000000, 1, '2019-05-24 21:41:58', 1),
(1204, 0000001204, '20mm GI COMDUITE INSPECTION BEND', '20mm GI COMDUITE INSPECTION BEND', 0010, 00100004, 001000040000, 0010000400000000, 1, '2019-05-24 21:41:59', 1),
(1205, 0000001205, '25mm', '25mm', 0010, 00100004, 001000040000, 0010000400000000, 1, '2019-05-24 21:41:59', 1),
(1206, 0000001206, '32mm', '32mm', 0010, 00100004, 001000050000, 0010000500000000, 1, '2019-05-24 21:41:59', 1),
(1207, 0000001207, '20mm  GI CONDUITE SADDLE', '20mm  GI CONDUITE SADDLE', 0010, 00100005, 001000050000, 0010000500000000, 1, '2019-05-24 21:41:59', 1),
(1208, 0000001208, '25mm', '25mm', 0010, 00100005, 001000050000, 0010000500000000, 1, '2019-05-24 21:41:59', 1),
(1209, 0000001209, '32mm', '32mm', 0010, 00100005, 001000060000, 0010000600000000, 1, '2019-05-24 21:41:59', 1),
(1210, 0000001210, '20mm GI CONDUITE COUPLING', '20mm GI CONDUITE COUPLING', 0010, 00100006, 001000060000, 0010000600000000, 1, '2019-05-24 21:41:59', 1),
(1211, 0000001211, '25mm', '25mm', 0010, 00100006, 001000060000, 0010000600000000, 1, '2019-05-24 21:41:59', 1),
(1212, 0000001212, '32mm', '32mm', 0010, 00100006, 001100010000, 0011000100000000, 1, '2019-05-24 21:41:59', 1);
INSERT INTO `products` (`products_table_id`, `product_code`, `product_name`, `product_description`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `product_location_id`, `saved_datetime`, `saved_user`) VALUES
(1213, 0000001213, '20mm PVC CONDUITE', '20mm PVC CONDUITE', 0011, 00110001, 001100010000, 0011000100000000, 1, '2019-05-24 21:41:59', 1),
(1214, 0000001214, '25mm', '25mm', 0011, 00110001, 001100010000, 0011000100000000, 1, '2019-05-24 21:41:59', 1),
(1215, 0000001215, '32mm', '32mm', 0011, 00110001, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1216, 0000001216, '20mm  4 Way PVC JUNCTION BOX', '20mm  4 Way PVC JUNCTION BOX', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1217, 0000001217, '20mm  3 Way', '20mm  3 Way', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1218, 0000001218, '20mm  2 WAY  Angle', '20mm  2 WAY  Angle', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1219, 0000001219, '20mm  2 WAY  Straight', '20mm  2 WAY  Straight', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1220, 0000001220, '20mm   End', '20mm   End', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1221, 0000001221, '25mm  4 Way', '25mm  4 Way', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1222, 0000001222, '25mm  4 Way  Black (Kevilton)', '25mm  4 Way  Black (Kevilton)', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1223, 0000001223, '25mm  3 Way', '25mm  3 Way', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1224, 0000001224, '25mm  2 WAY  Angle', '25mm  2 WAY  Angle', 0011, 00110002, 001100020000, 0011000200000000, 1, '2019-05-24 21:41:59', 1),
(1225, 0000001225, '25mm  2 WAY  Straight', '25mm  2 WAY  Straight', 0011, 00110002, 001100030000, 0011000300000000, 1, '2019-05-24 21:41:59', 1),
(1226, 0000001226, '20mm PVC CONDUITE BEND', '20mm PVC CONDUITE BEND', 0011, 00110003, 001100030000, 0011000300000000, 1, '2019-05-24 21:41:59', 1),
(1227, 0000001227, '25mm', '25mm', 0011, 00110003, 001100030000, 0011000300000000, 1, '2019-05-24 21:42:00', 1),
(1228, 0000001228, '32mm', '32mm', 0011, 00110003, 001100040000, 0011000400000000, 1, '2019-05-24 21:42:00', 1),
(1229, 0000001229, '20mm PVC CONCUITE INSPECTION BEND', '20mm PVC CONCUITE INSPECTION BEND', 0011, 00110004, 001100040000, 0011000400000000, 1, '2019-05-24 21:42:00', 1),
(1230, 0000001230, '25mm', '25mm', 0011, 00110004, 001100040000, 0011000400000000, 1, '2019-05-24 21:42:00', 1),
(1231, 0000001231, '32mm', '32mm', 0011, 00110004, 001100050000, 0011000500000000, 1, '2019-05-24 21:42:00', 1),
(1232, 0000001232, '20mm PVC CONDUITE SADDLE', '20mm PVC CONDUITE SADDLE', 0011, 00110005, 001100050000, 0011000500000000, 1, '2019-05-24 21:42:00', 1),
(1233, 0000001233, '25mm', '25mm', 0011, 00110005, 001100050000, 0011000500000000, 1, '2019-05-24 21:42:00', 1),
(1234, 0000001234, '32mm', '32mm', 0011, 00110005, 001100060000, 0011000600000000, 1, '2019-05-24 21:42:00', 1),
(1235, 0000001235, '20mm PVC CONDUITE COUPLING', '20mm PVC CONDUITE COUPLING', 0011, 00110006, 001100060000, 0011000600000000, 1, '2019-05-24 21:42:00', 1),
(1236, 0000001236, '25mm', '25mm', 0011, 00110006, 001100060000, 0011000600000000, 1, '2019-05-24 21:42:00', 1),
(1237, 0000001237, '32mm', '32mm', 0011, 00110006, 001100070000, 0011000700000000, 1, '2019-05-24 21:42:00', 1),
(1238, 0000001238, '20mm PVC BOX CONNECTOR', '20mm PVC BOX CONNECTOR', 0011, 00110007, 001100070000, 0011000700000000, 1, '2019-05-24 21:42:00', 1),
(1239, 0000001239, '25mm', '25mm', 0011, 00110007, 001100070000, 0011000700000000, 1, '2019-05-24 21:42:00', 1),
(1240, 0000001240, '32mm', '32mm', 0011, 00110007, 001100080000, 0011000800000000, 1, '2019-05-24 21:42:00', 1),
(1241, 0000001241, '20mm PVC FLEXIBLE CONNECTOR', '20mm PVC FLEXIBLE CONNECTOR', 0011, 00110008, 001100080000, 0011000800000000, 1, '2019-05-24 21:42:00', 1),
(1242, 0000001242, '25mm', '25mm', 0011, 00110008, 001100080000, 0011000800000000, 1, '2019-05-24 21:42:00', 1),
(1243, 0000001243, '32mm', '32mm', 0011, 00110008, 001100090000, 0011000900000000, 1, '2019-05-24 21:42:00', 1),
(1244, 0000001244, '1 GANG SWITCH BOX', '1 GANG SWITCH BOX', 0011, 00110009, 001100090000, 0011000900000000, 1, '2019-05-24 21:42:00', 1),
(1245, 0000001245, '2 GANG', '2 GANG', 0011, 00110009, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1246, 0000001246, '2½\"   (73mm) GROOVED COUPLING', '2½\"   (73mm) GROOVED COUPLING', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1247, 0000001247, '3\"      (89mm)', '3\"      (89mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1248, 0000001248, '4\"      (114mm)', '4\"      (114mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1249, 0000001249, '5\"      (139mm)', '5\"      (139mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1250, 0000001250, '6\"      (168mm)', '6\"      (168mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1251, 0000001251, '8\"      (219mm)', '8\"      (219mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1252, 0000001252, '10\"    (273mm)', '10\"    (273mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:00', 1),
(1253, 0000001253, '12\"    (323mm)', '12\"    (323mm)', 0012, 00120001, 001200010000, 0012000100000000, 1, '2019-05-24 21:42:01', 1),
(1254, 0000001254, '168 x 50  GROOVED SADDLE', '168 x 50  GROOVED SADDLE', 0012, 00120001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1255, 0000001255, '15mm  S.S PIPE', '15mm  S.S PIPE', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1256, 0000001256, '20mm', '20mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1257, 0000001257, '25mm', '25mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1258, 0000001258, '32mm', '32mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1259, 0000001259, '40mm', '40mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1260, 0000001260, '50mm', '50mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1261, 0000001261, '65mm', '65mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1262, 0000001262, '75mm', '75mm', 0013, 00130001, 001300010000, 0013000100000000, 1, '2019-05-24 21:42:01', 1),
(1263, 0000001263, '100mm', '100mm', 0013, 00130001, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1264, 0000001264, '15mm  S.S SOCKET', '15mm  S.S SOCKET', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1265, 0000001265, '20mm', '20mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1266, 0000001266, '25mm', '25mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1267, 0000001267, '32mm', '32mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1268, 0000001268, '40mm', '40mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1269, 0000001269, '50mm', '50mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1270, 0000001270, '65mm', '65mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1271, 0000001271, '75mm', '75mm', 0013, 00130002, 001300020000, 0013000200000000, 1, '2019-05-24 21:42:01', 1),
(1272, 0000001272, '100mm', '100mm', 0013, 00130002, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:01', 1),
(1273, 0000001273, '15mm  S.S ELBOW', '15mm  S.S ELBOW', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:01', 1),
(1274, 0000001274, '20mm', '20mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:01', 1),
(1275, 0000001275, '25mm', '25mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:01', 1),
(1276, 0000001276, '32mm', '32mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:02', 1),
(1277, 0000001277, '40mm', '40mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:02', 1),
(1278, 0000001278, '50mm', '50mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:02', 1),
(1279, 0000001279, '65mm', '65mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:02', 1),
(1280, 0000001280, '75mm', '75mm', 0013, 00130003, 001300030000, 0013000300000000, 1, '2019-05-24 21:42:02', 1),
(1281, 0000001281, '100mm', '100mm', 0013, 00130003, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1282, 0000001282, '20mm x 20mm  S.S TEE', '20mm x 20mm  S.S TEE', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1283, 0000001283, '25mm x 20mm', '25mm x 20mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1284, 0000001284, '25mm x 25mm', '25mm x 25mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1285, 0000001285, '32mm x 20mm', '32mm x 20mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1286, 0000001286, '32mm x 25mm', '32mm x 25mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1287, 0000001287, '32mmx 32mm', '32mmx 32mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1288, 0000001288, '40mm x 20mm', '40mm x 20mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1289, 0000001289, '40mm x 25mm', '40mm x 25mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1290, 0000001290, '40mm x 32mm', '40mm x 32mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1291, 0000001291, '40mm x 40mm', '40mm x 40mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1292, 0000001292, '50mm x 20mm', '50mm x 20mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1293, 0000001293, '50mm x 25mm', '50mm x 25mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1294, 0000001294, '50mm x 32mm', '50mm x 32mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1295, 0000001295, '50mm x 40mm', '50mm x 40mm', 0013, 00130004, 001300040000, 0013000400000000, 1, '2019-05-24 21:42:02', 1),
(1296, 0000001296, '50mm x 50mm', '50mm x 50mm', 0013, 00130004, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:02', 1),
(1297, 0000001297, '25mm x 15mm  S.S REDUCER', '25mm x 15mm  S.S REDUCER', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1298, 0000001298, '25mm x 20mm', '25mm x 20mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1299, 0000001299, '32mm x 20mm', '32mm x 20mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1300, 0000001300, '32mm x 25mm', '32mm x 25mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1301, 0000001301, '40mm x 20mm', '40mm x 20mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1302, 0000001302, '40mm x 25mm', '40mm x 25mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1303, 0000001303, '40mm x 32mm', '40mm x 32mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1304, 0000001304, '50mm x 15mm', '50mm x 15mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1305, 0000001305, '50mm x 20mm', '50mm x 20mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1306, 0000001306, '50mm x 25mm', '50mm x 25mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1307, 0000001307, '50mm x 40mm', '50mm x 40mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1308, 0000001308, '65mm x 15mm', '65mm x 15mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1309, 0000001309, '65mm x 20mm', '65mm x 20mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1310, 0000001310, '65mm x 32mm', '65mm x 32mm', 0013, 00130005, 001300050000, 0013000500000000, 1, '2019-05-24 21:42:03', 1),
(1311, 0000001311, '65mm x 40mm', '65mm x 40mm', 0013, 00130005, 001400010000, 0014000100000000, 1, '2019-05-24 21:42:03', 1),
(1312, 0000001312, '80mm GATE VALVE FLANGE TYPE', '80mm GATE VALVE FLANGE TYPE', 0014, 00140001, 001400010000, 0014000100000000, 1, '2019-05-24 21:42:03', 1),
(1313, 0000001313, '90mm', '90mm', 0014, 00140001, 001400010000, 0014000100000000, 1, '2019-05-24 21:42:03', 1),
(1314, 0000001314, '100mm', '100mm', 0014, 00140001, 001400010000, 0014000100000000, 1, '2019-05-24 21:42:03', 1),
(1315, 0000001315, '125mm', '125mm', 0014, 00140001, 001400010000, 0014000100000000, 1, '2019-05-24 21:42:03', 1),
(1316, 0000001316, '150mm', '150mm', 0014, 00140001, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:03', 1),
(1317, 0000001317, '3/8\"  GATE VALVE THRED TYPE', '3/8\"  GATE VALVE THRED TYPE', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1318, 0000001318, '15mm', '15mm', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1319, 0000001319, '20mm', '20mm', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1320, 0000001320, '25mm', '25mm', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1321, 0000001321, '32mm', '32mm', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1322, 0000001322, '40mm', '40mm', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1323, 0000001323, '50mm', '50mm', 0014, 00140002, 001400020000, 0014000200000000, 1, '2019-05-24 21:42:04', 1),
(1324, 0000001324, '100mm', '100mm', 0014, 00140002, 001400030000, 0014000300000000, 1, '2019-05-24 21:42:04', 1),
(1325, 0000001325, '20mm GLOBE VALVE T/T', '20mm GLOBE VALVE T/T', 0014, 00140003, 001400030000, 0014000300000000, 1, '2019-05-24 21:42:04', 1),
(1326, 0000001326, '25mm', '25mm', 0014, 00140003, 001400030000, 0014000300000000, 1, '2019-05-24 21:42:04', 1),
(1327, 0000001327, '32mm', '32mm', 0014, 00140003, 001400030000, 0014000300000000, 1, '2019-05-24 21:42:04', 1),
(1328, 0000001328, '40mm', '40mm', 0014, 00140003, 001400040000, 0014000400000000, 1, '2019-05-24 21:42:04', 1),
(1329, 0000001329, '15mm Y-STRAINER T/T', '15mm Y-STRAINER T/T', 0014, 00140004, 001400040000, 0014000400000000, 1, '2019-05-24 21:42:04', 1),
(1330, 0000001330, '25mm', '25mm', 0014, 00140004, 001400040000, 0014000400000000, 1, '2019-05-24 21:42:04', 1),
(1331, 0000001331, '40mm', '40mm', 0014, 00140004, 001400040000, 0014000400000000, 1, '2019-05-24 21:42:04', 1),
(1332, 0000001332, '50mm', '50mm', 0014, 00140004, 001400040000, 0014000400000000, 1, '2019-05-24 21:42:04', 1),
(1333, 0000001333, '50mm  S/S', '50mm  S/S', 0014, 00140004, 001400050000, 0014000500000000, 1, '2019-05-24 21:42:04', 1),
(1334, 0000001334, '60mm  Y-STRINER F/T', '60mm  Y-STRINER F/T', 0014, 00140005, 001400050000, 0014000500000000, 1, '2019-05-24 21:42:05', 1),
(1335, 0000001335, '100mm', '100mm', 0014, 00140005, 001400050000, 0014000500000000, 1, '2019-05-24 21:42:05', 1),
(1336, 0000001336, '125mm', '125mm', 0014, 00140005, 001400050000, 0014000500000000, 1, '2019-05-24 21:42:05', 1),
(1337, 0000001337, '150mm', '150mm', 0014, 00140005, 001400050000, 0014000500000000, 1, '2019-05-24 21:42:05', 1),
(1338, 0000001338, '200mm', '200mm', 0014, 00140005, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1339, 0000001339, '3/8\"  COCK VLAVE ', '3/8\"  COCK VLAVE ', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1340, 0000001340, '3/8\"  3way', '3/8\"  3way', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1341, 0000001341, '15mm', '15mm', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1342, 0000001342, '20mm', '20mm', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1343, 0000001343, '20mm  3way', '20mm  3way', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1344, 0000001344, '25mm  3way', '25mm  3way', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1345, 0000001345, '32mm', '32mm', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1346, 0000001346, '40mm  3way', '40mm  3way', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1347, 0000001347, '50mm  3way', '50mm  3way', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1348, 0000001348, '50mm   ', '50mm   ', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1349, 0000001349, '65mm', '65mm', 0014, 00140006, 001400060000, 0014000600000000, 1, '2019-05-24 21:42:05', 1),
(1350, 0000001350, '100mm', '100mm', 0014, 00140006, 001400070000, 0014000700000000, 1, '2019-05-24 21:42:05', 1),
(1351, 0000001351, '40mm BUTTERFLY VALVE', '40mm BUTTERFLY VALVE', 0014, 00140007, 001400070000, 0014000700000000, 1, '2019-05-24 21:42:05', 1),
(1352, 0000001352, '50mm', '50mm', 0014, 00140007, 001400070000, 0014000700000000, 1, '2019-05-24 21:42:05', 1),
(1353, 0000001353, '65mm', '65mm', 0014, 00140007, 001400070000, 0014000700000000, 1, '2019-05-24 21:42:05', 1),
(1354, 0000001354, '100mm', '100mm', 0014, 00140007, 001400070000, 0014000700000000, 1, '2019-05-24 21:42:05', 1),
(1355, 0000001355, '125mm', '125mm', 0014, 00140007, 001400070000, 0014000700000000, 1, '2019-05-24 21:42:05', 1),
(1356, 0000001356, '300mm', '300mm', 0014, 00140007, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:05', 1),
(1357, 0000001357, '40mm FLEXIBLE JOINT', '40mm FLEXIBLE JOINT', 0014, 00140008, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:05', 1),
(1358, 0000001358, '50mm', '50mm', 0014, 00140008, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:06', 1),
(1359, 0000001359, '65mm', '65mm', 0014, 00140008, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:06', 1),
(1360, 0000001360, '80mm', '80mm', 0014, 00140008, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:06', 1),
(1361, 0000001361, '100mm', '100mm', 0014, 00140008, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:06', 1),
(1362, 0000001362, '125mm', '125mm', 0014, 00140008, 001400080000, 0014000800000000, 1, '2019-05-24 21:42:06', 1),
(1363, 0000001363, '150mm', '150mm', 0014, 00140008, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1364, 0000001364, '3/8\"   CHECK VALVE T/T', '3/8\"   CHECK VALVE T/T', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1365, 0000001365, '15mm', '15mm', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1366, 0000001366, '20mm', '20mm', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1367, 0000001367, '25mm', '25mm', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1368, 0000001368, '32mm', '32mm', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1369, 0000001369, '40mm   (Non Return)', '40mm   (Non Return)', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1370, 0000001370, '40mm    ', '40mm    ', 0014, 00140009, 001400090000, 0014000900000000, 1, '2019-05-24 21:42:06', 1),
(1371, 0000001371, '50mm', '50mm', 0014, 00140009, 001400100000, 0014001000000000, 1, '2019-05-24 21:42:06', 1),
(1372, 0000001372, '40mm  CHECK VALVE T/T', '40mm  CHECK VALVE T/T', 0014, 00140010, 001400100000, 0014001000000000, 1, '2019-05-24 21:42:07', 1),
(1373, 0000001373, '50mm', '50mm', 0014, 00140010, 001400100000, 0014001000000000, 1, '2019-05-24 21:42:07', 1),
(1374, 0000001374, '65mm', '65mm', 0014, 00140010, 001400100000, 0014001000000000, 1, '2019-05-24 21:42:07', 1),
(1375, 0000001375, '100mm', '100mm', 0014, 00140010, 001500010000, 0015000100000000, 1, '2019-05-24 21:42:07', 1),
(1376, 0000001376, '800mm x 100mm CABLE TRAY', '800mm x 100mm CABLE TRAY', 0015, 00150001, 001500010000, 0015000100000000, 1, '2019-05-24 21:42:07', 1),
(1377, 0000001377, '600mm x 100mm', '600mm x 100mm', 0015, 00150001, 001500010000, 0015000100000000, 1, '2019-05-24 21:42:07', 1),
(1378, 0000001378, '500mm x 75mm', '500mm x 75mm', 0015, 00150001, 001500010000, 0015000100000000, 1, '2019-05-24 21:42:07', 1),
(1379, 0000001379, '400mm x 100mm', '400mm x 100mm', 0015, 00150001, 001500020000, 0015000200000000, 1, '2019-05-24 21:42:07', 1),
(1380, 0000001380, '800mm x 100 CABLE LADDER', '800mm x 100 CABLE LADDER', 0015, 00150002, 001500020000, 0015000200000000, 1, '2019-05-24 21:42:07', 1),
(1381, 0000001381, '1000mm x 100', '1000mm x 100', 0015, 00150002, 001500020000, 0015000200000000, 1, '2019-05-24 21:42:07', 1),
(1382, 0000001382, '1200mm x 100', '1200mm x 100', 0015, 00150002, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1383, 0000001383, '1000mm x 1000mm TEE', '1000mm x 1000mm TEE', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1384, 0000001384, '1000mm x 400mm', '1000mm x 400mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1385, 0000001385, '1000mm x 800mm', '1000mm x 800mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1386, 0000001386, '800mm x 800mm', '800mm x 800mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1387, 0000001387, '800mm x 400mm', '800mm x 400mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1388, 0000001388, '800mm x 200mm', '800mm x 200mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1389, 0000001389, '800mm x 100mm', '800mm x 100mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1390, 0000001390, '600mm x 600mm', '600mm x 600mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1391, 0000001391, '400mm x 200mm', '400mm x 200mm', 0015, 00150003, 001500030000, 0015000300000000, 1, '2019-05-24 21:42:07', 1),
(1392, 0000001392, '400mm x 100mm', '400mm x 100mm', 0015, 00150003, 001500040000, 0015000400000000, 1, '2019-05-24 21:42:07', 1),
(1393, 0000001393, '1000mm  BEND', '1000mm  BEND', 0015, 00150004, 001500040000, 0015000400000000, 1, '2019-05-24 21:42:07', 1),
(1394, 0000001394, '800mm', '800mm', 0015, 00150004, 001500040000, 0015000400000000, 1, '2019-05-24 21:42:07', 1),
(1395, 0000001395, '600mm', '600mm', 0015, 00150004, 001500040000, 0015000400000000, 1, '2019-05-24 21:42:07', 1),
(1396, 0000001396, '400mm', '400mm', 0015, 00150004, 001500050000, 0015000500000000, 1, '2019-05-24 21:42:08', 1),
(1397, 0000001397, '1000mm RISER', '1000mm RISER', 0015, 00150005, 001500050000, 0015000500000000, 1, '2019-05-24 21:42:08', 1),
(1398, 0000001398, '800mm', '800mm', 0015, 00150005, 001600010000, 0016000100000000, 1, '2019-05-24 21:42:08', 1),
(1399, 0000001399, 'WATER CLOSET', 'WATER CLOSET', 0016, 00160001, 001600010001, 0016000100010000, 1, '2019-05-24 21:42:08', 1),
(1400, 0000001400, 'WATER CLOSET', 'WATER CLOSET', 0016, 00160001, 001600010002, 0016000100020000, 1, '2019-05-24 21:42:08', 1),
(1401, 0000001401, 'WASH BASIN', 'WASH BASIN', 0016, 00160002, 001600020001, 0016000200010000, 1, '2019-05-24 21:42:08', 1),
(1402, 0000001402, 'WASH BASIN', 'WASH BASIN', 0016, 00160002, 001600020002, 0016000200020000, 1, '2019-05-24 21:42:08', 1),
(1403, 0000001403, 'URINAL', 'URINAL', 0016, 00160003, 001600030001, 0016000300010000, 1, '2019-05-24 21:42:08', 1),
(1404, 0000001404, 'URINAL', 'URINAL', 0016, 00160003, 001600030002, 0016000300020000, 1, '2019-05-24 21:42:08', 1),
(1405, 0000001405, 'MIRROR', 'MIRROR', 0016, 00160004, 001600040001, 0016000400010000, 1, '2019-05-24 21:42:08', 1),
(1406, 0000001406, 'MIRROR', 'MIRROR', 0016, 00160004, 001600040002, 0016000400020000, 1, '2019-05-24 21:42:08', 1),
(1407, 0000001407, 'SOAP HOLDER', 'SOAP HOLDER', 0016, 00160005, 001600050001, 0016000500010000, 1, '2019-05-24 21:42:08', 1),
(1408, 0000001408, 'SOAP HOLDER', 'SOAP HOLDER', 0016, 00160005, 001600050002, 0016000500020000, 1, '2019-05-24 21:42:08', 1),
(1409, 0000001409, 'PAPER HOLDER', 'PAPER HOLDER', 0016, 00160006, 001600060001, 0016000600010000, 1, '2019-05-24 21:42:08', 1),
(1410, 0000001410, 'PAPER HOLDER', 'PAPER HOLDER', 0016, 00160006, 001600060002, 0016000600020000, 1, '2019-05-24 21:42:08', 1),
(1411, 0000001411, 'BIDDET SHOWER', 'BIDDET SHOWER', 0016, 00160007, 001600070001, 0016000700010000, 1, '2019-05-24 21:42:08', 1),
(1412, 0000001412, 'BIDDET SHOWER', 'BIDDET SHOWER', 0016, 00160007, 001600070002, 0016000700020000, 1, '2019-05-24 21:42:08', 1),
(1413, 0000001413, 'TOWEL BAR', 'TOWEL BAR', 0016, 00160008, 001600080001, 0016000800010000, 1, '2019-05-24 21:42:08', 1),
(1414, 0000001414, 'TOWEL BAR', 'TOWEL BAR', 0016, 00160008, 001600080002, 0016000800020000, 1, '2019-05-24 21:42:08', 1),
(1415, 0000001415, 'BOTTLE TRAP', 'BOTTLE TRAP', 0016, 00160009, 001600090001, 0016000900010000, 1, '2019-05-24 21:42:08', 1),
(1416, 0000001416, 'BOTTLE TRAP', 'BOTTLE TRAP', 0016, 00160009, 001600090002, 0016000900020000, 1, '2019-05-24 21:42:08', 1),
(1417, 0000001417, 'P TRAP', 'P TRAP', 0016, 00160010, 001600100001, 0016001000010000, 1, '2019-05-24 21:42:08', 1),
(1418, 0000001418, 'P TRAP', 'P TRAP', 0016, 00160010, 001600100002, 0016001000020000, 1, '2019-05-24 21:42:09', 1),
(1419, 0000001419, 'ROBE HOOK', 'ROBE HOOK', 0016, 00160011, 001600110001, 0016001100010000, 1, '2019-05-24 21:42:09', 1),
(1420, 0000001420, 'ROBE HOOK', 'ROBE HOOK', 0016, 00160011, 001600110002, 0016001100020000, 1, '2019-05-24 21:42:09', 1),
(1421, 0000001421, 'SOAP DISPENSER', 'SOAP DISPENSER', 0016, 00160012, 001600120001, 0016001200010000, 1, '2019-05-24 21:42:09', 1),
(1422, 0000001422, 'SOAP DISPENSER', 'SOAP DISPENSER', 0016, 00160012, 001600120002, 0016001200020000, 1, '2019-05-24 21:42:09', 1),
(1423, 0000001423, 'ANGLE VALVE', 'ANGLE VALVE', 0016, 00160013, 001600130001, 0016001300010000, 1, '2019-05-24 21:42:09', 1),
(1424, 0000001424, 'ANGLE VALVE', 'ANGLE VALVE', 0016, 00160013, 001600130002, 0016001300020000, 1, '2019-05-24 21:42:09', 1),
(1425, 0000001425, 'FLEXIBLE HOSE', 'FLEXIBLE HOSE', 0016, 00160014, 001600140001, 0016001400010000, 1, '2019-05-24 21:42:09', 1),
(1426, 0000001426, 'FLEXIBLE HOSE', 'FLEXIBLE HOSE', 0016, 00160014, 001600140002, 0016001400020000, 1, '2019-05-24 21:42:09', 1),
(1427, 0000001427, 'FLEXIBLE HOSE', 'FLEXIBLE HOSE', 0016, 00160014, 001600140003, 0016001400030000, 1, '2019-05-24 21:42:09', 1),
(1428, 0000001428, '1/4\"  x 3/8\" INSULATION TUBE', '1/4\"  x 3/8\" INSULATION TUBE', 0017, 00170001, 001700010000, 0017000100000000, 1, '2019-05-24 21:42:09', 1),
(1429, 0000001429, '1/2\" x 3/8\"', '1/2\" x 3/8\"', 0017, 00170001, 001700010000, 0017000100000000, 1, '2019-05-24 21:42:09', 1),
(1430, 0000001430, '1\" x 1/2\"', '1\" x 1/2\"', 0017, 00170001, 001700010000, 0017000100000000, 1, '2019-05-24 21:42:09', 1),
(1431, 0000001431, '1\" x 3/4\" ', '1\" x 3/4\" ', 0017, 00170001, 001700010000, 0017000100000000, 1, '2019-05-24 21:42:09', 1),
(1432, 0000001432, '1\" x 1\"', '1\" x 1\"', 0017, 00170001, 001700010000, 0017000100000000, 1, '2019-05-24 21:42:09', 1),
(1433, 0000001433, '5/8\" x 3/4\'', '5/8\" x 3/4\'', 0017, 00170001, 001700010000, 0017000100000000, 1, '2019-05-24 21:42:09', 1),
(1434, 0000001434, '6mm INSULATION SHEET', '6mm INSULATION SHEET', 0017, 00170002, 001700020000, 0017000200000000, 1, '2019-05-24 21:42:09', 1),
(1435, 0000001435, '10mm', '10mm', 0017, 00170002, 001700020000, 0017000200000000, 1, '2019-05-24 21:42:09', 1),
(1436, 0000001436, '12mm', '12mm', 0017, 00170002, 001700020000, 0017000200000000, 1, '2019-05-24 21:42:09', 1),
(1437, 0000001437, '20mm', '20mm', 0017, 00170002, 001700020000, 0017000200000000, 1, '2019-05-24 21:42:09', 1),
(1438, 0000001438, '25mm', '25mm', 0017, 00170002, 001700020000, 0017000200000000, 1, '2019-05-24 21:42:09', 1),
(1439, 0000001439, '8\' x 4\' x 12mm AMOSOUND SHEET', '8\' x 4\' x 12mm AMOSOUND SHEET', 0017, 00170003, 001700030000, 0017000300000000, 1, '2019-05-24 21:42:09', 1),
(1440, 0000001440, '8\' x 4\' x 25mmT GLASSWOOL BOARD', '8\' x 4\' x 25mmT GLASSWOOL BOARD', 0017, 00170004, 001700040001, 0017000400010000, 1, '2019-05-24 21:42:09', 1),
(1441, 0000001441, '8\' x 4\' x 50mmT ', '8\' x 4\' x 50mmT ', 0017, 00170004, 001700040001, 0017000400010000, 1, '2019-05-24 21:42:09', 1),
(1442, 0000001442, '8\' x 4\' x 25mmT ', '8\' x 4\' x 25mmT ', 0017, 00170004, 001700040002, 0017000400020000, 1, '2019-05-24 21:42:10', 1),
(1443, 0000001443, '8\' x 4\' x 50mmT ', '8\' x 4\' x 50mmT ', 0017, 00170004, 001700040002, 0017000400020000, 1, '2019-05-24 21:42:10', 1),
(1444, 0000001444, '25mmT GLASSWOOL ROLL', '25mmT GLASSWOOL ROLL', 0017, 00170005, 001700050001, 0017000500010000, 1, '2019-05-24 21:42:10', 1),
(1445, 0000001445, '50mmT', '50mmT', 0017, 00170005, 001700050001, 0017000500010000, 1, '2019-05-24 21:42:10', 1),
(1446, 0000001446, '25mmT GLASSWOOL ROLL', '25mmT GLASSWOOL ROLL', 0017, 00170005, 001700050002, 0017000500020000, 1, '2019-05-24 21:42:10', 1),
(1447, 0000001447, '50mmT', '50mmT', 0017, 00170005, 001700050002, 0017000500020000, 1, '2019-05-24 21:42:10', 1),
(1448, 0000001448, '50mmT ROCKWOOL', '50mmT ROCKWOOL', 0017, 00170006, 001700060000, 0017000600000000, 1, '2019-05-24 21:42:10', 1),
(1449, 0000001449, '25mm x 38mmL', '25mm x 38mmL', 0017, 00170007, 001700070000, 0017000700000000, 1, '2019-05-24 21:42:10', 1),
(1450, 0000001450, '25mm x 65mmL', '25mm x 65mmL', 0017, 00170007, 001700070000, 0017000700000000, 1, '2019-05-24 21:42:10', 1),
(1451, 0000001451, '50mm x 65mmL', '50mm x 65mmL', 0017, 00170007, 001700070000, 0017000700000000, 1, '2019-05-24 21:42:10', 1),
(1452, 0000001452, '6mm GI NUT', '6mm GI NUT', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1453, 0000001453, '8mm', '8mm', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1454, 0000001454, '3/8\"', '3/8\"', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1455, 0000001455, '10mm', '10mm', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1456, 0000001456, '12mm', '12mm', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1457, 0000001457, '16mm', '16mm', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1458, 0000001458, '20mm', '20mm', 0018, 00180001, 001800010000, 0018000100000000, 1, '2019-05-24 21:42:10', 1),
(1459, 0000001459, '5/16 x 20mmL GI BOLT', '5/16 x 20mmL GI BOLT', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:10', 1),
(1460, 0000001460, '5/16 x 25mmL', '5/16 x 25mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:10', 1),
(1461, 0000001461, '3/8\" x 25mmL', '3/8\" x 25mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:10', 1),
(1462, 0000001462, '10 x 25mmL', '10 x 25mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:10', 1),
(1463, 0000001463, '12 x 25mmL', '12 x 25mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1464, 0000001464, '12  x 50mmL', '12  x 50mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1465, 0000001465, '16 x 65mmL', '16 x 65mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1466, 0000001466, '16 x 75mmL', '16 x 75mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1467, 0000001467, '16 x 90mmL', '16 x 90mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1468, 0000001468, '16 x 110mmL', '16 x 110mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1469, 0000001469, '20 x 50mmL', '20 x 50mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1470, 0000001470, '20 X 65mmL', '20 X 65mmL', 0018, 00180002, 001800020000, 0018000200000000, 1, '2019-05-24 21:42:11', 1),
(1471, 0000001471, '6mm GI WASHER', '6mm GI WASHER', 0018, 00180003, 001800030000, 0018000300000000, 1, '2019-05-24 21:42:11', 1),
(1472, 0000001472, '8mm', '8mm', 0018, 00180003, 001800030000, 0018000300000000, 1, '2019-05-24 21:42:11', 1),
(1473, 0000001473, '10mm', '10mm', 0018, 00180003, 001800030000, 0018000300000000, 1, '2019-05-24 21:42:11', 1),
(1474, 0000001474, '12mm', '12mm', 0018, 00180003, 001800030000, 0018000300000000, 1, '2019-05-24 21:42:11', 1),
(1475, 0000001475, '16mm', '16mm', 0018, 00180003, 001800030000, 0018000300000000, 1, '2019-05-24 21:42:11', 1),
(1476, 0000001476, '20mm', '20mm', 0018, 00180003, 001800030000, 0018000300000000, 1, '2019-05-24 21:42:11', 1),
(1477, 0000001477, '5/16 x 20mmL GI BOLT & NUT', '5/16 x 20mmL GI BOLT & NUT', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1478, 0000001478, '5/16 x 25mmL', '5/16 x 25mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1479, 0000001479, '3/8\" x 25mmL', '3/8\" x 25mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1480, 0000001480, '10 x 25mmL', '10 x 25mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1481, 0000001481, '12 x 25mmL', '12 x 25mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1482, 0000001482, '12  x 50mmL', '12  x 50mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1483, 0000001483, '16 x 65mmL', '16 x 65mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1484, 0000001484, '16 x 75mmL', '16 x 75mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:11', 1),
(1485, 0000001485, '16 x 90mmL', '16 x 90mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:12', 1),
(1486, 0000001486, '16 x 110mmL', '16 x 110mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:12', 1),
(1487, 0000001487, '20 x 50mmL', '20 x 50mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:12', 1),
(1488, 0000001488, '20 X 65mmL', '20 X 65mmL', 0018, 00180004, 001800040000, 0018000400000000, 1, '2019-05-24 21:42:12', 1),
(1489, 0000001489, '3/8\" ANCHOR BOLT', '3/8\" ANCHOR BOLT', 0019, 00190001, 001900010000, 0019000100000000, 1, '2019-05-24 21:42:12', 1),
(1490, 0000001490, '10mm', '10mm', 0019, 00190001, 001900010000, 0019000100000000, 1, '2019-05-24 21:42:12', 1),
(1491, 0000001491, '1/2\"', '1/2\"', 0019, 00190001, 001900010000, 0019000100000000, 1, '2019-05-24 21:42:12', 1),
(1492, 0000001492, '12mm', '12mm', 0019, 00190001, 001900010000, 0019000100000000, 1, '2019-05-24 21:42:12', 1),
(1493, 0000001493, '16mm', '16mm', 0019, 00190001, 001900010000, 0019000100000000, 1, '2019-05-24 21:42:12', 1),
(1494, 0000001494, '10mm AY BOLT', '10mm AY BOLT', 0019, 00190002, 001900020000, 0019000200000000, 1, '2019-05-24 21:42:12', 1),
(1495, 0000001495, '12mm', '12mm', 0019, 00190002, 001900020000, 0019000200000000, 1, '2019-05-24 21:42:12', 1),
(1496, 0000001496, '16mm', '16mm', 0019, 00190002, 001900020000, 0019000200000000, 1, '2019-05-24 21:42:12', 1),
(1497, 0000001497, '3/8\" THREAD BAR', '3/8\" THREAD BAR', 0019, 00190003, 001900030000, 0019000300000000, 1, '2019-05-24 21:42:12', 1),
(1498, 0000001498, '10mm', '10mm', 0019, 00190003, 001900030000, 0019000300000000, 1, '2019-05-24 21:42:12', 1),
(1499, 0000001499, '1/2\"', '1/2\"', 0019, 00190003, 001900030000, 0019000300000000, 1, '2019-05-24 21:42:12', 1),
(1500, 0000001500, '12mm', '12mm', 0019, 00190003, 001900030000, 0019000300000000, 1, '2019-05-24 21:42:12', 1),
(1501, 0000001501, '16mm', '16mm', 0019, 00190003, 001900030000, 0019000300000000, 1, '2019-05-24 21:42:12', 1),
(1502, 0000001502, '20mm', '20mm', 0019, 00190003, 001900030000, 0019000300000000, 1, '2019-05-24 21:42:12', 1),
(1503, 0000001503, '3/8\" INSERT', '3/8\" INSERT', 0019, 00190004, 001900040000, 0019000400000000, 1, '2019-05-24 21:42:12', 1),
(1504, 0000001504, '1/2\"', '1/2\"', 0019, 00190004, 001900040000, 0019000400000000, 1, '2019-05-24 21:42:12', 1),
(1505, 0000001505, '100mm x 1mm  CUTTING WHEEL', '100mm x 1mm  CUTTING WHEEL', 0019, 00190005, 001900050000, 0019000500000000, 1, '2019-05-24 21:42:12', 1),
(1506, 0000001506, '100mm x 2.5mm', '100mm x 2.5mm', 0019, 00190005, 001900050000, 0019000500000000, 1, '2019-05-24 21:42:12', 1),
(1507, 0000001507, '180mm', '180mm', 0019, 00190005, 001900050000, 0019000500000000, 1, '2019-05-24 21:42:12', 1),
(1508, 0000001508, '355mm', '355mm', 0019, 00190005, 001900050000, 0019000500000000, 1, '2019-05-24 21:42:13', 1),
(1509, 0000001509, '405mm', '405mm', 0019, 00190005, 001900050000, 0019000500000000, 1, '2019-05-24 21:42:13', 1),
(1510, 0000001510, '100mm GRINDING WHEEL', '100mm GRINDING WHEEL', 0019, 00190006, 001900060000, 0019000600000000, 1, '2019-05-24 21:42:13', 1),
(1511, 0000001511, '180mm', '180mm', 0019, 00190006, 001900060000, 0019000600000000, 1, '2019-05-24 21:42:13', 1),
(1512, 0000001512, '100mm DIAMOND WHEEL', '100mm DIAMOND WHEEL', 0019, 00190007, 001900070000, 0019000700000000, 1, '2019-05-24 21:42:13', 1),
(1513, 0000001513, '180mm', '180mm', 0019, 00190007, 001900070000, 0019000700000000, 1, '2019-05-24 21:42:13', 1),
(1514, 0000001514, 'S-6  RAWL PLUG', 'S-6  RAWL PLUG', 0019, 00190008, 001900080000, 0019000800000000, 1, '2019-05-24 21:42:13', 1),
(1515, 0000001515, 'S-7', 'S-7', 0019, 00190008, 001900080000, 0019000800000000, 1, '2019-05-24 21:42:13', 1),
(1516, 0000001516, 'S-8', 'S-8', 0019, 00190008, 001900080000, 0019000800000000, 1, '2019-05-24 21:42:13', 1),
(1517, 0000001517, 'S-10', 'S-10', 0019, 00190008, 001900080000, 0019000800000000, 1, '2019-05-24 21:42:13', 1),
(1518, 0000001518, 'S-12', 'S-12', 0019, 00190008, 001900080000, 0019000800000000, 1, '2019-05-24 21:42:13', 1),
(1519, 0000001519, '1\" x 6  BRASS SCREWS', '1\" x 6  BRASS SCREWS', 0019, 00190009, 001900090000, 0019000900000000, 1, '2019-05-24 21:42:13', 1),
(1520, 0000001520, '1¼\" x 7', '1¼\" x 7', 0019, 00190009, 001900090000, 0019000900000000, 1, '2019-05-24 21:42:13', 1),
(1521, 0000001521, '1½\" x 8', '1½\" x 8', 0019, 00190009, 001900090000, 0019000900000000, 1, '2019-05-24 21:42:13', 1),
(1522, 0000001522, '2\" x 10', '2\" x 10', 0019, 00190009, 001900090000, 0019000900000000, 1, '2019-05-24 21:42:13', 1),
(1523, 0000001523, '2½\" x 12', '2½\" x 12', 0019, 00190009, 001900090000, 0019000900000000, 1, '2019-05-24 21:42:13', 1),
(1524, 0000001524, '1\" x 6 TAPPING SCREW', '1\" x 6 TAPPING SCREW', 0019, 00190010, 001900100000, 0019001000000000, 1, '2019-05-24 21:42:13', 1),
(1525, 0000001525, '1¼\" x 7', '1¼\" x 7', 0019, 00190010, 001900100000, 0019001000000000, 1, '2019-05-24 21:42:13', 1),
(1526, 0000001526, '1½\" x 8', '1½\" x 8', 0019, 00190010, 001900100000, 0019001000000000, 1, '2019-05-24 21:42:13', 1),
(1527, 0000001527, '2\" x 10', '2\" x 10', 0019, 00190010, 001900100000, 0019001000000000, 1, '2019-05-24 21:42:13', 1),
(1528, 0000001528, '2.5mm WELDING ROD', '2.5mm WELDING ROD', 0019, 00190011, 001900110000, 0019001100000000, 1, '2019-05-24 21:42:13', 1),
(1529, 0000001529, '3.2mm', '3.2mm', 0019, 00190011, 001900110000, 0019001100000000, 1, '2019-05-24 21:42:13', 1),
(1530, 0000001530, '4.0mm', '4.0mm', 0019, 00190011, 001900110000, 0019001100000000, 1, '2019-05-24 21:42:13', 1),
(1531, 0000001531, '4 LT THINNER', '4 LT THINNER', 0019, 00190012, 001900120000, 0019001200000000, 1, '2019-05-24 21:42:13', 1),
(1532, 0000001532, '2 LT', '2 LT', 0019, 00190012, 001900120000, 0019001200000000, 1, '2019-05-24 21:42:14', 1),
(1533, 0000001533, '25mm x 25mm x 3mm GI ANGLE', '25mm x 25mm x 3mm GI ANGLE', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1534, 0000001534, '25mm x 25mm x 5mm', '25mm x 25mm x 5mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1535, 0000001535, '30mm x 30mm x 3mm', '30mm x 30mm x 3mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1536, 0000001536, '30mm x 30mm x 5mm', '30mm x 30mm x 5mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1537, 0000001537, '40mm x 40mm x 3mm', '40mm x 40mm x 3mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1538, 0000001538, '40mm x 40mm x 5mm', '40mm x 40mm x 5mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1539, 0000001539, '50mm x 50mm x 5mm', '50mm x 50mm x 5mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1540, 0000001540, '65mm x 65mm x 5mm', '65mm x 65mm x 5mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1541, 0000001541, '75mm x 75mm x 5mm', '75mm x 75mm x 5mm', 0019, 00190013, 001900130001, 0019001300010000, 1, '2019-05-24 21:42:14', 1),
(1542, 0000001542, '25mm x 25mm x 3mm M.S ANGLE', '25mm x 25mm x 3mm M.S ANGLE', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1543, 0000001543, '25mm x 25mm x 5mm', '25mm x 25mm x 5mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1544, 0000001544, '30mm x 30mm x 3mm', '30mm x 30mm x 3mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1545, 0000001545, '30mm x 30mm x 5mm', '30mm x 30mm x 5mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1546, 0000001546, '40mm x 40mm x 3mm', '40mm x 40mm x 3mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1547, 0000001547, '40mm x 40mm x 5mm', '40mm x 40mm x 5mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1548, 0000001548, '50mm x 50mm x 5mm', '50mm x 50mm x 5mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1549, 0000001549, '65mm x 65mm x 5mm', '65mm x 65mm x 5mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1550, 0000001550, '75mm x 75mm x 5mm', '75mm x 75mm x 5mm', 0019, 00190013, 001900130002, 0019001300020000, 1, '2019-05-24 21:42:14', 1),
(1551, 0000001551, '50mm x 25mm x 5mm GI C-CHANNEL', '50mm x 25mm x 5mm GI C-CHANNEL', 0019, 00190014, 001900140001, 0019001400010000, 1, '2019-05-24 21:42:14', 1),
(1552, 0000001552, '75mm x 40mm x 5mm', '75mm x 40mm x 5mm', 0019, 00190014, 001900140001, 0019001400010000, 1, '2019-05-24 21:42:14', 1),
(1553, 0000001553, '100mm x 50mm x 5mm', '100mm x 50mm x 5mm', 0019, 00190014, 001900140001, 0019001400010000, 1, '2019-05-24 21:42:14', 1),
(1554, 0000001554, '125mm x 75mm x 5mm', '125mm x 75mm x 5mm', 0019, 00190014, 001900140001, 0019001400010000, 1, '2019-05-24 21:42:14', 1),
(1555, 0000001555, '8\' x 4\' x 0.5mm GI SHEET', '8\' x 4\' x 0.5mm GI SHEET', 0019, 00190015, 001900150000, 0019001500000000, 1, '2019-05-24 21:42:15', 1),
(1556, 0000001556, '8\' x 4\' x 0.6mm', '8\' x 4\' x 0.6mm', 0019, 00190015, 001900150000, 0019001500000000, 1, '2019-05-24 21:42:15', 1),
(1557, 0000001557, '8\' x 4\' x 0.8mm', '8\' x 4\' x 0.8mm', 0019, 00190015, 001900150000, 0019001500000000, 1, '2019-05-24 21:42:15', 1),
(1558, 0000001558, '8\' x 4\' x 1mm', '8\' x 4\' x 1mm', 0019, 00190015, 001900150000, 0019001500000000, 1, '2019-05-24 21:42:15', 1),
(1559, 0000001559, '8\' x 4\' x 3mm M.S SHEET', '8\' x 4\' x 3mm M.S SHEET', 0019, 00190016, 001900160000, 0019001600000000, 1, '2019-05-24 21:42:15', 1),
(1560, 0000001560, '8\' x 4\' x 5mm', '8\' x 4\' x 5mm', 0019, 00190016, 001900160000, 0019001600000000, 1, '2019-05-24 21:42:15', 1),
(1561, 0000001561, '8\' x 4\' x 8mm', '8\' x 4\' x 8mm', 0019, 00190016, 001900160000, 0019001600000000, 1, '2019-05-24 21:42:15', 1),
(1562, 0000001562, '8\' x 4\' x 10mm', '8\' x 4\' x 10mm', 0019, 00190016, 001900160000, 0019001600000000, 1, '2019-05-24 21:42:15', 1),
(1563, 0000001563, '8\' x 4\' x 12mm', '8\' x 4\' x 12mm', 0019, 00190016, 001900160000, 0019001600000000, 1, '2019-05-24 21:42:15', 1),
(1564, 0000001564, 'H/S  HACK SAW BLADE', 'H/S  HACK SAW BLADE', 0019, 00190017, 001900170000, 0019001700000000, 1, '2019-05-24 21:42:15', 1),
(1565, 0000001565, 'C/S', 'C/S', 0019, 00190017, 001900170000, 0019001700000000, 1, '2019-05-24 21:42:15', 1),
(1566, 0000001566, 'NT CUTTER BLADE', 'NT CUTTER BLADE', 0019, 00190018, 001900180000, 0019001800000000, 1, '2019-05-24 21:42:15', 1),
(1567, 0000001567, '20mm THREAD SEAL', '20mm THREAD SEAL', 0019, 00190019, 001900190000, 0019001900000000, 1, '2019-05-24 21:42:15', 1),
(1568, 0000001568, '25mm', '25mm', 0019, 00190019, 001900190000, 0019001900000000, 1, '2019-05-24 21:42:15', 1),
(1569, 0000001569, '15mm HANGER BAND', '15mm HANGER BAND', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1570, 0000001570, '20mm', '20mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1571, 0000001571, '25mm', '25mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1572, 0000001572, '32mm', '32mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1573, 0000001573, '40mm', '40mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1574, 0000001574, '50mm', '50mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1575, 0000001575, '65mm', '65mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1576, 0000001576, '75mm', '75mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:15', 1),
(1577, 0000001577, '90mm', '90mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:16', 1),
(1578, 0000001578, '100mm', '100mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:16', 1),
(1579, 0000001579, '125mm', '125mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:16', 1),
(1580, 0000001580, '150mm', '150mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:16', 1),
(1581, 0000001581, '200mm', '200mm', 0019, 00190020, 001900200000, 0019002000000000, 1, '2019-05-24 21:42:16', 1),
(1582, 0000001582, '15mm U-BOLT', '15mm U-BOLT', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1583, 0000001583, '20mm', '20mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1584, 0000001584, '25mm', '25mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1585, 0000001585, '32mm', '32mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1586, 0000001586, '40mm', '40mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1587, 0000001587, '50mm', '50mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1588, 0000001588, '65mm', '65mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1589, 0000001589, '75mm', '75mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1590, 0000001590, '90mm', '90mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:16', 1),
(1591, 0000001591, '100mm', '100mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:17', 1),
(1592, 0000001592, '125mm', '125mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:17', 1),
(1593, 0000001593, '150mm', '150mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:17', 1),
(1594, 0000001594, '200mm', '200mm', 0019, 00190021, 001900210000, 0019002100000000, 1, '2019-05-24 21:42:17', 1),
(1595, 0000001595, '1.5mm  O-LUG', '1.5mm  O-LUG', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1596, 0000001596, '2.5mm', '2.5mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1597, 0000001597, '4mm', '4mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1598, 0000001598, '5.5mm', '5.5mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1599, 0000001599, '6mm', '6mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1600, 0000001600, '10mm', '10mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1601, 0000001601, '16mm', '16mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1602, 0000001602, '25mm', '25mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1603, 0000001603, '35mm', '35mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1604, 0000001604, '50mm', '50mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1605, 0000001605, '70mm', '70mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1606, 0000001606, '90mm', '90mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1607, 0000001607, '100mm', '100mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1608, 0000001608, '150mm', '150mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1609, 0000001609, '185mm', '185mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1610, 0000001610, '400mm', '400mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1611, 0000001611, '500mm ', '500mm ', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1612, 0000001612, '630mm', '630mm', 0020, 00200001, 002000010000, 0020000100000000, 1, '2019-05-24 21:42:17', 1),
(1613, 0000001613, '1.5mm  U-LUG', '1.5mm  U-LUG', 0020, 00200002, 002000020000, 0020000200000000, 1, '2019-05-24 21:42:17', 1),
(1614, 0000001614, '2.5mm', '2.5mm', 0020, 00200002, 002000020000, 0020000200000000, 1, '2019-05-24 21:42:17', 1),
(1615, 0000001615, '4mm', '4mm', 0020, 00200002, 002000020000, 0020000200000000, 1, '2019-05-24 21:42:17', 1);
INSERT INTO `products` (`products_table_id`, `product_code`, `product_name`, `product_description`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `product_location_id`, `saved_datetime`, `saved_user`) VALUES
(1616, 0000001616, '1mm  I-LUG', '1mm  I-LUG', 0020, 00200003, 002000030000, 0020000300000000, 1, '2019-05-24 21:42:18', 1),
(1617, 0000001617, '1.5mm', '1.5mm', 0020, 00200003, 002000030000, 0020000300000000, 1, '2019-05-24 21:42:18', 1),
(1618, 0000001618, '2.5mm', '2.5mm', 0020, 00200003, 002000030000, 0020000300000000, 1, '2019-05-24 21:42:18', 1),
(1619, 0000001619, '4mm', '4mm', 0020, 00200003, 002000030000, 0020000300000000, 1, '2019-05-24 21:42:18', 1),
(1620, 0000001620, '1.5mm  FERRULS', '1.5mm  FERRULS', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1621, 0000001621, '2.5mm', '2.5mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1622, 0000001622, '4mm', '4mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1623, 0000001623, '6mm', '6mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1624, 0000001624, '10mm', '10mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1625, 0000001625, '16mm', '16mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1626, 0000001626, '25mm', '25mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1627, 0000001627, '35mm', '35mm', 0020, 00200004, 002000040000, 0020000400000000, 1, '2019-05-24 21:42:18', 1),
(1628, 0000001628, 'PVC PG-11  CABLE GLAND', 'PVC PG-11  CABLE GLAND', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1629, 0000001629, 'PVC PG-13.5', 'PVC PG-13.5', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1630, 0000001630, 'PVC PG-16', 'PVC PG-16', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1631, 0000001631, 'PVC PG-21', 'PVC PG-21', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1632, 0000001632, 'PVC PG-25', 'PVC PG-25', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1633, 0000001633, 'PVC PG-36', 'PVC PG-36', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1634, 0000001634, 'PVC PG-42', 'PVC PG-42', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1635, 0000001635, 'PVC PG-48', 'PVC PG-48', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:18', 1),
(1636, 0000001636, 'PVC M20', 'PVC M20', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1637, 0000001637, 'BRASS CW-32L', 'BRASS CW-32L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1638, 0000001638, 'BRASS CW-40L', 'BRASS CW-40L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1639, 0000001639, 'BRASS CW-63L', 'BRASS CW-63L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1640, 0000001640, 'BRASS CW-75L', 'BRASS CW-75L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1641, 0000001641, 'BRASS A2-16L', 'BRASS A2-16L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1642, 0000001642, 'BRASS A2-25L', 'BRASS A2-25L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1643, 0000001643, 'BRASS A2-32S', 'BRASS A2-32S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1644, 0000001644, 'BRASS A2-40S', 'BRASS A2-40S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1645, 0000001645, 'BRASS A2-50L', 'BRASS A2-50L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1646, 0000001646, 'BRASS A2-75S', 'BRASS A2-75S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1647, 0000001647, 'BRASS A2-90L', 'BRASS A2-90L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1648, 0000001648, 'BRASS BW-25S', 'BRASS BW-25S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1649, 0000001649, 'BRASS BW-25L', 'BRASS BW-25L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1650, 0000001650, 'BRASS BW-32S', 'BRASS BW-32S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1651, 0000001651, 'BRASS BW-32L', 'BRASS BW-32L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1652, 0000001652, 'BRASS BW-40S', 'BRASS BW-40S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1653, 0000001653, 'BRASS BW-40L', 'BRASS BW-40L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1654, 0000001654, 'BRASS BW-50S', 'BRASS BW-50S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1655, 0000001655, 'BRASS BW-50L', 'BRASS BW-50L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1656, 0000001656, 'BRASS BW-63S', 'BRASS BW-63S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:19', 1),
(1657, 0000001657, 'BRASS BW-63L', 'BRASS BW-63L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:20', 1),
(1658, 0000001658, 'BRASS BW-75S', 'BRASS BW-75S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:20', 1),
(1659, 0000001659, 'BRASS BW-75L', 'BRASS BW-75L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:20', 1),
(1660, 0000001660, 'BRASS BW-90S', 'BRASS BW-90S', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:20', 1),
(1661, 0000001661, 'BRASS BW-90L', 'BRASS BW-90L', 0020, 00200005, 002000050000, 0020000500000000, 1, '2019-05-24 21:42:20', 1),
(1662, 0000001662, 'GEQ-2621 GROMMET', 'GEQ-2621 GROMMET', 0020, 00200006, 002000060000, 0020000600000000, 1, '2019-05-24 21:42:20', 1),
(1663, 0000001663, 'GEQ-2015', 'GEQ-2015', 0020, 00200006, 002000060000, 0020000600000000, 1, '2019-05-24 21:42:20', 1),
(1664, 0000001664, 'GM-0603', 'GM-0603', 0020, 00200006, 002000060000, 0020000600000000, 1, '2019-05-24 21:42:20', 1),
(1665, 0000001665, '4\"   Blue   25MT HEAT SLEEVE', '4\"   Blue   25MT HEAT SLEEVE', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:20', 1),
(1666, 0000001666, '4\"   Black   25MT', '4\"   Black   25MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:20', 1),
(1667, 0000001667, '2½\"   Black  25MT', '2½\"   Black  25MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:20', 1),
(1668, 0000001668, '2½\"   Ash    25MT', '2½\"   Ash    25MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:20', 1),
(1669, 0000001669, '2½\"   Blue  25MT', '2½\"   Blue  25MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:20', 1),
(1670, 0000001670, '2½\"   Brown  25MT', '2½\"   Brown  25MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1671, 0000001671, '1½\"  Brown  50MT', '1½\"  Brown  50MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1672, 0000001672, '1½\"  Ash    50MT', '1½\"  Ash    50MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1673, 0000001673, '1½\"  Blue   50MT', '1½\"  Blue   50MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1674, 0000001674, '1¼\"  Black  50MT', '1¼\"  Black  50MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1675, 0000001675, '1¼\"  Brown  50MT', '1¼\"  Brown  50MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1676, 0000001676, '1\"    Blue   20MT', '1\"    Blue   20MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1677, 0000001677, '3/4\"  Brown  50MT', '3/4\"  Brown  50MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1678, 0000001678, '3/4\"  Blue  25MT', '3/4\"  Blue  25MT', 0020, 00200007, 002000070000, 0020000700000000, 1, '2019-05-24 21:42:21', 1),
(1679, 0000001679, '8mm  x  100MT MARKER TUBE', '8mm  x  100MT MARKER TUBE', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1680, 0000001680, '7mm  x  100MT', '7mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1681, 0000001681, '6mm  x  100MT', '6mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1682, 0000001682, '5.5mm  x  100MT', '5.5mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1683, 0000001683, '5mm  x  100MT', '5mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1684, 0000001684, '4.5mm  x  100MT', '4.5mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1685, 0000001685, '4mm  x  100MT', '4mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1686, 0000001686, '3.2mm  x  100MT', '3.2mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1687, 0000001687, '2.5mm  x  100MT', '2.5mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1688, 0000001688, '2mm  x  100MT', '2mm  x  100MT', 0020, 00200008, 002000080000, 0020000800000000, 1, '2019-05-24 21:42:21', 1),
(1689, 0000001689, '75mm  CABLE TIE', '75mm  CABLE TIE', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:21', 1),
(1690, 0000001690, '100mm', '100mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:21', 1),
(1691, 0000001691, '150mm', '150mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1692, 0000001692, '200mm', '200mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1693, 0000001693, '250mm', '250mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1694, 0000001694, '300mm', '300mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1695, 0000001695, '450mm', '450mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1696, 0000001696, '600mm', '600mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1697, 0000001697, '900mm', '900mm', 0020, 00200009, 002000090000, 0020000900000000, 1, '2019-05-24 21:42:22', 1),
(1698, 0000001698, 'INSULATION TAPE', 'INSULATION TAPE', 0020, 00200010, 002000100000, 0020001000000000, 1, '2019-05-24 21:42:22', 1),
(1699, 0000001699, 'F-CO', 'F-CO', 0020, 00200010, 002000100000, 0020001000000000, 1, '2019-05-24 21:42:22', 1),
(1700, 0000001700, '1G 1WAY  SWITCH', '1G 1WAY  SWITCH', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1701, 0000001701, '2G 1WAY', '2G 1WAY', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1702, 0000001702, '3G 1WAY', '3G 1WAY', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1703, 0000001703, '5G 1WAY', '5G 1WAY', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1704, 0000001704, 'BELL PRESS', 'BELL PRESS', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1705, 0000001705, 'DOUBLE POLE SWITCH 20A', 'DOUBLE POLE SWITCH 20A', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1706, 0000001706, 'BLAN PLATE', 'BLAN PLATE', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1707, 0000001707, 'LIGHT DIMMER', 'LIGHT DIMMER', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1708, 0000001708, 'FAN SPEED CONTROLLER', 'FAN SPEED CONTROLLER', 0021, 00210001, 002100010000, 0021000100000000, 1, '2019-05-24 21:42:22', 1),
(1709, 0000001709, '5A  SOCKET OUTLET', '5A  SOCKET OUTLET', 0021, 00210002, 002100020000, 0021000200000000, 1, '2019-05-24 21:42:22', 1),
(1710, 0000001710, '13A 1G', '13A 1G', 0021, 00210002, 002100020000, 0021000200000000, 1, '2019-05-24 21:42:22', 1),
(1711, 0000001711, '13A 2G', '13A 2G', 0021, 00210002, 002100020000, 0021000200000000, 1, '2019-05-24 21:42:22', 1),
(1712, 0000001712, '15A', '15A', 0021, 00210002, 002100020000, 0021000200000000, 1, '2019-05-24 21:42:23', 1),
(1713, 0000001713, '5Amp  PLUG TOP', '5Amp  PLUG TOP', 0021, 00210003, 002100030000, 0021000300000000, 1, '2019-05-24 21:42:23', 1),
(1714, 0000001714, '13Amp', '13Amp', 0021, 00210003, 002100030000, 0021000300000000, 1, '2019-05-24 21:42:23', 1),
(1715, 0000001715, '16A 3 Pin  INDUSTRILA SOCKET', '16A 3 Pin  INDUSTRILA SOCKET', 0021, 00210004, 002100040000, 0021000400000000, 1, '2019-05-24 21:42:23', 1),
(1716, 0000001716, '16A 5 Pin', '16A 5 Pin', 0021, 00210004, 002100040000, 0021000400000000, 1, '2019-05-24 21:42:23', 1),
(1717, 0000001717, '32A 3 Pin', '32A 3 Pin', 0021, 00210004, 002100040000, 0021000400000000, 1, '2019-05-24 21:42:23', 1),
(1718, 0000001718, '32A 5 Pin', '32A 5 Pin', 0021, 00210004, 002100040000, 0021000400000000, 1, '2019-05-24 21:42:23', 1),
(1719, 0000001719, '63A 5 Pin', '63A 5 Pin', 0021, 00210004, 002100040000, 0021000400000000, 1, '2019-05-24 21:42:23', 1),
(1720, 0000001720, '6Amp  MCB', '6Amp  MCB', 0021, 00210005, 002100050000, 0021000500000000, 1, '2019-05-24 21:42:23', 1),
(1721, 0000001721, '10Amp', '10Amp', 0021, 00210005, 002100050000, 0021000500000000, 1, '2019-05-24 21:42:23', 1),
(1722, 0000001722, '20Amp', '20Amp', 0021, 00210005, 002100050000, 0021000500000000, 1, '2019-05-24 21:42:23', 1),
(1723, 0000001723, '32Amp', '32Amp', 0021, 00210005, 002100050000, 0021000500000000, 1, '2019-05-24 21:42:23', 1),
(1724, 0000001724, '20Amp 2 Pole  MCCB', '20Amp 2 Pole  MCCB', 0021, 00210006, 002100060000, 0021000600000000, 1, '2019-05-24 21:42:23', 1),
(1725, 0000001725, '20Amp 4 Pole', '20Amp 4 Pole', 0021, 00210006, 002100060000, 0021000600000000, 1, '2019-05-24 21:42:23', 1),
(1726, 0000001726, '32Amp 2 Pole', '32Amp 2 Pole', 0021, 00210006, 002100060000, 0021000600000000, 1, '2019-05-24 21:42:23', 1),
(1727, 0000001727, '32Amp 4 Pole', '32Amp 4 Pole', 0021, 00210006, 002100060000, 0021000600000000, 1, '2019-05-24 21:42:23', 1),
(1728, 0000001728, '63Amp 4 Pole', '63Amp 4 Pole', 0021, 00210006, 002100060000, 0021000600000000, 1, '2019-05-24 21:42:23', 1),
(1729, 0000001729, '40Amp 2 Pole RCCB', '40Amp 2 Pole RCCB', 0021, 00210007, 002100070000, 0021000700000000, 1, '2019-05-24 21:42:23', 1),
(1730, 0000001730, '40Amp 4 Pole', '40Amp 4 Pole', 0021, 00210007, 002100070000, 0021000700000000, 1, '2019-05-24 21:42:23', 1),
(1731, 0000001731, '63Amp 2 Pole', '63Amp 2 Pole', 0021, 00210007, 002100070000, 0021000700000000, 1, '2019-05-24 21:42:23', 1),
(1732, 0000001732, '63Amp 4 Pole', '63Amp 4 Pole', 0021, 00210007, 002100070000, 0021000700000000, 1, '2019-05-24 21:42:23', 1),
(1733, 0000001733, '100 x 100 CEILING DIFFUCER', '100 x 100 CEILING DIFFUCER', 0022, 00220001, 002200010000, 0022000100000000, 1, '2019-05-24 21:42:23', 1),
(1734, 0000001734, '150 x 150', '150 x 150', 0022, 00220001, 002200010000, 0022000100000000, 1, '2019-05-24 21:42:23', 1),
(1735, 0000001735, '300 x 300', '300 x 300', 0022, 00220001, 002200010000, 0022000100000000, 1, '2019-05-24 21:42:23', 1),
(1736, 0000001736, '450 x 600', '450 x 600', 0022, 00220001, 002200010000, 0022000100000000, 1, '2019-05-24 21:42:23', 1),
(1737, 0000001737, '100 x 100 SUPPLY GRILL', '100 x 100 SUPPLY GRILL', 0022, 00220002, 002200020000, 0022000200000000, 1, '2019-05-24 21:42:24', 1),
(1738, 0000001738, '150 x 150', '150 x 150', 0022, 00220002, 002200020000, 0022000200000000, 1, '2019-05-24 21:42:24', 1),
(1739, 0000001739, '300 x 300', '300 x 300', 0022, 00220002, 002200020000, 0022000200000000, 1, '2019-05-24 21:42:24', 1),
(1740, 0000001740, '450 x 600', '450 x 600', 0022, 00220002, 002200020000, 0022000200000000, 1, '2019-05-24 21:42:24', 1),
(1741, 0000001741, '100 x 100 RETURN GRILL', '100 x 100 RETURN GRILL', 0022, 00220003, 002200030000, 0022000300000000, 1, '2019-05-24 21:42:24', 1),
(1742, 0000001742, '150 x 150', '150 x 150', 0022, 00220003, 002200030000, 0022000300000000, 1, '2019-05-24 21:42:24', 1),
(1743, 0000001743, '300 x 300', '300 x 300', 0022, 00220003, 002200030000, 0022000300000000, 1, '2019-05-24 21:42:24', 1),
(1744, 0000001744, '450 x 600', '450 x 600', 0022, 00220003, 002200030000, 0022000300000000, 1, '2019-05-24 21:42:24', 1),
(1745, 0000001745, '100 x 100 LINEAR SLTS DIFFUCER', '100 x 100 LINEAR SLTS DIFFUCER', 0022, 00220004, 002200040000, 0022000400000000, 1, '2019-05-24 21:42:24', 1),
(1746, 0000001746, '150 x 150', '150 x 150', 0022, 00220004, 002200040000, 0022000400000000, 1, '2019-05-24 21:42:24', 1),
(1747, 0000001747, '300 x 300', '300 x 300', 0022, 00220004, 002200040000, 0022000400000000, 1, '2019-05-24 21:42:24', 1),
(1748, 0000001748, '450 x 600', '450 x 600', 0022, 00220004, 002200040000, 0022000400000000, 1, '2019-05-24 21:42:24', 1),
(1749, 0000001749, '56\" CEILING FAN', '56\" CEILING FAN', 0023, 00230001, 002300010000, 0023000100000000, 1, '2019-05-24 21:42:24', 1),
(1750, 0000001750, '48\"', '48\"', 0023, 00230001, 002300010000, 0023000100000000, 1, '2019-05-24 21:42:24', 1),
(1751, 0000001751, 'Model No: 1  EXHOUST FAN', 'Model No: 1  EXHOUST FAN', 0023, 00230002, 002300020000, 0023000200000000, 1, '2019-05-24 21:42:24', 1),
(1752, 0000001752, 'Model No: 2', 'Model No: 2', 0023, 00230002, 002300020000, 0023000200000000, 1, '2019-05-24 21:42:24', 1),
(1753, 0000001753, '300 x 300  VENTILATION FAN', '300 x 300  VENTILATION FAN', 0023, 00230003, 002300030000, 0023000300000000, 1, '2019-05-24 21:42:24', 1),
(1754, 0000001754, '450 x 450', '450 x 450', 0023, 00230003, 002300030000, 0023000300000000, 1, '2019-05-24 21:42:24', 1),
(1755, 0000001755, 'Capacity 1  DUCT FAN', 'Capacity 1  DUCT FAN', 0023, 00230004, 002300040000, 0023000400000000, 1, '2019-05-24 21:42:24', 1),
(1756, 0000001756, 'Capacity 2', 'Capacity 2', 0023, 00230004, 002300040000, 0023000400000000, 1, '2019-05-24 21:42:24', 1),
(1757, 0000001757, 'Capacity 1 CENTRIFIGAL PUMP', 'Capacity 1 CENTRIFIGAL PUMP', 0024, 00240001, 002400010000, 0024000100000000, 1, '2019-05-24 21:42:24', 1),
(1758, 0000001758, 'Capacity 2', 'Capacity 2', 0024, 00240001, 002400010000, 0024000100000000, 1, '2019-05-24 21:42:24', 1),
(1759, 0000001759, 'SIZE/ MODEL SUBMERSIBLE PUMP', 'SIZE/ MODEL SUBMERSIBLE PUMP', 0024, 00240002, 002400020000, 0024000200000000, 1, '2019-05-24 21:42:24', 1),
(1760, 0000001760, 'SIZE/ MODEL ', 'SIZE/ MODEL ', 0024, 00240002, 002400020000, 0024000200000000, 1, '2019-05-24 21:42:25', 1),
(1761, 0000001761, 'SIZE/ MODEL  FLURECENT', 'SIZE/ MODEL  FLURECENT', 0025, 00250001, 002500010000, 0025000100000000, 1, '2019-05-24 21:42:25', 1),
(1762, 0000001762, 'SIZE/ MODEL  DOWN LIGHT', 'SIZE/ MODEL  DOWN LIGHT', 0025, 00250002, 002500020000, 0025000200000000, 1, '2019-05-24 21:42:25', 1),
(1763, 0000001763, '500W HELOGEN LAMP', '500W HELOGEN LAMP', 0025, 00250001, 002500010000, 0025000100000000, 1, '2019-05-24 21:42:25', 1),
(1764, 0000001764, '1000W', '1000W', 0025, 00250001, 002500010000, 0025000100000000, 1, '2019-05-24 21:42:25', 1),
(1765, 0000001765, '10mm ARMOURD CABLE', '10mm ARMOURD CABLE', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1766, 0000001766, '16mm', '16mm', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1767, 0000001767, '25mm', '25mm', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1768, 0000001768, '35mm', '35mm', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1769, 0000001769, '50mm', '50mm', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1770, 0000001770, '120mm', '120mm', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1771, 0000001771, '150mm', '150mm', 0026, 00260001, 002600010001, 0026000100010000, 1, '2019-05-24 21:42:25', 1),
(1772, 0000001772, '10mm ARMOURD CABLE', '10mm ARMOURD CABLE', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1773, 0000001773, '16mm', '16mm', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1774, 0000001774, '25mm', '25mm', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1775, 0000001775, '35mm', '35mm', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1776, 0000001776, '50mm', '50mm', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1777, 0000001777, '120mm', '120mm', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1778, 0000001778, '150mm', '150mm', 0026, 00260001, 002600010002, 0026000100020000, 1, '2019-05-24 21:42:25', 1),
(1779, 0000001779, '10mm ARMOURD CABLE', '10mm ARMOURD CABLE', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1780, 0000001780, '16mm', '16mm', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1781, 0000001781, '25mm', '25mm', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1782, 0000001782, '35mm', '35mm', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1783, 0000001783, '50mm', '50mm', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1784, 0000001784, '120mm', '120mm', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1785, 0000001785, '150mm', '150mm', 0026, 00260001, 002600010003, 0026000100030000, 1, '2019-05-24 21:42:25', 1),
(1786, 0000001786, '10mm ARMOURD CABLE', '10mm ARMOURD CABLE', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:25', 1),
(1787, 0000001787, '16mm', '16mm', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:26', 1),
(1788, 0000001788, '25mm', '25mm', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:26', 1),
(1789, 0000001789, '35mm', '35mm', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:26', 1),
(1790, 0000001790, '50mm', '50mm', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:26', 1),
(1791, 0000001791, '120mm', '120mm', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:26', 1),
(1792, 0000001792, '150mm', '150mm', 0026, 00260001, 002600010004, 0026000100040000, 1, '2019-05-24 21:42:26', 1),
(1793, 0000001793, '1mm ARMOURD CABLE', '1mm ARMOURD CABLE', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1794, 0000001794, '1.5mm', '1.5mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1795, 0000001795, '2.5mm', '2.5mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1796, 0000001796, '4mm', '4mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1797, 0000001797, '6mm', '6mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1798, 0000001798, '10mm', '10mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1799, 0000001799, '25mm', '25mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1800, 0000001800, '35mm', '35mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1801, 0000001801, '50mm', '50mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1802, 0000001802, '70mm', '70mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1803, 0000001803, '95mm', '95mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1804, 0000001804, '120mm', '120mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1805, 0000001805, '150mm', '150mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1806, 0000001806, '185mm', '185mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1807, 0000001807, '240mm', '240mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1808, 0000001808, '300mm', '300mm', 0026, 00260002, 002600020001, 0026000200010000, 1, '2019-05-24 21:42:26', 1),
(1809, 0000001809, '1mm ARMOURD CABLE', '1mm ARMOURD CABLE', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1810, 0000001810, '1.5mm', '1.5mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1811, 0000001811, '2.5mm', '2.5mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1812, 0000001812, '4mm', '4mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1813, 0000001813, '6mm', '6mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1814, 0000001814, '10mm', '10mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1815, 0000001815, '25mm', '25mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:26', 1),
(1816, 0000001816, '35mm', '35mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1817, 0000001817, '50mm', '50mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1818, 0000001818, '70mm', '70mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1819, 0000001819, '95mm', '95mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1820, 0000001820, '120mm', '120mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1821, 0000001821, '150mm', '150mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1822, 0000001822, '185mm', '185mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1823, 0000001823, '240mm', '240mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1824, 0000001824, '300mm', '300mm', 0026, 00260002, 002600020002, 0026000200020000, 1, '2019-05-24 21:42:27', 1),
(1825, 0000001825, '1mm ARMOURD CABLE', '1mm ARMOURD CABLE', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1826, 0000001826, '1.5mm', '1.5mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1827, 0000001827, '2.5mm', '2.5mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1828, 0000001828, '4mm', '4mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1829, 0000001829, '6mm', '6mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1830, 0000001830, '10mm', '10mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1831, 0000001831, '25mm', '25mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1832, 0000001832, '35mm', '35mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1833, 0000001833, '50mm', '50mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1834, 0000001834, '70mm', '70mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1835, 0000001835, '95mm', '95mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1836, 0000001836, '120mm', '120mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1837, 0000001837, '150mm', '150mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1838, 0000001838, '185mm', '185mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1839, 0000001839, '240mm', '240mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1840, 0000001840, '300mm', '300mm', 0026, 00260002, 002600020003, 0026000200030000, 1, '2019-05-24 21:42:27', 1),
(1841, 0000001841, '1mm ARMOURD CABLE', '1mm ARMOURD CABLE', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:27', 1),
(1842, 0000001842, '1.5mm', '1.5mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:27', 1),
(1843, 0000001843, '2.5mm', '2.5mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1844, 0000001844, '4mm', '4mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1845, 0000001845, '6mm', '6mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1846, 0000001846, '10mm', '10mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1847, 0000001847, '25mm', '25mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1848, 0000001848, '35mm', '35mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1849, 0000001849, '50mm', '50mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1850, 0000001850, '70mm', '70mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1851, 0000001851, '95mm', '95mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1852, 0000001852, '120mm', '120mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1853, 0000001853, '150mm', '150mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1854, 0000001854, '185mm', '185mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1855, 0000001855, '240mm', '240mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1856, 0000001856, '300mm', '300mm', 0026, 00260002, 002600020004, 0026000200040000, 1, '2019-05-24 21:42:28', 1),
(1857, 0000001857, '1.5mm EARTH CABLE', '1.5mm EARTH CABLE', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1858, 0000001858, '2.5mm', '2.5mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1859, 0000001859, '4mm', '4mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1860, 0000001860, '6mm', '6mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1861, 0000001861, '10mm', '10mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1862, 0000001862, '16mm', '16mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1863, 0000001863, '25mm', '25mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1864, 0000001864, '35mm', '35mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1865, 0000001865, '50mm', '50mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1866, 0000001866, '70mm', '70mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:28', 1),
(1867, 0000001867, '120mm', '120mm', 0026, 00260003, 002600030000, 0026000300000000, 1, '2019-05-24 21:42:29', 1),
(1868, 0000001868, '1mm FLEXIBLE CABLE', '1mm FLEXIBLE CABLE', 0026, 00260004, 002600040001, 0026000400010000, 1, '2019-05-24 21:42:29', 1),
(1869, 0000001869, '1.5mm', '1.5mm', 0026, 00260004, 002600040001, 0026000400010000, 1, '2019-05-24 21:42:29', 1),
(1870, 0000001870, '2.5mm', '2.5mm', 0026, 00260004, 002600040001, 0026000400010000, 1, '2019-05-24 21:42:29', 1),
(1871, 0000001871, '4mm', '4mm', 0026, 00260004, 002600040001, 0026000400010000, 1, '2019-05-24 21:42:29', 1),
(1872, 0000001872, '1mm FLEXIBLE CABLE', '1mm FLEXIBLE CABLE', 0026, 00260004, 002600040002, 0026000400020000, 1, '2019-05-24 21:42:29', 1),
(1873, 0000001873, '1.5mm', '1.5mm', 0026, 00260004, 002600040002, 0026000400020000, 1, '2019-05-24 21:42:29', 1),
(1874, 0000001874, '2.5mm', '2.5mm', 0026, 00260004, 002600040002, 0026000400020000, 1, '2019-05-24 21:42:29', 1),
(1875, 0000001875, '4mm', '4mm', 0026, 00260004, 002600040002, 0026000400020000, 1, '2019-05-24 21:42:29', 1),
(1876, 0000001876, '1mm FLEXIBLE CABLE', '1mm FLEXIBLE CABLE', 0026, 00260004, 002600040003, 0026000400030000, 1, '2019-05-24 21:42:29', 1),
(1877, 0000001877, '1.5mm', '1.5mm', 0026, 00260004, 002600040003, 0026000400030000, 1, '2019-05-24 21:42:29', 1),
(1878, 0000001878, '2.5mm', '2.5mm', 0026, 00260004, 002600040003, 0026000400030000, 1, '2019-05-24 21:42:29', 1),
(1879, 0000001879, '4mm', '4mm', 0026, 00260004, 002600040003, 0026000400030000, 1, '2019-05-24 21:42:29', 1),
(1880, 0000001880, '8760 BELDEN CABLE', '8760 BELDEN CABLE', 0026, 00260005, 002600050000, 0026000500000000, 1, '2019-05-24 21:42:29', 1),
(1881, 0000001881, '1505', '1505', 0026, 00260005, 002600050000, 0026000500000000, 1, '2019-05-24 21:42:29', 1),
(1882, 0000001882, 'CAT6', 'CAT6', 0026, 00260005, 002600050000, 0026000500000000, 1, '2019-05-24 21:42:29', 1),
(1883, 0000001883, 'CAT5', 'CAT5', 0026, 00260005, 002600050000, 0026000500000000, 1, '2019-05-24 21:42:29', 1),
(1884, 0000001884, '2 Pair TELEPHONE CABLE', '2 Pair TELEPHONE CABLE', 0026, 00260006, 002600060000, 0026000600000000, 1, '2019-05-24 21:42:29', 1),
(1885, 0000001885, '10 pair', '10 pair', 0026, 00260006, 002600060000, 0026000600000000, 1, '2019-05-24 21:42:29', 1),
(1886, 0000001886, '25 pair', '25 pair', 0026, 00260006, 002600060000, 0026000600000000, 1, '2019-05-24 21:42:29', 1),
(1887, 0000001887, '50 pair', '50 pair', 0026, 00260006, 002600060000, 0026000600000000, 1, '2019-05-24 21:42:29', 1),
(1888, 0000001888, '1mm CONTROL CABLE', '1mm CONTROL CABLE', 0026, 00260007, 002600070000, 0026000700000000, 1, '2019-05-24 21:42:29', 1),
(1889, 0000001889, '1.5mm', '1.5mm', 0026, 00260007, 002600070000, 0026000700000000, 1, '2019-05-24 21:42:29', 1),
(1890, 0000001890, '2.5mm', '2.5mm', 0026, 00260007, 002600070000, 0026000700000000, 1, '2019-05-24 21:42:30', 1),
(1891, 0000001891, '10mm ALUMINIUM CABLE', '10mm ALUMINIUM CABLE', 0026, 00260008, 002600080000, 0026000800000000, 1, '2019-05-24 21:42:30', 1),
(1892, 0000001892, '16mm', '16mm', 0026, 00260008, 002600080000, 0026000800000000, 1, '2019-05-24 21:42:30', 1),
(1893, 0000001893, '25mm', '25mm', 0026, 00260008, 002600080000, 0026000800000000, 1, '2019-05-24 21:42:30', 1),
(1894, 0000001894, '35mm', '35mm', 0026, 00260008, 002600080000, 0026000800000000, 1, '2019-05-24 21:42:30', 1),
(1895, 0000001895, '50mm', '50mm', 0026, 00260008, 002600080000, 0026000800000000, 1, '2019-05-24 21:42:30', 1),
(1896, 0000001896, '70mm', '70mm', 0026, 00260008, 002600080000, 0026000800000000, 1, '2019-05-24 21:42:30', 1),
(1897, 0000001897, '1MT EARTH ROD', '1MT EARTH ROD', 0027, 00270001, 002700010000, 0027000100000000, 1, '2019-05-24 21:42:30', 1),
(1898, 0000001898, '2MT', '2MT', 0027, 00270001, 002700010000, 0027000100000000, 1, '2019-05-24 21:42:30', 1),
(1899, 0000001899, '25mmT COPPER TAPE', '25mmT COPPER TAPE', 0027, 00270002, 002700020000, 0027000200000000, 1, '2019-05-24 21:42:30', 1),
(1900, 0000001900, '70mm BEAR CABLE', '70mm BEAR CABLE', 0027, 00270003, 002700030000, 0027000300000000, 1, '2019-05-24 21:42:30', 1),
(1901, 0000001901, '95mm', '95mm', 0027, 00270003, 002700030000, 0027000300000000, 1, '2019-05-24 21:42:30', 1),
(1902, 0000001902, '9mm ROD TO CLAMP', '9mm ROD TO CLAMP', 0027, 00270004, 002700040000, 0027000400000000, 1, '2019-05-24 21:42:30', 1),
(1903, 0000001903, '12mm', '12mm', 0027, 00270004, 002700040000, 0027000400000000, 1, '2019-05-24 21:42:30', 1),
(1904, 0000001904, 'CONCREET  EARTH PIT', 'CONCREET  EARTH PIT', 0027, 00270005, 002700050000, 0027000500000000, 1, '2019-05-24 21:42:30', 1),
(1905, 0000001905, 'PLASTIC', 'PLASTIC', 0027, 00270005, 002700050000, 0027000500000000, 1, '2019-05-24 21:42:30', 1),
(1906, 0000001906, 'CO2  FIRE EXTINGISER', 'CO2  FIRE EXTINGISER', 0028, 00280001, 002800010000, 0028000100000000, 1, '2019-05-24 21:42:30', 1),
(1907, 0000001907, 'WATER', 'WATER', 0028, 00280001, 002800010000, 0028000100000000, 1, '2019-05-24 21:42:30', 1),
(1908, 0000001908, 'DRY POWDER', 'DRY POWDER', 0028, 00280001, 002800010000, 0028000100000000, 1, '2019-05-24 21:42:30', 1),
(1909, 0000001909, 'SIZE/ MODEL  FIRE CABINUT', 'SIZE/ MODEL  FIRE CABINUT', 0028, 00280002, 002800020000, 0028000200000000, 1, '2019-05-24 21:42:30', 1),
(1910, 0000001910, 'SIZE/ MODEL  HOSE REAL', 'SIZE/ MODEL  HOSE REAL', 0028, 00280003, 002800030000, 0028000300000000, 1, '2019-05-24 21:42:30', 1),
(1911, 0000001911, 'SIZE/ MODEL  FIRE NOZEL', 'SIZE/ MODEL  FIRE NOZEL', 0028, 00280004, 002800040000, 0028000400000000, 1, '2019-05-24 21:42:30', 1),
(1912, 0000001912, 'HEAT DETECTORS', 'HEAT DETECTORS', 0028, 00280005, 002800050000, 0028000500000000, 1, '2019-05-24 21:42:30', 1),
(1913, 0000001913, 'SMOKE DETECTORS', 'SMOKE DETECTORS', 0028, 00280005, 002800050000, 0028000500000000, 1, '2019-05-24 21:42:30', 1),
(1914, 0000001914, 'SPRINKLER', 'SPRINKLER', 0028, 00280006, 002800060000, 0028000600000000, 1, '2019-05-24 21:42:30', 1),
(1915, 0000001915, 'Model / AMP  AMPLIFIRE', 'Model / AMP  AMPLIFIRE', 0029, 00290001, 002900010000, 0029000100000000, 1, '2019-05-24 21:42:30', 1),
(1916, 0000001916, 'Model / AMP  SPEEKERS', 'Model / AMP  SPEEKERS', 0029, 00290002, 002900020000, 0029000200000000, 1, '2019-05-24 21:42:31', 1),
(1917, 0000001917, 'A4 Papers   STAITIONERY', 'A4 Papers   STAITIONERY', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1918, 0000001918, 'A3 Papers', 'A3 Papers', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1919, 0000001919, 'Ball Point Pen (Blue/Black)', 'Ball Point Pen (Blue/Black)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1920, 0000001920, 'Ball Point Pen (Red)', 'Ball Point Pen (Red)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1921, 0000001921, 'Battery AA', 'Battery AA', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1922, 0000001922, 'Battery AAA', 'Battery AAA', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1923, 0000001923, 'Binding Clips 1 1/4\"', 'Binding Clips 1 1/4\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1924, 0000001924, 'Binding Clips 1\"', 'Binding Clips 1\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1925, 0000001925, 'Binding Clips 1/2\"', 'Binding Clips 1/2\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1926, 0000001926, 'Binding Clips 2\"', 'Binding Clips 2\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1927, 0000001927, 'Binding Clips 3/4\"', 'Binding Clips 3/4\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1928, 0000001928, 'Binding Cover Set', 'Binding Cover Set', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1929, 0000001929, 'Box File 4cm', 'Box File 4cm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1930, 0000001930, 'Box File 6cm', 'Box File 6cm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1931, 0000001931, 'CD-RW', 'CD-RW', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1932, 0000001932, 'Cello Tape 1\"', 'Cello Tape 1\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1933, 0000001933, 'Cello Tape 1/2\"', 'Cello Tape 1/2\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:31', 1),
(1934, 0000001934, 'Cello Tape 2\"', 'Cello Tape 2\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1935, 0000001935, 'Colour Pencil Set', 'Colour Pencil Set', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1936, 0000001936, 'CR Books', 'CR Books', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1937, 0000001937, 'CD-R Without Case', 'CD-R Without Case', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1938, 0000001938, 'DVD', 'DVD', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1939, 0000001939, 'Eraser', 'Eraser', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1940, 0000001940, 'Ex. Books', 'Ex. Books', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1941, 0000001941, 'Field Note Books Spiral Type', 'Field Note Books Spiral Type', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1942, 0000001942, 'Field Note Books', 'Field Note Books', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1943, 0000001943, 'File Fastners-Pkt', 'File Fastners-Pkt', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1944, 0000001944, 'File Lace ', 'File Lace ', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1945, 0000001945, 'Foot Ruler', 'Foot Ruler', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1946, 0000001946, 'Glue Bottle 500 Ml', 'Glue Bottle 500 Ml', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1947, 0000001947, 'Glue Stick', 'Glue Stick', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1948, 0000001948, 'Gum Tape 2\"', 'Gum Tape 2\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1949, 0000001949, 'Highlighter Pens', 'Highlighter Pens', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1950, 0000001950, 'Marker Pens', 'Marker Pens', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1951, 0000001951, 'Masking Tape 1\"', 'Masking Tape 1\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1952, 0000001952, 'Paper Clips', 'Paper Clips', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1953, 0000001953, 'Paper File Cover', 'Paper File Cover', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1954, 0000001954, 'Pencil', 'Pencil', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1955, 0000001955, 'Pencil Cutter', 'Pencil Cutter', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1956, 0000001956, 'Pencil Lead 0.5mm (12pcs)', 'Pencil Lead 0.5mm (12pcs)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1957, 0000001957, 'Pencil Lead 0.7mm ', 'Pencil Lead 0.7mm ', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1958, 0000001958, 'Plastic File Cover', 'Plastic File Cover', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:32', 1),
(1959, 0000001959, 'Plastic File Separators-Colour', 'Plastic File Separators-Colour', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1960, 0000001960, 'Post-It 1\"x2\"', 'Post-It 1\"x2\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1961, 0000001961, 'Post-It 1\"x3\"  (4 Colouurs)', 'Post-It 1\"x3\"  (4 Colouurs)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1962, 0000001962, 'Spiral Binding 15 mm', 'Spiral Binding 15 mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1963, 0000001963, 'Spiral Binding 20 mm', 'Spiral Binding 20 mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1964, 0000001964, 'Spiral Binding 25 mm', 'Spiral Binding 25 mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1965, 0000001965, 'Spiral Binding 6 mm', 'Spiral Binding 6 mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1966, 0000001966, 'Spiral Binding 10 mm', 'Spiral Binding 10 mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1967, 0000001967, 'Stapler Pin 369', 'Stapler Pin 369', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1968, 0000001968, 'Stapler Pin B-10', 'Stapler Pin B-10', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1969, 0000001969, 'Tippex', 'Tippex', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1970, 0000001970, 'Toner 29x', 'Toner 29x', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1971, 0000001971, 'Toner 16A', 'Toner 16A', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1972, 0000001972, 'Mouse', 'Mouse', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1973, 0000001973, 'Multy Socket 13Amp', 'Multy Socket 13Amp', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1974, 0000001974, 'Multy Socket 05Amp', 'Multy Socket 05Amp', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1975, 0000001975, 'Plug Top 13A', 'Plug Top 13A', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1976, 0000001976, 'Copper Rod 16mm    MATERIALS', 'Copper Rod 16mm    MATERIALS', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1977, 0000001977, 'Cotton Gloves (Half Leather)', 'Cotton Gloves (Half Leather)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1978, 0000001978, 'Cotton Gloves (Rubber Dot)', 'Cotton Gloves (Rubber Dot)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1979, 0000001979, 'Cotton Waste', 'Cotton Waste', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1980, 0000001980, 'Cutting Wheel 180mm', 'Cutting Wheel 180mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1981, 0000001981, 'Cutting Wheel 100mm x 1mm', 'Cutting Wheel 100mm x 1mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:33', 1),
(1982, 0000001982, 'Cutting Wheel 100mm x 2mm', 'Cutting Wheel 100mm x 2mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1983, 0000001983, 'Drill Bit 3.3mm ', 'Drill Bit 3.3mm ', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1984, 0000001984, 'Drill Bit 3.5mm', 'Drill Bit 3.5mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1985, 0000001985, 'Drill Bit 4mm', 'Drill Bit 4mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1986, 0000001986, 'Drill Bit 5mm', 'Drill Bit 5mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1987, 0000001987, 'Drill Bit 6mm', 'Drill Bit 6mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1988, 0000001988, 'Dust Mask (Oxypura)', 'Dust Mask (Oxypura)', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1989, 0000001989, 'Extention Cord 13A 4way', 'Extention Cord 13A 4way', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1990, 0000001990, 'Grease 500g', 'Grease 500g', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1991, 0000001991, 'Grinding Wheel 100mm', 'Grinding Wheel 100mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1992, 0000001992, 'Grinding Wheel 180mm', 'Grinding Wheel 180mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1993, 0000001993, 'Hack Saw Blade H/S', 'Hack Saw Blade H/S', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1994, 0000001994, 'Marking Pen \"White\"', 'Marking Pen \"White\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1995, 0000001995, 'Marking Pot', 'Marking Pot', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1996, 0000001996, 'Measuring Tape 3M', 'Measuring Tape 3M', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1997, 0000001997, 'Measuring Tape 5M', 'Measuring Tape 5M', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:34', 1),
(1998, 0000001998, 'Measuring Tape 8M', 'Measuring Tape 8M', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(1999, 0000001999, 'Multi Socket 13Amp', 'Multi Socket 13Amp', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2000, 0000002000, 'Multi Socket 05Amp', 'Multi Socket 05Amp', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2001, 0000002001, 'NT Cutter Blade', 'NT Cutter Blade', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2002, 0000002002, 'Safety Goggle \"Eagle\"', 'Safety Goggle \"Eagle\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2003, 0000002003, 'Shoe Guard', 'Shoe Guard', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2004, 0000002004, 'Silicon Gray', 'Silicon Gray', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2005, 0000002005, 'Sprit Level 600mm \"Stanly\"', 'Sprit Level 600mm \"Stanly\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2006, 0000002006, 'Sprit Level 300mm \"Stanly\"', 'Sprit Level 300mm \"Stanly\"', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2007, 0000002007, 'Thnner 4lt', 'Thnner 4lt', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2008, 0000002008, 'Welding Apron', 'Welding Apron', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2009, 0000002009, 'Welding Glass - Black', 'Welding Glass - Black', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2010, 0000002010, 'Welding Glass - White', 'Welding Glass - White', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2011, 0000002011, 'Welding Glouves', 'Welding Glouves', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1);
INSERT INTO `products` (`products_table_id`, `product_code`, `product_name`, `product_description`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `product_location_id`, `saved_datetime`, `saved_user`) VALUES
(2012, 0000002012, 'Wleding Head Shield', 'Wleding Head Shield', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2013, 0000002013, 'Wleding Hand Shield', 'Wleding Hand Shield', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2014, 0000002014, 'Weding Holder 300A', 'Weding Holder 300A', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2015, 0000002015, 'Weding Holder 500A', 'Weding Holder 500A', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2016, 0000002016, 'Welding Rod E-6013 MT12 2.5mm', 'Welding Rod E-6013 MT12 2.5mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:35', 1),
(2017, 0000002017, 'Welding Rod E-6013 MT12 3.2mm', 'Welding Rod E-6013 MT12 3.2mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2018, 0000002018, 'Welding Rod E-7016  2.5mm', 'Welding Rod E-7016  2.5mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2019, 0000002019, 'Welding Rod E-7016  3.2mm', 'Welding Rod E-7016  3.2mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2020, 0000002020, 'Welding Rod E-7016  4.0mm', 'Welding Rod E-7016  4.0mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2021, 0000002021, 'Welding Rod S.S 2.5mm', 'Welding Rod S.S 2.5mm', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2022, 0000002022, 'ZRC Paint 6LB', 'ZRC Paint 6LB', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2023, 0000002023, 'Cutter Nozzel', 'Cutter Nozzel', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2024, 0000002024, 'Band Saw Blades -650HD-HS38x5040x4', 'Band Saw Blades -650HD-HS38x5040x4', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2025, 0000002025, 'Asada - 70110', 'Asada - 70110', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2026, 0000002026, 'Asada - 70114', 'Asada - 70114', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2027, 0000002027, 'TFD Corners 1.2MM', 'TFD Corners 1.2MM', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2028, 0000002028, 'TFD Corners 1.5MM ', 'TFD Corners 1.5MM ', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2029, 0000002029, 'Volume Damper Handle-Short', 'Volume Damper Handle-Short', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2030, 0000002030, 'Volume Damper Handle-Long', 'Volume Damper Handle-Long', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1),
(2031, 0000002031, 'Volume Damper Bush', 'Volume Damper Bush', 0030, 00300000, 003000000000, 0030000000000000, 1, '2019-05-24 21:42:36', 1);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `projects_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_code` varchar(255) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `project_description` text NOT NULL,
  `location_id` int(11) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`projects_table_id`),
  KEY `project_code` (`project_code`),
  KEY `saved_user` (`saved_user`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`projects_table_id`, `project_code`, `project_name`, `project_description`, `location_id`, `saved_datetime`, `saved_user`) VALUES
(1, 'ERR01', 'wattala', 'Wattala', 5, '2019-06-04 06:01:45', 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchaseorders`
--

DROP TABLE IF EXISTS `purchaseorders`;
CREATE TABLE IF NOT EXISTS `purchaseorders` (
  `purchaseorders_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseorder_no` varchar(255) NOT NULL,
  `materialrequest_code` varchar(255) NOT NULL,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `supplier_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `delivery_location_id` int(11) NOT NULL,
  `po_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `po_status` varchar(255) NOT NULL,
  `poitem_status` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`purchaseorders_table_id`),
  KEY `delivery_location_id` (`delivery_location_id`),
  KEY `materialrequest_code` (`materialrequest_code`),
  KEY `saved_user` (`saved_user`),
  KEY `product_code` (`product_code`),
  KEY `supplier_code` (`supplier_code`),
  KEY `purchaseorder_no` (`purchaseorder_no`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchaseorders`
--

INSERT INTO `purchaseorders` (`purchaseorders_table_id`, `purchaseorder_no`, `materialrequest_code`, `product_code`, `quantity`, `supplier_code`, `delivery_location_id`, `po_date`, `delivery_date`, `po_status`, `poitem_status`, `saved_datetime`, `saved_user`) VALUES
(21, '', 'MR009999', 0000000780, '2.00', 0000000001, 1, '2019-06-22', '2019-06-21', 'Pending', 'Pending', '2019-06-06 16:22:56', 1),
(22, 'p00011', 'MR009999', 0000000642, '5.00', 0000000001, 1, '2019-06-13', '2019-06-29', 'Saved', 'Pending', '2019-06-06 16:22:56', 1),
(23, '', 'MR009999', 0000001244, '0.00', 0000000001, 1, '2019-06-22', '2019-06-21', 'Pending', 'Pending', '2019-06-10 04:25:13', 1),
(24, 'p0001', 'MR009999', 0000001733, '5.00', 0000000001, 1, '2019-06-07', '2019-06-20', 'Saved', 'Pending', '2019-06-10 04:25:13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE IF NOT EXISTS `reports` (
  `reports_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `report` varchar(255) NOT NULL,
  PRIMARY KEY (`reports_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`reports_table_id`, `report`) VALUES
(1, 'Products Report'),
(2, 'Location Wise Stock Report'),
(3, 'Purchase Orders Report'),
(4, 'Good Received Notes Report'),
(5, 'Pending Purchase Orders Report');

-- --------------------------------------------------------

--
-- Table structure for table `sitetransfers`
--

DROP TABLE IF EXISTS `sitetransfers`;
CREATE TABLE IF NOT EXISTS `sitetransfers` (
  `sitetransfers_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `materialrequest_code` varchar(255) NOT NULL,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_code` int(8) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_2_code` bigint(12) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_3_code` bigint(16) UNSIGNED ZEROFILL NOT NULL,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `requested_quantity` decimal(10,2) NOT NULL,
  `transferred_quantity` decimal(10,2) NOT NULL,
  `requested_location` int(11) NOT NULL,
  `destination_location` int(11) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`sitetransfers_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
CREATE TABLE IF NOT EXISTS `stocks` (
  `stocks_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `quantity_type` varchar(255) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`stocks_table_id`),
  KEY `location_id` (`location_id`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`stocks_table_id`, `product_code`, `quantity`, `quantity_type`, `location_id`) VALUES
(1, 0000000001, '0.00', 'Nos', 4),
(2, 0000000002, '0.00', 'Nos', 4),
(3, 0000000003, '10.00', 'Nos', 4),
(4, 0000000004, '30.00', 'Nos', 4),
(5, 0000000005, '18.00', 'Nos', 4),
(6, 0000000006, '2.00', 'Nos', 4),
(7, 0000000007, '100.00', 'Nos', 4),
(8, 0000000008, '116.00', 'Nos', 4),
(9, 0000000009, '0.00', 'Nos', 4),
(10, 0000000010, '0.00', 'Nos', 4),
(11, 0000000011, '133.00', 'Nos', 4),
(12, 0000000012, '152.00', 'Nos', 4),
(13, 0000000013, '0.00', 'Nos', 4),
(14, 0000000014, '15.00', 'Nos', 4),
(15, 0000000015, '1.00', 'Nos', 4),
(16, 0000000016, '19.00', 'Nos', 4),
(17, 0000000017, '235.00', 'Nos', 4),
(18, 0000000018, '45.00', 'Nos', 4),
(19, 0000000019, '2.00', 'Nos', 4),
(20, 0000000020, '1.00', 'Nos', 4),
(21, 0000000021, '0.00', 'Nos', 4),
(22, 0000000022, '18.00', 'Nos', 4),
(23, 0000000023, '13.00', 'Nos', 4),
(24, 0000000024, '39.00', 'Nos', 4),
(25, 0000000025, '119.00', 'Nos', 6),
(26, 0000000026, '70.00', 'Nos', 4),
(27, 0000000027, '94.00', 'Nos', 2),
(28, 0000000028, '59.00', 'Nos', 2),
(29, 0000000029, '44.00', 'Nos', 2),
(30, 0000000030, '50.00', 'Nos', 2),
(31, 0000000031, '0.00', 'Nos', 2),
(32, 0000000032, '105.00', 'Nos', 2),
(33, 0000000033, '5.00', 'Nos', 2),
(34, 0000000034, '10.00', 'Nos', 2),
(35, 0000000035, '0.00', 'Nos', 2),
(36, 0000000036, '3.00', 'Nos', 2),
(37, 0000000037, '0.00', 'Nos', 2),
(38, 0000000038, '2.00', 'Nos', 2),
(39, 0000000039, '1.00', 'Nos', 2),
(40, 0000000040, '3.00', 'Nos', 2),
(41, 0000000041, '53.00', 'Nos', 3);

-- --------------------------------------------------------

--
-- Table structure for table `subcategories_1`
--

DROP TABLE IF EXISTS `subcategories_1`;
CREATE TABLE IF NOT EXISTS `subcategories_1` (
  `subcategories_1_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_code` int(8) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_name` varchar(255) NOT NULL,
  `subcategory_1_description` text NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`subcategories_1_table_id`),
  KEY `category_code` (`category_code`),
  KEY `saved_user` (`saved_user`),
  KEY `subcategory_1_code` (`subcategory_1_code`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subcategories_1`
--

INSERT INTO `subcategories_1` (`subcategories_1_table_id`, `category_code`, `subcategory_1_code`, `subcategory_1_name`, `subcategory_1_description`, `saved_datetime`, `saved_user`) VALUES
(1, 0001, 00010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(2, 0002, 00020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(3, 0003, 00030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(4, 0004, 00040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(5, 0005, 00050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(6, 0006, 00060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(7, 0007, 00070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(8, 0008, 00080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(9, 0009, 00090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(10, 0010, 00100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(11, 0011, 00110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(12, 0012, 00120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(13, 0013, 00130000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(14, 0014, 00140000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(15, 0015, 00150000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(16, 0016, 00160000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(17, 0017, 00170000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(18, 0018, 00180000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(19, 0019, 00190000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(20, 0020, 00200000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(21, 0021, 00210000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(22, 0022, 00220000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(23, 0023, 00230000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(24, 0024, 00240000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(25, 0025, 00250000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(26, 0026, 00260000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(27, 0027, 00270000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(28, 0028, 00280000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(29, 0029, 00290000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(30, 0030, 00300000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(31, 0031, 00310000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(32, 0001, 00010001, 'PVC TEE', 'PVC TEE', '2019-05-23 18:05:27', 1),
(33, 0001, 00010002, 'PVC ELBOW 90\'', 'PVC ELBOW 90\'', '2019-05-23 18:05:27', 1),
(34, 0001, 00010003, 'PVC ELBOW 45\'', 'PVC ELBOW 45\'', '2019-05-23 18:05:28', 1),
(35, 0001, 00010004, 'PVC REDUCER', 'PVC REDUCER', '2019-05-23 18:05:28', 1),
(36, 0001, 00010005, 'PVC SOCKET', 'PVC SOCKET', '2019-05-23 18:05:28', 1),
(37, 0001, 00010006, 'PVC Y-JOINT', 'PVC Y-JOINT', '2019-05-23 18:05:28', 1),
(38, 0001, 00010007, 'PVC SWEEP TEE', 'PVC SWEEP TEE', '2019-05-23 18:05:28', 1),
(39, 0001, 00010008, 'PVC VALVE SOCKET', 'PVC VALVE SOCKET', '2019-05-23 18:05:28', 1),
(40, 0001, 00010009, 'PVC FAUCET SOCKET', 'PVC FAUCET SOCKET', '2019-05-23 18:05:28', 1),
(41, 0001, 00010010, 'PVC END CAP', 'PVC END CAP', '2019-05-23 18:05:28', 1),
(42, 0001, 00010011, 'PVC CLEANOUT', 'PVC CLEANOUT', '2019-05-23 18:05:29', 1),
(43, 0001, 00010012, 'PVC UNION', 'PVC UNION', '2019-05-23 18:05:29', 1),
(44, 0001, 00010013, 'PVC FLANGE', 'PVC FLANGE', '2019-05-23 18:05:29', 1),
(45, 0001, 00010014, 'PVC TEST PLUG', 'PVC TEST PLUG', '2019-05-23 18:05:29', 1),
(46, 0001, 00010015, 'PVC REDUCING BUSH', 'PVC REDUCING BUSH', '2019-05-23 18:05:29', 1),
(47, 0001, 00010016, 'PVC CLAMP SADDLE', 'PVC CLAMP SADDLE', '2019-05-23 18:05:29', 1),
(48, 0001, 00010017, 'PVC PIPE', 'PVC PIPE', '2019-05-23 18:05:29', 1),
(49, 0002, 00020001, 'GI TEE WELD TYPE', 'GI TEE WELD TYPE', '2019-05-23 18:05:29', 1),
(50, 0002, 00020002, 'GI REDUCER WELD TYPE', 'GI REDUCER WELD TYPE', '2019-05-23 18:05:30', 1),
(51, 0002, 00020003, 'GI ELBOW 90\' WELD TYPE', 'GI ELBOW 90\' WELD TYPE', '2019-05-23 18:05:30', 1),
(52, 0002, 00020004, 'GI ELBOW 45\' WELD TYPE', 'GI ELBOW 45\' WELD TYPE', '2019-05-23 18:05:30', 1),
(53, 0002, 00020005, 'GI SOCKET WELD TYPE', 'GI SOCKET WELD TYPE', '2019-05-23 18:05:30', 1),
(54, 0002, 00020006, 'GI END CAP WELD TYPE', 'GI END CAP WELD TYPE', '2019-05-23 18:05:30', 1),
(55, 0002, 00020007, 'GI BLIND FLANGE', 'GI BLIND FLANGE', '2019-05-23 18:05:30', 1),
(56, 0002, 00020008, 'GI FLANGE WELD TYPE', 'GI FLANGE WELD TYPE', '2019-05-23 18:05:30', 1),
(57, 0002, 00020009, 'GI PIPE', 'GI PIPE', '2019-05-23 18:05:30', 1),
(58, 0003, 00030001, 'GI TEE THREAD TYPE', 'GI TEE THREAD TYPE', '2019-05-23 18:05:30', 1),
(59, 0003, 00030002, 'GI ELBOW 90\' THREAD TYPE', 'GI ELBOW 90\' THREAD TYPE', '2019-05-23 18:05:30', 1),
(60, 0003, 00030003, 'GI ELBOW 45\' THREAD TYPE', 'GI ELBOW 45\' THREAD TYPE', '2019-05-23 18:05:30', 1),
(61, 0003, 00030004, 'GI REDUCER THREAD TYPE', 'GI REDUCER THREAD TYPE', '2019-05-23 18:05:31', 1),
(62, 0003, 00030005, 'GI UNION', 'GI UNION', '2019-05-23 18:05:31', 1),
(63, 0003, 00030006, 'GI SOCKET THREAD TYPE ', 'GI SOCKET THREAD TYPE ', '2019-05-23 18:05:31', 1),
(64, 0003, 00030007, 'GI REDUCING BUSH', 'GI REDUCING BUSH', '2019-05-23 18:05:31', 1),
(65, 0003, 00030008, 'GI PLUG', 'GI PLUG', '2019-05-23 18:05:31', 1),
(66, 0003, 00030009, 'GI NIPPLE', 'GI NIPPLE', '2019-05-23 18:05:31', 1),
(67, 0003, 00030010, 'GI END CAP THREAD TYPE', 'GI END CAP THREAD TYPE', '2019-05-23 18:05:31', 1),
(68, 0004, 00040001, 'BI TEE WELD TYPE', 'BI TEE WELD TYPE', '2019-05-23 18:05:31', 1),
(69, 0004, 00040002, 'BI REDUCER WELD TYPE', 'BI REDUCER WELD TYPE', '2019-05-23 18:05:31', 1),
(70, 0004, 00040003, 'BI ELBOW 90\' WELD TYPE', 'BI ELBOW 90\' WELD TYPE', '2019-05-23 18:05:31', 1),
(71, 0004, 00040004, 'BI ELBOW 45\' WELD TYPE', 'BI ELBOW 45\' WELD TYPE', '2019-05-23 18:05:31', 1),
(72, 0004, 00040005, 'BI SOCKET WELD TYPE', 'BI SOCKET WELD TYPE', '2019-05-23 18:05:31', 1),
(73, 0004, 00040006, 'BI END CAP WELD TYPE', 'BI END CAP WELD TYPE', '2019-05-23 18:05:32', 1),
(74, 0004, 00040007, 'BI BLIND FLANGE', 'BI BLIND FLANGE', '2019-05-23 18:05:32', 1),
(75, 0004, 00040008, 'BI FLANGE WELD TYPE', 'BI FLANGE WELD TYPE', '2019-05-23 18:05:32', 1),
(76, 0004, 00040009, 'BI PIPE', 'BI PIPE', '2019-05-23 18:05:32', 1),
(77, 0005, 00050001, 'BI TEE THREAD TYPE', 'BI TEE THREAD TYPE', '2019-05-23 18:05:32', 1),
(78, 0005, 00050002, 'BI ELBOW 90\' THREAD TYPE', 'BI ELBOW 90\' THREAD TYPE', '2019-05-23 18:05:32', 1),
(79, 0005, 00050003, 'BI ELBOW 45\' THREAD TYPE', 'BI ELBOW 45\' THREAD TYPE', '2019-05-23 18:05:32', 1),
(80, 0005, 00050004, 'BI REDUCER THREAD TYPE', 'BI REDUCER THREAD TYPE', '2019-05-23 18:05:32', 1),
(81, 0005, 00050005, 'BI UNION', 'BI UNION', '2019-05-23 18:05:32', 1),
(82, 0005, 00050006, 'BI SOCKET THREAD TYPE ', 'BI SOCKET THREAD TYPE ', '2019-05-23 18:05:32', 1),
(83, 0005, 00050007, 'BI REDUCING BUSH', 'BI REDUCING BUSH', '2019-05-23 18:05:32', 1),
(84, 0005, 00050008, 'BI PLUG', 'BI PLUG', '2019-05-23 18:05:32', 1),
(85, 0005, 00050009, 'BI NIPPLE', 'BI NIPPLE', '2019-05-23 18:05:33', 1),
(86, 0005, 00050010, 'BI END CAP THREAD TYPE', 'BI END CAP THREAD TYPE', '2019-05-23 18:05:33', 1),
(87, 0006, 00060001, 'PPR ELBOW 90\'', 'PPR ELBOW 90\'', '2019-05-23 18:05:33', 1),
(88, 0006, 00060002, 'PPR ELBOW 45\'', 'PPR ELBOW 45\'', '2019-05-23 18:05:33', 1),
(89, 0006, 00060003, 'PPR SOCKET', 'PPR SOCKET', '2019-05-23 18:05:33', 1),
(90, 0006, 00060004, 'PPR TEE', 'PPR TEE', '2019-05-23 18:05:33', 1),
(91, 0006, 00060005, 'PPR REDUCER', 'PPR REDUCER', '2019-05-23 18:05:33', 1),
(92, 0006, 00060006, 'PPR FLANGE ADAPTOR', 'PPR FLANGE ADAPTOR', '2019-05-23 18:05:33', 1),
(93, 0006, 00060007, 'PPR MALE ADAPTOR', 'PPR MALE ADAPTOR', '2019-05-23 18:05:33', 1),
(94, 0006, 00060008, 'PPR FEMALE ADAPTOR', 'PPR FEMALE ADAPTOR', '2019-05-23 18:05:33', 1),
(95, 0006, 00060009, 'PPR END CAP', 'PPR END CAP', '2019-05-23 18:05:33', 1),
(96, 0006, 00060010, 'PPR UNION', 'PPR UNION', '2019-05-23 18:05:34', 1),
(97, 0006, 00060011, 'PPR SADDLE', 'PPR SADDLE', '2019-05-23 18:05:34', 1),
(98, 0006, 00060012, 'PPR PIPE', 'PPR PIPE', '2019-05-23 18:05:34', 1),
(99, 0007, 00070001, 'Y-JUNTION', 'Y-JUNTION', '2019-05-23 18:05:34', 1),
(100, 0007, 00070002, 'TEE', 'TEE', '2019-05-23 18:05:34', 1),
(101, 0007, 00070003, 'CLEAN OUT', 'CLEAN OUT', '2019-05-23 18:05:34', 1),
(102, 0007, 00070004, 'ELBOW 45\'', 'ELBOW 45\'', '2019-05-23 18:05:34', 1),
(103, 0007, 00070005, 'ELBOW 67\'', 'ELBOW 67\'', '2019-05-23 18:05:34', 1),
(104, 0007, 00070006, 'ELBOW 87\'', 'ELBOW 87\'', '2019-05-23 18:05:34', 1),
(105, 0007, 00070007, 'FLOOR TRAP', 'FLOOR TRAP', '2019-05-23 18:05:34', 1),
(106, 0007, 00070008, 'SOCKET', 'SOCKET', '2019-05-23 18:05:34', 1),
(107, 0007, 00070009, 'REDUCER', 'REDUCER', '2019-05-23 18:05:34', 1),
(108, 0007, 00070010, 'ACCESS QUADRATE', 'ACCESS QUADRATE', '2019-05-23 18:05:35', 1),
(109, 0007, 00070011, 'END CAP', 'END CAP', '2019-05-23 18:05:35', 1),
(110, 0007, 00070012, 'PIPE', 'PIPE', '2019-05-23 18:05:35', 1),
(111, 0008, 00080001, 'TEE BUTT WELD', 'TEE BUTT WELD', '2019-05-23 18:05:35', 1),
(112, 0008, 00080002, 'TEE ELECTRO FUSTION', 'TEE ELECTRO FUSTION', '2019-05-23 18:05:35', 1),
(113, 0008, 00080003, 'ELBOW 90\' BUTT WELD', 'ELBOW 90\' BUTT WELD', '2019-05-23 18:05:35', 1),
(114, 0008, 00080004, 'ELBOW 90\' ELECTRO FUSTION', 'ELBOW 90\' ELECTRO FUSTION', '2019-05-23 18:05:35', 1),
(115, 0008, 00080005, 'ELBOW 45\' BUTT WELD', 'ELBOW 45\' BUTT WELD', '2019-05-23 18:05:35', 1),
(116, 0008, 00080006, 'ELBOW 45\' ELECTRO FUSTION', 'ELBOW 45\' ELECTRO FUSTION', '2019-05-23 18:05:35', 1),
(117, 0008, 00080007, 'REDUCER  BUTT WELD', 'REDUCER  BUTT WELD', '2019-05-23 18:05:35', 1),
(118, 0008, 00080008, 'REDUCER ELECTRO FUSTION', 'REDUCER ELECTRO FUSTION', '2019-05-23 18:05:35', 1),
(119, 0008, 00080009, 'SOCKET ELECTRO FUSTION', 'SOCKET ELECTRO FUSTION', '2019-05-23 18:05:35', 1),
(120, 0008, 00080010, 'FLANGE ADEPTOR', 'FLANGE ADEPTOR', '2019-05-23 18:05:36', 1),
(121, 0008, 00080011, 'FLANGE  ', 'FLANGE  ', '2019-05-23 18:05:36', 1),
(122, 0008, 00080012, 'PIPE', 'PIPE', '2019-05-23 18:05:36', 1),
(123, 0009, 00090001, 'COPPER PIPE', 'COPPER PIPE', '2019-05-23 18:05:36', 1),
(124, 0009, 00090002, 'COPPER ELBOW 90\'', 'COPPER ELBOW 90\'', '2019-05-23 18:05:36', 1),
(125, 0009, 00090003, 'COPPER ELBOW 45\'', 'COPPER ELBOW 45\'', '2019-05-23 18:05:36', 1),
(126, 0009, 00090004, 'COPPER SOCKET', 'COPPER SOCKET', '2019-05-23 18:05:36', 1),
(127, 0009, 00090005, 'COPPER REDUCER', 'COPPER REDUCER', '2019-05-23 18:05:36', 1),
(128, 0009, 00090006, 'COPPER TEE', 'COPPER TEE', '2019-05-23 18:05:36', 1),
(129, 0009, 00090007, 'COPPER MALE ADAPTOR', 'COPPER MALE ADAPTOR', '2019-05-23 18:05:36', 1),
(130, 0009, 00090008, 'COPPER FEMALE ADAPTOR', 'COPPER FEMALE ADAPTOR', '2019-05-23 18:05:36', 1),
(131, 0010, 00100001, 'CONDUITE PIPE', 'CONDUITE PIPE', '2019-05-23 18:05:37', 1),
(132, 0010, 00100002, 'JUNCTION BOX', 'JUNCTION BOX', '2019-05-23 18:05:37', 1),
(133, 0010, 00100003, 'BEND', 'BEND', '2019-05-23 18:05:37', 1),
(134, 0010, 00100004, 'INSPECTION BEND', 'INSPECTION BEND', '2019-05-23 18:05:37', 1),
(135, 0010, 00100005, 'SADDLE', 'SADDLE', '2019-05-23 18:05:37', 1),
(136, 0010, 00100006, 'COUPLING', 'COUPLING', '2019-05-23 18:05:37', 1),
(137, 0011, 00110001, 'CONDUITE PIPE', 'CONDUITE PIPE', '2019-05-23 18:05:37', 1),
(138, 0011, 00110002, 'JUNCTION BOX', 'JUNCTION BOX', '2019-05-23 18:05:37', 1),
(139, 0011, 00110003, 'BEND', 'BEND', '2019-05-23 18:05:37', 1),
(140, 0011, 00110004, 'INSPECTION BEND', 'INSPECTION BEND', '2019-05-23 18:05:37', 1),
(141, 0011, 00110005, 'SADDLE', 'SADDLE', '2019-05-23 18:05:37', 1),
(142, 0011, 00110006, 'COUPLING', 'COUPLING', '2019-05-23 18:05:38', 1),
(143, 0011, 00110007, 'BOX CONNECTOR', 'BOX CONNECTOR', '2019-05-23 18:05:38', 1),
(144, 0011, 00110008, 'FLEXIBLE CONNECTOR', 'FLEXIBLE CONNECTOR', '2019-05-23 18:05:38', 1),
(145, 0011, 00110009, 'SWITCH BOX', 'SWITCH BOX', '2019-05-23 18:05:38', 1),
(146, 0012, 00120001, 'COUPLING', 'COUPLING', '2019-05-23 18:05:38', 1),
(147, 0012, 00120002, 'SADDLE', 'SADDLE', '2019-05-23 18:05:38', 1),
(148, 0013, 00130001, 'PIPE', 'PIPE', '2019-05-23 18:05:38', 1),
(149, 0013, 00130002, 'SOCKET', 'SOCKET', '2019-05-23 18:05:38', 1),
(150, 0013, 00130003, 'ELBOW', 'ELBOW', '2019-05-23 18:05:38', 1),
(151, 0013, 00130004, 'TEE', 'TEE', '2019-05-23 18:05:38', 1),
(152, 0013, 00130005, 'REDUCER', 'REDUCER', '2019-05-23 18:05:38', 1),
(153, 0014, 00140001, 'GATE VALVE FLANGE TYPE', 'GATE VALVE FLANGE TYPE', '2019-05-23 18:05:39', 1),
(154, 0014, 00140002, 'GATE VALVE THREAD TYPE', 'GATE VALVE THREAD TYPE', '2019-05-23 18:05:39', 1),
(155, 0014, 00140003, 'GLOBE VALVE THREAD TYPE', 'GLOBE VALVE THREAD TYPE', '2019-05-23 18:05:39', 1),
(156, 0014, 00140004, 'Y-STRAINER THREAD TYPE', 'Y-STRAINER THREAD TYPE', '2019-05-23 18:05:39', 1),
(157, 0014, 00140005, 'Y-STRAINER FLANGE  TYPE', 'Y-STRAINER FLANGE  TYPE', '2019-05-23 18:05:39', 1),
(158, 0014, 00140006, 'COCK VALVE', 'COCK VALVE', '2019-05-23 18:05:39', 1),
(159, 0014, 00140007, 'BUTTERFLY VALVE', 'BUTTERFLY VALVE', '2019-05-23 18:05:39', 1),
(160, 0014, 00140008, 'FLEXIBLE JOINT', 'FLEXIBLE JOINT', '2019-05-23 18:05:39', 1),
(161, 0014, 00140009, 'CHECK VALVE THRAD TYPE', 'CHECK VALVE THRAD TYPE', '2019-05-23 18:05:39', 1),
(162, 0014, 00140010, 'CHECK VALVE FLANGE  TYPE', 'CHECK VALVE FLANGE  TYPE', '2019-05-23 18:05:39', 1),
(163, 0015, 00150001, 'CABLE TRAY', 'CABLE TRAY', '2019-05-23 18:05:39', 1),
(164, 0015, 00150002, 'CABLE LADDER', 'CABLE LADDER', '2019-05-23 18:05:39', 1),
(165, 0015, 00150003, 'TEE', 'TEE', '2019-05-23 18:05:40', 1),
(166, 0015, 00150004, 'BEND', 'BEND', '2019-05-23 18:05:40', 1),
(167, 0015, 00150005, 'RISER', 'RISER', '2019-05-23 18:05:40', 1),
(168, 0016, 00160001, 'WATER CLOSET', 'WATER CLOSET', '2019-05-23 18:05:40', 1),
(169, 0016, 00160002, 'WASH BASIN', 'WASH BASIN', '2019-05-23 18:05:40', 1),
(170, 0016, 00160003, 'URINAL', 'URINAL', '2019-05-23 18:05:40', 1),
(171, 0016, 00160004, 'MIRROR', 'MIRROR', '2019-05-23 18:05:41', 1),
(172, 0016, 00160005, 'SOAP HOLDER', 'SOAP HOLDER', '2019-05-23 18:05:41', 1),
(173, 0016, 00160006, 'PAPER HOLDER', 'PAPER HOLDER', '2019-05-23 18:05:41', 1),
(174, 0016, 00160007, 'BIDDET SHOWER', 'BIDDET SHOWER', '2019-05-23 18:05:41', 1),
(175, 0016, 00160008, 'TOWEL BAR', 'TOWEL BAR', '2019-05-23 18:05:41', 1),
(176, 0016, 00160009, 'BOTTLE TRAP', 'BOTTLE TRAP', '2019-05-23 18:05:41', 1),
(177, 0016, 00160010, 'P TRAP', 'P TRAP', '2019-05-23 18:05:41', 1),
(178, 0016, 00160011, 'ROBE HOOK', 'ROBE HOOK', '2019-05-23 18:05:41', 1),
(179, 0016, 00160012, 'SOAP DISPENSER', 'SOAP DISPENSER', '2019-05-23 18:05:41', 1),
(180, 0016, 00160013, 'ANGLE VALVE', 'ANGLE VALVE', '2019-05-23 18:05:41', 1),
(181, 0016, 00160014, 'FLEXIBLE HOSE', 'FLEXIBLE HOSE', '2019-05-23 18:05:42', 1),
(182, 0017, 00170001, 'INSULATON TUBE', 'INSULATON TUBE', '2019-05-23 18:05:42', 1),
(183, 0017, 00170002, 'INSULATION SHEET', 'INSULATION SHEET', '2019-05-23 18:05:42', 1),
(184, 0017, 00170003, 'ARMOSOUND SHEET', 'ARMOSOUND SHEET', '2019-05-23 18:05:42', 1),
(185, 0017, 00170004, 'GLASSWOOL BOARD', 'GLASSWOOL BOARD', '2019-05-23 18:05:42', 1),
(186, 0017, 00170005, 'GLASSWOOL ROLL', 'GLASSWOOL ROLL', '2019-05-23 18:05:42', 1),
(187, 0017, 00170006, 'ROCKWOOL', 'ROCKWOOL', '2019-05-23 18:05:42', 1),
(188, 0017, 00170007, 'DUCT PIN', 'DUCT PIN', '2019-05-23 18:05:42', 1),
(189, 0018, 00180001, 'GI NUT', 'GI NUT', '2019-05-23 18:05:42', 1),
(190, 0018, 00180002, 'GI BOLT', 'GI BOLT', '2019-05-23 18:05:43', 1),
(191, 0018, 00180003, 'GI WASHER', 'GI WASHER', '2019-05-23 18:05:43', 1),
(192, 0018, 00180004, 'GI BOLT & NUT', 'GI BOLT & NUT', '2019-05-23 18:05:43', 1),
(193, 0019, 00190001, 'ANCHOR BOLT', 'ANCHOR BOLT', '2019-05-23 18:05:43', 1),
(194, 0019, 00190002, 'AY BOLT', 'AY BOLT', '2019-05-23 18:05:43', 1),
(195, 0019, 00190003, 'THREAD BAR', 'THREAD BAR', '2019-05-23 18:05:43', 1),
(196, 0019, 00190004, 'INSERT', 'INSERT', '2019-05-23 18:05:43', 1),
(197, 0019, 00190005, 'CUTTING WHEEL', 'CUTTING WHEEL', '2019-05-23 18:05:43', 1),
(198, 0019, 00190006, 'GRINDING WHEEL', 'GRINDING WHEEL', '2019-05-23 18:05:43', 1),
(199, 0019, 00190007, 'DIAMOND WHEEL', 'DIAMOND WHEEL', '2019-05-23 18:05:43', 1),
(200, 0019, 00190008, 'RAWL PLUG', 'RAWL PLUG', '2019-05-23 18:05:44', 1),
(201, 0019, 00190009, 'BRASS SCREWS', 'BRASS SCREWS', '2019-05-23 18:05:44', 1),
(202, 0019, 00190010, 'TAPPING SCREWS', 'TAPPING SCREWS', '2019-05-23 18:05:44', 1),
(203, 0019, 00190011, 'WELDING ROD', 'WELDING ROD', '2019-05-23 18:05:44', 1),
(204, 0019, 00190012, 'THINNER', 'THINNER', '2019-05-23 18:05:44', 1),
(205, 0019, 00190013, 'ANGLE IRON', 'ANGLE IRON', '2019-05-23 18:05:44', 1),
(206, 0019, 00190014, 'C-CHANNEL', 'C-CHANNEL', '2019-05-23 18:05:44', 1),
(207, 0019, 00190015, 'GI SHEET', 'GI SHEET', '2019-05-23 18:05:44', 1),
(208, 0019, 00190016, 'M.S SHEET', 'M.S SHEET', '2019-05-23 18:05:44', 1),
(209, 0019, 00190017, 'HACKSAW BLADE', 'HACKSAW BLADE', '2019-05-23 18:05:45', 1),
(210, 0019, 00190018, 'NT CUTTER BLADE', 'NT CUTTER BLADE', '2019-05-23 18:05:45', 1),
(211, 0019, 00190019, 'THREAD SEAL', 'THREAD SEAL', '2019-05-23 18:05:45', 1),
(212, 0019, 00190020, 'HANGER BAND', 'HANGER BAND', '2019-05-23 18:05:45', 1),
(213, 0019, 00190021, 'U-BOLT', 'U-BOLT', '2019-05-23 18:05:45', 1),
(214, 0020, 00200001, 'O - LUG', 'O - LUG', '2019-05-23 18:05:45', 1),
(215, 0020, 00200002, 'U - LUG', 'U - LUG', '2019-05-23 18:05:45', 1),
(216, 0020, 00200003, 'I - LUG', 'I - LUG', '2019-05-23 18:05:45', 1),
(217, 0020, 00200004, 'FERRULS', 'FERRULS', '2019-05-23 18:05:45', 1),
(218, 0020, 00200005, 'CABLE GLAND', 'CABLE GLAND', '2019-05-23 18:05:45', 1),
(219, 0020, 00200006, 'GROMMET', 'GROMMET', '2019-05-23 18:05:46', 1),
(220, 0020, 00200007, 'HEET SLEEVE', 'HEET SLEEVE', '2019-05-23 18:05:46', 1),
(221, 0020, 00200008, 'MARKER TUBE', 'MARKER TUBE', '2019-05-23 18:05:46', 1),
(222, 0020, 00200009, 'CABLE TIE', 'CABLE TIE', '2019-05-23 18:05:46', 1),
(223, 0020, 00200010, 'TAPE', 'TAPE', '2019-05-23 18:05:46', 1),
(224, 0021, 00210001, 'SWITCH', 'SWITCH', '2019-05-23 18:05:46', 1),
(225, 0021, 00210002, 'SOCKET OUTLET', 'SOCKET OUTLET', '2019-05-23 18:05:46', 1),
(226, 0021, 00210003, 'PLUG TOP', 'PLUG TOP', '2019-05-23 18:05:46', 1),
(227, 0021, 00210004, 'INDUSTRIAL SOCKET', 'INDUSTRIAL SOCKET', '2019-05-23 18:05:46', 1),
(228, 0021, 00210005, 'MCB ', 'MCB ', '2019-05-23 18:05:46', 1),
(229, 0021, 00210006, 'MCCB', 'MCCB', '2019-05-23 18:05:46', 1),
(230, 0021, 00210007, 'RCCB', 'RCCB', '2019-05-23 18:05:46', 1),
(231, 0022, 00220001, 'CEILING DIFFUCER', 'CEILING DIFFUCER', '2019-05-23 18:05:47', 1),
(232, 0022, 00220002, 'SUPPLY GRILLS', 'SUPPLY GRILLS', '2019-05-23 18:05:47', 1),
(233, 0022, 00220003, 'RUTURN GRILLS', 'RUTURN GRILLS', '2019-05-23 18:05:47', 1),
(234, 0022, 00220004, 'LINEAR SLOTS  DIFFUCERS', 'LINEAR SLOTS  DIFFUCERS', '2019-05-23 18:05:47', 1),
(235, 0023, 00230001, 'CEILING FAN', 'CEILING FAN', '2019-05-23 18:05:47', 1),
(236, 0023, 00230002, 'EXHOUST FAN', 'EXHOUST FAN', '2019-05-23 18:05:47', 1),
(237, 0023, 00230003, 'VENTILATION FAN', 'VENTILATION FAN', '2019-05-23 18:05:47', 1),
(238, 0023, 00230004, 'DUCT FAN', 'DUCT FAN', '2019-05-23 18:05:47', 1),
(239, 0024, 00240001, 'CENTRIFIGAL PUMP', 'CENTRIFIGAL PUMP', '2019-05-23 18:05:47', 1),
(240, 0024, 00240002, 'SUBMESIBLE PUMP', 'SUBMESIBLE PUMP', '2019-05-23 18:05:47', 1),
(241, 0025, 00250001, 'FLOURECENT FITTINGS', 'FLOURECENT FITTINGS', '2019-05-23 18:05:47', 1),
(242, 0025, 00250002, 'DOWN LIGHT', 'DOWN LIGHT', '2019-05-23 18:05:48', 1),
(243, 0025, 00250003, 'HELOGEN LAMP', 'HELOGEN LAMP', '2019-05-23 18:05:48', 1),
(244, 0026, 00260001, 'ARMOURD CABLE', 'ARMOURD CABLE', '2019-05-23 18:05:48', 1),
(245, 0026, 00260002, 'NON ARMOURD CABLE', 'NON ARMOURD CABLE', '2019-05-23 18:05:48', 1),
(246, 0026, 00260003, 'EARTH CABLE', 'EARTH CABLE', '2019-05-23 18:05:48', 1),
(247, 0026, 00260004, 'FLEXIBLE CABLE', 'FLEXIBLE CABLE', '2019-05-23 18:05:48', 1),
(248, 0026, 00260005, 'BELDEN CABLE', 'BELDEN CABLE', '2019-05-23 18:05:48', 1),
(249, 0026, 00260006, 'TELPHONE CABLE', 'TELPHONE CABLE', '2019-05-23 18:05:48', 1),
(250, 0026, 00260007, 'CONTROL CABLE', 'CONTROL CABLE', '2019-05-23 18:05:48', 1),
(251, 0026, 00260008, 'ALUMINIUM CABLE', 'ALUMINIUM CABLE', '2019-05-23 18:05:48', 1),
(252, 0027, 00270001, 'EARTH ROD', 'EARTH ROD', '2019-05-23 18:05:48', 1),
(253, 0027, 00270002, 'COPPER TAPE', 'COPPER TAPE', '2019-05-23 18:05:49', 1),
(254, 0027, 00270003, 'BEAR CABLE', 'BEAR CABLE', '2019-05-23 18:05:49', 1),
(255, 0027, 00270004, 'ROD TO CLAMP', 'ROD TO CLAMP', '2019-05-23 18:05:49', 1),
(256, 0027, 00270005, 'EARTH PIT', 'EARTH PIT', '2019-05-23 18:05:49', 1),
(257, 0028, 00280001, 'FIRE EXTINGIISHER', 'FIRE EXTINGIISHER', '2019-05-23 18:05:49', 1),
(258, 0028, 00280002, 'FIRE CABINET', 'FIRE CABINET', '2019-05-23 18:05:49', 1),
(259, 0028, 00280003, 'FIRE HOSE REAL', 'FIRE HOSE REAL', '2019-05-23 18:05:49', 1),
(260, 0028, 00280004, 'HOSE NOZZLE', 'HOSE NOZZLE', '2019-05-23 18:05:49', 1),
(261, 0028, 00280005, 'DETECTORS', 'DETECTORS', '2019-05-23 18:05:49', 1),
(262, 0028, 00280006, 'SPRINKLERS', 'SPRINKLERS', '2019-05-23 18:05:49', 1),
(263, 0029, 00290001, 'AMPLIFIRE', 'AMPLIFIRE', '2019-05-23 18:05:49', 1),
(264, 0029, 00290002, 'SPEAKERS', 'SPEAKERS', '2019-05-23 18:05:50', 1),
(265, 0030, 00300001, 'STATIONERY', 'STATIONERY', '2019-05-23 18:05:50', 1),
(266, 0031, 00310001, 'MATERIALS', 'MATERIALS', '2019-05-23 18:05:50', 1);

-- --------------------------------------------------------

--
-- Table structure for table `subcategories_2`
--

DROP TABLE IF EXISTS `subcategories_2`;
CREATE TABLE IF NOT EXISTS `subcategories_2` (
  `subcategories_2_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_code` int(8) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_2_code` bigint(12) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_2_name` varchar(255) NOT NULL,
  `subcategory_2_description` text NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`subcategories_2_table_id`),
  KEY `subcategory_2_code` (`subcategory_2_code`),
  KEY `category_code` (`category_code`),
  KEY `saved_user` (`saved_user`),
  KEY `subcategory_1_code` (`subcategory_1_code`)
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subcategories_2`
--

INSERT INTO `subcategories_2` (`subcategories_2_table_id`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_2_name`, `subcategory_2_description`, `saved_datetime`, `saved_user`) VALUES
(1, 0001, 00010000, 000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(2, 0002, 00020000, 000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(3, 0003, 00030000, 000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(4, 0004, 00040000, 000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(5, 0005, 00050000, 000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(6, 0006, 00060000, 000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(7, 0007, 00070000, 000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(8, 0008, 00080000, 000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(9, 0009, 00090000, 000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(10, 0010, 00100000, 001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(11, 0011, 00110000, 001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(12, 0012, 00120000, 001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(13, 0013, 00130000, 001300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(14, 0014, 00140000, 001400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(15, 0015, 00150000, 001500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(16, 0016, 00160000, 001600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(17, 0017, 00170000, 001700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(18, 0018, 00180000, 001800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(19, 0019, 00190000, 001900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(20, 0020, 00200000, 002000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(21, 0021, 00210000, 002100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(22, 0022, 00220000, 002200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(23, 0023, 00230000, 002300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(24, 0024, 00240000, 002400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(25, 0025, 00250000, 002500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(26, 0026, 00260000, 002600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(27, 0027, 00270000, 002700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(28, 0028, 00280000, 002800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(29, 0029, 00290000, 002900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(30, 0030, 00300000, 003000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(31, 0031, 00310000, 003100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(32, 0001, 00010001, 000100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:27', 1),
(33, 0001, 00010002, 000100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(34, 0001, 00010003, 000100030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(35, 0001, 00010004, 000100040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(36, 0001, 00010005, 000100050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(37, 0001, 00010006, 000100060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(38, 0001, 00010007, 000100070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(39, 0001, 00010008, 000100080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(40, 0001, 00010009, 000100090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(41, 0001, 00010010, 000100100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(42, 0001, 00010011, 000100110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(43, 0001, 00010012, 000100120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(44, 0001, 00010013, 000100130000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(45, 0001, 00010014, 000100140000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(46, 0001, 00010015, 000100150000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(47, 0001, 00010016, 000100160000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(48, 0001, 00010017, 000100170000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(49, 0002, 00020001, 000200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(50, 0002, 00020002, 000200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(51, 0002, 00020003, 000200030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(52, 0002, 00020004, 000200040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(53, 0002, 00020005, 000200050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(54, 0002, 00020006, 000200060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(55, 0002, 00020007, 000200070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(56, 0002, 00020008, 000200080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(57, 0002, 00020009, 000200090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(58, 0003, 00030001, 000300010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(59, 0003, 00030002, 000300020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(60, 0003, 00030003, 000300030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(61, 0003, 00030004, 000300040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(62, 0003, 00030005, 000300050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(63, 0003, 00030006, 000300060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(64, 0003, 00030007, 000300070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(65, 0003, 00030008, 000300080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(66, 0003, 00030009, 000300090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(67, 0003, 00030010, 000300100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(68, 0004, 00040001, 000400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(69, 0004, 00040002, 000400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(70, 0004, 00040003, 000400030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(71, 0004, 00040004, 000400040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(72, 0004, 00040005, 000400050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(73, 0004, 00040006, 000400060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(74, 0004, 00040007, 000400070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(75, 0004, 00040008, 000400080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(76, 0004, 00040009, 000400090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(77, 0005, 00050001, 000500010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(78, 0005, 00050002, 000500020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(79, 0005, 00050003, 000500030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(80, 0005, 00050004, 000500040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(81, 0005, 00050005, 000500050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(82, 0005, 00050006, 000500060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(83, 0005, 00050007, 000500070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(84, 0005, 00050008, 000500080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(85, 0005, 00050009, 000500090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(86, 0005, 00050010, 000500100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(87, 0006, 00060001, 000600010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(88, 0006, 00060002, 000600020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(89, 0006, 00060003, 000600030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(90, 0006, 00060004, 000600040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(91, 0006, 00060005, 000600050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(92, 0006, 00060006, 000600060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(93, 0006, 00060007, 000600070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(94, 0006, 00060008, 000600080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(95, 0006, 00060009, 000600090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(96, 0006, 00060010, 000600100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(97, 0006, 00060011, 000600110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(98, 0006, 00060012, 000600120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(99, 0007, 00070001, 000700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(100, 0007, 00070002, 000700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(101, 0007, 00070003, 000700030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(102, 0007, 00070004, 000700040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(103, 0007, 00070005, 000700050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(104, 0007, 00070006, 000700060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(105, 0007, 00070007, 000700070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(106, 0007, 00070008, 000700080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(107, 0007, 00070009, 000700090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(108, 0007, 00070010, 000700100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(109, 0007, 00070011, 000700110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(110, 0007, 00070012, 000700120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(111, 0008, 00080001, 000800010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(112, 0008, 00080002, 000800020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(113, 0008, 00080003, 000800030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(114, 0008, 00080004, 000800040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(115, 0008, 00080005, 000800050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(116, 0008, 00080006, 000800060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(117, 0008, 00080007, 000800070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(118, 0008, 00080008, 000800080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(119, 0008, 00080009, 000800090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(120, 0008, 00080010, 000800100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(121, 0008, 00080011, 000800110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(122, 0008, 00080012, 000800120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(123, 0009, 00090001, 000900010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(124, 0009, 00090002, 000900020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(125, 0009, 00090003, 000900030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(126, 0009, 00090004, 000900040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(127, 0009, 00090005, 000900050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(128, 0009, 00090006, 000900060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(129, 0009, 00090007, 000900070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(130, 0009, 00090008, 000900080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(131, 0010, 00100001, 001000010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(132, 0010, 00100002, 001000020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(133, 0010, 00100003, 001000030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(134, 0010, 00100004, 001000040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(135, 0010, 00100005, 001000050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(136, 0010, 00100006, 001000060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(137, 0011, 00110001, 001100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(138, 0011, 00110002, 001100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(139, 0011, 00110003, 001100030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(140, 0011, 00110004, 001100040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(141, 0011, 00110005, 001100050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(142, 0011, 00110006, 001100060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(143, 0011, 00110007, 001100070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(144, 0011, 00110008, 001100080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(145, 0011, 00110009, 001100090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(146, 0012, 00120001, 001200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(147, 0012, 00120002, 001200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(148, 0013, 00130001, 001300010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(149, 0013, 00130002, 001300020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(150, 0013, 00130003, 001300030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(151, 0013, 00130004, 001300040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(152, 0013, 00130005, 001300050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(153, 0014, 00140001, 001400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(154, 0014, 00140002, 001400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(155, 0014, 00140003, 001400030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(156, 0014, 00140004, 001400040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(157, 0014, 00140005, 001400050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(158, 0014, 00140006, 001400060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(159, 0014, 00140007, 001400070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(160, 0014, 00140008, 001400080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(161, 0014, 00140009, 001400090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(162, 0014, 00140010, 001400100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(163, 0015, 00150001, 001500010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(164, 0015, 00150002, 001500020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(165, 0015, 00150003, 001500030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(166, 0015, 00150004, 001500040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(167, 0015, 00150005, 001500050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(168, 0016, 00160001, 001600010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(169, 0016, 00160002, 001600020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(170, 0016, 00160003, 001600030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(171, 0016, 00160004, 001600040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(172, 0016, 00160005, 001600050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(173, 0016, 00160006, 001600060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(174, 0016, 00160007, 001600070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(175, 0016, 00160008, 001600080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(176, 0016, 00160009, 001600090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(177, 0016, 00160010, 001600100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(178, 0016, 00160011, 001600110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(179, 0016, 00160012, 001600120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(180, 0016, 00160013, 001600130000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(181, 0016, 00160014, 001600140000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(182, 0017, 00170001, 001700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(183, 0017, 00170002, 001700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(184, 0017, 00170003, 001700030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(185, 0017, 00170004, 001700040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(186, 0017, 00170005, 001700050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(187, 0017, 00170006, 001700060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(188, 0017, 00170007, 001700070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(189, 0018, 00180001, 001800010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(190, 0018, 00180002, 001800020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(191, 0018, 00180003, 001800030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(192, 0018, 00180004, 001800040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(193, 0019, 00190001, 001900010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(194, 0019, 00190002, 001900020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(195, 0019, 00190003, 001900030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(196, 0019, 00190004, 001900040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(197, 0019, 00190005, 001900050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(198, 0019, 00190006, 001900060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(199, 0019, 00190007, 001900070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(200, 0019, 00190008, 001900080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(201, 0019, 00190009, 001900090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(202, 0019, 00190010, 001900100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(203, 0019, 00190011, 001900110000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(204, 0019, 00190012, 001900120000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(205, 0019, 00190013, 001900130000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(206, 0019, 00190014, 001900140000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(207, 0019, 00190015, 001900150000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(208, 0019, 00190016, 001900160000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(209, 0019, 00190017, 001900170000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(210, 0019, 00190018, 001900180000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(211, 0019, 00190019, 001900190000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(212, 0019, 00190020, 001900200000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(213, 0019, 00190021, 001900210000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(214, 0020, 00200001, 002000010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(215, 0020, 00200002, 002000020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(216, 0020, 00200003, 002000030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(217, 0020, 00200004, 002000040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(218, 0020, 00200005, 002000050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(219, 0020, 00200006, 002000060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(220, 0020, 00200007, 002000070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(221, 0020, 00200008, 002000080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(222, 0020, 00200009, 002000090000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(223, 0020, 00200010, 002000100000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(224, 0021, 00210001, 002100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(225, 0021, 00210002, 002100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(226, 0021, 00210003, 002100030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(227, 0021, 00210004, 002100040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(228, 0021, 00210005, 002100050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(229, 0021, 00210006, 002100060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(230, 0021, 00210007, 002100070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(231, 0022, 00220001, 002200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(232, 0022, 00220002, 002200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(233, 0022, 00220003, 002200030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(234, 0022, 00220004, 002200040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(235, 0023, 00230001, 002300010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(236, 0023, 00230002, 002300020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(237, 0023, 00230003, 002300030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(238, 0023, 00230004, 002300040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(239, 0024, 00240001, 002400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(240, 0024, 00240002, 002400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(241, 0025, 00250001, 002500010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(242, 0025, 00250002, 002500020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(243, 0025, 00250003, 002500030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(244, 0026, 00260001, 002600010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(245, 0026, 00260002, 002600020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(246, 0026, 00260003, 002600030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(247, 0026, 00260004, 002600040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(248, 0026, 00260005, 002600050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(249, 0026, 00260006, 002600060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(250, 0026, 00260007, 002600070000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(251, 0026, 00260008, 002600080000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(252, 0027, 00270001, 002700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(253, 0027, 00270002, 002700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(254, 0027, 00270003, 002700030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(255, 0027, 00270004, 002700040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(256, 0027, 00270005, 002700050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(257, 0028, 00280001, 002800010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(258, 0028, 00280002, 002800020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(259, 0028, 00280003, 002800030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(260, 0028, 00280004, 002800040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(261, 0028, 00280005, 002800050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(262, 0028, 00280006, 002800060000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(263, 0029, 00290001, 002900010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(264, 0029, 00290002, 002900020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(265, 0030, 00300001, 003000010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(266, 0031, 00310001, 003100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(267, 0001, 00010017, 000100170001, 'PN-11', 'PN-11', '2019-05-23 18:06:43', 1),
(268, 0001, 00010017, 000100170002, 'PN-07', 'PN-07', '2019-05-23 18:06:43', 1),
(269, 0001, 00010017, 000100170003, 'TYPE 400', 'TYPE 400', '2019-05-23 18:06:43', 1),
(270, 0001, 00010017, 000100170004, 'DRAINAGE', 'DRAINAGE', '2019-05-23 18:06:43', 1),
(271, 0002, 00020007, 000200070001, '10K', '10K', '2019-05-23 18:06:43', 1),
(272, 0002, 00020007, 000200070002, 'PN-16', 'PN-16', '2019-05-23 18:06:43', 1),
(273, 0002, 00020008, 000200080001, '10K', '10K', '2019-05-23 18:06:43', 1),
(274, 0002, 00020008, 000200080002, 'PN-10', 'PN-10', '2019-05-23 18:06:43', 1),
(275, 0002, 00020008, 000200080003, 'PN-16', 'PN-16', '2019-05-23 18:06:43', 1),
(276, 0002, 00020008, 000200080004, 'PN-25', 'PN-25', '2019-05-23 18:06:43', 1),
(277, 0002, 00020008, 000200080005, 'ANSI', 'ANSI', '2019-05-23 18:06:43', 1),
(278, 0002, 00020009, 000200090001, 'HEAVY DUTY', 'HEAVY DUTY', '2019-05-23 18:06:43', 1),
(279, 0002, 00020009, 000200090002, 'MEDIUM DUTY', 'MEDIUM DUTY', '2019-05-23 18:06:43', 1),
(280, 0004, 00040007, 000400070001, '10K', '10K', '2019-05-23 18:06:44', 1),
(281, 0004, 00040007, 000400070002, 'PN-16', 'PN-16', '2019-05-23 18:06:44', 1),
(282, 0004, 00040008, 000400080001, '10K', '10K', '2019-05-23 18:06:44', 1),
(283, 0004, 00040008, 000400080002, 'PN-10', 'PN-10', '2019-05-23 18:06:44', 1),
(284, 0004, 00040008, 000400080003, 'PN-16', 'PN-16', '2019-05-23 18:06:44', 1),
(285, 0004, 00040008, 000400080004, 'PN-25', 'PN-25', '2019-05-23 18:06:44', 1),
(286, 0004, 00040008, 000400080005, 'ANSI', 'ANSI', '2019-05-23 18:06:44', 1),
(287, 0004, 00040009, 000400090001, 'HEAVY DUTY', 'HEAVY DUTY', '2019-05-23 18:06:44', 1),
(288, 0004, 00040009, 000400090002, 'MEDIUM DUTY', 'MEDIUM DUTY', '2019-05-23 18:06:44', 1),
(289, 0006, 00060012, 000600120001, 'PN-10', 'PN-10', '2019-05-23 18:06:44', 1),
(290, 0006, 00060012, 000600120002, 'PN-16', 'PN-16', '2019-05-23 18:06:44', 1),
(291, 0006, 00060012, 000600120003, 'PN-25', 'PN-25', '2019-05-23 18:06:44', 1),
(292, 0016, 00160001, 001600010001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:44', 1),
(293, 0016, 00160001, 001600010002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:45', 1),
(294, 0016, 00160002, 001600020001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:45', 1),
(295, 0016, 00160002, 001600020002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:45', 1),
(296, 0016, 00160003, 001600030001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:45', 1),
(297, 0016, 00160003, 001600030002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:45', 1),
(298, 0016, 00160004, 001600040001, 'Size : 1', 'Size : 1', '2019-05-23 18:06:45', 1),
(299, 0016, 00160004, 001600040002, 'Size : 2', 'Size : 2', '2019-05-23 18:06:45', 1),
(300, 0016, 00160005, 001600050001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:45', 1),
(301, 0016, 00160005, 001600050002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:45', 1),
(302, 0016, 00160006, 001600060001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:45', 1),
(303, 0016, 00160006, 001600060002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:45', 1),
(304, 0016, 00160007, 001600070001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:46', 1),
(305, 0016, 00160007, 001600070002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:46', 1),
(306, 0016, 00160008, 001600080001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:46', 1),
(307, 0016, 00160008, 001600080002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:46', 1),
(308, 0016, 00160009, 001600090001, 'Size : 1', 'Size : 1', '2019-05-23 18:06:46', 1),
(309, 0016, 00160009, 001600090002, 'Size : 2', 'Size : 2', '2019-05-23 18:06:46', 1),
(310, 0016, 00160010, 001600100001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:46', 1),
(311, 0016, 00160010, 001600100002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:46', 1),
(312, 0016, 00160011, 001600110001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:46', 1),
(313, 0016, 00160011, 001600110002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:46', 1),
(314, 0016, 00160012, 001600120001, 'Model No: 1', 'Model No: 1', '2019-05-23 18:06:47', 1),
(315, 0016, 00160012, 001600120002, 'Model No: 2', 'Model No: 2', '2019-05-23 18:06:47', 1),
(316, 0016, 00160013, 001600130001, '1/2\"', '1/2\"', '2019-05-23 18:06:47', 1),
(317, 0016, 00160013, 001600130002, '1/2\" x 3/8\"', '1/2\" x 3/8\"', '2019-05-23 18:06:47', 1),
(318, 0016, 00160014, 001600140001, '1/2\" x 300mmL', '1/2\" x 300mmL', '2019-05-23 18:06:47', 1),
(319, 0016, 00160014, 001600140002, '1/2\" x 450mmL', '1/2\" x 450mmL', '2019-05-23 18:06:47', 1),
(320, 0016, 00160014, 001600140003, '1/2\" x 600mmL', '1/2\" x 600mmL', '2019-05-23 18:06:47', 1),
(321, 0017, 00170004, 001700040001, 'WITH FOIL', 'WITH FOIL', '2019-05-23 18:06:47', 1),
(322, 0017, 00170004, 001700040002, 'WITHOUT FOIL', 'WITHOUT FOIL', '2019-05-23 18:06:47', 1),
(323, 0017, 00170005, 001700050001, 'WITH FOIL', 'WITH FOIL', '2019-05-23 18:06:47', 1),
(324, 0017, 00170005, 001700050002, 'WITHOUT FOIL', 'WITHOUT FOIL', '2019-05-23 18:06:47', 1),
(325, 0019, 00190013, 001900130001, 'GI', 'GI', '2019-05-23 18:06:48', 1),
(326, 0019, 00190013, 001900130002, 'M.S', 'M.S', '2019-05-23 18:06:48', 1),
(327, 0019, 00190014, 001900140001, 'GI', 'GI', '2019-05-23 18:06:48', 1),
(328, 0019, 00190014, 001900140002, 'M.S', 'M.S', '2019-05-23 18:06:48', 1),
(329, 0026, 00260001, 002600010001, '1CORE', '1CORE', '2019-05-23 18:06:48', 1),
(330, 0026, 00260001, 002600010002, '2CORE', '2CORE', '2019-05-23 18:06:48', 1),
(331, 0026, 00260001, 002600010003, '3CORE', '3CORE', '2019-05-23 18:06:48', 1),
(332, 0026, 00260001, 002600010004, '4CORE', '4CORE', '2019-05-23 18:06:48', 1),
(333, 0026, 00260002, 002600020001, '1CORE', '1CORE', '2019-05-23 18:06:48', 1),
(334, 0026, 00260002, 002600020002, '2CORE', '2CORE', '2019-05-23 18:06:48', 1),
(335, 0026, 00260002, 002600020003, '3CORE', '3CORE', '2019-05-23 18:06:48', 1),
(336, 0026, 00260002, 002600020004, '4CORE', '4CORE', '2019-05-23 18:06:49', 1),
(337, 0026, 00260004, 002600040001, '2CORE', '2CORE', '2019-05-23 18:06:49', 1),
(338, 0026, 00260004, 002600040002, '3CORE', '3CORE', '2019-05-23 18:06:49', 1),
(339, 0026, 00260004, 002600040003, '4CORE', '4CORE', '2019-05-23 18:06:49', 1),
(340, 0027, 00270001, 002700010001, '1MT', '1MT', '2019-05-23 18:06:49', 1),
(341, 0027, 00270001, 002700010002, '2MT', '2MT', '2019-05-23 18:06:49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `subcategories_3`
--

DROP TABLE IF EXISTS `subcategories_3`;
CREATE TABLE IF NOT EXISTS `subcategories_3` (
  `subcategories_3_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_code` int(8) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_2_code` bigint(12) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_3_code` bigint(16) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_3_name` varchar(255) NOT NULL,
  `subcategory_3_description` text NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`subcategories_3_table_id`),
  KEY `subcategory_3_code` (`subcategory_3_code`),
  KEY `category_code` (`category_code`),
  KEY `saved_user` (`saved_user`),
  KEY `subcategory_1_code` (`subcategory_1_code`),
  KEY `subcategory_2_code` (`subcategory_2_code`)
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subcategories_3`
--

INSERT INTO `subcategories_3` (`subcategories_3_table_id`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `subcategory_3_name`, `subcategory_3_description`, `saved_datetime`, `saved_user`) VALUES
(1, 0001, 00010000, 000100000000, 0001000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(2, 0002, 00020000, 000200000000, 0002000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(3, 0003, 00030000, 000300000000, 0003000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(4, 0004, 00040000, 000400000000, 0004000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(5, 0005, 00050000, 000500000000, 0005000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:50', 1),
(6, 0006, 00060000, 000600000000, 0006000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(7, 0007, 00070000, 000700000000, 0007000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(8, 0008, 00080000, 000800000000, 0008000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(9, 0009, 00090000, 000900000000, 0009000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(10, 0010, 00100000, 001000000000, 0010000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:51', 1),
(11, 0011, 00110000, 001100000000, 0011000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(12, 0012, 00120000, 001200000000, 0012000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(13, 0013, 00130000, 001300000000, 0013000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(14, 0014, 00140000, 001400000000, 0014000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(15, 0015, 00150000, 001500000000, 0015000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(16, 0016, 00160000, 001600000000, 0016000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(17, 0017, 00170000, 001700000000, 0017000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:52', 1),
(18, 0018, 00180000, 001800000000, 0018000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(19, 0019, 00190000, 001900000000, 0019000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(20, 0020, 00200000, 002000000000, 0020000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(21, 0021, 00210000, 002100000000, 0021000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(22, 0022, 00220000, 002200000000, 0022000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(23, 0023, 00230000, 002300000000, 0023000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(24, 0024, 00240000, 002400000000, 0024000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:53', 1),
(25, 0025, 00250000, 002500000000, 0025000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(26, 0026, 00260000, 002600000000, 0026000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(27, 0027, 00270000, 002700000000, 0027000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(28, 0028, 00280000, 002800000000, 0028000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(29, 0029, 00290000, 002900000000, 0029000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(30, 0030, 00300000, 003000000000, 0030000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(31, 0031, 00310000, 003100000000, 0031000000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 17:55:54', 1),
(32, 0001, 00010001, 000100010000, 0001000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:27', 1),
(33, 0001, 00010002, 000100020000, 0001000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(34, 0001, 00010003, 000100030000, 0001000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(35, 0001, 00010004, 000100040000, 0001000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(36, 0001, 00010005, 000100050000, 0001000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(37, 0001, 00010006, 000100060000, 0001000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(38, 0001, 00010007, 000100070000, 0001000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(39, 0001, 00010008, 000100080000, 0001000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(40, 0001, 00010009, 000100090000, 0001000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:28', 1),
(41, 0001, 00010010, 000100100000, 0001001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(42, 0001, 00010011, 000100110000, 0001001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(43, 0001, 00010012, 000100120000, 0001001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(44, 0001, 00010013, 000100130000, 0001001300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(45, 0001, 00010014, 000100140000, 0001001400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(46, 0001, 00010015, 000100150000, 0001001500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(47, 0001, 00010016, 000100160000, 0001001600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(48, 0001, 00010017, 000100170000, 0001001700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(49, 0002, 00020001, 000200010000, 0002000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:29', 1),
(50, 0002, 00020002, 000200020000, 0002000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(51, 0002, 00020003, 000200030000, 0002000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(52, 0002, 00020004, 000200040000, 0002000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(53, 0002, 00020005, 000200050000, 0002000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(54, 0002, 00020006, 000200060000, 0002000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(55, 0002, 00020007, 000200070000, 0002000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(56, 0002, 00020008, 000200080000, 0002000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(57, 0002, 00020009, 000200090000, 0002000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(58, 0003, 00030001, 000300010000, 0003000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(59, 0003, 00030002, 000300020000, 0003000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(60, 0003, 00030003, 000300030000, 0003000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:30', 1),
(61, 0003, 00030004, 000300040000, 0003000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(62, 0003, 00030005, 000300050000, 0003000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(63, 0003, 00030006, 000300060000, 0003000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(64, 0003, 00030007, 000300070000, 0003000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(65, 0003, 00030008, 000300080000, 0003000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(66, 0003, 00030009, 000300090000, 0003000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(67, 0003, 00030010, 000300100000, 0003001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(68, 0004, 00040001, 000400010000, 0004000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(69, 0004, 00040002, 000400020000, 0004000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(70, 0004, 00040003, 000400030000, 0004000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(71, 0004, 00040004, 000400040000, 0004000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(72, 0004, 00040005, 000400050000, 0004000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:31', 1),
(73, 0004, 00040006, 000400060000, 0004000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(74, 0004, 00040007, 000400070000, 0004000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(75, 0004, 00040008, 000400080000, 0004000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(76, 0004, 00040009, 000400090000, 0004000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(77, 0005, 00050001, 000500010000, 0005000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(78, 0005, 00050002, 000500020000, 0005000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(79, 0005, 00050003, 000500030000, 0005000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(80, 0005, 00050004, 000500040000, 0005000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(81, 0005, 00050005, 000500050000, 0005000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(82, 0005, 00050006, 000500060000, 0005000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(83, 0005, 00050007, 000500070000, 0005000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:32', 1),
(84, 0005, 00050008, 000500080000, 0005000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(85, 0005, 00050009, 000500090000, 0005000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(86, 0005, 00050010, 000500100000, 0005001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(87, 0006, 00060001, 000600010000, 0006000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(88, 0006, 00060002, 000600020000, 0006000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(89, 0006, 00060003, 000600030000, 0006000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(90, 0006, 00060004, 000600040000, 0006000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(91, 0006, 00060005, 000600050000, 0006000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(92, 0006, 00060006, 000600060000, 0006000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(93, 0006, 00060007, 000600070000, 0006000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(94, 0006, 00060008, 000600080000, 0006000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:33', 1),
(95, 0006, 00060009, 000600090000, 0006000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(96, 0006, 00060010, 000600100000, 0006001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(97, 0006, 00060011, 000600110000, 0006001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(98, 0006, 00060012, 000600120000, 0006001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(99, 0007, 00070001, 000700010000, 0007000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(100, 0007, 00070002, 000700020000, 0007000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(101, 0007, 00070003, 000700030000, 0007000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(102, 0007, 00070004, 000700040000, 0007000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(103, 0007, 00070005, 000700050000, 0007000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(104, 0007, 00070006, 000700060000, 0007000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(105, 0007, 00070007, 000700070000, 0007000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(106, 0007, 00070008, 000700080000, 0007000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:34', 1),
(107, 0007, 00070009, 000700090000, 0007000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(108, 0007, 00070010, 000700100000, 0007001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(109, 0007, 00070011, 000700110000, 0007001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(110, 0007, 00070012, 000700120000, 0007001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(111, 0008, 00080001, 000800010000, 0008000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(112, 0008, 00080002, 000800020000, 0008000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(113, 0008, 00080003, 000800030000, 0008000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(114, 0008, 00080004, 000800040000, 0008000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(115, 0008, 00080005, 000800050000, 0008000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(116, 0008, 00080006, 000800060000, 0008000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(117, 0008, 00080007, 000800070000, 0008000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(118, 0008, 00080008, 000800080000, 0008000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:35', 1),
(119, 0008, 00080009, 000800090000, 0008000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(120, 0008, 00080010, 000800100000, 0008001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(121, 0008, 00080011, 000800110000, 0008001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(122, 0008, 00080012, 000800120000, 0008001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(123, 0009, 00090001, 000900010000, 0009000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(124, 0009, 00090002, 000900020000, 0009000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(125, 0009, 00090003, 000900030000, 0009000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(126, 0009, 00090004, 000900040000, 0009000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(127, 0009, 00090005, 000900050000, 0009000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(128, 0009, 00090006, 000900060000, 0009000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(129, 0009, 00090007, 000900070000, 0009000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(130, 0009, 00090008, 000900080000, 0009000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:36', 1),
(131, 0010, 00100001, 001000010000, 0010000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(132, 0010, 00100002, 001000020000, 0010000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(133, 0010, 00100003, 001000030000, 0010000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(134, 0010, 00100004, 001000040000, 0010000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(135, 0010, 00100005, 001000050000, 0010000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(136, 0010, 00100006, 001000060000, 0010000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(137, 0011, 00110001, 001100010000, 0011000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(138, 0011, 00110002, 001100020000, 0011000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(139, 0011, 00110003, 001100030000, 0011000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(140, 0011, 00110004, 001100040000, 0011000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:37', 1),
(141, 0011, 00110005, 001100050000, 0011000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(142, 0011, 00110006, 001100060000, 0011000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(143, 0011, 00110007, 001100070000, 0011000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(144, 0011, 00110008, 001100080000, 0011000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(145, 0011, 00110009, 001100090000, 0011000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(146, 0012, 00120001, 001200010000, 0012000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(147, 0012, 00120002, 001200020000, 0012000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(148, 0013, 00130001, 001300010000, 0013000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(149, 0013, 00130002, 001300020000, 0013000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(150, 0013, 00130003, 001300030000, 0013000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(151, 0013, 00130004, 001300040000, 0013000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:38', 1),
(152, 0013, 00130005, 001300050000, 0013000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(153, 0014, 00140001, 001400010000, 0014000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(154, 0014, 00140002, 001400020000, 0014000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(155, 0014, 00140003, 001400030000, 0014000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(156, 0014, 00140004, 001400040000, 0014000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(157, 0014, 00140005, 001400050000, 0014000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(158, 0014, 00140006, 001400060000, 0014000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(159, 0014, 00140007, 001400070000, 0014000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(160, 0014, 00140008, 001400080000, 0014000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(161, 0014, 00140009, 001400090000, 0014000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(162, 0014, 00140010, 001400100000, 0014001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(163, 0015, 00150001, 001500010000, 0015000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:39', 1),
(164, 0015, 00150002, 001500020000, 0015000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(165, 0015, 00150003, 001500030000, 0015000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(166, 0015, 00150004, 001500040000, 0015000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(167, 0015, 00150005, 001500050000, 0015000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(168, 0016, 00160001, 001600010000, 0016000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(169, 0016, 00160002, 001600020000, 0016000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(170, 0016, 00160003, 001600030000, 0016000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:40', 1),
(171, 0016, 00160004, 001600040000, 0016000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(172, 0016, 00160005, 001600050000, 0016000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(173, 0016, 00160006, 001600060000, 0016000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(174, 0016, 00160007, 001600070000, 0016000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(175, 0016, 00160008, 001600080000, 0016000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(176, 0016, 00160009, 001600090000, 0016000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(177, 0016, 00160010, 001600100000, 0016001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(178, 0016, 00160011, 001600110000, 0016001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(179, 0016, 00160012, 001600120000, 0016001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:41', 1),
(180, 0016, 00160013, 001600130000, 0016001300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(181, 0016, 00160014, 001600140000, 0016001400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(182, 0017, 00170001, 001700010000, 0017000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(183, 0017, 00170002, 001700020000, 0017000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(184, 0017, 00170003, 001700030000, 0017000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(185, 0017, 00170004, 001700040000, 0017000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(186, 0017, 00170005, 001700050000, 0017000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(187, 0017, 00170006, 001700060000, 0017000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(188, 0017, 00170007, 001700070000, 0017000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:42', 1),
(189, 0018, 00180001, 001800010000, 0018000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(190, 0018, 00180002, 001800020000, 0018000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(191, 0018, 00180003, 001800030000, 0018000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(192, 0018, 00180004, 001800040000, 0018000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(193, 0019, 00190001, 001900010000, 0019000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(194, 0019, 00190002, 001900020000, 0019000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(195, 0019, 00190003, 001900030000, 0019000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(196, 0019, 00190004, 001900040000, 0019000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(197, 0019, 00190005, 001900050000, 0019000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(198, 0019, 00190006, 001900060000, 0019000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:43', 1),
(199, 0019, 00190007, 001900070000, 0019000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(200, 0019, 00190008, 001900080000, 0019000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(201, 0019, 00190009, 001900090000, 0019000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(202, 0019, 00190010, 001900100000, 0019001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(203, 0019, 00190011, 001900110000, 0019001100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(204, 0019, 00190012, 001900120000, 0019001200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(205, 0019, 00190013, 001900130000, 0019001300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(206, 0019, 00190014, 001900140000, 0019001400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(207, 0019, 00190015, 001900150000, 0019001500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:44', 1),
(208, 0019, 00190016, 001900160000, 0019001600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(209, 0019, 00190017, 001900170000, 0019001700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(210, 0019, 00190018, 001900180000, 0019001800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(211, 0019, 00190019, 001900190000, 0019001900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(212, 0019, 00190020, 001900200000, 0019002000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(213, 0019, 00190021, 001900210000, 0019002100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(214, 0020, 00200001, 002000010000, 0020000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(215, 0020, 00200002, 002000020000, 0020000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(216, 0020, 00200003, 002000030000, 0020000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(217, 0020, 00200004, 002000040000, 0020000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:45', 1),
(218, 0020, 00200005, 002000050000, 0020000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(219, 0020, 00200006, 002000060000, 0020000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(220, 0020, 00200007, 002000070000, 0020000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(221, 0020, 00200008, 002000080000, 0020000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(222, 0020, 00200009, 002000090000, 0020000900000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(223, 0020, 00200010, 002000100000, 0020001000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(224, 0021, 00210001, 002100010000, 0021000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(225, 0021, 00210002, 002100020000, 0021000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(226, 0021, 00210003, 002100030000, 0021000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(227, 0021, 00210004, 002100040000, 0021000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(228, 0021, 00210005, 002100050000, 0021000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(229, 0021, 00210006, 002100060000, 0021000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:46', 1),
(230, 0021, 00210007, 002100070000, 0021000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(231, 0022, 00220001, 002200010000, 0022000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(232, 0022, 00220002, 002200020000, 0022000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(233, 0022, 00220003, 002200030000, 0022000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(234, 0022, 00220004, 002200040000, 0022000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(235, 0023, 00230001, 002300010000, 0023000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(236, 0023, 00230002, 002300020000, 0023000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(237, 0023, 00230003, 002300030000, 0023000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(238, 0023, 00230004, 002300040000, 0023000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(239, 0024, 00240001, 002400010000, 0024000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(240, 0024, 00240002, 002400020000, 0024000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:47', 1),
(241, 0025, 00250001, 002500010000, 0025000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(242, 0025, 00250002, 002500020000, 0025000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(243, 0025, 00250003, 002500030000, 0025000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(244, 0026, 00260001, 002600010000, 0026000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(245, 0026, 00260002, 002600020000, 0026000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(246, 0026, 00260003, 002600030000, 0026000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(247, 0026, 00260004, 002600040000, 0026000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(248, 0026, 00260005, 002600050000, 0026000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(249, 0026, 00260006, 002600060000, 0026000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(250, 0026, 00260007, 002600070000, 0026000700000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(251, 0026, 00260008, 002600080000, 0026000800000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:48', 1),
(252, 0027, 00270001, 002700010000, 0027000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(253, 0027, 00270002, 002700020000, 0027000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(254, 0027, 00270003, 002700030000, 0027000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(255, 0027, 00270004, 002700040000, 0027000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(256, 0027, 00270005, 002700050000, 0027000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(257, 0028, 00280001, 002800010000, 0028000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(258, 0028, 00280002, 002800020000, 0028000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(259, 0028, 00280003, 002800030000, 0028000300000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(260, 0028, 00280004, 002800040000, 0028000400000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(261, 0028, 00280005, 002800050000, 0028000500000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(262, 0028, 00280006, 002800060000, 0028000600000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:49', 1),
(263, 0029, 00290001, 002900010000, 0029000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(264, 0029, 00290002, 002900020000, 0029000200000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(265, 0030, 00300001, 003000010000, 0030000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(266, 0031, 00310001, 003100010000, 0031000100000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:05:50', 1),
(267, 0001, 00010017, 000100170001, 0001001700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(268, 0001, 00010017, 000100170002, 0001001700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(269, 0001, 00010017, 000100170003, 0001001700030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(270, 0001, 00010017, 000100170004, 0001001700040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(271, 0002, 00020007, 000200070001, 0002000700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(272, 0002, 00020007, 000200070002, 0002000700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(273, 0002, 00020008, 000200080001, 0002000800010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(274, 0002, 00020008, 000200080002, 0002000800020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(275, 0002, 00020008, 000200080003, 0002000800030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(276, 0002, 00020008, 000200080004, 0002000800040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(277, 0002, 00020008, 000200080005, 0002000800050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(278, 0002, 00020009, 000200090001, 0002000900010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:43', 1),
(279, 0002, 00020009, 000200090002, 0002000900020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(280, 0004, 00040007, 000400070001, 0004000700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(281, 0004, 00040007, 000400070002, 0004000700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(282, 0004, 00040008, 000400080001, 0004000800010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(283, 0004, 00040008, 000400080002, 0004000800020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(284, 0004, 00040008, 000400080003, 0004000800030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(285, 0004, 00040008, 000400080004, 0004000800040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(286, 0004, 00040008, 000400080005, 0004000800050000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(287, 0004, 00040009, 000400090001, 0004000900010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(288, 0004, 00040009, 000400090002, 0004000900020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(289, 0006, 00060012, 000600120001, 0006001200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(290, 0006, 00060012, 000600120002, 0006001200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(291, 0006, 00060012, 000600120003, 0006001200030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:44', 1),
(292, 0016, 00160001, 001600010001, 0016000100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(293, 0016, 00160001, 001600010002, 0016000100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(294, 0016, 00160002, 001600020001, 0016000200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(295, 0016, 00160002, 001600020002, 0016000200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(296, 0016, 00160003, 001600030001, 0016000300010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(297, 0016, 00160003, 001600030002, 0016000300020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(298, 0016, 00160004, 001600040001, 0016000400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(299, 0016, 00160004, 001600040002, 0016000400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(300, 0016, 00160005, 001600050001, 0016000500010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(301, 0016, 00160005, 001600050002, 0016000500020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(302, 0016, 00160006, 001600060001, 0016000600010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:45', 1),
(303, 0016, 00160006, 001600060002, 0016000600020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(304, 0016, 00160007, 001600070001, 0016000700010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(305, 0016, 00160007, 001600070002, 0016000700020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(306, 0016, 00160008, 001600080001, 0016000800010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(307, 0016, 00160008, 001600080002, 0016000800020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(308, 0016, 00160009, 001600090001, 0016000900010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(309, 0016, 00160009, 001600090002, 0016000900020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(310, 0016, 00160010, 001600100001, 0016001000010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(311, 0016, 00160010, 001600100002, 0016001000020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(312, 0016, 00160011, 001600110001, 0016001100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:46', 1),
(313, 0016, 00160011, 001600110002, 0016001100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(314, 0016, 00160012, 001600120001, 0016001200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(315, 0016, 00160012, 001600120002, 0016001200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(316, 0016, 00160013, 001600130001, 0016001300010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(317, 0016, 00160013, 001600130002, 0016001300020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(318, 0016, 00160014, 001600140001, 0016001400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(319, 0016, 00160014, 001600140002, 0016001400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(320, 0016, 00160014, 001600140003, 0016001400030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(321, 0017, 00170004, 001700040001, 0017000400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(322, 0017, 00170004, 001700040002, 0017000400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(323, 0017, 00170005, 001700050001, 0017000500010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:47', 1),
(324, 0017, 00170005, 001700050002, 0017000500020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(325, 0019, 00190013, 001900130001, 0019001300010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(326, 0019, 00190013, 001900130002, 0019001300020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(327, 0019, 00190014, 001900140001, 0019001400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(328, 0019, 00190014, 001900140002, 0019001400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(329, 0026, 00260001, 002600010001, 0026000100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(330, 0026, 00260001, 002600010002, 0026000100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(331, 0026, 00260001, 002600010003, 0026000100030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(332, 0026, 00260001, 002600010004, 0026000100040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(333, 0026, 00260002, 002600020001, 0026000200010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(334, 0026, 00260002, 002600020002, 0026000200020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:48', 1),
(335, 0026, 00260002, 002600020003, 0026000200030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1),
(336, 0026, 00260002, 002600020004, 0026000200040000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1),
(337, 0026, 00260004, 002600040001, 0026000400010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1),
(338, 0026, 00260004, 002600040002, 0026000400020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1),
(339, 0026, 00260004, 002600040003, 0026000400030000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1),
(340, 0027, 00270001, 002700010001, 0027000100010000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1),
(341, 0027, 00270001, 002700010002, 0027000100020000, ' NOT AVAILABLE', ' NOT AVAILABLE', '2019-05-23 18:06:49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `supplierproducts`
--

DROP TABLE IF EXISTS `supplierproducts`;
CREATE TABLE IF NOT EXISTS `supplierproducts` (
  `supplierproducts_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `category_code` int(4) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_1_code` int(8) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_2_code` bigint(12) UNSIGNED ZEROFILL NOT NULL,
  `subcategory_3_code` bigint(16) UNSIGNED ZEROFILL NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`supplierproducts_table_id`),
  KEY `category_code` (`category_code`),
  KEY `saved_user` (`saved_user`),
  KEY `subcategory_1_code` (`subcategory_1_code`),
  KEY `subcategory_2_code` (`subcategory_2_code`),
  KEY `subcategory_3_code` (`subcategory_3_code`),
  KEY `supplier_code` (`supplier_code`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplierproducts`
--

INSERT INTO `supplierproducts` (`supplierproducts_table_id`, `supplier_code`, `category_code`, `subcategory_1_code`, `subcategory_2_code`, `subcategory_3_code`, `saved_datetime`, `saved_user`) VALUES
(1, 0000000493, 0023, 00230000, 002300000000, 0023000000000000, '2019-06-05 01:11:29', 1),
(2, 0000000493, 0023, 00230001, 002300010000, 0023000100000000, '2019-06-05 01:11:29', 1),
(3, 0000000493, 0023, 00230004, 002300040000, 0023000400000000, '2019-06-05 01:11:29', 1),
(4, 0000000493, 0023, 00230002, 002300020000, 0023000200000000, '2019-06-05 01:11:30', 1),
(5, 0000000493, 0023, 00230003, 002300030000, 0023000300000000, '2019-06-05 01:11:30', 1),
(6, 0000000492, 0005, 00050000, 000500000000, 0005000000000000, '2019-06-05 01:31:21', 1),
(7, 0000000492, 0005, 00050003, 000500030000, 0005000300000000, '2019-06-05 01:31:21', 1),
(8, 0000000492, 0005, 00050002, 000500020000, 0005000200000000, '2019-06-05 01:31:21', 1),
(9, 0000000492, 0005, 00050010, 000500100000, 0005001000000000, '2019-06-05 01:31:21', 1),
(10, 0000000492, 0005, 00050009, 000500090000, 0005000900000000, '2019-06-05 01:31:21', 1),
(11, 0000000492, 0005, 00050008, 000500080000, 0005000800000000, '2019-06-05 01:31:21', 1),
(12, 0000000492, 0005, 00050004, 000500040000, 0005000400000000, '2019-06-05 01:31:21', 1),
(13, 0000000492, 0005, 00050007, 000500070000, 0005000700000000, '2019-06-05 01:31:21', 1),
(14, 0000000492, 0005, 00050006, 000500060000, 0005000600000000, '2019-06-05 01:31:21', 1),
(15, 0000000492, 0005, 00050001, 000500010000, 0005000100000000, '2019-06-05 01:31:22', 1),
(16, 0000000492, 0005, 00050005, 000500050000, 0005000500000000, '2019-06-05 01:31:22', 1);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `suppliers_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_code` int(10) UNSIGNED ZEROFILL NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_address` text NOT NULL,
  `supplier_contact_no1` varchar(255) NOT NULL,
  `supplier_contact_no2` varchar(255) DEFAULT NULL,
  `supplier_email1` varchar(255) DEFAULT NULL,
  `supplier_email2` varchar(255) DEFAULT NULL,
  `supplier_fax_no1` varchar(255) DEFAULT NULL,
  `supplier_fax_no2` varchar(255) DEFAULT NULL,
  `supplier_description` text NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`suppliers_table_id`),
  KEY `supplier_code` (`supplier_code`),
  KEY `saved_user` (`saved_user`)
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`suppliers_table_id`, `supplier_code`, `supplier_name`, `supplier_address`, `supplier_contact_no1`, `supplier_contact_no2`, `supplier_email1`, `supplier_email2`, `supplier_fax_no1`, `supplier_fax_no2`, `supplier_description`, `saved_datetime`, `saved_user`) VALUES
(1, 0000000001, '3M Lanka (Pvt) Ltd', '3rd Floor, 65 C, Dharmapala Mawatha, Colombo 07.', '0112326990', '', '', '', '114410083', '114410084', '30 days credit', '2018-05-23 21:18:53', 1),
(2, 0000000002, 'A & A Enterprieses ', '355,1st Lane ,Dehiwala RD, Boralesgamuwa', '0112519349', '', 'adriantindall@sltnet.lk', '', '112519350', '', '07 days credit', '2018-05-23 21:18:53', 1),
(3, 0000000003, 'A Tech Technology (Pvt) Limited', '# 178, Negombo Road,  Wattala.', '0114895959', '', '', '', '112941331', '', '30 days credit', '2018-05-23 21:18:53', 1),
(4, 0000000004, 'A.C. Paul & Co., Ltd', 'P.O. Box 1172,  326 Sri Sangaraja Mawatha, Colombo 10', '0112431018', '0112431019', 'acpaul@sltnet.lk', '', '112421209', '', 'Cash', '2018-05-23 21:18:53', 1),
(5, 0000000005, 'A.D. Perera & Sons', 'No. 31/1, First Lane,Sri Gnanendra Mawatha, Nawala, Sri Lanka.', '0112806860', '0112806210', '', '', '112805211', '112887014', '10% Advance Payment with on demand bank guarantee & Balance in progress', '2018-05-23 21:18:53', 1),
(6, 0000000006, 'A.G.N.K. Mechanical Engineers & Enterprises (Pvt) Ltd.', 'No. 197, Kanuwana, Ja-Ela, Sri Lanka.', '0112236486', '0112235117', 'agnk@sol.lk', 'agnke@sltnet.lk', '114830623', '', 'After Work. 0114362793', '2018-05-23 21:18:53', 1),
(7, 0000000007, 'A.K.Wasantha Kumara', 'Iduru Waththa, Ovitigala, Mathugama', '0771011726', '', '', '', '', '', '100% by cheque Payment', '2018-05-23 21:18:53', 1),
(8, 0000000008, 'A.N. Electricals', 'No. 9, Old Kirulapone Road,Nugegoda, Sri Lanka.', '0114864355', '0114586490', '', '', '112815558', '', '100% On Delivery', '2018-05-23 21:18:53', 1),
(9, 0000000009, 'A.V.P. Agent', '# 121, 1/12 Pearl Paradise Market, (Old Post Office Market)1st Cross Street, Colombo - 11.', '0112331846', '', 'avpagent1@gmail.com', '', '112445846', '', '45 days credit', '2018-05-23 21:18:53', 1),
(10, 0000000010, 'Abans (Pvt)  Ltd -Toto  Divistion', 'No.498, Galle Road, Colombo -03', '0114514636', '', '', '', '114510676', '', '30 days credit', '2018-05-23 21:18:53', 1),
(11, 0000000011, 'Abans (Pvt) Limited - Central Air Conditioning & Engineering', '128, Airport Road, Rathmalana', '0114216012', '', '', '', '114216015', '', '30 days credit', '2018-05-23 21:18:53', 1),
(12, 0000000012, 'Abans (Pvt) Ltd', '498, Gall Road, Colombo 3', '0112565265', '0112565279', '', '', '112565299', '', '30 days credit', '2018-05-23 21:18:53', 1),
(13, 0000000013, 'Abans Electircal Ltd', '506 B Galle Road, Colombo 6', '0114216012', '', 'electronics@abansgroup.com', '', '114216015', '', '30 days credit', '2018-05-23 21:18:53', 1),
(14, 0000000014, 'ABC Computers (Pvt) Ltd', 'No. 48, Ward Place, Colombo 07', '0114710033', '', 'sales@abc.lk', '', '112684687', '', '30 days credit', '2018-05-23 21:18:53', 1),
(15, 0000000015, 'Access  Agencies (Pvt) Ltd.', '160/20, Kirimandala Mawatha,  Narahenpita.', '0114519183', '0114519185', 'access_agencies@access.lk', '', '114519180', '', ' 14 days  Credit  ', '2018-05-23 21:18:53', 1),
(16, 0000000016, 'Access Energy Solutions (Pvt) Ltd.,', 'Level 4 ,\"Access Towers\" , No. 278,Union Place, Colombo 02', '0112302394', '0112302395', '', '', '112305478', '', 'On completion', '2018-05-23 21:18:53', 1),
(17, 0000000017, 'Access International (Pvt) Ltd.', 'Access Tower, 278, Union Place,  Colombo 02.', '0112302302', '', 'generators@access.lk', 'mahendra@accesslk.com', '112302381', '', '30 days credit', '2018-05-23 21:18:53', 1),
(18, 0000000018, 'AccSoft Solutions (Pvt) Ltd.', '85/2, Dharmapala Mawatha,  Colombo 07.', '0115353530', '', '', '', '115353553', '', '50% on Confirmation & balance 50% on Delivery', '2018-05-23 21:18:53', 1),
(19, 0000000019, 'Aceref  Spares (Pvt) Ltd', '279, Union Place,  Colombo 02.', '0112435434', '0112300952', '', '', '112303544', '', 'Cheque on delivery', '2018-05-23 21:18:53', 1),
(20, 0000000020, 'ACL Cables  Plc', '60, Rodney Street,  Colombo 08. ', '0117608300', '', 'info@acl.lk', '', '112699503', '', '30 days credit', '2018-05-23 21:18:53', 1),
(21, 0000000021, 'ACL Electric (Pvt) Ltd', 'No. 60, Rodney Street,  Colombo 08, Sri Lanka, P.O. Box 1280.', '0112697652', '0117608300', '', '', '112699503', '', '30 days credit', '2018-05-23 21:18:53', 1),
(22, 0000000022, 'ACMA Engineering (Pte) Ltd', '23, Right Circular RD, Jayanthipura, Battaramulla', '0112883999', '', 'dutycmb@acmagroup.com', '', '112866472', '', '30 days credit', '2018-05-23 21:18:53', 1),
(23, 0000000023, 'Adela  Stell', '155,Messenger Street, Colombo-12', '0112441203', '0112478169', '', '', '112478894', '', '30 days credit. 0112445385', '2018-05-23 21:18:53', 1),
(24, 0000000024, 'Advanced Technologies', 'No.46,S.DE S. Jayasinghe Mawatha, Dehiwala', '0112829516', '0112824224', '', '', '112829516', '', '30 days credit', '2018-05-23 21:18:53', 1),
(25, 0000000025, 'Agro Technical Ltd', 'D/4, Industrial Estate,  Ekala.', '0112240966', '0112240968', '', '', '112240970', '', '50% with the order & balance on collection', '2018-05-23 21:18:53', 1),
(26, 0000000026, 'AGRU Plastics (South Asia) Pte. Ltd', '122, Dawson Street, Colombo 02', '0114717500', '', '', '', '112454653', '', 'T/T On BL', '2018-05-23 21:18:53', 1),
(27, 0000000027, 'Air Control Systems (Pvt) Ltd', '760, Bloemendhal RD, Colombo 15', '0112981580', '', 'aircontrol@sltnet.lk', '', '112981580', '', '30 days credit', '2018-05-23 21:18:53', 1),
(28, 0000000028, 'Air Leader (Pvt) Ltd', 'No. 558-A/4 Siyabalape Rd, Heiyanthuduwa, Sri Lanka', '0115664489', '', 'info@airleader.lk', '', '117919001', '', 'On Delivery', '2018-05-23 21:18:53', 1),
(29, 0000000029, 'Airflow Solutions (Pvt) Ltd', 'No. 14 / 2 / C, Galpotta Road, Athurugiriya.', '0112562764', '', 'airflow@sltnet.lk', '', '112562768', '', '10 days credit', '2018-05-23 21:18:53', 1),
(30, 0000000030, 'Aiwa Tailors', 'No. 49/3, Kandy Road, Dalugama,Kelaniya.', '0117207711', '0773032319', '', '', '', '', '50% Advance Payment with on demand bank guarantee & Balance after delivery', '2018-05-23 21:18:53', 1),
(31, 0000000031, 'Ajanee Trading Co., (Pvt) Ltd', '71,Union Place, Colombo 2', '0112325068', '0112433543', 'ajaneel@colombomail.lk', '', '112433852', '', '30 days credit', '2018-05-23 21:18:53', 1),
(32, 0000000032, 'Alcobronz Engineering (Pvt) Ltd', '130/16, Major Wasantha Guneratne Mawatha, Mahara, Kadawatha', '0114969073', '', 'sales@alcobronz.com', '', '112926859', '', 'Full payment on delivery', '2018-05-23 21:18:53', 1),
(33, 0000000033, 'Allied Trading International (Pvt) Ltd.', '#301,Old Moor Street, Colombo-12', '0112343561', '0112325719', 'alliedtrading@eureka.lk', '', '112433852', '', '30 days credit', '2018-05-23 21:18:53', 1),
(34, 0000000034, 'Alpex Management Company', '47A, Malwatte Road, Dehiwala.', '0112736197', '', 'alpex1@sltnet.lk', '', '112736198', '114202286', '15  days credit', '2018-05-23 21:18:53', 1),
(35, 0000000035, 'Alpha Fire Services (Pvt) Ltd', '487/5,Old Kottawa Road, Pannipitiya', '0112745764', '', 'alphasrilanka@sltnet.lk', '', '112851315', '', '30 days credit', '2018-05-23 21:18:53', 1),
(36, 0000000036, 'Alpha Industries (Pvt)Ltd', 'NO. 49/16, Iceland Building, Galle, Road, Colombo 03.', '0114707707', '0114707769', '', '', '114707775', '', '100% In Advance', '2018-05-23 21:18:53', 1),
(37, 0000000037, 'Alpha Thermal Systems [Pvt] Ltd.', '121, Castle Street, Colombo 08', '0112679944', '', 'info@solartherm.lk', '', '112679945', '', 'Cheque on delivery', '2018-05-23 21:18:53', 1),
(38, 0000000038, 'Alston Stationery Pvt Ltd', '68, W.A.D. Ramanayake Mawatha, Colombo 02.', '0112436580', '0112441945', '', '', '112334374', '', '30 days credit. 0715388653 / 0710326455', '2018-05-23 21:18:53', 1),
(39, 0000000039, 'Alucop Cables Limited', 'P.O. Box 06 , Kaduwela', '0114412000', '0114412004', 'duminda@alucopcables.com', '', '112770291', '', '30 days credit', '2018-05-23 21:18:53', 1),
(40, 0000000040, 'Ambro Electricals', '92, 1st Cross Street, Colombo 11.', '0112458562', '0112423808', 'ambroel@sltnet.lk', '', '112327923', '', '30 days credit', '2018-05-23 21:18:53', 1),
(41, 0000000041, 'American Premium Water Systems (Pvt) Ltd.', '281/6,Centerpoint Building,R.A.De Mel Mw, Colombo 03', '0114514441', '', '', '', '114522836', '', '30 days credit', '2018-05-23 21:18:53', 1),
(42, 0000000042, 'American Premium Water Systems (Pvt) Ltd.', '523/5A, Mithripalasenanayake Mawatha, A\'pura', '0254923815', '', 'apwsapura@wow.lk', '', '254580267', '', '30 days credit', '2018-05-23 21:18:53', 1),
(43, 0000000043, 'Amster Office Automation', '#283/7, Old Kandy Road, Dalugama, Kelaniya', '0002912779', '', 'dsymons@sltnet.lk', '', '314873732', '114813222', '30 days credit', '2018-05-23 21:18:53', 1),
(44, 0000000044, 'AMW Computers', '132A/2, St. Joseph Street,  Nigombo', '0312228992', '', '', '', '312228992', '', '21 days credit', '2018-05-23 21:18:53', 1),
(45, 0000000045, 'AnS Information Technologies (Pvt) Ltd', 'No. 473 1/2, Galle Road, Colombo  3', '0114209171', '0114209172', 'ans@eureka.lk', '', '114209172', '', '30 days credit', '2018-05-23 21:18:53', 1),
(46, 0000000046, 'Anton Hardware', 'No. 139, Kotugoda Road, Seeduwa.', '0112258961', '', '', '', '', '', '100% In Advance', '2018-05-23 21:18:53', 1),
(47, 0000000047, 'Anuradha Agencies Pvt Ltd', 'No: 181, Negombo Road, Peliyagoda.', '0112931145', '', '', '', '', '', '07 days credit', '2018-05-23 21:18:53', 1),
(48, 0000000048, 'Apogee International (Pvt) Limited', 'No. 99/6, Rosmead Place, Colombo 07', '0112699699', '0777309409', '', '', '112695047', '', '50% advance and balance on delivery', '2018-05-23 21:18:53', 1),
(49, 0000000049, 'APP Engineering Lanka (Pvt) Ltd.,', 'No.26, 2nd Floor, Vajira Road, Colombo 4.', '0112501756', '', '', '', '112501759', '', '30 days credit', '2018-05-23 21:18:53', 1),
(50, 0000000050, 'Aqua Technologies (Pvt) Ltd.', 'No. 523, Kotte Road, Pitakotte', '0112861295', '', 'hydro@eureka.lk/sales@hydraqua.net', '', '114547634', '', '50% in advance & balance with delivery', '2018-05-23 21:18:53', 1),
(51, 0000000051, 'Ark Enterprises', 'No: 150, 152, Stanley Road, Jaffna,', '0212222052', '', '', '', '212224021', '', '30 days credit', '2018-05-23 21:18:53', 1),
(52, 0000000052, 'Armstrong Products', 'No. 554 A, Gonahena Junction, Ranmuthugala, Kadawatha', '0112972346', '0112972203', '', '', '112972203', '', 'Payment On Deliver. 0112925066', '2018-05-23 21:18:53', 1),
(53, 0000000053, 'Arpico Showroom', 'No. 97, Bank Site, Anuradhapura', '0252235703', '', '', '', '252235703', '', '30 days credit', '2018-05-23 21:18:53', 1),
(54, 0000000054, 'Aruna Timber Stores', '260, Weligampitiya, Ja-Ela', '0602124856', '', '', '', '', '', 'Cash', '2018-05-23 21:18:53', 1),
(55, 0000000055, 'Assidua Technologies Private Limited', 'No. 4A, Kawdana Road, Dehiwala, Sri Lanka.', '0112710088', '0112710090', '', '', '112710089', '', '30 days credit', '2018-05-23 21:18:53', 1),
(56, 0000000056, 'Associated Motorways (Private Limited)', 'Yamaha Town, 482, T. B. Jaya Mawatha, Colombo 10.', '0112699711', '0112699713', 'yamaha.OBM@amwltd.com', '', '', '', 'Full payment before delivery', '2018-05-23 21:18:53', 1),
(57, 0000000057, 'Auscar Engineering Services (Pvt)Ltd', 'Unit A1, Industrial Estate,  Ekala, Ja-Ela.', '0114351752', '0722253513', '', '', '112945516', '', '30 days credit', '2018-05-23 21:18:53', 1),
(58, 0000000058, 'Auto Lanka A/C', 'Nattandiya Road,Thabbowa', '0721724255', '', '', '', '', '', 'Progress Payment', '2018-05-23 21:18:53', 1),
(59, 0000000059, 'Aviva Trade Centre', 'No. 19-2/3, Abdul Hameed Street, Colombo 12', '0115238389', '', 'aviva@sltnet.lk', '', '112326622', '', '30 days credit', '2018-05-23 21:18:53', 1),
(60, 0000000060, 'Avro Trade Centre', 'No. 27-2,/Hulftsdort Street, Colombo-12', '0115238388', '0728933368', '', '', '112337977', '', 'Credit 30 days. 0755275090', '2018-05-23 21:18:53', 1),
(61, 0000000061, 'Bamber & Bruce (PVT) Ltd.', 'No. 22/A, Vijaya Kumaranatunge Mawatha, Colombo 05.', '0112514254', '', 'bbruce@sltnet.lk', '', '112514813', '', '100% in advance', '2018-05-23 21:18:53', 1),
(62, 0000000062, 'BaseHP (Pvt) LTD', 'No. 110 1/1, 1st Floor, Havelock Road, Colombo 05.', '0115746800', '0773610073', '', '', '112506633', '', '30 days credit', '2018-05-23 21:18:53', 1),
(63, 0000000063, 'Bearings & Spares (Pvt) Ltd', 'No. 179, Negambo Road, Kandana', '0112237276', '0112234256', 'bearings@sltnet.lk', '', '114830828', '', '30 days credit', '2018-05-23 21:18:53', 1),
(64, 0000000064, 'Belrig Projects & Agencies', 'No. 105B 1/1, Dutugemunu Street, Kohuwala', '0714048738', '0117632961', 'belrig@dialognet.lk', '', '', '', '50% Advance with PO Confimation, Balance on delivery', '2018-05-23 21:18:53', 1),
(65, 0000000065, 'Berakah Steels', 'No. 91, Princess Gate, Colombo 12, Sri Lanka.', '0112331317', '', '', '', '112331318', '', '30 days credit', '2018-05-23 21:18:53', 1),
(66, 0000000066, 'Bhoomi-Tech (Pvt) LTD.,', 'No.122,Hill Street, Dehiwala', '0112734551', '0112713088', 'bhoomi@lsplanka.lk', '', '112713088', '', '30 days credit', '2018-05-23 21:18:53', 1),
(67, 0000000067, 'Bianco (Pvt) Ltd.', 'No: 49/1, Fife Road, Colombo 05.', '0112507252', '', 'bianco@sltnet.lk', '', '112507251', '', 'Credit 30 days  ', '2018-05-23 21:18:53', 1),
(68, 0000000068, 'Blue Water Systems', 'No. 255 B, Hokandara Road, Thalawathugoda, Sri Lanka', '0115755369', '', '', '', '112796774', '', 'Progress Payment', '2018-05-23 21:18:53', 1),
(69, 0000000069, 'BME Services (Pvt) Ltd', 'No: 179/3, Polhengoda Road,Kirulapone , Colombo 5.', '0112816500', '', '', '', '112816555', '', 'Payment after Completion', '2018-05-23 21:18:53', 1),
(70, 0000000070, 'Boston Devices Pvt Ltd,', 'No: 125/2, Nawala Road, Narahenpita, Colombo 05.', '0112369377', '', '', '', '112369477', '', '30 days credit', '2018-05-23 21:18:53', 1),
(71, 0000000071, 'Brown & Company Plc', '481, T.B Jayah Mawatha, Colombo - 10', '0112663000', '', 'makitadirect@brownsgroup.com', '', '112307377', '', '30 days credit', '2018-05-23 21:18:53', 1),
(72, 0000000072, 'Browns Group Industries (Pvt) Ltd', 'Browns Industrial Park, Makandana, Gonawila, Pannala, Sri Lanka.', '0112663464', '0777448654', '', '', '312298097', '', '100% By Irrevocable LC at sight', '2018-05-23 21:18:53', 1),
(73, 0000000073, 'Building Services Engineering (Pvt)Ltd,', '122, Dawson Street, Colombo 02.', '0112432822', '0114717500', '', '', '112454653', '', '07 days credit', '2018-05-23 21:18:53', 1),
(74, 0000000074, 'Built-Mech Services (Pvt) Ltd', '125/2, Nawala RD, Narahenpita, Colombo 5', '0114403536', '0114401812', 'palitha@builtmech.net', '', '112369619', '', '30 days credit. 0114401813', '2018-05-23 21:18:53', 1),
(75, 0000000075, 'Business Machines Co. (Pvt.) Ltd.', '\"Business Machines Building\" #1, Lake Crescent Colombo 2, Sri Lanka.', '0112304380', '', '', '', '112304831', '', '07 days credit', '2018-05-23 21:18:53', 1),
(76, 0000000076, 'Business Solutions Systems (Pvt) LTD.', '#152,Nawala RD, Nugegoda', '0112832832', '0112832932', 'bss@bss.lk', '', '112809319', '', '30 days credit', '2018-05-23 21:18:53', 1),
(77, 0000000077, 'Butterfly Garden Structures', 'Gall Road, Kudawaskaduwa, Kalutara.', '0723575113', '', '', '', '', '', 'Payment on Delivery with on demand bank guarantee', '2018-05-23 21:18:53', 1),
(78, 0000000078, 'C & P Technologies (Pvt)Ltd', 'No. 91, Isipathana Mawatha, Colombo 05', '0112501899', '0714816096', '', '', '112501899', '', '30 days credit', '2018-05-23 21:18:53', 1),
(79, 0000000079, 'C.W. Mackie PLC', 'P.O. Box, 89, No. 36, D.R. Wijewardena Mawatha, Colombo 10.', '0112423554', '0771149515', '', '', '112331100', '112440228', '30 days credit', '2018-05-23 21:18:53', 1),
(80, 0000000080, 'Cambridge Traders', '22 E, Quarry Rd, Colombo  12', '0112432187', '0112437785', 'info@cambridgetrd.com', '', '112423153', '', '30 days credit', '2018-05-23 21:18:53', 1),
(81, 0000000081, 'Carousel Moldings (Private) Limited', '#148, Vauxhall Street, Colombo 02.', '0117866800', '0117866803', '', '', '117866810', '', '40 days credit', '2018-05-23 21:18:53', 1),
(82, 0000000082, 'Central Agency', '22, Queens RD, Colombo 12', '0112327870', '0112432450', '', '', '112336735', '', '30 days credit', '2018-05-23 21:18:53', 1),
(83, 0000000083, 'Central Electricals Lanka (Pvt) Ltd', '82,Maliban Street, Colombo-11', '0112449603', '0112435672', 'centralelec@sltnet.lk', '', '112449603', '', '30 days credit', '2018-05-23 21:18:53', 1),
(84, 0000000084, 'Central Industries PLC', 'No.312,Nawala RD, Rajagiriya', '0112806623', '', 'info@nationalpvc.com', '', '112806621', '', '30 days credit', '2018-05-23 21:18:53', 1),
(85, 0000000085, 'Ceramic Home', 'No. 189, Nawala Road, Nugegoda', '0112823355', '0770130046', '', '', '112852184', '', '30 days credit', '2018-05-23 21:18:53', 1),
(86, 0000000086, 'Ceylon Fibre Roving Services (Pvt) Ltd', 'No: 8, Araliya Mawatha, Mabole,Wattala.', '0112980185', '0714021184', 'bramik935@yahoo.com', '', '112980185', '', '14 days credit', '2018-05-23 21:18:53', 1),
(87, 0000000087, 'Ceylon Leather Products  PLC.', 'P.O.Box 01,Rathupaswala, Mudungoda', '0335228228', '', 'info@clplsrilanka.com', '', '332258751', '', '30 days credit', '2018-05-23 21:18:53', 1),
(88, 0000000088, 'Ceylon Steel Corporation Ltd', 'Oruwala, Athurugiriya, Sri lanka.', '0112206055', '0112206000', '', '', '112772211', '', '100% payment on collection', '2018-05-23 21:18:53', 1),
(89, 0000000089, 'Ceyoka (Pvt) Limited', 'No. 55, Negombo Road, Peliyagoda.', '0112989999', '', 'engineering@ceyoka.com', '', '112913910', '', '30 days credit', '2018-05-23 21:18:53', 1),
(90, 0000000090, 'Chalani Metals', '82/B, Minuwangoda Road, Kanuwana, Ja-Ela.', '0112241510', '0112234947', '', '', '', '', '30 days credit', '2018-05-23 21:18:53', 1),
(91, 0000000091, 'Charter House International (Pvt) Limited', 'No. 161, Nawala Road,  Colombo 5.', '0112368690', '', '', '', '112368625', '', '100% By Irrevocable LC at sight', '2018-05-23 21:18:53', 1),
(92, 0000000092, 'Chint Power Solutions (Pvt) Limited', 'No. 332/2, Galle Road,  Colombo 03.', '0112301915', '0112301996', '', '', '112391977', '', '30 days credit', '2018-05-23 21:18:53', 1),
(93, 0000000093, 'CIC Holdings PLC (NALCO Dept.)', 'No. 77, Sri Sasanajothi Mawatha, (Telawala Road), Ratmalana.', '0592610858', '', '', '', '114204377', '', '30 days credit', '2018-05-23 21:18:53', 1),
(94, 0000000094, 'City Electric Company', 'No. 6, De Fonseka Place, Bambalapitiya,Colombo 04, Sri Lanka.', '0112554499', '', '', '', '112595950', '', '30 days credit', '2018-05-23 21:18:53', 1),
(95, 0000000095, 'Colonial Electrical Equipments,', '545/B, Sri Sangaraja Mawatha,', '0112384593', '0112384545', '', '', '112424603', '112384593', '30 days credit', '2018-05-23 21:18:53', 1),
(96, 0000000096, 'Colonial Engineering (Pvt ) Ltd', '#138, Sri Sumanatissa Mawatha, Colombo  12', '0112334197', '0112472639', 'coloneng@sltnet.lk', '', '114610260', '', '30 days credit', '2018-05-23 21:18:53', 1),
(97, 0000000097, 'Cool King Ref Engineers & Suppliers', 'No: 211, Union  Place, Colombo 02', '0112334721', '', '', '', '112334726', '', '100% payment with confirmation order', '2018-05-23 21:18:53', 1),
(98, 0000000098, 'Cooltech Engineering Services (Pvt) LTD.', 'No. 21, St. Peter\'s Road, Moratuwa.', '0114208263', '0115514750', 'cooltech2007@yahoo.com', '', '114208263', '', '30 days credit', '2018-05-23 21:18:53', 1),
(99, 0000000099, 'Creative Technologies', '421/125,Darely RD, Colombo 10', '0112685580', '', 'creattive@eureka.lk', '', '112685580', '', 'Cash', '2018-05-23 21:18:53', 1),
(100, 0000000100, 'Crimson International', 'No. 159-1/4, Mahavidyalaya Mawatha, Colombo 13.', '0112445411', '0773011453', '', '', '112445411', '', '15 days credit', '2018-05-23 21:18:53', 1),
(101, 0000000101, 'Cubic Engineering Co. (Pvt) Ltd', 'N0. 370/1 , Nawala RD, Rajagiriya', '0112861010', '', 'info@cubic.lk', '', '112864040', '', '30 days credit', '2018-05-23 21:18:53', 1),
(102, 0000000102, 'Cygnet Technologies (Pvt) Ltd', '317/1, Old Nawala Road, Rajagiriya', '0112805178', '', 'cygnet@cygnet.com.lk', '', '112805178', '', '30 days credit', '2018-05-23 21:18:53', 1),
(103, 0000000103, 'D & M Engineering Company (Pvt) Ltd', '135/4D Pahala Biyanwila, Kadawatha, Sri Lanka.', '0115629327', '0115230403', '', '', '112923820', '', '14 days credit. 0773495734', '2018-05-23 21:18:53', 1),
(104, 0000000104, 'D. R. Manufacturing', 'No. 26th, Mile Postteet, Kandy Road, Nittambuwa - 11880', '0332299000', '', 'arosha@drmanufacturing.com', '', '332285449', '', '100% in advance', '2018-05-23 21:18:53', 1),
(105, 0000000105, 'D.J. Fabricators', 'No. 184/2/A, Halmulla, Wellampitiya.', '0112532715', '0773796244', '', '', '112532715', '', '14 days credit', '2018-05-23 21:18:53', 1),
(106, 0000000106, 'D.R. Industries (Pvt) Ltd', 'No. 746, Galle Road, Colombo 04.', '0112508590', '', 'corporate@damro.lk', '', '112508578', '', '100% in advance', '2018-05-23 21:18:53', 1),
(107, 0000000107, 'D.S. Engineering & Son (Private) Ltd', 'Office :#80, Horana Road, Panadura, Sri Lanka.', '0385090536', '0384281614', '', '', '382234033', '', '7 days credit', '2018-05-23 21:18:53', 1),
(108, 0000000108, 'Danis Trade Centre', 'No. 136-D, Vivekananda Hill,Colombo - 13.', '0112339464', '0713212489', '', '', '112339465', '', '30 days credit', '2018-05-23 21:18:53', 1),
(109, 0000000109, 'Data Master Computer Systems (PVT) LTD.', 'No.91,Bauddaloka Mawatha, Colombo - 4', '0112505479', '0112507164', '', '', '112505479', '', '30 days credit', '2018-05-23 21:18:53', 1),
(110, 0000000110, 'Dax Engineering Co. (Pvt) Ltd.', 'No. 223, Nawala Road,  Narahenpita, Colombo 05, Sri Lanka.', '0114547547', '0714527034', '', '', '117392910', '', 'Payment on Delivery', '2018-05-23 21:18:53', 1),
(111, 0000000111, 'Daya Fashion (Pvt) Ltd', 'No. 512/A, Kospalana Watta, Polpithimukalana, Kandana', '0112242219', '', '', '', '', '', '100% on delivery', '2018-05-23 21:18:53', 1),
(112, 0000000112, 'Debug Computer Peripherals (Pvt) Ltd.', '58, 42nd Lane, Wellawatte, Colombo - 6', '0112362612', '', '', '', '115338264', '', '30 days credit', '2018-05-23 21:18:53', 1),
(113, 0000000113, 'Dee & Sha Holdings', '138, Welipara, Dalugama, Kelaniya, Sri Lanka.', '0112916573', '0772975812', '', '', '112914520', '', '30 days credit', '2018-05-23 21:18:53', 1),
(114, 0000000114, 'Delmege Forsyth & Co.Ltd,', 'No: # 101 ,Vinayalankara Mw, Colombo 10.', '0117729229', '0117729396', '', '', '112665915', '', '30 days credit', '2018-05-23 21:18:53', 1),
(115, 0000000115, 'Demoni Traders', 'No. 126/1/1A, Mahavidyalaya Mawatha, Colombo 13, Sri Lanka.', '0112322550', '', '', '', '112322550', '', '30 days credit', '2018-05-23 21:18:53', 1),
(116, 0000000116, 'Deshani Trading ', 'No: 419, Galle Road,  Wadduwa.', '0387210518', '0383384178', '', '', '', '', 'By Cheque(at the returning of Equipment). 0777442577', '2018-05-23 21:18:53', 1),
(117, 0000000117, 'Dhanushka Engineering Co.(Pvt) Limited', 'Block 7-C ,Kolonnawa Industrial Estate,Mandawila Road,Gothatuwa New Town 10620 .', '1144135635', '', '', '', '112419274', '', 'progress payment', '2018-05-23 21:18:53', 1),
(118, 0000000118, 'Diaweb e Forms (Pvt) Ltd', 'No. 148, Naramminiya Road, Waragoda, Kelaniya.', '0112917604', '', '', '', '', '', '100% in advance', '2018-05-23 21:18:53', 1),
(119, 0000000119, 'Diesel & Moter Engineering Company Limited', '65, Jethawana Road, Colombo 14.', '0114497977', '', 'dimo@dimolanka.com', 'Diluk.DeSilva@dimolanka.com', '114741571', '', '45 days credit', '2018-05-23 21:18:53', 1),
(120, 0000000120, 'Dil Enterprises', 'No. 61 1/1, Messenger Street,  Colombo 12', '0112386723', '0777378779', 'dilenps@sltnet.lk', '', '112334840', '', '30 days credit', '2018-05-23 21:18:53', 1),
(121, 0000000121, 'Dilina Lanka Tiles & Hardware', 'No. 311, Colombo Road, Mukalangamuwa, Seeduwa.', '0113121700', '', '', '', '112265222', '', '07  days credit', '2018-05-23 21:18:53', 1),
(122, 0000000122, 'Dilshan Trading Company', 'No. 56, Hulftsdorp Street, Colombo 12.', '0112322000', '0114374442', '', '', '112338838', '', '30 days credit', '2018-05-23 21:18:53', 1),
(123, 0000000123, 'Dimo (Private) Limited', 'P.O. Box 339, No. 65, Jethawana Road, Colombo 14.', '0114607100', '', 'dimo@dimolanka.com', '', '114607101', '', '30 days credit', '2018-05-23 21:18:53', 1),
(124, 0000000124, 'Discount Sofa Centre', 'No. 1191/1, Negombo Road,Kandana.', '0114830606', '', '', '', '114830606', '', 'Full payment with order', '2018-05-23 21:18:53', 1),
(125, 0000000125, 'DMS Electronics (Pvt) Ltd', '12/1,  Tickell Road, Borella, Colombo 08.', '0114336337', '', 'sc@dmselectronics.com', '', '114741880', '', '30 days credit', '2018-05-23 21:18:53', 1),
(126, 0000000126, 'Dockyard General Engineering Services (PVT.) LTD.', '2,Srimath Bandaranayaka Mawatha, Colombo 12', '0242470809', '', 'dockyard@itmin.net', '', '114714151', '', '30 days credit', '2018-05-23 21:18:53', 1),
(127, 0000000127, 'Duro Pipe Industrial  (Pvt) Ltd', '307, 2 nd Flour, George R. De Silva Mawatha, Colombo  13', '0112440760', '', 'duropipe@sltnet.lk', '', '112432453', '', '30 days credit', '2018-05-23 21:18:53', 1),
(128, 0000000128, 'Dusky International (Pvt)Ltd,', 'No: 26/5, Jayaweera MW,Sri jayawardhanapura, Kotte.', '0112877185', '0727369827', '', '', '112869319', '', 'Payment after delivery', '2018-05-23 21:18:53', 1),
(129, 0000000129, 'Dynacom Engineering (Pvt) Ltd,', '451,Kandy Road,Kelaniya.', '0115394271', '0115394280', '', '', '112910797', '', '3 Month in Advance. 0770106088', '2018-05-23 21:18:53', 1),
(130, 0000000130, 'Dynagro (Pvt)Ltd', 'N0. 549 B, Isuru Uyana, D.P. Wijesinghe Mawatha, Thalangama South, Battaramulla.', '0112784797', '', '', '', '112786251', '', '100% By Irrevocable LC at sight', '2018-05-23 21:18:53', 1),
(131, 0000000131, 'Dynamic AV Technologies (Pvt) Ltd', 'No: 413, R.A. De Mel Mawatha, Colombo 03.', '0112589744', '', '', '', '112589733', '', '100 %  T/T in advance', '2018-05-23 21:18:53', 1),
(132, 0000000132, 'E Com Solutions (Pvt) Ltd', '151, Kaduwela Road, Battaramulla.', '0115511312', '', 'info@ecomik.com', '', '115511719', '', 'Full Payment On Confirmation', '2018-05-23 21:18:53', 1),
(133, 0000000133, 'East Link Engineering CO., (PVT) LTD.', 'No. 163/26, Nawala road, Colombo 05.', '0112505090', '', 'eastlin@sltnet.lk', '', '112368367', '', '30 days credit', '2018-05-23 21:18:53', 1),
(134, 0000000134, 'East Link Enternational (Pvt) Ltd', 'No. 241/31, Kirula Road, Colombo 05.', '0112368369', '', '', '', '112368268', '', '30 days credit', '2018-05-23 21:18:53', 1),
(135, 0000000135, 'Eco Stationery (Pvt) Ltd.', '54/A, Station Road, Wattala.', '0112940070', '', '', '', '112940070', '112943012', '14 days credit', '2018-05-23 21:18:53', 1),
(136, 0000000136, 'Edna Engineering (Pvt) Ltd', '336, Anwarama, Mawanella', '0352246462', '', 'virajith@edna.lk', '', '352246462', '', '30 days credit', '2018-05-23 21:18:53', 1),
(137, 0000000137, 'Electro Metal Pressings (Pvt) Limited', 'No. 26, Templeburg Industrial Estate, Panagoda', '0114442329', '0114442497', 'empfactory@sltnet.lk', 'empsales@sltnet.lk', '112751900', '', '30 days credit', '2018-05-23 21:18:53', 1),
(138, 0000000138, 'Electro Multi Trading (Pvt) Ltd', '103/7C, New Kandy Road, Kotalawala, Kaduwela.', '0113122422', '0112548494', 'emultitraders@gmail.com', '', '112579062', '', '30 days credit', '2018-05-23 21:18:53', 1),
(139, 0000000139, 'Electro Serv (Pvt) Limited', '124, Nawala Road, Narahenpita', '0112581104', '0112501928', 'electsev@sltnet.lk', 'salesa@electro-serv.lk', '112501691', '', '30 days credit', '2018-05-23 21:18:53', 1),
(140, 0000000140, 'Elite Radio & Engineering Co. (Pvt) Ltd.', 'No: 35/3, Nawala Road, Narahenpita, Colombo 05.', '0112368472', '', 'suren@eliteradio.com', 'engineering@eliteradio.com', '112368471', '', 'Cheque on delivery', '2018-05-23 21:18:53', 1),
(141, 0000000141, 'E-Mark Stationeries,', '40 B, Kosala Lane, Colombo 11.', '0112438221', '0777312820', '', '', '112438221', '', '30 days credit', '2018-05-23 21:18:53', 1),
(142, 0000000142, 'Empire Trading Agency', 'No.110, Layards Broadway, Colombo 14', '0112433047', '0115330470', 'empita@slt.lk', '', '112431180', '', '30 days credit', '2018-05-23 21:18:53', 1),
(143, 0000000143, 'Energy Management Systems (Pvt) Ltd.', 'No. 40, Amarasekara Mawatha,  Colombo 05.', '0112504531', '', 'wilmot@ems.lk', '', '112504532', '', '30 days credit', '2018-05-23 21:18:53', 1),
(144, 0000000144, 'Energynet Pvt Limited', '60,Ward Place, Colombo -7', '0115334477', '', '', '', '115349313', '', '30 days credit', '2018-05-23 21:18:53', 1),
(145, 0000000145, 'Enex Agencies (Pvt) Ltd', 'No. 29/A, Sri Premarathna Mawatha, Moratumulla, Moratuwa,                      Sri Lanka.', '0112653203', '0112654912', '', '', '112652693', '', 'Payment on Delivery. 0112652884', '2018-05-23 21:18:53', 1),
(146, 0000000146, 'Envee Supplies (Pvt) Ltd', 'No. 335, Nawala(Rajagiriya)Rd, Nawala, Sri Lanka.', '0112805813', '0112805366', '', '', '112806387', '', 'Payment on delivery', '2018-05-23 21:18:53', 1),
(147, 0000000147, 'Enveroplus Engineerings (Pvt) Ltd', '200/2B, Devala Road, Talangama South, Battaramulla, 10120, Sri Lanka.', '0112861679', '0115664489', '', '', '112889917', '', 'Progress Payment', '2018-05-23 21:18:53', 1),
(148, 0000000148, 'EsselTech Engineering (Pvt) Ltd', 'No-563, Orex City,  Ekala, Ja-Ela, Sri Lanka ', '0776556000', '', 'vithanagecw@esseltech.lk', '', '', '', '100% by Irrevocable LC at sight', '2018-05-23 21:18:53', 1),
(149, 0000000149, 'Euro Motors (Pte)Ltd.,', 'No. 94/40, Kirulapone Avenue, Polhengoda, Colombo 05', '0115504504', '', 'info@euromotors.lk', '', '112515724', '', '30 days credit', '2018-05-23 21:18:53', 1),
(150, 0000000150, 'Evergreen Lighting & Electrical (Pvt) Ltd', 'N0. G339, Nivasiepura, Kotugoda, Sri Lanka', '0114887888', '0114041414', 'veronica@xon-group.com', '', '112289494', '', '31 days credit. 0718444256', '2018-05-23 21:18:53', 1),
(151, 0000000151, 'Evoke Trading (Pvt) Ltd.', 'No. 120/A, Barnes Place, Colombo 07.', '0114899811', '', '', '', '112699760', '', '30 days credit', '2018-05-23 21:18:53', 1),
(152, 0000000152, 'Ewis Services (Pvt) Ltd', 'No. 252, Galle Road, Colombo - 00300', '0114520520', '0112452246', 'services@ewisl.net', '', '112447303', '', '100% In Advance', '2018-05-23 21:18:53', 1),
(153, 0000000153, 'Expo Technologies Pvt,  Ltd', 'Block 9A,Ocean View Tower Station RD, Colombo 04', '0112504821', '0112504822', '', '', '112504819', '', '30 days credit', '2018-05-23 21:18:53', 1),
(154, 0000000154, 'Felix Enterprises (Pvt) Ltd', 'No. 95, Regland Watta Junction, Colombo Road, Boyagane, Kurunegala.', '0374945207', '0374945208', '', '', '372221321', '', 'Cheque on Delivery', '2018-05-23 21:18:53', 1),
(155, 0000000155, 'Fencom Technologies  (Pvt) Ltd', 'No. 595,4th Floor, Colombo 6', '0115508098', '', '', '', '115531299', '', '30 days credit', '2018-05-23 21:18:53', 1),
(156, 0000000156, 'Fentons LTD', 'P.O. Box 310, \"TRELEAVEN,\" 350, Union Place, Colombo 2.             ', '0112448518', '', 'info@fentons.com', '', '112448517', '', '30 days credit', '2018-05-23 21:18:53', 1),
(157, 0000000157, 'Filtair International  (Pvt) Ltd', 'No. 16/2, Vishuddharama Road, Walgama.', '0382289299', '', 'filtairinternational@gmail.com', '', '382289331', '', '30 days credit', '2018-05-23 21:18:53', 1),
(158, 0000000158, 'Filtrene Pvt .Ltd', '570,Gall Road, Panadura', '0382244717', '', 'filtrene@sltnet.lk', '', '382232317', '', '30 days credit', '2018-05-23 21:18:53', 1),
(159, 0000000159, 'Finco Engineering (Private)Limited.', 'No: 291, Modera street, Colombo 01500', '0112546052', '', '', '', '112546056', '', 'Credit 30 Days', '2018-05-23 21:18:53', 1),
(160, 0000000160, 'Fire-X Projects (Pvt) Ltd', '283, Kerawalapitiya Road, Hendala, Wattala.', '0112932322', '', 'firex@sltnet.lk', '', '112932322', '', '30 days credit', '2018-05-23 21:18:53', 1),
(161, 0000000161, 'Flow Tech Engineering (Pvt) Ltd', '201-B, High Level Road, Nugegoda, Sri Lanka.', '0117675675', '', '', '', '117675676', '', '30 days credit', '2018-05-23 21:18:53', 1),
(162, 0000000162, 'Free Lanka Trading Co., Ltd', 'Level 3, Prince Alfred Tower, P.O. Box 125, No. 10, Alfred House Gardens, Colombo 03.', '0114523624', '0114523671', '', '', '114523651', '', '30 days credit', '2018-05-23 21:18:53', 1),
(163, 0000000163, 'Frostaire Industries (Pvt) Limited', '\"Frostaire House\" P.O. Box, 1952, 102 Union Place, Colombo 02', '0112473473', '0773188411', 'sales@frostaire.com', '', '112458899', '', '30 days credit', '2018-05-23 21:18:53', 1),
(164, 0000000164, 'FRP Services & Co (Lanka) Ltd.', 'No. 515, Galle Road, Mount lavinia.', '0112716902', '', 'frp@frplanka.com', '', '112739957', '', '30 days credit', '2018-05-23 21:18:53', 1),
(165, 0000000165, 'G.C.S. Traders,', '80/3, Tharunaweera Mawatha, Kalutara North,Kalutara.', '0342221712', '0344923858', '', '', '', '', 'Full Payment on delivery with on demand bank guarantee. 077 1810309 ,077 5532450', '2018-05-23 21:18:53', 1),
(166, 0000000166, 'Galle Electrical Enterprises (Pvt) Ltd', 'No. 76/A, Yatinuwara Veediya,  Kandy.', '0812204815', '', '', '', '812204815', '', 'Payment After delivery', '2018-05-23 21:18:53', 1),
(167, 0000000167, 'GD Creations', 'No. 74, Dawson Street, Colombo 02', '0114253238', '', 'info@gdcreations.com', '', '719378981', '', 'Full payment within one week after delivery', '2018-05-23 21:18:53', 1),
(168, 0000000168, 'GD Creations', 'No. 74, Dawson Street, Colombo 02.', '0114253238', '', 'info@gdcreations.com', '', '719378981', '', '7 Days Credit', '2018-05-23 21:18:53', 1),
(169, 0000000169, 'General Innovations (Pvt) Ltd', 'No. 133/7, Nawala Road, Narahenpita, Colombo 05.', '0112369975', '0112369976', 'sales@gen-innov.com', '', '112368226', '', '30 days credit', '2018-05-23 21:18:53', 1),
(170, 0000000170, 'General Sales Co (Pvt) Ltd', 'No. 191, Viking House, Galle Road, Mt. Lavinia.', '0112738674', '0112738675', '', '', '112735812', '', '30 days credit', '2018-05-23 21:18:53', 1),
(171, 0000000171, 'Gennext Private Limited', '158, Walukarama Road, Colombo 03, Sri Lanka.', '0114422040', '', 'ian.p@gennextteam.lk', '', '', '', '30 days credit', '2018-05-23 21:18:53', 1),
(172, 0000000172, 'Gestetner of Ceylon PLC.', 'P.O. Box 331, 248,Vauxhall , Vauxhall Street, Colombo-02', '0117725555', '', 'technical@gestetnersl.com', '', '117725541', '', '30 days credit', '2018-05-23 21:18:53', 1),
(173, 0000000173, 'Giga Tech Solutions', '39/1,Ground Floor, Fortune Arcade, Galle RD, Colombo  4', '0112597996', '0114908671', 'gts@dialogsl.net', '', '112597996', '', '30 days credit', '2018-05-23 21:18:53', 1),
(174, 0000000174, 'Gismo International (Pvt) Ltd', 'No. 150, Nawala Road, Nugegoda', '0112865914', '0112817884', '', '', '112865913', '', '60% Advance with bank Guarantee & Balance on delivery. 0773321999', '2018-05-23 21:18:53', 1),
(175, 0000000175, 'Global Tech Air Conditioning & Refrigeration Ltd', '8B, Corey Mawatha, Rajagiriya.', '0115735822', '', 'lazer@sltnet.lk', '', '112863162', '', '75% in advance before commencement and balance after completion', '2018-05-23 21:18:53', 1),
(176, 0000000176, 'Global Tech Services (Pvt) Ltd', 'No. 32, Battaramulla Road,Ethul Kotte.', '0114852780', '', '', '', '112053060', '', '50% upon order & 50% upon delivery', '2018-05-23 21:18:53', 1),
(177, 0000000177, 'Global Trans Logistics (Pvt) Ltd', '#214/3/2/142nd Floor, Camway Plaza, Srimath Bandaranayaka Mawatha, Colombo - 01200.', '0114375858', '0114376633', '', '', '112445454', '', '14 days credit. 0114376688', '2018-05-23 21:18:53', 1),
(178, 0000000178, 'Golden Trading Company', 'No. 190B, Bandaranayake Mawatha, Colombo.', '0115696709', '0714161536', '', '', '112447803', '', '30 days credit', '2018-05-23 21:18:53', 1),
(179, 0000000179, 'Green Aircon (Pvt) Ltd', 'No. 315, Jayantha Weerasekera Mawatha, Colombo 10.', '0117547700', '', '', '', '117547703', '', '95% of payment upon delivery Balance 05% retention  (for 01 Year)', '2018-05-23 21:18:53', 1),
(180, 0000000180, 'Green Safety Equipment', 'No : 405/E/1, Dippitigoda, Kelaniya.', '0767644337', '', 'greensafetyeg@gmail.com', '', '', '', '30 Days Credit', '2018-05-23 21:18:53', 1),
(181, 0000000181, 'Green Tech Engineering Consultants (Pvt) Ltd', 'No.2, Rajawatta Terrace,Off Siebel avenue, Colombo 06.', '0112827630', '', '', '', '112827630', '', 'Progress Payment', '2018-05-23 21:18:53', 1),
(182, 0000000182, 'H.E. Engineering (Pvt) Ltd', 'No. 170, St.Joseph Street, Colombo 14,', '0112341983', '0112341984', '', '', '112341985', '', '30 days credit. 0718733731', '2018-05-23 21:18:53', 1),
(183, 0000000183, 'H.L.P.Hardware', 'Ahungalla, Uragaha Road.', '0771304021', '', '', '', '', '', 'Payment on Delivery', '2018-05-23 21:18:53', 1),
(184, 0000000184, 'Hayleys Consumer Products Ltd.', '#25, Foster Lane, Colombo -10', '0114766200', '1126889569', '', '', '112688971', '', '30 days credit', '2018-05-23 21:18:53', 1),
(185, 0000000185, 'Hayleys Electronics Lighting (Pvt)Ltd', '#25,  Foster Lane, Colombo - 10', '0112166271', '0112166200', '', '', '112688971', '', '60% Advance Payment and Balance on Delivery. 0773710731', '2018-05-23 21:18:53', 1),
(186, 0000000186, 'Hayleys Industrial Solutions (Private) Limited', '25, Foster Lane, Colombo 10, Sri Lanka', '0114739700', '0112699100', '', '', '1126811392688880', '', '60% Advance with the order', '2018-05-23 21:18:53', 1),
(187, 0000000187, 'Hemsons International (PTE) Ltd', 'Hemas Building, P.O. Box 1945, No. 36, Bristol Street, Colombo 00100.', '0112327948', '0112323308', '', '', '112478234', '', '100% in advance', '2018-05-23 21:18:53', 1),
(188, 0000000188, 'Hunter & Company PLC', 'Hilti Centre, No. 207, Nawala Road, Nugegoda.', '0114713352', '', 'hunterhc@eo.lk', '', '114723208', '', '30 days credit', '2018-05-23 21:18:53', 1),
(189, 0000000189, 'Hydromech Engineering (Pvt) Ltd', 'No. 70/27, Andiris Mawatha, Old Kesbewa Road, Rattanapitiya, Boralesgamuwa, Sri Lanka.', '0112509911', '0114410127', '', '', '112509911', '', 'Payment on Delivery', '2018-05-23 21:18:53', 1),
(190, 0000000190, 'Hydromet (Pvt) LTD.', 'No. 55/D Epitamulla Road, Pitakotte', '0112862441', '', 'sales@hydroaqua.net', '', '114547634', '', '30 days credit', '2018-05-23 21:18:53', 1),
(191, 0000000191, 'I.Q. Systems (PVT) Ltd.', '35A 1/1, Sunethradevi Road, Kohuwala, Nugegoda.', '0112769969', '', '', '', '112826807', '', 'By Irrevocable LC at sight', '2018-05-23 21:18:53', 1),
(192, 0000000192, 'ICE Technologies (Pvt) Ltd.,', 'No: 941/5, 6th Lane,Parliament Drive,Ethul Kotte, Kotte', '0115231257', '0714307660', '', '', '112868555', '', 'Cheque on delivery with on demand bank guarantee', '2018-05-23 21:18:53', 1),
(193, 0000000193, 'IDAC ( Private ) Limited', '#21, Sri Sunandarama Road, Kalubowila', '0112764000', '', 'project@idacgroup.com', '', '112763800', '', 'Cash', '2018-05-23 21:18:53', 1),
(194, 0000000194, 'Illyas & Company (PVT) LTD', 'No. 107, Messenger Street, Colombo 12', '0112436407', '0112434936', 'info@illyasceramic.com', 'colomboagenc@sltnet.lk', '112332926', '112527922', '2 Weeks Credit. 0112389103/4, 0112432586', '2018-05-23 21:18:53', 1),
(195, 0000000195, 'Ilmas Glass', '362/1 B, Main Street, Ambagaha Handiya, Dharga Town', '0342290825', '0773999019', '', '', '', '', 'On Progress Payment', '2018-05-23 21:18:53', 1),
(196, 0000000196, 'Indigo Asia Computer Systems', 'No. 21/5A, Polhengoda Gardens, Colombo 05', '0115018786', '', '', '', '112825466', '', '30 days credit', '2018-05-23 21:18:53', 1),
(197, 0000000197, 'Industrial Plastics (Pvt) Ltd', '#148, Vauxhall Street, Colombo 02.', '0114760100', '', '', '', '115352741', '', '30 days credit', '2018-05-23 21:18:53', 1),
(198, 0000000198, 'Industrial Safety Equipment Co. (Pvt) Ltd.', '3, Gunasekara Gardens, Nawala Road, Rajagiriya.', '0112873230', '', 'isbc@isplanka.lk', '', '112866208', '', '30 days credit', '2018-05-23 21:18:53', 1),
(199, 0000000199, 'Industrial Technology Institute', 'No. 120/4 A, Vidya Mawatha, Colombo 07.', '0112379800', '', '', '', '112379950', '', '100% in advance', '2018-05-23 21:18:53', 1),
(200, 0000000200, 'Induwara Traders', 'No. 89/30, Jinadasa Nandasena MW, Kiribathgoda.', '0777210239', '', 'induwaratraders12@gmail.com', '', '', '', '30 days credit', '2018-05-23 21:18:53', 1),
(201, 0000000201, 'Intec Systems and Solutions (Pvt) Ltd', 'No. 40/22, Longdon Place,  Colombo 07, Sri Lanka', '0112055380', '', '', '', '112055381', '', '100 % By Irrevocable LC at sight', '2018-05-23 21:18:53', 1),
(202, 0000000202, 'Integrated Power Systems (Pvt) Ltd', '#107,Kynsey Road, Colombo 07', '0114855411', '', 'markdesilva1234@yahoo.com', '', '114722216', '', '30 days credit', '2018-05-23 21:18:53', 1),
(203, 0000000203, 'Intelligent Automations (Pvt) Limted', 'No. 35/A 1/1, Sunethra devi Road, Kohuwela, Nugegoda.', '0112769969', '', '', '', '112826807', '', '30 days credit', '2018-05-23 21:18:53', 1),
(204, 0000000204, 'Interior House (Pvt) Ltd', 'No. 61/2A, Nawala Road, Nugegoda.', '0722225069', '0722331516', '', '', '112768451', '', '30 days credit', '2018-05-23 21:18:53', 1),
(205, 0000000205, 'Intruder Solutions', 'No. 80 B, Galle Road, Mt. Lavinia.', '0114953575', '', '', '', '115550450', '', '65% advance for First three items & balance in handing over', '2018-05-23 21:18:53', 1),
(206, 0000000206, 'Isuru Lanka  Tech', 'No. 41/12, Jayakontha Lane, Kirula Road, Narahenpita, Colombo-05.', '0773104296', '0777565224', '', '', '', '', 'Cheque on Collection with on demand bank guarantee. 0114901912 ', '2018-05-23 21:18:53', 1),
(207, 0000000207, 'IT Services', 'No. 560/7/A, Mihindu Mawatha, Malabe.', '0752375097', '', 'itservices@gmail.com', '', '115631365', '', 'Credit 14 days', '2018-05-23 21:18:53', 1),
(208, 0000000208, 'J & A Trading', 'No. 116/3, Maradana Road, Handala, Wattala.', '0779851316', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:53', 1),
(209, 0000000209, 'J C Enterprises.,', '637 / 2 , Sirimavo Bandaranayake Mawatha, Colombo 14.', '0112385404', '', '', '', '112385403', '', '100% Payment on Collection', '2018-05-23 21:18:53', 1),
(210, 0000000210, 'J. S. Lanka Service & Suppliers (Pvt) Limited', 'No: 3/9 ,Church Road ,Wewala, Piliyandala.', '0114899954', '', '', '', '114232823', '', '65% dowm payment on confirmation & balance to be made within 30 days upon receiving invoice', '2018-05-23 21:18:53', 1),
(211, 0000000211, 'J.S.S. Enterprises (Pvt) Ltd.,', 'No. 121, Union Place, Colombo - 02', '0112393229', '0112389466', '', '', '112389467', '112446543', 'Cheque  On Delivery. 0112449543', '2018-05-23 21:18:53', 1),
(212, 0000000212, 'Janashakthi Insurance  PLC.', 'No. 46, Muttiah Road,  Colombo 02.', '0112303300', '', '', '', '117309196', '112132922', '90 days credit', '2018-05-23 21:18:53', 1),
(213, 0000000213, 'Janatha Steels', '20, Quarry Road, Colombo 12.', '0112421412', '', '', '', '112345667', '', '30 days credit', '2018-05-23 21:18:53', 1),
(214, 0000000214, 'Jat Holdings (Pvt) Ltd.,', '351, Pannipitiya Road,Thalawathugoda.', '0114407700', '0779974343', '', '', '112773793', '', '75% Advance , 15% after 50% completion & 10% on completion work', '2018-05-23 21:18:53', 1),
(215, 0000000215, 'JC Engineering (Pvt) Ltd', 'No: 637/2 ,Sirimavo Bandaranayaka Mawatha, Colombo 14.', '0112385404', '', '', '', '112385403', '', '75% Advance with on demand bank guarantee & Balance after Completion', '2018-05-23 21:18:53', 1),
(216, 0000000216, 'Jinanic Electricals', 'No. 215, Delgahawatta, Angoda', '0112578580', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:53', 1),
(217, 0000000217, 'Jinasena (Pvt) Ltd', 'No.176/1, Thibirigasyaya Road, Colombo 05.', '0112584919', '', 'lalith@jinasena.com.lk', '', '112584947', '', 'Full payment on collection', '2018-05-23 21:18:53', 1),
(218, 0000000218, 'JN Lanka Holdings Company (pvt) Ltd,', 'No. 249, Weligampitiya, Jaela', '0112238991', '0112238992', '', '', '112238990', '', '35 days credit', '2018-05-23 21:18:53', 1),
(219, 0000000219, 'John Keels Office Automation', '320/1, Union Place, Colombo-02', '0112431576', '0114702611', 'jkoa@keells.com', '', '112431745', '', 'Cash', '2018-05-23 21:18:53', 1),
(220, 0000000220, 'Johnan Japan (Pvt) Ltd', 'Ratmalana Industrial Estate,652, Galle Road, Ratmalana, Sri Lanka.', '0112137250', '', '', '', '112137251', '', 'Monthly Payment', '2018-05-23 21:18:54', 1),
(221, 0000000221, 'Johnan Lanka Machinery (Pvt) Ltd', 'Ratmalana Industrial Estate,652, Galle Road, Ratmalana, Sri Lanka.', '0112626333', '', '', '', '112626444', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(222, 0000000222, 'Jude A Fernando', '10, Ja-Ela Waththa,  Weligampitiya, Ja-Ela', '0114831533', '', '', '', '114831533', '', '30 days credit', '2018-05-23 21:18:54', 1),
(223, 0000000223, 'K. S. Trading (Pvt) Limited', 'No: 494/1, Nawala Road, Rajagiriya, Sri Lanka.      ', '0112887134', '', '', '', '114547615', '', '100 % By Irrevocable LC at sight', '2018-05-23 21:18:54', 1),
(224, 0000000224, 'K.I.K Industries', 'No. 31, Major Gunarathne Mawatha, Off Templers Road, Mount Lavinia - 10370', '9097909071', '', '', '', '', '', '100% in advance', '2018-05-23 21:18:54', 1),
(225, 0000000225, 'K.I.K. Engineering Co. (Pvt) Ltd', 'No 31, Major Gunarathna Mawatha, Off Templar\'s Road, Mount Lavinia.', '0112717413', '', 'kikecpl@kik.lk', '', '112715055', '', '30 days credit', '2018-05-23 21:18:54', 1),
(226, 0000000226, 'K.I.K.Lanka (Pvt)Ltd', 'Spur Rd, Phase 1, Export Pro Zone, Katunayake', '0112251111', '', 'kik@kik.lk', '', '112256501', '', '14 days credit', '2018-05-23 21:18:54', 1),
(227, 0000000227, 'K.R.S. Perera', 'No. 44/1, Minuwangoda Road, Kanuwana, Ja-Ela.', '0112241510', '0112234947', '', '', '112286599', '', '30 days credit. 0724182782', '2018-05-23 21:18:54', 1),
(228, 0000000228, 'Karuna Mattress Centre', '204 A, Sea Beach Road, Colombo 11.', '0112435767', '', '', '', '', '', 'Cheque on delivery', '2018-05-23 21:18:54', 1),
(229, 0000000229, 'Kelani Cables PLC.', 'P.O. Box 14, Wewelduwa, Kelaniya.', '0112911224', '', 'info@kelanicables.com', '', '112910481', '112913284', '30 days credit', '2018-05-23 21:18:54', 1),
(230, 0000000230, 'Ken Tools and Machineries INT\'L (PVT) LTD.', 'No. 321, Sri Sangaraja Mawatha, Colombo 10.', '0114883935', '', 'info@kenlanka.com', '', '112326246', '', 'Cheque on delivery', '2018-05-23 21:18:54', 1),
(231, 0000000231, 'Kevilton Electrical Products (Pvt) Ltd.', '#148, Vauxhall Street, Colombo 02.', '0114760100', '', 'kevilton.sales@slon.maharaja.lk', '', '117267247', '115352741', '45 days credit', '2018-05-23 21:18:54', 1),
(232, 0000000232, 'Key Group Three (Private) Ltd.', '462, T.B. Jayah Mawatha, Colombo 10.', '0112688809', '', 'keygrp3@sltnet.lk', '', '112688808', '', '30 days credit', '2018-05-23 21:18:54', 1),
(233, 0000000233, 'Kins Global Trading (Pvt) Ltd', 'No. 455, Colombo Road, Negombo', '0312227764', '', 'kinsglobal@sltnet.lk', '', '312228368', '', '7 days credit', '2018-05-23 21:18:54', 1),
(234, 0000000234, 'Kir Holdings (Pvt)  Limited', '186C,Anagarika Dharmapala Mawatha, Dehiwala', '0112713580', '0112715548', 'kirhold@dialogsl.net', '', '114307956', '', '30 days credit', '2018-05-23 21:18:54', 1),
(235, 0000000235, 'KLC Engineering', 'No. 88/7, Vijitha Lane, Egodauyana, Moratuwa.', '0113164383', '', 'klcengineer@yahoo.com', '', '112484783', '', '30 days credit', '2018-05-23 21:18:54', 1),
(236, 0000000236, 'Lahiru Engineering', 'No: 103/C 1, Laksiri Japapadaya, Bandarawattha,Seeduwa.', '0112260582', '0777131526', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(237, 0000000237, 'Lahiru Industries', 'No.9/3, Ragama Rd., Pahala Karagahamuna, Kadawatha', '0114934289', '0724119797', '', '', '', '', 'Cash', '2018-05-23 21:18:54', 1),
(238, 0000000238, 'Lahiru Pest Control & Environmental Services (Pvt)Ltd,', 'No: 139A,Old Negombo Road, Ja-Ela', '0115853406', '', '', '', '112239591', '', 'Before Strating treatment', '2018-05-23 21:18:54', 1),
(239, 0000000239, 'Lakshan Industries', '707/A,Korathota North, Kaduwela', '0114443760', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(240, 0000000240, 'Lalanka Water Management  (Pvt) Ltd', '13/3,Sri Dharmarama Road, Ratmalana', '0112722486', '', 'lalanka@eureka.lk', '', '112724997', '', '30 days credit', '2018-05-23 21:18:54', 1),
(241, 0000000241, 'Lanka Communication Services (Pvt)Ltd', 'No. 65 C, Dharmapala Mawatha, Colombo 07', '0112437545', '', '', '', '112437547', '', '50% Advance & Balance Payment 15 days after completion', '2018-05-23 21:18:54', 1),
(242, 0000000242, 'Lanka Development Network Private LImited', '60, S. De S. Jayasinghe Mawatha, Kohuwala, Sri Lanka.', '0112824775', '', '', '', '112825256', '', '50% In Advance with on demand bank guarantee, Balance on delivery', '2018-05-23 21:18:54', 1),
(243, 0000000243, 'Lanka Polymers (Pvt) Ltd', 'No.191, Hekitta Road, Wattala', '0112933456', '0112933460', 'hants@slt.lk', '', '112934155', '', '30 days credit', '2018-05-23 21:18:54', 1),
(244, 0000000244, 'Lanka Transformers Ltd.,', 'No. 154/11, Station Road, Angulana, Moratuwa - 10400', '1124013058', '', 'galvanize@lti.k', '', '112401309', '', '100% in advance', '2018-05-23 21:18:54', 1),
(245, 0000000245, 'Lankan Hume Pipes Company (Private) Limited', 'Horatuduwa, Polgasovita, Piliyandala, Sri Lanka.', '0112704312', '0112602589', '', '', '112704368', '', '14 days credit', '2018-05-23 21:18:54', 1),
(246, 0000000246, 'Lapzone (pvt) Ltd', 'No. 31, Galle Road, Colombo 04, Sri Lanka', '0112592594', '0112583900', 'pradeeth@lapzone.lk', 'lapzone@sltnet.lk', '112592594', '', '30 days credit. 0756901991 / 0710529791', '2018-05-23 21:18:54', 1),
(247, 0000000247, 'Leadingway Ventures (Private) Limited', 'No. 75A, 1st Floor, Hill Street, Dehiwala, Sri Lanka', '0115288856', '0115288858', '', '', '112710959', '', '30 days credit. 0777367366', '2018-05-23 21:18:54', 1),
(248, 0000000248, 'Leap Inc.', 'No. 30, Mount Plaza Residencies, Station Road, Mount Lavinia.', '0775588943', '', 'Ravi@leapincorp.com', '', '112763800', '', '100% with the PO', '2018-05-23 21:18:54', 1),
(249, 0000000249, 'LECS International', '144 High Level Road, Colombo 06, Sri Lanka', '0112514800', '0112514801', '', '', '112514802', '', '50% Advance Payment and Balance within 30 days. 0112514805', '2018-05-23 21:18:54', 1);
INSERT INTO `suppliers` (`suppliers_table_id`, `supplier_code`, `supplier_name`, `supplier_address`, `supplier_contact_no1`, `supplier_contact_no2`, `supplier_email1`, `supplier_email2`, `supplier_fax_no1`, `supplier_fax_no2`, `supplier_description`, `saved_datetime`, `saved_user`) VALUES
(250, 0000000250, 'Liberty Motor Associates (Pvt) Ltd', 'No. 488, Sri Sangaraja Mawatha, Colombo 10, Sri Lanka.', '0112321384', '0112451044', '', '', '112446454', '', '30 days credit', '2018-05-23 21:18:54', 1),
(251, 0000000251, 'Logiventures (Pvt) Ltd', 'No. 317, Negombo Road, Welisara.', '0114815815', '', 'info@logiventures.com', '', '112233607', '', 'Monthly Basis', '2018-05-23 21:18:54', 1),
(252, 0000000252, 'Lucksons', 'Kanuwana, Ja-Ela', '0112236855', '', '', '', '112231161', '', '30 days credit', '2018-05-23 21:18:54', 1),
(253, 0000000253, 'Lucky Hardware', '77,Bank Site, Anuradhapura', '0252223874', '', '', '', '252223874', '', '30 days credit', '2018-05-23 21:18:54', 1),
(254, 0000000254, 'M.A.P. Senevirathne', 'Kaluwamodara, Aluthgama.', '0777394426', '', '', '', '', '', '100% in advance', '2018-05-23 21:18:54', 1),
(255, 0000000255, 'M.P. Silva', '501, Wellabada, Kuda Waskaduwa,Waskaduwa.', '', '', '', '', '', '', '07 days credit after delivery', '2018-05-23 21:18:54', 1),
(256, 0000000256, 'Macbertan  (Private) Limited', '# 74 1/1, Orient Building, Dawson Street, Colombo 02.', '0117685720', '', '', '', '117685727', '', '30 days credit', '2018-05-23 21:18:54', 1),
(257, 0000000257, 'Macksons Paints Lanka (Pvt) Ltd', 'No: 75/1, Wattalpola Road, Henamulla, Panadura.', '0115556559', '', 'www.multilac.com', '', '115556559', '', 'Cheque on delivery', '2018-05-23 21:18:54', 1),
(258, 0000000258, 'Magline Switchboards (Pvt) Ltd', '380, Telawala Road, Mt. Laviniya', '0112637555', '0114205721', 'handunge@magline.net', '', '112624981', '', '30 days credit', '2018-05-23 21:18:54', 1),
(259, 0000000259, 'Makwell International (Pvt) Ltd                                                                   (Suran Distributors)', 'No. 09, Chilaw Road, Dalupotha, Negombo. ', '0312223535', '0777895555', 'manjukawpm@gmail.com', 'surandistributors@yahoo.com', '312223535', '', '30 days credit. 0773876700 ', '2018-05-23 21:18:54', 1),
(260, 0000000260, 'Marlbo Trading Company', 'No. 24, Abdul Gaffoor Mawatha, Colombo - 03.', '0112576999', '0112577874', '', '', '112577872', '', '30 days credit. 0770104618', '2018-05-23 21:18:54', 1),
(261, 0000000261, 'Maspro Lanka (Private) Limited', '155, U.D.A. Industrial Estate, Katuwana Road, Homagama.', '0112855571', '', '', '', '112855572', '', '30 days credit', '2018-05-23 21:18:54', 1),
(262, 0000000262, 'Master Designs', '21,Samagi Mawatha, Off Pantalin Mawatha, Rilaulla, Kandana.', '0114368817', '', '', '', '114830509', '', '100% on delivery', '2018-05-23 21:18:54', 1),
(263, 0000000263, 'Mathura Steel', '333 1/1, Old, Moor Street, Colombo  12', '0112336757', '', 'mathuras@sltnet.lk', '', '112440960', '', '30 days credit', '2018-05-23 21:18:54', 1),
(264, 0000000264, 'Max Link Technologies', 'No. 105, Unity Plaza, Colombo 04.', '0114383840', '0114545967', '', '', '112581158', '', '100% by cheque with order. 0772335111, 0766920377', '2018-05-23 21:18:54', 1),
(265, 0000000265, 'Mclarence Lubricants Limited', 'No. 284, Vauxhall Street, Colombo  02', '0114799155', '0114799100', 'secretariat@mclarenslubes.lk', '', '114621297', '', '30 days credit', '2018-05-23 21:18:54', 1),
(266, 0000000266, 'McShaw Automotive Limited', 'No. 284, Vauxhall Street, Colombo 02.', '0114799100', '', '', '', '114621297', '', '30 days credit', '2018-05-23 21:18:54', 1),
(267, 0000000267, 'Mechmar Cochran Lanka (Pvt) Ltd', 'No 543, Negombo Road, Wattala', '0112947182', '0114818896', 'Mechmar@slt.lk', '', '112981982', '', '30 days credit', '2018-05-23 21:18:54', 1),
(268, 0000000268, 'Mega Heaters (Pvt) Ltd.', '# 691, Station Road, Kottawa, Pannipitiya.', '0112851328', '0112898800', 'mega@sltnet.lk', '', '112847718', '', '50% in advance & balance on delivery', '2018-05-23 21:18:54', 1),
(269, 0000000269, 'Memory Technologies Lanka (Pvt) Ltd.', 'No: 14, Palmyrah Avenue, Colombo 3.', '0115344365', '', '', '', '115577994', '', '30 days credit', '2018-05-23 21:18:54', 1),
(270, 0000000270, 'Metropolitan Agencies', 'No. 85, Braybrooke Place, Colombo - 00200', '', '', '', '', '', '', '100% in advance', '2018-05-23 21:18:54', 1),
(271, 0000000271, 'Metropolitan Air-conditioning and Refrigeration (Pvt) Ltd', '#402/A, Kaduwela Road, Thalangama North, Battaramulla.', '0114539771', '', '', '', '114539788', '', '30 days credit', '2018-05-23 21:18:54', 1),
(272, 0000000272, 'Metropolitan Computers (Pvt.) Ltd.', 'M-centre, No. 394, Negombo Road, Wattala.', '0114610162', '', 'ayub.a@metropolitan.lk', '', '112941902', '', 'Payment on delivery', '2018-05-23 21:18:54', 1),
(273, 0000000273, 'Metropolitan Engineering (Pvt)Ltd', 'No. 402/A, Thalangama North, Battaramulla.', '0114524800', '', 'powersystems@metropolitan.lk', '', '114524888', '', '30 days credit', '2018-05-23 21:18:54', 1),
(274, 0000000274, 'Metropolitan Office (Pvt) Ltd.', 'No 106, Colombo RD, Gampaha', '0332227483', '', '', '', '332225711', '', '30 days credit', '2018-05-23 21:18:54', 1),
(275, 0000000275, 'Metropolitan Office (Pvt) Ltd.', 'No 12, Magazine Road, Colombo 08', '0112437797', '', '', '', '112685322', '', '30 days credit', '2018-05-23 21:18:54', 1),
(276, 0000000276, 'Metropolitan Office (Pvt) Ltd.', '334/110F,Maithripala Senanayake MW, A\'PURA', '0252222073', '', 'anura@metropolitan.lk', '', '252224417', '', '30 days credit', '2018-05-23 21:18:54', 1),
(277, 0000000277, 'Micro Bytech International (Pvt) Ltd.', '141/1, High Level Road,  Nugegoda.', '0112815481', '0114510546', 'bytechg@eureka.lk', '', '114517925', '', '30 days credit', '2018-05-23 21:18:54', 1),
(278, 0000000278, 'Micro Bytech Trading', '59/1,High Level Road, Kirullapone, Colombo - O6', '0112514451', '0112513162', 'bytechg@eureca.lk', '', '112513030', '', '30 days credit', '2018-05-23 21:18:54', 1),
(279, 0000000279, 'Micro Innovations', 'No. 35/2, Godagama Road, Athurugiriya, Sri Lanka.', '0777661234', '', '', '', '', '', '2 Weeks credit', '2018-05-23 21:18:54', 1),
(280, 0000000280, 'Microchem Laboratories (Pvt) Ltd.', 'No. 112/1A, 1/1, Stanley Thilakarathne Mw., Nugegoda.', '0112827123', '0773152797', '', '', '112829123', '', '100% in advance', '2018-05-23 21:18:54', 1),
(281, 0000000281, 'Miyoko International', 'No. 217, Colombo Road, Wanduragala, Kurunegala.', '0372227940', '', '', '', '372222688', '', 'Cheque on Delivery', '2018-05-23 21:18:54', 1),
(282, 0000000282, 'Monara Steel Centre', '333 2/18, Old Moor Steet, Colombo - 12', '0112470738', '0112470739', 'monara333@sltnet.lk', '', '112320108', '', '30 days credit', '2018-05-23 21:18:54', 1),
(283, 0000000283, 'Moon Hardware Centre', 'No. 375-A, Old Moor Street, Colombo 12', '0112345873', '0112344060', 'nmoon@sltnet.lk', '', '114716234', '114716235', '30 days credit. 0112440959', '2018-05-23 21:18:54', 1),
(284, 0000000284, 'My-Lan Marketing', '#18,De Voss Avenue, Colombo 4', '0112597713', '0112588444', 'freshcatch@mymail.lk', 'mmkg2009@gmail.com', '112588777', '', '30 days credit', '2018-05-23 21:18:54', 1),
(285, 0000000285, 'Narah Computer Forms', 'Industrial Complex, 309/4C, Negombo Road, Welisara.', '0112245700', '', 'narahncf@sltnet.lk', 'narahncf@gmail.com', '112245900', '', '30 days credit', '2018-05-23 21:18:54', 1),
(286, 0000000286, 'National Engineering Research & Development Centre of Sri Lanka', '2P/17B, Industrial Estate, Ekala, Ja-Ela, Sri Lanka', '0112236284', '0112236384', 'nerdcentre@nerdc.lk', 'electrical@nerdc.lk', '112233153', '', '100% In Advance. 0112236307', '2018-05-23 21:18:54', 1),
(287, 0000000287, 'Natural Lighting (Pvt) Ltd,', '19/2-A ,New Parliament Road,Palawatte,  Battaramulla.', '0112177020', '', '', '', '112177021', '', '30 days credit', '2018-05-23 21:18:54', 1),
(288, 0000000288, 'Nawakrama (Pvt) Ltd', 'No. 55,Negambo Road, Peliyagoda', '0115344444', '', 'engineering@nawakrama.com', '', '112913910', '', '30 days credit', '2018-05-23 21:18:54', 1),
(289, 0000000289, 'Nawaloka Trading Co., Ltd', '55, Negombo Road, Peliyagoda.', '0112949564', '', 'sanjaya@nawalokatrading.com', '', '112949561', '', '50% in advance & balance on delivery', '2018-05-23 21:18:54', 1),
(290, 0000000290, 'Neat Lanka (Pvt)Ltd', '10,Shop, 3/23,Majestic City, Station RD, Colombo 4', '0112586658', '', 'neatmc@webstation.lk', '', '112595512', '', 'Cash', '2018-05-23 21:18:54', 1),
(291, 0000000291, 'Negombo Sales Centre', 'No: 64, Ave Maria Road, Negombo.', '0312232400', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(292, 0000000292, 'Net Sys Solutions Limited', '69/7A, Kuruppu Road, Borella, Colombo 08.', '0112683585', '', 'info@netsyslk.com', 'alwist@mgmrnet.com', '115511910', '', '30 days credit', '2018-05-23 21:18:54', 1),
(293, 0000000293, 'New Lalith Tailors & Textiles', 'No: 144/3, Gampaha Road, Makewita.', '0333430538', '0770715439', '', '', '', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(294, 0000000294, 'New R. E. Shutter 2000', 'No. 86/1, Baseline Road, Seeduwa North, Seeduwa.', '0777542117', '0111372440', '', '', '112251610', '', 'In Advance', '2018-05-23 21:18:54', 1),
(295, 0000000295, 'New Royal Electrical', 'No. 57/4, Kanaththa Road, Hendala,Wattala, Sri Lanka.', '0112938428', '0114930863', '', '', '112938428', '', '30 days credit', '2018-05-23 21:18:54', 1),
(296, 0000000296, 'Newrow Electrical Engineering (pvt) Ltd.', 'No: 407, Janatha Mawatha, Attidiya, Dehiwela.', '0113042831', '', 'newrow@sltnet.lk', '', '112712112', '', '30 days credit', '2018-05-23 21:18:54', 1),
(297, 0000000297, 'Next Gen Technologies (Pvt) Ltd', 'No. 410, A, 1st Floor, Lalsons\' Building, Galle Road, Colombo 03.', '0772674465', '', 'info@nextgentech.lk', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(298, 0000000298, 'NextEn (Pvt) Ltd,', 'No: 719, Ethul Kotte, Kotte, Sri Lanka, 10100.', '0715304305', '0772 042031', '', '', '', '', '14 days credit', '2018-05-23 21:18:54', 1),
(299, 0000000299, 'Nich Interior Solutions,', 'No: 178, Negombo Road, Rilaulla , Kandana.', '0112225590', '0718366730', 'nichholdings1@gmail.com', '', '112953935', '', '75% on confirmation with on demand Bank Guarantee & 25% on delivery', '2018-05-23 21:18:54', 1),
(300, 0000000300, 'Nickon Trading Company', 'No. 78/6, Maliban Street, Colombo 11', '0112444891', '0716136396', '', '', '112444891', '', '30 days credit', '2018-05-23 21:18:54', 1),
(301, 0000000301, 'Nikini Automation Systems (Pvt) Limited', 'No. 249, High Level Road, Colombo 5.', '0112826894', '', '', '', '112826252', '', '50% in advance and balance after 14 days of delivery', '2018-05-23 21:18:54', 1),
(302, 0000000302, 'Nimal Super Light (Pvt) Ltd', 'No: 108, Hospital Road, Kalubowila, Dehiwala', '0112727198', '0112732535', '', '', '112727198', '', '50% Advance & Balance after completion. 0722289255', '2018-05-23 21:18:54', 1),
(303, 0000000303, 'Nimal Tyre Works', '214, Negombo Rd, Ja-Ela', '0112231451', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(304, 0000000304, 'Nirmanthi Timber Stores', '128, Baseline Road, Seeduwa', '0112252406', '0112252468', '', '', '112255103', '', '30 days credit', '2018-05-23 21:18:54', 1),
(305, 0000000305, 'Nosters (Pvt) Ltd.', '5, Park Circus Road, Colombo 05.', '0114209152', '', '', '', '114209153', '', '100% on delivery', '2018-05-23 21:18:54', 1),
(306, 0000000306, 'Novatec Sanitaryware Lanka (Pvt) Ltd', 'No. 09, Chilaw Road, Dalupotha, Negombo. ', '3122223535', '0773876700', '', '', '312223535', '', '30 days credit', '2018-05-23 21:18:54', 1),
(307, 0000000307, 'NPS Equipment (Pvt) Ltd', '132, Maya Avenue, Colombo 06, Sri Lanka', '0114542896', '0773475970', '', '', '112508647', '', '100 % By Irrevocable LC at sight', '2018-05-23 21:18:54', 1),
(308, 0000000308, 'Omega Engineering & S.S. Fabricators (Pvt) Ltd', 'No. 53/D, Kossinnawatte Road, , 10th Mile Post, Katuwawala, Borelasgamuwa, Sri Lanka.', '0115768865', '0115768866', '', '', '112518377', '', '75% Advance with on demand bank guarantee, balance on completion. 0777760848', '2018-05-23 21:18:54', 1),
(309, 0000000309, 'Onco Solutions (Pvt) Ltd', '343/2A, Athurugiriya Road, Hokandara North, Hokandara, Sri Lanka.', '0773285033', '', '', '', '', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(310, 0000000310, 'Onida Steels', '41,Quarry Road, Colombo  12.', '0112445065', '0112338889', 'info@onidasteels.com', '', '112338889', '', '30 days credit', '2018-05-23 21:18:54', 1),
(311, 0000000311, 'Open Systems Technologies (Pte) Ltd.', '1st Floor ,E.H.Cooray Bldg,  411,Gall RD, Colombo 3', '0112301734', '', 'ost@eopnsys.com', '', '115338501', '', '30 days credit', '2018-05-23 21:18:54', 1),
(312, 0000000312, 'Orel MFG (Pvt) Ltd.', '34,Old Road, Nawinna, Maharagama.', '0114792100', '', 'sales@orelpower.com', '', '114792128', '', '30 days credit', '2018-05-23 21:18:54', 1),
(313, 0000000313, 'Orel Solutions (Pvt) Ltd.', 'No. 34,Old Road, Nawinna, Maharagama.', '0114792100', '', 'sales@orelpower.com', '', '114792128', '', '30 days credit', '2018-05-23 21:18:54', 1),
(314, 0000000314, 'Orient Insurance Limited', '133, New Bullers Road, Colombo o4', '0112030300', '', '', '', '112555589', '', '30 days credit', '2018-05-23 21:18:54', 1),
(315, 0000000315, 'Oseli Fashion & Exporters', 'No. 242/2, Robert Gunawardena Mawatha,Battaramulla.', '0332295839', '0773557354', '', '', '', '', '7 Days Credit', '2018-05-23 21:18:54', 1),
(316, 0000000316, 'Oxygen house (Pvt) Ltd.', '180/1, Ragama Road, Kadawatha', '0112901119', '', '', '', '112928089', '', '30 days credit', '2018-05-23 21:18:54', 1),
(317, 0000000317, 'P. R. K. Engineering (Pvt) Ltd.', '156, Mihindu Mawatha, Bangalawatta, Kottawa,  Pannipitiya.', '0112782306', '', 'prkengineering@sltnet.lk', '', '112782306', '', 'Credit 07 days', '2018-05-23 21:18:54', 1),
(318, 0000000318, 'P.N.Traders', 'N0.43, Maliban Street, Colombo 11', '0112451989', '', '', '', '112437636', '', '30 days credit', '2018-05-23 21:18:54', 1),
(319, 0000000319, 'Paskal Engineering Co (Pvt) Ltd.', 'No. 241/31, Kirula Road, Colombo 05.', '0112369469', '', 'paskal.lk', '', '112369470', '', '30 days credit', '2018-05-23 21:18:54', 1),
(320, 0000000320, 'PC Technologies', 'No: 311, 1st Floor, Unity Plaza,  Galle Road, Colombo 04.', '0114510624', '', '', '', '114510624', '', 'Payment of Delivery', '2018-05-23 21:18:54', 1),
(321, 0000000321, 'Pee Bee Management Services (Pvt) Ltd', '35, U.D.A Industrial Estate, Katuwana RD, Homagama', '0112855492', '0112892031', 'peebeemanagement@peebeegroup.com', '', '112892033', '', '30 days credit', '2018-05-23 21:18:54', 1),
(322, 0000000322, 'Perera Concrete Works', '01,St. Ana Rd,Weligampitiya, Ja-Ela', '0112234278', '', '', '', '', '', 'Cash', '2018-05-23 21:18:54', 1),
(323, 0000000323, 'Personal Safety Equipment Company', 'No. 40, 3rd Floor Super Market, Colombo 08, Sri Lanka.', '0112671011', '0114012172', '', '', '112684789', '', '2 Weeks Credit', '2018-05-23 21:18:54', 1),
(324, 0000000324, 'Phoenix Industries LTD', '35, Ragama Road,Welisara', '0114726333', '0773992147', '', '', '112958007', '', '30 days credit', '2018-05-23 21:18:54', 1),
(325, 0000000325, 'Pidilite Lanka (Private) Limited.', '# 74 1/1, Orient Building, Dawson Street, Colombo 02.', '0117685720', '0117685721', '', '', '117685727', '', '30 days credit. 01176857216, 0777772857', '2018-05-23 21:18:54', 1),
(326, 0000000326, 'Plumbing Service', 'Ground Road, Anechenei, Muthur.', '0789599618', '', '', '', '', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(327, 0000000327, 'Polycrome Electrical Industries  (Pvt) Ltd.', 'No: 333/9, Old Kesbewa Road, Rattanapitiya, Boralesgamuwa.', '0114308801', '0114308802', 'pradeep@polycrome.lk', 'nadeekaa@polycrome.lk', '112509580', '', '07 days credit', '2018-05-23 21:18:54', 1),
(328, 0000000328, 'Polymer Products Impex (Private Limited)', '200/2, Sri Indrasara Mawatha, Aruggoda, Panadura, Sri Lanka 12500.', '0382234515', '0773472829', '', '', '382238725', '', '50% on order confirmation & balance on delivery', '2018-05-23 21:18:54', 1),
(329, 0000000329, 'Precision Tech Services (Pvt) Ltd.', 'No 152, Nawala Road, Nugegoda.', '0112832832', '', 'pts@pts.lk', '', '112809319', '', '30 days credit', '2018-05-23 21:18:54', 1),
(330, 0000000330, 'Premium Stationers (Pvt)Ltd', 'No. 4, Gound Floor, Liberty Plaza, Colombo 03.', '0112574793', '0112370386', '', '', '112301292', '', 'Cheque on Delivery', '2018-05-23 21:18:54', 1),
(331, 0000000331, 'Pubudu Engineering (Pvt) Ltd,', 'No: 68, UDA Industrial Estate, Katuwana Road,Homagama.', '0112855584', '0718734076', 'thilina@pubudueng.net', '', '114308344', '', '30 days credit', '2018-05-23 21:18:54', 1),
(332, 0000000332, 'Qqelle Electric Pvt  Ltd', 'No. 55, Vinayalankara Mawatha, Colombo 10.', '0114339762', '', 'skanderaj@quellesolutions.com', '', '112696961', '', '30 days credit', '2018-05-23 21:18:54', 1),
(333, 0000000333, 'Quality Traders', 'No: 69 A, Quarry Road,Colombo 12.', '0112333494', '0773331742', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(334, 0000000334, 'Quick Freighters (Pvt) Ltd.', 'No. 38, Church Road, Kandana.', '0112236573', '', 'quickfreighters@gmail.com', '', '112236573', '', 'After completion', '2018-05-23 21:18:54', 1),
(335, 0000000335, 'R.N. Enterprieses', 'No. 29, 2nd Rohini Lane (Opposite Front Street),Colombo 11.', '0112344647', '', '', '', '112344647', '', '30 days credit', '2018-05-23 21:18:54', 1),
(336, 0000000336, 'Randeni Printers', '320D, Batagama North, Ja-Ela.', '0112234723', '0768306215', 'randeniprinters3@gmail.com', 'pasicroos70@gmail.com', '114831533', '', '30 days credit. 0785626015 sumudu0031@gmail.com', '2018-05-23 21:18:54', 1),
(337, 0000000337, 'Ranjith Suppliers', 'No. 4/105, Halpe Cross Road,  Halpe - Katana.', '0776137491', '', '', '', '', '', '03 days credit', '2018-05-23 21:18:54', 1),
(338, 0000000338, 'Reliance Networks (Pvt) Ltd', 'No. 14, Dharmarama Road, Colombo 06.Colombo 12.', '0114400400', '0777792600', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(339, 0000000339, 'Renown Enterprises', 'No. 538/A 1/7 ,Aluthmawatha Road, Colombo 15.', '0112529891', '0777431197', '', '', '112529891', '', '30 days credit', '2018-05-23 21:18:54', 1),
(340, 0000000340, 'Rexel Electric (Pvt) Ltd', '559, Sri Sangaraja Mawatha, Colombo 10.', '0112440392', '0112437582', '', '', '112436381', '', '30 days credit', '2018-05-23 21:18:54', 1),
(341, 0000000341, 'Rhino Roofing Products Limited', 'No. 752,Baseline Road, Colombo 09.', '0112693694', '', 'headoffice@rhino.lk', '', '112667267', '', '30 days credit', '2018-05-23 21:18:54', 1),
(342, 0000000342, 'Richard Pieris Rubber Products Ltd', 'No. 310, High Level RD, Nawinna, Maharagama', '0114310574', '', '', '', '112804787', '', '30 days credit', '2018-05-23 21:18:54', 1),
(343, 0000000343, 'Richardson Projects ( Pvt ) Ltd', 'No. 842, Level 3 , Galle Road, Colombo 3.', '0112564454', '0112564455', 'kamal@richardsonsl.com', '', '115558899', '', '30 days credit. 0115523523', '2018-05-23 21:18:54', 1),
(344, 0000000344, 'Roche Engineering (Pvt) Limited', 'No. 433, Galle Road, Colombo 04.', '0112582788', '', 'salesreng@rochegroup.lk', '', '114514345', '', 'Full payment with order', '2018-05-23 21:18:54', 1),
(345, 0000000345, 'Rockwool Engineering (Pvt) Limited', 'No. 61/2/21, Millennium Plaza, Keyzer Street, Colombo - 11.', '0115929263', '0776661152', '', '', '115929363', '', '30 days credit', '2018-05-23 21:18:54', 1),
(346, 0000000346, 'Rodrigo & Sons (Pvt) Ltd', 'No. 64, Ernest Place, Laxapathiya, Moratuwa, Sri Lanka', '0112647349', '0117392000', 'info@rodsons.com', '', '112647308', '', '30 days credit', '2018-05-23 21:18:54', 1),
(347, 0000000347, 'Rohan Rodrigo Ref .& Air. Co (Pvt.) Ltd', 'No. 217, Union Place, Colombo 2', '0112307040', '0112334721', 'kapila@rr.lk', 'rodrigo@gmail.com', '112334726', '', '30 days credit. 0115732685', '2018-05-23 21:18:54', 1),
(348, 0000000348, 'Romasha Engineers (Pvt) Ltd', 'No. 52/1A, Old - Kesbewa Road, Gangodawila, Nugegoda, Sri Lanka.', '0112820420', '0115670440', '', '', '112769993', '', 'Full Payment on delivery                                           (By Cheque)', '2018-05-23 21:18:54', 1),
(349, 0000000349, 'Roofmart ( Pvt ) Ltd', '#238,Werahera, Boralesgamuwa', '0112518905', '', 'marketing@roofmartlk.com', '', '112518904', '', '30 days credit', '2018-05-23 21:18:54', 1),
(350, 0000000350, 'Rotax (Pvt) Limited', 'No.332, Galle RD, Colombo 4', '0115574000', '0112556750', 'prasadR@rochegroup.lk', '', '112587286', '115522007', '30 days credit', '2018-05-23 21:18:54', 1),
(351, 0000000351, 'Ruby International Associates', 'No. 333-1/3,First Floor & 346, Old Moor Street, Colombo 12', '0112337259', '0112440952', 'rubyia@dynaweb.lk', '', '112446506', '', '30 days credit', '2018-05-23 21:18:54', 1),
(352, 0000000352, 'S A Engineering (Pvt) Ltd', 'No. 229/B, Negombo Road, Ambalammulla, Seeduwa.', '0112240866', '0773199993', '', '', '112258661', '', '100% Advance Payment. 0714732732 / 0714939882', '2018-05-23 21:18:54', 1),
(353, 0000000353, 'S L J Holdings (Pvt) Ltd.', 'SLJ House, 225, Nawala Road, Narahenpita, Colombo 05.', '0115761010', '0115358111', 'jinendra@sljholdings.com', 'info@sljholdings.com', '115358111', '', '50% in advance & balance 07 days after delivery. 0773318472', '2018-05-23 21:18:54', 1),
(354, 0000000354, 'S.T.K. Multi Engineers (Pvt) Ltd', 'Bangala Waththa, Sirigala,  Dambadeniya.', '0372266522', '0777067667', '', '', '372266633', '', '30 days credit', '2018-05-23 21:18:54', 1),
(355, 0000000355, 'Safe Gas Systems (Pvt) Ltd', 'No. 6B/1, Pagoda Rd, Nugegoda, Sri Lanka.', '0112827094', '', '', '', '112852558', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(356, 0000000356, 'Sampatha Distributors (Pvt) Ltd', 'No. 212, Divulapitiya, Boralesgamuwa', '0112518028', '0114871288', 'emaAsampatha@sltnet.lk', '', '112518028', '', '14 days credit', '2018-05-23 21:18:54', 1),
(357, 0000000357, 'Samson Information Technologies (PVT) Ltd', 'No. 34A,  Wijerama Mawatha, Colombo 07.', '0114957850', '0114380559', 'info@samsoninfotec.com', '', '114622437', '114641834', '100% On Delivery', '2018-05-23 21:18:54', 1),
(358, 0000000358, 'Samurai Engineering Services & Consultants (Pvt) Ltd.', 'No. 94/2/17, Udeshi City Shopping Complex, Makola Road, Kiribathgoda.', '0112908456', '', 'samuraiENG@sltnet.lk', '', '', '', 'Full payment after commissioning', '2018-05-23 21:18:54', 1),
(359, 0000000359, 'San Trading Enterprises (Pvt) Ltd,', 'No: 295,Madampitiya Road,Colombo 14.', '0112521609', '', '', '', '112540346', '', 'Payment after Delivery', '2018-05-23 21:18:54', 1),
(360, 0000000360, 'Sandhuru Dress Centre', '1B/42 R,National Housing Scheem, Raddolugama', '0716169119', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(361, 0000000361, 'Sanergy (Pvt) LTD.', 'No: 11/18A, School Avenue, Mahindarama Rd, Etulkotte 010100.', '0112862626', '', 'info@sanergy.lk', '', '112862626', '', 'One Week credit', '2018-05-23 21:18:54', 1),
(362, 0000000362, 'Sathosa Motors PLC (PQ105) ', 'P.O.  Box, 2114, No. 25, Vauxhall Street, Colombo 02, Sri Lanka.', '0112331622', '0112327360', '', '', '114713663', '', 'Full Payment before delivery', '2018-05-23 21:18:54', 1),
(363, 0000000363, 'Saw Engineering (Pvt) Ltd', 'No.52, Makola North, Makola, Kiribathgoda, Sri Lanka.', '0114925174', '0722300969', '', '', '112908376', '', 'Full Payment on delivery', '2018-05-23 21:18:54', 1),
(364, 0000000364, 'Sayura Salt Packaging & Distributors', '\"Sayura\"Nainawaththa, North Payagala.', '0342233946', '0344934596', '', '', '342040155', '', '7 days credit. 0773309238 / 0775752165', '2018-05-23 21:18:54', 1),
(365, 0000000365, 'Sayuri Enterprises', 'No.268/3, Negombo Road, Ja-Ela', '0112235352', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(366, 0000000366, 'Scan Engineering (Pvt) Ltd', 'SUITE 705, Hilton Colombo, RES, 200 Union Place, Col- 2', '0115747535', '0115747536', 'pavi@scanengineering.com', 'info@scanengineering.lk', '115555674', '', '30 days credit', '2018-05-23 21:18:54', 1),
(367, 0000000367, 'SCHNEIDER ELECTRIC LANKA (PVT) LTD,', 'Valiant Towers, 46/7, Nawam Mawatha, Colombo 2, Sri Lanka', '0117750505', '', '', '', '114724054', '', '100% by T/T in advance', '2018-05-23 21:18:54', 1),
(368, 0000000368, 'Sebim Engineering & Supplies (Pvt) Ltd', '55, Dutugemunu Mawatha, Peliyagoda.', '0112948288', '', 'sebim@sltnet.lk', 'sebimeng@yahoo.com', '112936470', '', '30 days credit', '2018-05-23 21:18:54', 1),
(369, 0000000369, 'Selaka  Enterprises', 'No. 77/1, Temple Rd,Maharagama.', '0112843007', '0715910063', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(370, 0000000370, 'Selini Engineering Associates', 'No. 35, Negombo Road, Tudella, Ja ela.', '0112232990', '0112232991', '', '', '112232991', '', 'Within one week', '2018-05-23 21:18:54', 1),
(371, 0000000371, 'Shanko', 'No. 192/23A, Srimath Bandaranayake Mw, Colombo 12', '0112435704', '0112338040', 'shanko@sltnet.lk', '', '112335229', '', '30 days credit', '2018-05-23 21:18:54', 1),
(372, 0000000372, 'Shehan Metal Crusher', '8 Kanuwa, Uragasman Handiya', '0771304021', '', '', '', '', '', 'Payment on Delivery', '2018-05-23 21:18:54', 1),
(373, 0000000373, 'Shine Trade Center', 'No.18-1/5, Little Plaza, Prince Street, Colombo 11', '0112333939', '', '', '', '112333939', '', '30 days credit', '2018-05-23 21:18:54', 1),
(374, 0000000374, 'Siedles Trading (Pvt) Ltd', 'No. 150/3, Ward Place, Colombo 07', '0112697952', '', '', '', '112698704', '', '30 days credit', '2018-05-23 21:18:54', 1),
(375, 0000000375, 'Sierra Cables PLC.', 'P.O. Box 6, Kaduwela.', '0114412000', '', 'sachithra@sierracables.com', '', '112770291', '', '30 days credit', '2018-05-23 21:18:54', 1),
(376, 0000000376, 'Sigma Enterprises', 'No. 352, Sri Sangaraja Mawatha, Colombo 10', '0112320963', '0112422628', '', '', '112334840', '112458605', '30 days credit', '2018-05-23 21:18:54', 1),
(377, 0000000377, 'Silicone Coatings', 'No. 67, Kumaradasa Mawatha, Mathara.', '0414933530', '0414933531', 'inq.web@nippolac.lk', '', '112222041', '', '100% in advance. 0414933537', '2018-05-23 21:18:54', 1),
(378, 0000000378, 'Singer (Sri Lanka) PLC', 'Singer Plus, Jaffna.', '0212225408', '', '', '', '', '', 'Full Payment with the Order Confirmation', '2018-05-23 21:18:54', 1),
(379, 0000000379, 'Singer (Sri Lanka) PLC', '4-B, De Krester Place, (Off Duplication Road), Colombo 4', '0112503372', '0112503369', '', '', '', '', '30 Days Credit. 0717019732', '2018-05-23 21:18:54', 1),
(380, 0000000380, 'Singer Mega', 'No. 811, Negombo Road,  Mabola, Wattala.', '0112981088', '0112981089', '', '', '112981497', '', 'Full Payment on collection', '2018-05-23 21:18:54', 1),
(381, 0000000381, 'Sinwa Adhesives (Pvt)Ltd', '15, Siriwardena Road,Dehiwala.', '0112761888', '0771063005', '', '', '114208747', '112726293', '30 days credit', '2018-05-23 21:18:54', 1),
(382, 0000000382, 'Sirocco Air Technologies (Pvt) Ltd', 'No. 28/12, Gemunu Mawatha,  Kotuwegoda, Rajagiriya.', '0117392010', '', 'info@sairt.com', '', '117392015', '', '100% after delivery', '2018-05-23 21:18:54', 1),
(383, 0000000383, 'Skyline Trading  Co', 'No: 355 Sri Sangaraja Mawatha,Colombo 10.', '0112432588', '0112458605', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(384, 0000000384, 'S-lon Lanka', 'No. 148, Vauxhall Street, Colombo 02.', '0114740100', '', 'roger@slon.maharaja.lk', '', '115352741', '', '30 days credit', '2018-05-23 21:18:54', 1),
(385, 0000000385, 'S-Lon Lear Lanka (Pvt) Ltd.', 'No. 07, Braybrooke Place, Colombo 02.', '0114792600', '0114760100', '', '', '115352741', '', '45 days credit', '2018-05-23 21:18:54', 1),
(386, 0000000386, 'SM International (Pte) Ltd,', 'No: 09, Dakshinarama Road, Mount -Lavinia.', '0112733199', '', '', '', '112733043', '', '30 days credit', '2018-05-23 21:18:54', 1),
(387, 0000000387, 'Smart Logistics', 'F10, Level 01, Thilakma City,No. 588 Negombo Road, Mahabage.', '0117885566', '', 'info@smartlogistics.lk', '', '117885567', '', 'COD', '2018-05-23 21:18:54', 1),
(388, 0000000388, 'Smooth Graphics', 'No. 399/3,Negombo Road, Kandana', '0602195556', '', 'ssmooth@gmail.com', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(389, 0000000389, 'SMS Marketing (Pvt) Ltd,', '# 302A ,First Floor,Unity Plaza, Colombo 04.', '0112055986', '0777281006', '', '', '1122055987', '', '30 days credit', '2018-05-23 21:18:54', 1),
(390, 0000000390, 'Softlogic Computers (Pvt) Ltd', 'No. 402, Galle Road, Colombo 03.', '0115391122', '', '', '', '115374481', '', '30 days credit', '2018-05-23 21:18:54', 1),
(391, 0000000391, 'Softlogic Information Technologies (Pvt)Ltd', '#14, De Fonseka Place, Colombo - 05.', '0115575000', '', '', '', '', '', '60% Advance, 40% on delivery', '2018-05-23 21:18:54', 1),
(392, 0000000392, 'Softlogic Retail (Pvt) Ltd', '(Office Automation Division), Subsidiary of Softlogic Holdings Plc, Panasonic Building, Level 3, 402, Galle Road,, Colombo 3, Sri Lanka.', '0115391100', '', '', '', '115391128', '112375151', 'Full Payment on delivery', '2018-05-23 21:18:54', 1),
(393, 0000000393, 'SoftlogicMax Showroom', 'No-340 (B7), Katubadda, Moratuwa.', '0115743344', '0776464957', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(394, 0000000394, 'Solex Engineering (Pvt) Ltd', 'No: 39,  New Nuge Road, Peliyagoda.', '0777343870', '', '', '', '112939727', '', 'Credit 14 days after delivery', '2018-05-23 21:18:54', 1),
(395, 0000000395, 'Southern Electrical', '36, Old Road, Nawinna, Maharagama.', '0112843601', '', '', '', '', '', '14 days credit', '2018-05-23 21:18:54', 1),
(396, 0000000396, 'Southern Fire (Pvt) Ltd.', '400/70, Seeduwa Villege, Seeduwa.', '0112251500', '0115234696', '', '', '112251028', '', '30 days credit', '2018-05-23 21:18:54', 1),
(397, 0000000397, 'Spelta Trade Centre', 'No. 126/1/1A, Mahavidyalaya Mawatha, Colombo 13.', '0112338291', '0777474091', '', '', '112338291', '', '30 days credit. 0777431197', '2018-05-23 21:18:54', 1),
(398, 0000000398, 'Spinney Trading Company', 'No. 88/11,1st  Cross Street, Colombo 11', '0112422984', '0112430792', 'spinney@sltnet.lk', '', '112436473', '', '30 days credit. 0112336309', '2018-05-23 21:18:54', 1),
(399, 0000000399, 'Sri Lanka Insurance Corporation LTD', 'Marine Department, 12th Floor, \"Rakshana Mandiraya\", No - 21, Vauxhall Street, Colombo 02, Sri Lanka.', '0112357335', '0112357351', '', '', '112357384', '112357384', '60 days credit', '2018-05-23 21:18:54', 1),
(400, 0000000400, 'Sri Lanka Telecom Services  Ltd', '#17, Sri Sugathodaya Mawatha, Colombo 02', '0112307450', '', 'marketing@slts.lk', '', '112307444', '', '30 days credit', '2018-05-23 21:18:54', 1),
(401, 0000000401, 'Sriyane Mosquto Net', 'No. 83, Rajapaksha Road, Ahungalla.', '0776500523', '', '', '', '', '', 'Payment on delivery', '2018-05-23 21:18:54', 1),
(402, 0000000402, 'ST.Anthony\'s Industries Group (Pvt) Ltd', 'P.O. Box 1455, 752/1, Dr. Danister De Silva Mawatha, Colombo 09.', '0112692161', '', 'anton@slt.lk', '', '112680610', '', '30 days credit', '2018-05-23 21:18:54', 1),
(403, 0000000403, 'State Engineering Corporation of Sri Lanka', 'Pre Cast Yard,Ekala.', '0112236279', '', '', '', '', '', '50% in Advance ,Balance payment before delivery', '2018-05-23 21:18:54', 1),
(404, 0000000404, 'STS Enterprises (Pvt)Ltd', 'No. 250/27, Rajawatta, Pahala Biyanwila, Kadawatha', '0112923105', '', 'stse@eol.lk', '', '114817213', '', '30 days credit', '2018-05-23 21:18:54', 1),
(405, 0000000405, 'Sunwell Engineering', 'No. 588/7A, Industrial Zone, LOT No. 01, Wewahenawatta, Ranmuthugala, Kadawatha.', '0114817222', '', '', '', '112971352', '', '45 days credit', '2018-05-23 21:18:54', 1),
(406, 0000000406, 'Super Cool Air - Conditioning & Refrigeration Engineering', 'Colombo Road, Bandarawaththa, Kakkapalliya, Chilaw.', '0778571270', '', '', '', '', '', 'Progress Paymet', '2018-05-23 21:18:54', 1),
(407, 0000000407, 'Super Neat Technology (Pvt) Ltd', ' #478 , Kandy Road, Kelaniya', '0114814646', '', 'superneat@sltnet.lk', '', '112915628', '', '30 days credit', '2018-05-23 21:18:54', 1),
(408, 0000000408, 'Suran Hardwares', 'No : 9, Chilaw Road, Dalupotha, Negombo.', '0312228223', '0314936844', '', '', '', '', '30 days credit. 0312228223', '2018-05-23 21:18:54', 1),
(409, 0000000409, 'Swiss Comp. Partnership', '#26, Fife Road, Colombo 05, Sri Lanka', '0112586161', '0777281386', 'swisscomp@sltnet.lk', '', '', '', '50% Advance payment with order confirmation and balance at the completion of work', '2018-05-23 21:18:54', 1),
(410, 0000000410, 'T & E Trading (Pvt) Ltd', 'No. 44/1, Ave Mariya Road, Negombo.', '0312225211', '', '', '', '312225211', '', '45 days credit', '2018-05-23 21:18:54', 1),
(411, 0000000411, 'Technic Lanka Fibre Glass', 'No. 09/C2,Church Road, Kandana', '0114974846', '', '', '', '115349996', '', '30 days credit', '2018-05-23 21:18:54', 1),
(412, 0000000412, 'Techno Forms (Pvt) Ltd', 'No.267/15, Galle Road, Colombo 03', '0112564945', '0112564946', 'tfmhp@sltnet.lk', '', '112564912', '', '30 days credit', '2018-05-23 21:18:54', 1),
(413, 0000000413, 'Techno Maart (Pte) Ltd', '#122, Dawson Street, Colombo  2', '0112314540', '0114717500', 'tmaartsales@sltnet.lk', 'manjula@bseng.lk', '112454653', '', '30 days credit. 0114714643 / 0759329892', '2018-05-23 21:18:54', 1),
(414, 0000000414, 'Teclan Engineering  (Pvt) Ltd.', 'No. 215, Malwana,  Biyagama.', '0114361801', '', 'info@teclaneng.com', 'jayani@teclaneng.com', '112548724', '', '30 days credit', '2018-05-23 21:18:54', 1),
(415, 0000000415, 'Tecnic Lanka Fibre Glass', 'No. 09/C2, Church Road, Kandana', '0114974846', '0773775574', 'tecniclanka@gmail.com', '', '115349996', '', '30 days credit', '2018-05-23 21:18:54', 1),
(416, 0000000416, 'Tekzol (Pvt) Ltd', 'No. 164, Stanley Thilakarathna Mw, Nugegoda, Sri Lanka.', '0777847801', '', '', '', '', '', '30 Days Credit', '2018-05-23 21:18:54', 1),
(417, 0000000417, 'Telesonic International', 'No. 18, Daisy Villa Avenue (R. A. De Mel Mawatha), Colombo 04.', '0112508160', '', 'info@telesonicintl.com', '', '112501726', '', 'At the time of collection', '2018-05-23 21:18:54', 1),
(418, 0000000418, 'Thahirs (Pvt) Ltd', 'No.5, 7 & 3, Quarry Road, Colombo 12.', '0112424999', '0112421076', 'thahirs@eureka.lk', '', '112449788', '', '30 days credit', '2018-05-23 21:18:54', 1),
(419, 0000000419, 'Thakral One (Pvt) Ltd', '4th Floor, 595, Galle Road, Colombo - 06.', '0115552324', '0115552325', '', '', '115552323', '115393310', '30 days credit.  0115552326, 0772282885', '2018-05-23 21:18:54', 1),
(420, 0000000420, 'The Hi-Fi Center Pvt Ltd,', 'No: 29/23,Vishaka Private Road, Colombo 04.', '0117400814', '0773780000', '', '', '112596767', '', '100% Payment on Delivey', '2018-05-23 21:18:54', 1),
(421, 0000000421, 'The Zenith Trading.', 'No. 319/B, Old Moor Street, Colombo 12.', '0112473012', '0115836092', '', '', '114615094', '', '30 days credit. 0773476199', '2018-05-23 21:18:54', 1),
(422, 0000000422, 'Thermo - Tec Marketing (Pvt) Ltd.', 'No. 380, Biyagama Road, Pethiyagoda, Kelaniya.', '0114013335', '', '', '', '112914241', '', 'Cheque on delivery', '2018-05-23 21:18:54', 1),
(423, 0000000423, 'Thilaka Traders', '333 2/10,  Old Moor Street, Colombo 12.', '0112431167', '', '', '', '112320108', '', '7 days credit', '2018-05-23 21:18:54', 1),
(424, 0000000424, 'Thilhara Ref &  Electrical (Pvt) Ltd', 'No. 84, Union Place, Colombo 02.', '0112314355', '0112459573', '', '', '112459573', '', '30 days credit', '2018-05-23 21:18:54', 1),
(425, 0000000425, 'Thilhara Trading & Company', 'No. 75, Union Place, Colombo 02.', '0112438633', '', '', '', '112438633', '', '30 days credit', '2018-05-23 21:18:54', 1),
(426, 0000000426, 'Thimira Electricals', 'No. 629/M, Dewasumiththarama Road, Eriyawetiya, Kelaniya', '0112909400', '0714243903', '', '', '112909400', '', 'Advance & Balance after the completion', '2018-05-23 21:18:54', 1),
(427, 0000000427, 'Titan Steel International', 'No. 15A, Abdul Jabbar Mawatha, Colombo - 12.', '0115926670', '', '', '', '112331817', '', '30 days credit', '2018-05-23 21:18:54', 1),
(428, 0000000428, 'T-Jay Enterprises (Pvt) Ltd', '#416, Colombo Road, Papiliyana, Sri Lanka', '0112812474', '', 'tjsales@sltnet.lk', '', '112811931', '', 'Full Payment on Collection', '2018-05-23 21:18:54', 1),
(429, 0000000429, 'TNN Lanka (Pvt) Ltd', 'No.07, Lauries Road, Colombo 03/04', '0114511175', '0114511176', 'tnn@sltnet.lk', 'ans@eureka.lk', '114511176', '', '30 days credit. 0112580768', '2018-05-23 21:18:54', 1),
(430, 0000000430, 'Toppan Forms (Colombo) Ltd', 'No. 345, Shanthi Mawatha, Alubomulla, Panadura', '0384925746', '', 'toppan@sltnet.lk', '', '382241466', '', '30 days credit', '2018-05-23 21:18:54', 1),
(431, 0000000431, 'Trade Promoters (Pvt) Limited', 'No.272/25, Sudharshana Mawatha, Malabe.', '0112413132', '', 'sales@etpl.lk', '', '112407166', '', 'as per the agreement', '2018-05-23 21:18:54', 1),
(432, 0000000432, 'Transwood', 'No. 27, Quarry Road, Colombo 12', '0112320103', '0112342870', 'transwood@sltnet.lk', '', '2332680', '', '30 days credit. 077755193', '2018-05-23 21:18:54', 1),
(433, 0000000433, 'Trico Hardwares', 'No. 34, De Croos, Road, Negombo', '0312238572', '0714902085', '', '', '312238572', '', '30 days credit', '2018-05-23 21:18:54', 1),
(434, 0000000434, 'Tritech Marketing INT (PVT) LTD', '#87 ,Makola South, Makola, Kiribathgoda', '0115544399', '0115544322', 'tritechmkt@sltnet.lk', '', '114815201', '', '30 days Credit', '2018-05-23 21:18:54', 1),
(435, 0000000435, 'Tudawe Brothers (Pvt) Ltd', '505/2, Elvitigala Mawatha, P.O. Box 26,Colombo 5, Sri Lanka.', '0112368494', '0112368451', '', '', '112501922', '', 'By Cheque In advanced  with on demand bank guarantee', '2018-05-23 21:18:54', 1),
(436, 0000000436, 'Tudawe Trading Company (Pvt) Ltd.', 'No. 509, Elvitigala Mawatha, Colombo 05.', '0112369630', '', 'karcher@tudawe.com', 'trading@tudawe.com', '112369633', '', 'Cheque on delivery', '2018-05-23 21:18:54', 1),
(437, 0000000437, 'U.L. Siriwardana', 'No.26, Old Quarry Road, Mount Lavinia.', '0112732612', '0714216885', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(438, 0000000438, 'U.M.Jayatissa', 'No. 10/1,Uswella Road, Hire Watta, Ambalangoda.', '0755341714', '', '', '', '', '', 'progress payment', '2018-05-23 21:18:54', 1),
(439, 0000000439, 'Udula Distributors Company', 'No. 68 1st Lane, Medawelikada Road, Rajagiriya.', '0112863903', '', 'uduladc@sltnet.lk', '', '112863903', '', '14 days credit', '2018-05-23 21:18:54', 1),
(440, 0000000440, 'Uique Creations', 'No. 21,Samagi Mawatha, Off Pantalin Mawatha, Rilaulla, Kandana.', '0114368817', '', 'masterdesigns45@yahoo.com', '', '114830509', '', '60% in advance & balance on completion by Cheques', '2018-05-23 21:18:54', 1),
(441, 0000000441, 'Uni Walkers (Pvt) Ltd.', 'Panasonic Building, Level 3, 402, Galle Road, Colombo 3.', '0115391100', '', '', '', '112375151', '', '30 days credit', '2018-05-23 21:18:54', 1),
(442, 0000000442, 'Unicorn Metalics Co., (Pte) Ltd.', 'No. 346, Sri Sangaraja Mawatha, Colombo - 10,', '0112432891', '', 'umcpl@sltnet.lk', '', '112439408', '', 'Full payment on collection', '2018-05-23 21:18:54', 1),
(443, 0000000443, 'Unimech Engineering', '1/4, Nanda Mawatha, Nugegoda.', '0112815600', '0115766307', '', '', '112815600', '115766307', '100 % By T/T in advance.', '2018-05-23 21:18:54', 1),
(444, 0000000444, 'Unimo Enterprises Limited', 'No. 100 Hyde Park Corner,  Colombo 2, Sri Lanka', '0112448112', '0112448114', '', '', '112304040', '112448113', 'On or Before Mentioned date. 112333603', '2018-05-23 21:18:54', 1),
(445, 0000000445, 'Union Assurance PLC', 'Union Assurance Centre, No. 20, St. Michael\'s Road, Colombo 13.', '0112428000', '', 'unionassurance@ualinkj.lk', '', '112344187', '', 'To be advised', '2018-05-23 21:18:54', 1),
(446, 0000000446, 'Unisonic Industrial Co., (Pvt) Ltd', 'No. 1191/1, Negombo Road, Kandana.', '0114830606', '', '', '', '114830606', '', '100% in advance', '2018-05-23 21:18:54', 1),
(447, 0000000447, 'Unisonic Interior Solutions (Pvt) Ltd', 'No: 119/01, Negombo Road, Kandana.', '0115921807', '0115921800', '', '', '', '', 'Payment on delivery. 0773188411', '2018-05-23 21:18:54', 1),
(448, 0000000448, 'Unitec Fire & Security Systems (Pvt) Ltd', 'Jezima Complex 436/440,  Galle Road, Colombo 03.', '0117391930', '', '', '', '117391933', '', '100% on delivery', '2018-05-23 21:18:54', 1),
(449, 0000000449, 'United Distributors (Pvt) Limited', 'No. 45/96, Nawala Road, Colombo 5.', '0112506332', '', 'udpl@sltnet.lk', '', '112368741', '', '30 days credit', '2018-05-23 21:18:54', 1),
(450, 0000000450, 'United Tractor & Equipment (Private) Ltd.', 'No. 683, Negombo Road, Mabole, Wattala.', '0112932109', '', '', '', '112931550', '', '100% on delivery', '2018-05-23 21:18:54', 1),
(451, 0000000451, 'University of Moratuwa', 'Moratuwa, Sri lanka.', '0112650301', '', '', '', '112650622', '112650465', '30 days credit', '2018-05-23 21:18:54', 1),
(452, 0000000452, 'University of Peradeniya', 'M/s. Department of Civil Engineering,University of Peradeniya,Peradeniya.', '0812393544', '', 'apns@civil.pdn.ac.lk', '', '812393500', '', 'Full payment upon submission of the design reports & drawings', '2018-05-23 21:18:54', 1),
(453, 0000000453, 'UNT Engineering (Pvt) Ltd', 'No. 255/B, Kolonnawa Road, Gothatuwa, Sri Lanka', '0112531157', '', '', '', '112531157', '', '50% Advanced Payment & 50% Completion of Project  (60 days credit)', '2018-05-23 21:18:54', 1),
(454, 0000000454, 'V S Information Systems (Pvt) Ltd', 'No. 07,  Suleiman Terrace, Colombo 05.', '0112599499', '', '', '', '112555805', '', 'Payment Final Day of Installation', '2018-05-23 21:18:54', 1),
(455, 0000000455, 'V.J.Boat Yard', 'G-5 Duwa, Negambo, Sri Lanka', '0312234331', '', '', '', '312235041', '', '50% progress payment & Balance after delivery', '2018-05-23 21:18:54', 1),
(456, 0000000456, 'Vibromix  (Pvt) Ltd', '\"MANJULA\",Mavila Road, Katuneriya', '0312255060', '0312222846', 'vibromix@sltnet.lk', '', '312226500', '', '30 days credit', '2018-05-23 21:18:54', 1),
(457, 0000000457, 'Vidma Electrical Engineering (Pvt) Ltd', 'No: 54, 2nd Floor,  Welikada Plaza, Rajagiriya', '0117548205', '', 'vidmaee@gmail.com', '', '117548205', '', '30 days credit', '2018-05-23 21:18:54', 1),
(458, 0000000458, 'Vins Tailors', 'No. 17, Main Street, Kandana', '0112238924', '', '', '', '', '', '50% Advance, Balance after Completion', '2018-05-23 21:18:54', 1),
(459, 0000000459, 'Virtuoso Powerware (Pvt) Ltd', 'No: 11, 1st Cross Street, Borupana Road, Rathmalana.', '0117267267', '', '', '', '117267247', '', '45 days credit', '2018-05-23 21:18:54', 1),
(460, 0000000460, 'Vista Solutions (Pvt) Ltd.', 'No. 278/3, 4th Lane, Kalapaluwawa,  Rajagiriya.', '0117630240', '', 'info@vistasolutions.lk', '', '117630241', '', '75% in advance & balance on completion', '2018-05-23 21:18:54', 1),
(461, 0000000461, 'Voltas Engineering (Pvt) Ltd.,', 'No. 172, Negombo Road, Rilaulla,Kandana.', '0112233055', '0113078955', '', '', '112233055', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(462, 0000000462, 'Walker Sons & Company Engineers (Pvt) Ltd', 'No. 18, St. Michael\'s Road,Colombo 03.', '0112396955', '', '', '', '112396955', '', 'Full payment on Delivery', '2018-05-23 21:18:54', 1),
(463, 0000000463, 'Wasana Holdings', '(Ragama S-LON Delivery Centre) No. 116, Elapitiwela, Ragama.', '0112954599', '0773439516', '', '', '112954599', '', '35 days credit', '2018-05-23 21:18:54', 1),
(464, 0000000464, 'Water Mart Engineering (Pvt) Limited', 'No 594, Galle Road, Colombo 03.', '0114515757', '0114340309', 'shernal@watermark.lk', 'jayamal@watermart.lk', '112588339', '', '30 days credit', '2018-05-23 21:18:54', 1),
(465, 0000000465, 'Welington Rubbers (Pvt) Limited', 'No. 35/108, Thiriwanegama, Kalagedihena (11875), Sri Lanka', '0334923236', '0332290900', '', '', '719378618', '033 2223520', '14 days credit. 0773976005', '2018-05-23 21:18:54', 1),
(466, 0000000466, 'Western Air Ducts Lanka (Pvt) Ltd', 'Mahena Road, Siyambalape', '0112400987', '', 'sales@wad.lk', '', '112400986', '', '07 days credit', '2018-05-23 21:18:54', 1),
(467, 0000000467, 'Western pvc & Hardware Stores', 'No: 117, Armour Street, Colombo 12.', '0113144396', '', 'westernpvchw@gmail.com', '', '112422991', '', '07 days credit', '2018-05-23 21:18:54', 1),
(468, 0000000468, 'Willpower Group Pvt Ltd', 'B9-SP, YMBA BLDG,70 D.S.Senanayaka Mw, Colombo  08', '0114610969', '', '', '', '112685909', '', 'For Chemical - 30 days credit  For Equipment - 70%Advance payment, balance on completion', '2018-05-23 21:18:54', 1),
(469, 0000000469, 'Wimal  Agro Tractors (Pvt) Ltd', 'No.03,Negombo Road, Dunagaha ', '0312246441', '', 'wimaltractors@sltnet.lk', '', '312246591', '', '30 days credit', '2018-05-23 21:18:54', 1),
(470, 0000000470, 'Wimani  Engineering Works', '193/3 Kalinga Mw, Henatiyana, Minuwangoda', '0114939603', '', '', '', '', '', '30 days credit', '2018-05-23 21:18:54', 1),
(471, 0000000471, 'Wisdom', 'No. 310, Negombo Road, Wattala  ', '0114897524', '0112948586', '', '', '112948586', '', '30 days credit', '2018-05-23 21:18:54', 1),
(472, 0000000472, 'Wurth Lanka Private Limited', '#4, Pagoda Nawala Cross Road, Nugegoda.', '0112817900', '', 'metal@wurth.lk', '', '112817901', '', '60 days credit', '2018-05-23 21:18:54', 1),
(473, 0000000473, 'Yamama Hardware', 'No. 129, 133, Bandaranayake Mawatha, Colombo - 12.', '0112336210', '0115765429', '', '', '112335628', '', '30 days credit', '2018-05-23 21:18:54', 1),
(474, 0000000474, 'Yashi Holdings (Pvt) Ltd.', 'No. 4/1, Hulgaswathe Lane, Balapokuna Road, Colombo 06.', '0112822060', '', 'yashi.holdings@gmail.com', '', '112822060', '', '30 days credit', '2018-05-23 21:18:54', 1),
(475, 0000000475, 'Zenith Engineering Company', 'No. 11/18, School Lane, Kalubowila, Dehiwala', '', '', '', '', '', '', '100% in advance', '2018-05-23 21:18:54', 1),
(476, 0000000476, 'Zenith Engineering Works', 'No. 138,Kahanthota Road, Malabe', '0112413903', '', 'zenitheng@gmail.com', '', '112412775', '', '30 days credit', '2018-05-23 21:18:54', 1),
(477, 0000000477, 'Zilione Technologies (Pvt) Ltd', 'No: 3, Mary\'s Road, Colombo 04.', '0115569999', '', '', '', '112599670', '', '30 days credit', '2018-05-23 21:18:54', 1),
(478, 0000000478, 'Binuditha Industries', 'No. 270/3,  Ehala Lunugama, Vithanawaththa, Madawala.', '0718342818', '', '', '', '', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(479, 0000000479, 'Ceyco Metal Merchants Pvt Ltd', 'No: 9, Quarry Road,Colombo 12.', '0112459059', '0112541685', '', '', '112459059', '112387766', '7 days credit', '2018-05-23 21:18:54', 1),
(480, 0000000480, 'Esta International (Private) Limited', 'No. 411/10, Attygalla Mawatha, Welikada, Rajagiriya, Sri Lanka.', '0117395700', '0117395702', '', '', '117395703', '', '30 Days Credit', '2018-05-23 21:18:54', 1),
(481, 0000000481, 'Firemax Fire Protection', 'No. 148, Mirigama, Sri Lanka', '0333962866', '0779623442', '', '', '', '', '14 days credit', '2018-05-23 21:18:54', 1),
(482, 0000000482, 'Goodrich Lanka (Pvt) Ltd', 'Level 24, East Tower, World Trade Centre, Colombo 01', '0112440077', '0112440078', '', '', '112440076', '', '100% Advance Payment with on demand bank guarantee ', '2018-05-23 21:18:54', 1),
(483, 0000000483, 'L.P.Services Lanka (Pvt) Ltd', '387/4/B ,Bodiraja Mawatha, Habarakada,Homagama.', '0112173032', '0114872572', '', '', '112895652', '', 'Payment after completion', '2018-05-23 21:18:54', 1),
(484, 0000000484, 'Maduka Construction,', 'No: 10/92, Makubura, Pannipitiya.', '0112898619', '', '', '', '', '', 'Progress Payment', '2018-05-23 21:18:54', 1),
(485, 0000000485, 'Micro Vision Satellite Systems (Pvt) Ltd', 'No.89, Kirula Road, Colombo 05.', '0112446519', '0112369232', '', '', '114979378', '', 'After delivery', '2018-05-23 21:18:54', 1),
(486, 0000000486, 'Nippon Paint (Lanka) Pvt Ltd', '\"Nippolac Towers\" No: 69/A, Buthgamuwa Road , Rajagiriya.', '1143569008', '0772117300', '', '', '', '', '30 days credit. 0772833169', '2018-05-23 21:18:54', 1),
(487, 0000000487, 'Overseas Trading Company', 'No: Kurukulawa, Ragama.', '0728845999', '', '', '', '', '', '100% Advance Payment with on demand bank guarantee', '2018-05-23 21:18:54', 1),
(488, 0000000488, 'Rolak Fire (Private) Limited', 'No. 21/A, Kanatta Rd, Boralesgamuwa.', '0114378320', '0114378321', '', '', '112150586', '', '30 days credit. 0727623705', '2018-05-23 21:18:54', 1),
(489, 0000000489, 'Shehan Hardware & Transport', 'No. 686, Negombo Road, Mabola, Wattala.', '0773040776', '0775754625', '', '', '', '', '7 days credit', '2018-05-23 21:18:54', 1),
(490, 0000000490, 'Solex Technologies (Pvt) Limited', 'No: 39,  New Nuge Road, Peliyagoda.', '0777343870', '', '', '', '112939727', '112939727', 'Full payment on collection', '2018-05-23 21:18:54', 1),
(491, 0000000491, 'Tech Waters (Private) Ltd', 'No. 303, High Level Road, Colombo 05, Sri Lanka.', '0112826340', '0112824287', '', '', '112853752', '', '30 days credit. 0112829622, 0714945415', '2018-05-23 21:18:54', 1),
(492, 0000000492, 'Thushari & Son Lanka Filling Station', 'M.D.M.J. Thushari, No. 211, Weligampitiya, Ja-Ela.', '0112901695', '0777777350', '', '', '112901932', '', 'Payment On Delivery. 0777646600', '2018-05-23 21:18:54', 1),
(493, 0000000493, 'Vinkah Steels', 'No. 119/3, Srimath Bandaranayke Mawatha,  Colombo 12, Sri Lanka.', '0112446274', '0112446273', '', '', '112446350', '', '35 days credit', '2018-05-23 21:18:54', 1),
(494, 0000000000, ' NOT AVAILABLE', ' NOT AVAILABLE', '0000000000', NULL, NULL, NULL, NULL, NULL, ' NOT AVAILABLE', '2018-06-14 21:29:55', 1);

-- --------------------------------------------------------

--
-- Table structure for table `transactionlogs`
--

DROP TABLE IF EXISTS `transactionlogs`;
CREATE TABLE IF NOT EXISTS `transactionlogs` (
  `transactionlogs_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_description` text NOT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transactionlogs_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `useraccounts`
--

DROP TABLE IF EXISTS `useraccounts`;
CREATE TABLE IF NOT EXISTS `useraccounts` (
  `useraccounts_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_user_name` varchar(255) NOT NULL,
  `designation_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `system_user_mobile` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` int(11) NOT NULL,
  `system_user_image` varchar(255) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`useraccounts_table_id`),
  KEY `designation_id` (`designation_id`),
  KEY `location_id` (`location_id`),
  KEY `saved_user` (`saved_user`),
  KEY `user_type` (`user_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `useraccounts`
--

INSERT INTO `useraccounts` (`useraccounts_table_id`, `system_user_name`, `designation_id`, `location_id`, `system_user_mobile`, `user_name`, `password`, `user_type`, `system_user_image`, `saved_datetime`, `saved_user`) VALUES
(1, 'Admin', 5, 4, '1234567890', 'Admin', 'e10adc3949ba59abbe56e057f20f883e', 1, 'Avatar.jpg', '2018-04-17 09:43:04', 1);

-- --------------------------------------------------------

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
CREATE TABLE IF NOT EXISTS `userpermissions` (
  `userpermissions_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `useraccounts_table_id` int(11) NOT NULL,
  `permissions_table_id` int(11) NOT NULL,
  `saved_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saved_user` int(11) NOT NULL,
  PRIMARY KEY (`userpermissions_table_id`),
  KEY `permissions_table_id` (`permissions_table_id`),
  KEY `saved_user` (`saved_user`),
  KEY `useraccounts_table_id` (`useraccounts_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userpermissions`
--

INSERT INTO `userpermissions` (`userpermissions_table_id`, `useraccounts_table_id`, `permissions_table_id`, `saved_datetime`, `saved_user`) VALUES
(1, 1, 1, '2018-05-07 14:00:58', 1),
(2, 1, 2, '2018-05-07 14:01:06', 1),
(4, 1, 4, '2018-05-07 14:01:22', 1),
(5, 1, 5, '2018-05-07 14:01:32', 1),
(6, 1, 6, '2018-05-07 14:01:43', 1),
(7, 1, 7, '2018-05-07 14:01:52', 1),
(10, 1, 10, '2018-05-07 14:02:54', 1),
(11, 1, 11, '2018-05-07 14:03:08', 1),
(12, 1, 12, '2018-05-07 14:03:19', 1),
(13, 1, 13, '2018-05-07 14:03:30', 1),
(14, 1, 14, '2018-05-07 14:03:47', 1),
(15, 1, 15, '2018-05-07 14:03:55', 1),
(30, 1, 16, '2018-05-12 17:09:12', 1),
(31, 1, 3, '2018-05-19 15:56:53', 1),
(32, 1, 17, '2018-05-24 23:31:05', 1),
(127, 1, 19, '2019-04-30 06:23:14', 1),
(128, 1, 18, '2019-04-30 06:23:58', 1);

-- --------------------------------------------------------

--
-- Table structure for table `usertypes`
--

DROP TABLE IF EXISTS `usertypes`;
CREATE TABLE IF NOT EXISTS `usertypes` (
  `usertypes_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `usertype` varchar(255) NOT NULL,
  PRIMARY KEY (`usertypes_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usertypes`
--

INSERT INTO `usertypes` (`usertypes_table_id`, `usertype`) VALUES
(1, 'Administrator'),
(2, 'User'),
(3, 'Procurement Staff'),
(4, 'Super User'),
(5, 'Project Manager');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
