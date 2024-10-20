DROP PROCEDURE IF EXISTS `POMELO_BEFORE_DROP_PRIMARY_KEY`;
DELIMITER //
CREATE PROCEDURE `POMELO_BEFORE_DROP_PRIMARY_KEY`(IN `SCHEMA_NAME_ARGUMENT` VARCHAR(255), IN `TABLE_NAME_ARGUMENT` VARCHAR(255))
BEGIN
        DECLARE HAS_AUTO_INCREMENT_ID TINYINT(1);
        DECLARE PRIMARY_KEY_COLUMN_NAME VARCHAR(255);
        DECLARE PRIMARY_KEY_TYPE VARCHAR(255);
        DECLARE SQL_EXP VARCHAR(1000);
        SELECT COUNT(*)
                INTO HAS_AUTO_INCREMENT_ID
                FROM `information_schema`.`COLUMNS`
                WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
                        AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
                        AND `Extra` = 'auto_increment'
                        AND `COLUMN_KEY` = 'PRI'
                        LIMIT 1;
        IF HAS_AUTO_INCREMENT_ID THEN
                SELECT `COLUMN_TYPE`
                        INTO PRIMARY_KEY_TYPE
                        FROM `information_schema`.`COLUMNS`
                        WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
                                AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
                                AND `COLUMN_KEY` = 'PRI'
                        LIMIT 1;
                SELECT `COLUMN_NAME`
                        INTO PRIMARY_KEY_COLUMN_NAME
                        FROM `information_schema`.`COLUMNS`
                        WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
                                AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
                                AND `COLUMN_KEY` = 'PRI'
                        LIMIT 1;
                SET SQL_EXP = CONCAT('ALTER TABLE `', (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA())), '`.`', TABLE_NAME_ARGUMENT, '` MODIFY COLUMN `', PRIMARY_KEY_COLUMN_NAME, '` ', PRIMARY_KEY_TYPE, ' NOT NULL;');
                SET @SQL_EXP = SQL_EXP;
                PREPARE SQL_EXP_EXECUTE FROM @SQL_EXP;
                EXECUTE SQL_EXP_EXECUTE;
                DEALLOCATE PREPARE SQL_EXP_EXECUTE;
        END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS `POMELO_AFTER_ADD_PRIMARY_KEY`;
DELIMITER //
CREATE PROCEDURE `POMELO_AFTER_ADD_PRIMARY_KEY`(IN `SCHEMA_NAME_ARGUMENT` VARCHAR(255), IN `TABLE_NAME_ARGUMENT` VARCHAR(255), IN `COLUMN_NAME_ARGUMENT` VARCHAR(255))
BEGIN
        DECLARE HAS_AUTO_INCREMENT_ID INT(11);
        DECLARE PRIMARY_KEY_COLUMN_NAME VARCHAR(255);
        DECLARE PRIMARY_KEY_TYPE VARCHAR(255);
        DECLARE SQL_EXP VARCHAR(1000);
        SELECT COUNT(*)
                INTO HAS_AUTO_INCREMENT_ID
                FROM `information_schema`.`COLUMNS`
                WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
                        AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
                        AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
                        AND `COLUMN_TYPE` LIKE '%int%'
                        AND `COLUMN_KEY` = 'PRI';
        IF HAS_AUTO_INCREMENT_ID THEN
                SELECT `COLUMN_TYPE`
                        INTO PRIMARY_KEY_TYPE
                        FROM `information_schema`.`COLUMNS`
                        WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
                                AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
                                AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
                                AND `COLUMN_TYPE` LIKE '%int%'
                                AND `COLUMN_KEY` = 'PRI';
                SELECT `COLUMN_NAME`
                        INTO PRIMARY_KEY_COLUMN_NAME
                        FROM `information_schema`.`COLUMNS`
                        WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
                                AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
                                AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
                                AND `COLUMN_TYPE` LIKE '%int%'
                                AND `COLUMN_KEY` = 'PRI';
                SET SQL_EXP = CONCAT('ALTER TABLE `', (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA())), '`.`', TABLE_NAME_ARGUMENT, '` MODIFY COLUMN `', PRIMARY_KEY_COLUMN_NAME, '` ', PRIMARY_KEY_TYPE, ' NOT NULL AUTO_INCREMENT;');
                SET @SQL_EXP = SQL_EXP;
                PREPARE SQL_EXP_EXECUTE FROM @SQL_EXP;
                EXECUTE SQL_EXP_EXECUTE;
                DEALLOCATE PREPARE SQL_EXP_EXECUTE;
        END IF;
END //
DELIMITER ;

CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241008125001_InitialCreate') THEN

    ALTER DATABASE CHARACTER SET utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241008125001_InitialCreate') THEN

    CREATE TABLE `Users` (
        `Id` int NOT NULL AUTO_INCREMENT,
        `UserId` int NOT NULL,
        `ReferalId` int NOT NULL,
        `Points` int NOT NULL,
        CONSTRAINT `PK_Users` PRIMARY KEY (`Id`)
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241008125001_InitialCreate') THEN

    CREATE TABLE `Prizes` (
        `Id` int NOT NULL AUTO_INCREMENT,
        `Name` longtext CHARACTER SET utf8mb4 NOT NULL,
        `Description` longtext CHARACTER SET utf8mb4 NULL,
        `Cost` int NOT NULL,
        `Image` longblob NULL,
        `WinnerId` int NULL,
        CONSTRAINT `PK_Prizes` PRIMARY KEY (`Id`),
        CONSTRAINT `FK_Prizes_Users_WinnerId` FOREIGN KEY (`WinnerId`) REFERENCES `Users` (`Id`)
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241008125001_InitialCreate') THEN

    CREATE INDEX `IX_Prizes_WinnerId` ON `Prizes` (`WinnerId`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241008125001_InitialCreate') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20241008125001_InitialCreate', '8.0.8');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241010200247_AddAdminTableAndChannelToPrize') THEN

    ALTER TABLE `Users` ADD `UserName` longtext CHARACTER SET utf8mb4 NOT NULL;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241010200247_AddAdminTableAndChannelToPrize') THEN

    ALTER TABLE `Prizes` ADD `ChannelName` longtext CHARACTER SET utf8mb4 NOT NULL;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241010200247_AddAdminTableAndChannelToPrize') THEN

    ALTER TABLE `Prizes` ADD `ChannelUrl` longtext CHARACTER SET utf8mb4 NOT NULL;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241010200247_AddAdminTableAndChannelToPrize') THEN

    CREATE TABLE `Admins` (
        `Id` int NOT NULL AUTO_INCREMENT,
        `UserName` int NOT NULL,
        `ChannelUrl` longtext CHARACTER SET utf8mb4 NOT NULL,
        CONSTRAINT `PK_Admins` PRIMARY KEY (`Id`)
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241010200247_AddAdminTableAndChannelToPrize') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20241010200247_AddAdminTableAndChannelToPrize', '8.0.8');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241015210428_ChangePrizeRelationship') THEN

    ALTER TABLE `Prizes` DROP FOREIGN KEY `FK_Prizes_Users_WinnerId`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241015210428_ChangePrizeRelationship') THEN

    ALTER TABLE `Prizes` RENAME COLUMN `WinnerId` TO `UserId`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241015210428_ChangePrizeRelationship') THEN

    ALTER TABLE `Prizes` RENAME INDEX `IX_Prizes_WinnerId` TO `IX_Prizes_UserId`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241015210428_ChangePrizeRelationship') THEN

    ALTER TABLE `Prizes` ADD CONSTRAINT `FK_Prizes_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`Id`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241015210428_ChangePrizeRelationship') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20241015210428_ChangePrizeRelationship', '8.0.8');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241016111219_AddChannelTable') THEN

    CREATE TABLE `Channels` (
        `Id` int NOT NULL AUTO_INCREMENT,
        `Name` longtext CHARACTER SET utf8mb4 NOT NULL,
        `Url` longtext CHARACTER SET utf8mb4 NOT NULL,
        CONSTRAINT `PK_Channels` PRIMARY KEY (`Id`)
    ) CHARACTER SET=utf8mb4;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241016111219_AddChannelTable') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20241016111219_AddChannelTable', '8.0.8');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    ALTER TABLE `Prizes` DROP FOREIGN KEY `FK_Prizes_Users_UserId`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    CALL POMELO_BEFORE_DROP_PRIMARY_KEY(NULL, 'Users');
    ALTER TABLE `Users` DROP PRIMARY KEY;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    ALTER TABLE `Prizes` DROP INDEX `IX_Prizes_UserId`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    ALTER TABLE `Users` DROP COLUMN `Id`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    ALTER TABLE `Admins` RENAME COLUMN `Id` TO `UserId`;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    ALTER TABLE `Users` MODIFY COLUMN `UserId` int NOT NULL AUTO_INCREMENT,
    ADD CONSTRAINT `PK_Users` PRIMARY KEY (`UserId`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    CREATE INDEX `IX_Prizes_UserId` ON `Prizes` (`UserId` DESC);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    ALTER TABLE `Prizes` ADD CONSTRAINT `FK_Prizes_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `Users` (`UserId`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241017201427_AddUserIdToAdminModel') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20241017201427_AddUserIdToAdminModel', '8.0.8');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

START TRANSACTION;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241018071243_FixTypeUserNameInAdminTable') THEN

    ALTER TABLE `Admins` MODIFY COLUMN `UserName` varchar(255) CHARACTER SET utf8mb4 NOT NULL;

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241018071243_FixTypeUserNameInAdminTable') THEN

    CREATE UNIQUE INDEX `IX_Admins_UserName` ON `Admins` (`UserName`);

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

DROP PROCEDURE IF EXISTS MigrationsScript;
DELIMITER //
CREATE PROCEDURE MigrationsScript()
BEGIN
    IF NOT EXISTS(SELECT 1 FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20241018071243_FixTypeUserNameInAdminTable') THEN

    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20241018071243_FixTypeUserNameInAdminTable', '8.0.8');

    END IF;
END //
DELIMITER ;
CALL MigrationsScript();
DROP PROCEDURE MigrationsScript;

COMMIT;

DROP PROCEDURE `POMELO_BEFORE_DROP_PRIMARY_KEY`;

DROP PROCEDURE `POMELO_AFTER_ADD_PRIMARY_KEY`;