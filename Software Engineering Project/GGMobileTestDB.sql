BEGIN TRANSACTION;
CREATE TABLE `Products` (
	`product_ID`	INTEGER NOT NULL,
	`product_name`	TEXT,
	`product_image_path`	TEXT,
	`product_desc`	TEXT,
	`product_price`	TEXT,
	PRIMARY KEY(product_ID)
);
INSERT INTO `Products` VALUES (1,'White Hat','/usr/me/whitehat.jpeg','it''s a white hat worn by the ancient magician, tumble tits. 
','$99.99');
INSERT INTO `Products` VALUES (2,'Cool Sword','/usr/me/coolsword.jpeg','The sword of a hero. It''s dangerous to go alone.','FREE');
COMMIT;
