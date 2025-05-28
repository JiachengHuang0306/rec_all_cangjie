CREATE DATABASE listDb;

USE listDb;

CREATE TABLE recAllList (
    id BIGINT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    typeId BIGINT NOT NULL,
    userIdentityGuid VARCHAR(255) NOT NULL,
    isDeleted TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_userIdentityGuid (userIdentityGuid),
    INDEX idx_isDeleted (isDeleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE recAllSet (
    id BIGINT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    typeId BIGINT NOT NULL,
    listId BIGINT NOT NULL,
    userIdentityGuid VARCHAR(255) NOT NULL,
    isDeleted TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_listId (listId),
    INDEX idx_userIdentityGuid (userIdentityGuid),
    INDEX idx_isDeleted (isDeleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE recAllItem (
    id BIGINT NOT NULL PRIMARY KEY,
    typeId BIGINT NOT NULL,
    setId BIGINT NOT NULL,
    contribId VARCHAR(255) NOT NULL,
    userIdentityGuid VARCHAR(255) NOT NULL,
    isDeleted TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_setId (setId),
    INDEX idx_userIdentityGuid (userIdentityGuid),
    INDEX idx_isDeleted (isDeleted)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE integrationEventLog (
    eventUuid VARCHAR(255) NOT NULL PRIMARY KEY,
    eventType VARCHAR(255) NOT NULL,
    stateValue BIGINT NOT NULL,
    createdTime TIMESTAMP NOT NULL,
    contentJson TEXT NOT NULL,
    transactionUuid VARCHAR(255) NOT NULL,
    INDEX idx_transactionUuid (transactionUuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `hilosequence` (
    `sequenceName` varchar(255) PRIMARY KEY,
    `nextHi` int NOT NULL
 ) ENGINE = InnoDB;

INSERT INTO `hilosequence` (`sequenceName`, `nextHi`) VALUES ('recAllList', 1);
INSERT INTO `hilosequence` (`sequenceName`, `nextHi`) VALUES ('recAllSet', 1);
INSERT INTO `hilosequence` (`sequenceName`, `nextHi`) VALUES ('recAllItem', 1);