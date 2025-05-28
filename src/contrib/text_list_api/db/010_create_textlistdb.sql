CREATE DATABASE textListDb;

USE textListDb;

CREATE TABLE textItem (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    itemId BIGINT NULL DEFAULT NULL,
    content TEXT NOT NULL,
    userIdentityGuid VARCHAR(255) NOT NULL,
    isDeleted TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_itemId (itemId),
    INDEX idx_userIdentityGuid (userIdentityGuid),
    INDEX idx_isDeleted (isDeleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;