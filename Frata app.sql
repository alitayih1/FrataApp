-- store frata users
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,	
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
); 

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Date_of_Birth` date NOT NULL,
  `Street_Address` varchar(50) NOT NULL,
  `City` varchar(25) NOT NULL,
  `State` char(2) NOT NULL,
  `Zipcode` int(11) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Sex` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `customers_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);


DROP TABLE IF EXISTS `account_type`;
CREATE TABLE `account_type` (
  `Account_Type` varchar(20) NOT NULL,
  `Minimum_Balance_Restriction` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Account_Type`)
);


DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Customer_id` int(10)  NOT NULL,
  `Account_Balance` decimal(10,2) NOT NULL,
  `Date_Opened` date NOT NULL,
  `Account_Type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Accounts_account_type1_idx` (`Account_Type`),
  CONSTRAINT `fk_Accounts_account_type1` FOREIGN KEY (`Account_Type`) REFERENCES `account_type` (`Account_Type`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accounts_has_Customer_Customer1` FOREIGN KEY (`Customer_id`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) unsigned NOT NULL,
  `flag` enum('gate','order-','refunded','deduction-','transfer') NOT NULL COMMENT 'dash indicates a negative value',
  `cash` decimal(14,2) NOT NULL,
  `description` varchar(255) NOT NULL COMMENT 'note',
  `transtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `wallet_idfk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
);	

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `Transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Transaction_Type` varchar(45) NOT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Date` date NOT NULL,
  `sender_id` int(10) unsigned NOT NULL,
  `receiver_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Transaction_id`),
  KEY `fk_transactions_Customer1_idx` (`sender_id`),
  CONSTRAINT `fk_transactions_Customer1` FOREIGN KEY (`sender_id`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_Customer2` FOREIGN KEY (`receiver_id`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `credit_cards`;
CREATE TABLE `credit_cards` (
  `CC_number` varchar(20) NOT NULL,
  `Maximum_Limit` decimal(10,2) NOT NULL,
  `Expiry_Date` date NOT NULL,
  `Customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`CC_number`),
  KEY `fk_Credit_card_details_Customer1_idx` (`Customer_id`),
  CONSTRAINT `fk_Credit_card_details_Customer1` FOREIGN KEY (`Customer_id`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `cc_transactions`;
CREATE TABLE `cc_transactions` (
  `Transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CC_Number` varchar(20) NOT NULL,
  `Transaction_Date` date NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Merchant_Details` varchar(45) NOT NULL,
  PRIMARY KEY (`Transaction_id`),
  KEY `fk_CC_transaction_details_Credit_card_details1_idx` (`CC_Number`),
  CONSTRAINT `fk_CC_transaction_details_Credit_card_details1` FOREIGN KEY (`CC_Number`) REFERENCES `credit_cards` (`CC_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
);



DROP TABLE IF EXISTS `cust_transactions`;
CREATE TABLE `cust_transactions` (
  `Transaction_Count_For_Month` tinyint NOT NULL,
  `Customer_id` tinyint NOT NULL,
  `Customer_Name` tinyint NOT NULL,
  `Transaction_Month` tinyint NOT NULL
);


DROP TABLE IF EXISTS `candle_type`;
CREATE TABLE `candle_type` (
  `id` tinyint NOT NULL,
  `candle_type_desc` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `cust_candles`;
CREATE TABLE `cust_candles` (
  `id` tinyint NOT NULL,
  `Customer_id` tinyint NOT NULL,
  `Customer_Name` tinyint NOT NULL,
  `candle_type_id` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cust_candles_candle_type` FOREIGN KEY (`candle_type_id`)   REFERENCES `candle_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION ,
  CONSTRAINT `fk_cust_candles_customers` FOREIGN KEY (`customer_id`)   REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION  

);

DROP TABLE IF EXISTS `cust_hassaleh`;
CREATE TABLE `cust_candles` (
  `id` tinyint NOT NULL,
  `Customer_id` tinyint NOT NULL,
  `Customer_Name` tinyint NOT NULL,
    `balance` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cust_hassaleh_customers` FOREIGN KEY (`Customer_id`)  REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION  
);






