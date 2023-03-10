DROP DATABASE IF EXISTS MockProject;
CREATE DATABASE MockProject;
USE MockProject;

DROP TABLE IF EXISTS Catalog;
CREATE TABLE Catalog(
	id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`name`		NVARCHAR(30) NOT NULL,
	image 		VARCHAR(100) 
);

DROP TABLE IF EXISTS Product;
CREATE TABLE Product (
    productId 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    productName	 	NVARCHAR(200) NOT NULL,
    catalogId		INT UNSIGNED NOT NULL ,
    `describe` 		NVARCHAR(1000) NOT NULL,
    size			VARCHAR(10) NOT NULL,
	amount		 	TINYINT UNSIGNED NOT NULL,
    purchase_Price	INT UNSIGNED NOT NULL,
    price			INT UNSIGNED NOT NULL,
    salePrice		INT UNSIGNED,
	review			NVARCHAR(1000) NOT NULL,
    createDate		DATETIME DEFAULT NOW(),
    FOREIGN KEY 	(catalogId) REFERENCES Catalog(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Image`;
CREATE TABLE `Image` (
	id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    productId	INT UNSIGNED NOT NULL UNIQUE KEY,
    image1 		VARCHAR(100) ,
    image2 		VARCHAR(100) ,
    image3 		VARCHAR(100) ,
    image4 		VARCHAR(100) ,
    image5 		VARCHAR(100) ,
    image6 		VARCHAR(100) ,
	FOREIGN KEY (productId) REFERENCES Product(productId)
);

DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role`(
	roleId     	SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	roleName 	ENUM ('ADMIN', 'STAFF','USER') DEFAULT 'USER' 
);

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
	userId 			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    userName	CHAR(50) NOT NULL UNIQUE CHECK (LENGTH(userName) >= 6 AND LENGTH(userName) <= 50),
    email		CHAR(50)  UNIQUE CHECK (LENGTH(email) >= 6 AND LENGTH(email) <= 50),
	`password`	VARCHAR(800) NOT NULL,
    firstName 	NVARCHAR(50) ,
	lastName 	NVARCHAR(50) ,
    phoneNumber		VARCHAR(20) ,
    address		NVARCHAR(300) ,
	`status`	TINYINT DEFAULT 0, -- 0: Not Active, 1: Active
    roleId		SMALLINT UNSIGNED DEFAULT 3 ,
	FOREIGN KEY (roleId)  REFERENCES `Role`(roleId)

);

DROP TABLE IF EXISTS Cart;
CREATE TABLE Cart (
	userId			INT UNSIGNED NOT NULL,
    productId		INT UNSIGNED NOT NULL,
    quantity			INT UNSIGNED NOT NULL,
	FOREIGN KEY (userId) REFERENCES `User` (userId),
    FOREIGN KEY (productId) REFERENCES Product (productId),
    PRIMARY KEY (userId,productId)
);

DROP TABLE IF EXISTS Pay;
CREATE TABLE Pay (
	payId			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	userId			INT UNSIGNED NOT NULL,
    totalPayment	INT UNSIGNED NOT NULL,
    FOREIGN KEY (userId) REFERENCES `User` (userId)

);
    
DROP TABLE IF EXISTS OderList;
CREATE TABLE OderList (
    oderId 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    userId		INT UNSIGNED NOT NULL,
    oderValue	INT UNSIGNED NOT NULL,
    `status`	ENUM('WAITING', 'DELIVERING', 'DELIVERED', 'CANCELED') NOT NULL,
	oderDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY (userId) REFERENCES `User` (userId)
);

DROP TABLE IF EXISTS OderDetail;
CREATE TABLE OderDetail (
	oderDetailId		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    oderId 				INT UNSIGNED NOT NULL,
	productName	 		NVARCHAR(200) NOT NULL,
	salePrice			INT UNSIGNED,
    quantity			INT UNSIGNED NOT NULL,
    total 				INT UNSIGNED NOT NULL,
    FOREIGN KEY (oderId) REFERENCES OderList (oderId)
);



DROP TABLE IF EXISTS `Comment`;
CREATE TABLE `Comment` (
	id 				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	userId			INT UNSIGNED NOT NULL,
    productId		INT UNSIGNED NOT NULL,
    content			NVARCHAR(200) ,
	createDate		DATETIME DEFAULT NOW(),
	FOREIGN KEY (userId) REFERENCES `User` (userId),
    FOREIGN KEY (productId) REFERENCES Product (productId),
    UNIQUE KEY (userId,productId)
);

DROP TABLE IF EXISTS CreatorProduct;
CREATE TABLE CreatorProduct (
	staffId		INT UNSIGNED NOT NULL,
    productId	INT UNSIGNED NOT NULL,
	FOREIGN KEY (staffId) REFERENCES `User` (userId),
    FOREIGN KEY (productId) REFERENCES Product (productId),
    PRIMARY KEY (staffId,productId)
);

-- Create table Registration_User_Token
DROP TABLE IF EXISTS 	`Registration_User_Token`;
CREATE TABLE IF NOT EXISTS `Registration_User_Token` ( 	
	id 				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`token`	 		CHAR(36) NOT NULL UNIQUE,
	`user_id` 		SMALLINT UNSIGNED NOT NULL,
	`expiryDate` 	DATETIME NOT NULL
);

-- Create table Reset_Password_Token
DROP TABLE IF EXISTS 	`Reset_Password_Token`;
CREATE TABLE IF NOT EXISTS `Reset_Password_Token` ( 	
	id 				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`token`	 		CHAR(36) NOT NULL UNIQUE,
	`user_id` 		SMALLINT UNSIGNED NOT NULL,
	`expiryDate` 	DATETIME NOT NULL
);

INSERT INTO Catalog(`name`, image)
values		
        
('??o Kho??c','res541d4fbafb5722a6b83cd1ac17de1ceafr.jpeg'),
('??o S?? Mi','goods_64_455952.webp'                      ),
('??o Ph??ng','goods_00_457124.webp'                      ),
('Qu???n','goods_67_445293.webp'                          ),
('V??y','goods_32_458682.webp'                           ),
('Qu???n Jean','goods_62_452524.webp'                     ),
('??o Len','res858283b0a1d2cdbb95d44622fda9ce24fr.jpeg'  ),
('Vest','A01_8225409_06_0_20220928180917_psz.jpeg'      );
INSERT INTO Product(productName, catalogId, `describe`,size, amount, purchase_Price, price, salePrice, review, 			createDate	)
values	
		  
					( '??o phao l??ng v?? 2 m???t 3 l???p cao c???p', '1', '??o phao l??ng v?? 2 m???t 3 l???p cao c???p. h??ng LO???I 1 SI??U NH??? , SI??U ???M ,SI??U D??Y D???N , G???N NH???, THI???T K??? TR??? TRUNG N??NG ?????NG ', 'S', '10', '980000', '990000', '10000', 'new', '2022-01-03 00:00:00'),
					( '??o kho??c d??i', '1', '??o kho??c d??i gi??p b???n ???m ??p khi ??i ra ngo??i', 'S', '55', '989888', '1200000', '10000', 'new', '2022-01-04 00:00:00'                                                                                                    ),
					( '??o kho??c Gile', '1', '??o kho??c l??ng v?? g???n nh???, m???c ???m, gi??? nhi???t t???t', 'S', '33', '450000', '550000', '10000', 'new', '2022-01-05 00:00:00'                                                                                                 ),
					( '??o kho??c sang tr???ng l???ch s???', '1', '??o kho??c v???i ch???t li???u sang tr???ng, ?????ng c???p', 'S', '33', '1500000', '1600000', '1599000', 'new', '2022-01-05 00:00:00'                                                                                    ),
					( '??o kho??c len c??? ?????ng', '1', '??o kho??c len n??? v???i ch???t li???u b???n, sang tr???ng', 'S', '10', '900000', '1000000', '999999', 'new', '2022-01-05 00:00:00'                                                                                           ),
					( '??o kho??c l??ng c???u c?? kh??a', '1', 'Ch???t li???u l??ng c???u mang l???i c???m gi??c ???m ??p', 'S', '10', '1100000', '1300000', '1290000', 'new', '2022-01-05 00:00:00'                                                                                       ),
					( '??o parka ch???ng tia UV', '1', 'T??c d???ng ch???ng l???i c??c tia UV b???o v??? da', 'S', '10', '650000', '690000', '680000', 'new', '2022-01-05 00:00:00'                                                                                                 ),
                   ( '??o kho??c d??? si??u nh???', '1', 'Ch???t li???u nh??? mang l???i c???m gi??c d??? ch???u', 'S', '10', '650000', '680000', '670000', 'new', '2022-01-05 00:00:00'                                                                                                  ),
                   ( '??o kho??c d??i', '1', 'Mang l???i c???m gi??c ???m ??p', 'S', '10', '950000', '1100000', '1099999', 'new', '2022-01-05 00:00:00'                                                                                                                        ),
                   ( '??o s?? mi polo', '2', 'Phong c??ch tr??? trung n??ng ?????ng', 'S', '10', '350000', '390000', '380000', 'new', '2022-01-05 00:00:00'			),
                   ( '??o s?? mi d??i tay', '2', 'Phong c??ch c??ng s??? n??ng ?????ng', 'S', '10', '450000', '480000', '470000', 'new', '2022-01-05 00:00:00'           ),
                   ( '??o s?? mi d??i tay c??ng s???', '2', 'Ch???t li???u cho c???m gi??c d??? ch???u', 'S', '10', '550000', '580000', '560000', 'new', '2022-01-05 00:00:00' ),
                   ( '??o s?? mi k??? s???c', '2', 'Phong c??ch n??ng ?????ng', 'S', '10', '350000', '380000', '365000', 'new', '2022-01-05 00:00:00'                    ),
                   ( '??o s?? mi k??? s???c', '2', 'Phong c??ch cho gi???i tr???', 'S', '10', '450000', '480000', '465000', 'new', '2022-01-05 00:00:00'                 ),
                      ( '??o s?? mi d??i tay', '2', 'Phong c??ch l???ch l??m', 'S', '10', '560000', '580000', '565000', 'new', '2022-01-05 00:00:00'                    ),
                      ( '??o s?? mi k??? caro', '2', 'Mang l???i s??? tr??? trung m???nh m???', 'S', '10', '450000', '480000', '465000', 'new', '2022-01-05 00:00:00'          ),
                      ( '??o s?? mi m??u s??ng', '2', 'Phong c??ch tr??? trung n??ng ?????ng', 'S', '10', '400000', '480000', '470000', 'new', '2022-01-05 00:00:00'        ),
                      ( '??o s?? mi k??? s???c', '2', 'Mang l???i c???m gi??c tho???i m??i d??? ch???u', 'S', '10', '350000', '380000', '375000', 'new', '2022-01-05 00:00:00'     );

                                                                                                
INSERT INTO Image(productId , image1   , image2   , image3   , image4   , image5   , image6   )
values										
					
 ('1', 'goods_450456_sub7.webp', 'goods_450456_sub3.webp', 'goods_450456_sub1.webp', 'goods_09_450456.webp', 'goods_450456_sub3.webp', 'goods_450456_sub3.webp'      ),
 ('2', 'goods_69_450450.webp', 'goods_450450_sub7.webp', 'goods_450450_sub8.webp', 'goods_450450_sub9.webp', 'goods_450450_sub11.webp', 'goods_69_450450.webp'       ),
 ('3', 'goods_68_450312.webp', 'goods_450312_sub14.webp', 'goods_450312_sub15.webp', 'goods_450312_sub14.webp', 'goods_68_450312.webp', 'goods_450312_sub15.webp'    ),
 ('4', 'goods_09_459772.webp', 'goods_459772_sub7.webp', 'goods_459772_sub8.webp', 'goods_459772_sub9.webp', 'goods_459772_sub11.webp', 'goods_459772_sub12.webp'    ),
 ('5', 'goods_04_461979.webp', 'goods_461979_sub14.webp', 'goods_461979_sub17.webp', 'goods_461979_sub18.webp', 'goods_461979_sub19.jpeg', 'goods_461979_sub20.jpeg' ),
 ('6', 'goods_30_449753.webp', 'jpgoods_449753_sub6.webp', 'goods_449753_sub7.webp', 'goods_449753_sub8.webp', 'goods_449753_sub9.webp', 'goods_30_449753.webp'      ),
 ('7', 'goods_03_445003.webp', 'goods_445003_sub14.webp', 'goods_445003_sub15.webp', 'goods_445003_sub17.webp', 'goods_03_445003.webp', 'goods_445003_sub14.webp'    ),
 ('8', 'goods_17_450310.webp', 'goods_450310_sub1.webp', 'goods_450310_sub7.webp', 'goods_450310_sub9.webp', 'goods_450310_sub11.webp', 'goods_450310_sub12.webp'    ),
 ('9', 'goods_58_450490.webp', 'goods_450490_sub1.webp', 'goods_450490_sub2.webp', 'goods_450490_sub7.webp', 'goods_450490_sub8.webp', 'goods_58_450490.webp'        ),
 ('10', 'goods_56_433039.webp', 'goods_433039_sub3.webp', 'goods_433039_sub4.webp', 'goods_433039_sub7.webp', 'goods_433039_sub8.webp', 'goods_56_433039.webp'        ),
 ('11', 'goods_64_455952 (1).webp', 'goods_455952_sub17.jpeg', 'goods_455952_sub18.jpeg', 'goods_455952_sub19.webp', 'goods_455952_sub20.jpeg', 'goods_455952_sub23.jpeg'),
 ('12', 'goods_09_427163.webp', 'goods_427163_sub17.webp', 'goods_427163_sub18.jpeg', 'goods_427163_sub19.webp', 'goods_427163_sub20.webp', 'goods_427163_sub23.jpeg'    ),
 ('13', 'goods_65_456227.webp', 'goods_456227_sub17.jpeg', 'goods_456227_sub18.jpeg', 'goods_456227_sub19.webp', 'goods_456227_sub20.webp', 'goods_456227_sub23.jpeg'    ),
 ('14', 'goods_67_452585.webp', 'goods_452585_sub14.webp', 'goods_452585_sub17.jpeg', 'goods_452585_sub18.jpeg', 'goods_452585_sub19.webp', 'goods_452585_sub20.webp'    ),
 ('15', 'goods_02_448235.webp', 'goods_448235_sub14.webp', 'goods_448235_sub17.jpeg', 'goods_448235_sub18.jpeg', 'goods_448235_sub19.webp', 'goods_448235_sub20.jpeg'    ),
 ('16', 'goods_10_456585.webp', 'goods_456585_sub17.webp', 'goods_456585_sub18.webp', 'goods_456585_sub19.webp', 'goods_456585_sub20.webp', 'goods_456585_sub23.jpeg'    ),
 ('17', 'goods_11_456576.webp', 'goods_456576_sub17.jpeg', 'goods_456576_sub18.jpeg', 'goods_456576_sub19.webp', 'goods_456576_sub20.jpeg', 'goods_456576_sub23.jpeg'    ),
 ('18', 'goods_66_441656.webp', 'goods_441656_sub18.webp', 'goods_441656_sub19.webp', 'goods_441656_sub20.webp', 'goods_441656_sub21.webp', 'goods_441656_sub22.webp'    );
 		                                                                                                                                                                 
INSERT INTO `Role` ( RoleName)                                                                                                                                           
VALUES 				('ADMIN'),
					('STAFF'),
					('USER');
        
INSERT INTO `User`(userName,                email,                         `password`,                                                         firstName,         lastName,        phoneNumber,    address,    `status` , roleId 	)
values	          ('hanh.havan@vti',		'hanhhanoi1999@gmail.com',		'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'H??'	,		 'V??n Hanh',   '013423432453',		'H?? N???i',	1		,'3'),	 
					('thanhhung12@vti',		'hung122112@gmail.com',			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'Nguy???n',		'Thanh H??ng',	'023443342546',		'H?? N???i',	1		,'3'),	 
					('can.tuananh@vti',		'cananh.tuan12@vti.com',		'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'C???n'	,		'Tu???n Anh',		'023543523446',		'H?? N???i',	0		,'3'),	 
					('toananh123@vti',		'toananh123@vti.com',			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'Nguy???n',		'Anh To??n',		'023443243354',		'H?? N???i',	1		,'3'),	 
					('manhhung123@vti',		'manhhung123@vti.com',			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'Nguy???n',		'M???nh H??ng',	'023423433535',		'H?? N???i',	1		,'3'),	
					('maianhvti123',		'maianhng@gmail.com', 			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'Nguy???n',		'Mai Anh',		'023423243354',		'H?? N???i',	1		,'3'),	
					('tuanvti12344',		'tuan1234@gmail.com', 			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		'Nguy???n',		'V??n Tu???n',		'04234234354', 		'H?? N???i',	1		,'3'),	
					('thaobp1026',			null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('Thube1997',			null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('thanhnguyen23',		null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('Dhai99856',			null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('Tunguyen.080701',		null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('trinh230',			null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('hungphongnguyn',		null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'1'),	
                    ('tuanvti1233445',		null				,			'$2a$10$W2neF9.6Agi6kAKVq8q3fec5dHW8KUA.b0VSIGdIZyUravfLpyIFi',		null	,	      null	,            null	,      null	,      1		,'2');   	
	
INSERT INTO Cart(userId,productId,quantity)
values			(1,1,2),	
				(1,2,2),
                (2,3,1),
				(2,6,3),
                (3,8,3),
				(4,9,3),
                (5,10,1),
                (6,4,4),
                (1,3,2),
                (2,4,10),
				(2,7,2),
                (3,9,3),
				(4,14,4),
                (5,15,5),
                (6,7,4),
                (7,5,3);
                
-- INSERT INTO Pay(userId,total)
-- values			(1,26799980),	
-- 				(2,15680000),
--                 (3,27599977);
				
                                                                                                             

INSERT INTO OderList(userId,  oderDate, oderValue,  `status`)
values	
-- (	1,'2023-01-08 01:44:50',	60000,	'WAITING'	);
(1,'2022-11-20', '23500000','WAITING'),
		(4,'2022-11-25', '33500000','CANCELED'),
        (6,'2022-11-28', '53500000','DELIVERING'),
        (1,'2022-11-20', '23500000','DELIVERED'),
        (2,'2022-11-25', '33500000','CANCELED'),
        (7,'2022-11-28', '5350000','DELIVERING'),
        (4,'2022-11-25', '33500000','CANCELED'),
--         (2,'2022-11-28', '53500000','DELIVERING'),
        (1,'2022-11-20', '23500000','DELIVERED');
--         (2,'2022-11-25', '33500000','CANCELED'),
--         (7,'2022-11-28', '5350000','DELIVERING'),
--         (5,'2022-11-20', '23500000','WAITING'),
--         (2,'2022-11-25', '30350000','CANCELED'),
--         (3,'2022-11-28', '53500000','DELIVERING');

-- INSERT INTO OderDetail(oderId,productName,quantity,  total)
-- values	(1,    10000000);
-- 		(1,    4,10000000),
--         (5,    1,10000000),
--         (10,   4,10000000),                   
--         (2,   17,10000000),
--         (6,   18,10000000),

        

                
INSERT INTO `Comment`(userId,productId,content,createDate)
values					(1,		1,		'xa??u','2020-03-05'),	
						(1,		2,		'xa??u','2020-03-05'),
						(1,     3,      'xa??u','2020-03-05'),
						(2,		3,		'xa??u','2020-03-07'),
						(3,     2,      'xa??u','2020-03-08'),
						(4,		3,		'xa??u','2020-03-05'),
						(5,     1,      'xa??u','2020-03-07'),
						(6,     4,      'xa??u','2020-03-07'),
						(7,     5,      'xa??u','2020-03-07');
                                
INSERT INTO CreatorProduct(staffId,productId)
values			(15,1),	
				(15,3),
                (15,2),
				(15,6),
                (15,7),
                (15,4),
                (15,5);                


