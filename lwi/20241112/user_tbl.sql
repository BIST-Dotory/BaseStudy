use dotory;

CREATE TABLE `user_tbl` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `user_pwd` varchar(45) NOT NULL,
  `user_type` varchar(45) NOT NULL,
  `user_major` varchar(45) DEFAULT NULL,
  `user_phone` varchar(45) NOT NULL,
  `firebase_token` varchar(500) DEFAULT NULL,
  `user_checked` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
