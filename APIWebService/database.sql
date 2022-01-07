Create DATABASE webapidatabase CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE webapidatabase;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Users` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` INT NOT NULL,
  `language` INT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `terms_conditions` INT(1) UNSIGNED NOT NULL DEFAULT '0',
  `login_failed` INT UNSIGNED NOT NULL DEFAULT '0',
  `last_login` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Users_History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Users_History` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_user` INT(10) UNSIGNED NOT NULL,
  `role` INT NOT NULL,
  `language` INT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `terms_conditions` INT(1) UNSIGNED NOT NULL DEFAULT '0',
  `login_failed` INT UNSIGNED NOT NULL DEFAULT '0',
  `last_login` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),

  KEY `Users_History_history_trigger_idx` (`history_trigger`),
  KEY `fk_Users_history_Users_idx` (`id_user`),
  KEY `fk_Users_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_Users_history_Users_idx` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_user
  AFTER INSERT
  ON Users FOR EACH ROW
  INSERT INTO Users_History
  SELECT NULL, 'insert', Users.* FROM Users WHERE Users.ID = NEW.ID;

CREATE
  TRIGGER update_user
  AFTER UPDATE
  ON Users FOR EACH ROW
  INSERT INTO Users_History
  SELECT NULL, 'update', Users.* FROM Users WHERE Users.ID = NEW.ID;

CREATE
  TRIGGER delete_user
  AFTER DELETE
  ON Users FOR EACH ROW
  INSERT INTO Users_History
  SELECT NULL, 'delete', Users.* FROM Users WHERE Users.ID = OLD.ID;

CREATE TABLE `AspNetRoles` (
  `Id` varchar(767) NOT NULL,
  `Name` varchar(256) NULL,
  `NormalizedName` varchar(200) NULL,
  `ConcurrencyStamp` text NULL,
  PRIMARY KEY (`Id`)
);


CREATE TABLE `AspNetRoleClaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(767) NOT NULL,
  `ClaimType` text NULL,
  `ClaimValue` text NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUsers` (
  `Id` varchar(767) NOT NULL,
  `UserName` varchar(256) NULL,
  `NormalizedUserName` varchar(256) NULL,
  `Email` varchar(256) NULL,
  `NormalizedEmail` varchar(256) NULL,
  `EmailConfirmed` int NOT NULL,
  `PasswordHash` text NULL,
  `SecurityStamp` text NULL,
  `ConcurrencyStamp` text NULL,
  `PhoneNumber` text NULL,
  `PhoneNumberConfirmed` int NOT NULL,
  `TwoFactorEnabled` int NOT NULL,
  `LockoutEnd` timestamp NULL,
  `LockoutEnabled` int NOT NULL,
  `AccessFailedCount` int NOT NULL,
  `UserID` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_AspNetUsers_Users_UserID` FOREIGN KEY (`UserID`) REFERENCES `Users` (`ID`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserClaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(200) NOT NULL,
  `ClaimType` text NULL,
  `ClaimValue` text NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserLogins` (
  `LoginProvider` varchar(200) NOT NULL,
  `ProviderKey` varchar(200) NOT NULL,
  `ProviderDisplayName` text NULL,
  `UserId` varchar(200) NOT NULL,
  PRIMARY KEY (`LoginProvider`, `ProviderKey`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserRoles` (
  `UserId` varchar(200) NOT NULL,
  `RoleId` varchar(200) NOT NULL,
  PRIMARY KEY (`UserId`, `RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserTokens` (
  `UserId` varchar(200) NOT NULL,
  `LoginProvider` varchar(200) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Value` text NULL,
  PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);


CREATE INDEX `IX_AspNetRoleClaims_RoleId` ON `AspNetRoleClaims` (`RoleId`);

CREATE UNIQUE INDEX `RoleNameIndex` ON `AspNetRoles` (`NormalizedName`);

CREATE INDEX `IX_AspNetUserClaims_UserId` ON `AspNetUserClaims` (`UserId`);

CREATE INDEX `IX_AspNetUserLogins_UserId` ON `AspNetUserLogins` (`UserId`);

CREATE INDEX `IX_AspNetUserRoles_RoleId` ON `AspNetUserRoles` (`RoleId`);

CREATE INDEX `EmailIndex` ON `AspNetUsers` (`NormalizedEmail`);

CREATE UNIQUE INDEX `UserNameIndex` ON `AspNetUsers` (`NormalizedUserName`);

CREATE INDEX `IX_AspNetUsers_UserID` ON `AspNetUsers` (`UserID`);

USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Basics_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Basics_Information` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `last_name` TEXT NOT NULL,
  `profile_avatar` TEXT NULL,
  `passport` TEXT NULL,
  `identification_card` TEXT NULL,
  `age` INT NULL,
  `birth_date` DATE NULL,
  `nationality` TEXT NULL,
  `gender` INT NULL,
  `civil_status` INT NULL,
  `blood_type` INT NULL,
  `phone_number` TEXT NULL,
  `phone_number2` TEXT NULL,
  `email` TEXT NOT NULL,
  `job_id` TEXT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Basics_Information_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Basics_Information_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Basics_Information_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Basics_Information_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Basics_Information_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_basic_information` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `last_name` TEXT NOT NULL,
  `profile_avatar` TEXT NULL,
  `age` INT NULL,
  `birth_date` DATE NULL,
  `nationality` TEXT NULL,
  `gender` INT NULL,
  `civil_status` INT NULL,
  `blood_type` INT NULL,
  `phone_number` TEXT NULL,
  `phone_number2` TEXT NULL,
  `email` TEXT NOT NULL,
  `job_id` TEXT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Basics_Information_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Basics_Information_history_Basics_Information_idx` (`id_basic_information`),
  KEY `fk_Basics_Information_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_Basics_Information_history_Basics_Information_idx` FOREIGN KEY (`id_basic_information`) REFERENCES `Basics_Information` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Basics_Information_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_basic_information
  AFTER INSERT
  ON Basics_Information FOR EACH ROW
  INSERT INTO Basics_Information_History
  SELECT NULL, 'insert', Basics_Information.* FROM Basics_Information WHERE Basics_Information.ID = NEW.ID;

CREATE
  TRIGGER update_basic_information
  AFTER UPDATE
  ON Basics_Information FOR EACH ROW
  INSERT INTO Basics_Information_History
  SELECT NULL, 'update', Basics_Information.* FROM Basics_Information WHERE Basics_Information.ID = NEW.ID;

CREATE
  TRIGGER delete_basic_information
  AFTER DELETE
  ON Basics_Information FOR EACH ROW
  INSERT INTO Basics_Information_History
  SELECT NULL, 'delete', Basics_Information.* FROM Basics_Information WHERE Basics_Information.ID = OLD.ID;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Localization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Localizations` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `address` TEXT NULL,
  `address2` TEXT NULL,
  `latitude` TEXT NULL,
  `longitude` TEXT NULL,
  `state` TEXT NULL,
  `city` TEXT NULL,
  `district` TEXT NULL,
  `country` TEXT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_localization_Users_modified_by_idx` (`id_user_modified_by`),
 KEY `fk_localization_Users_idx` (`id_user`),
 CONSTRAINT `fk_localization_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_localization_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Localization_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Localizations_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_localization` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `address` TEXT NULL,
  `address2` TEXT NULL,
  `latitude` TEXT NULL,
  `longitude` TEXT NULL,
  `state` TEXT NULL,
  `city` TEXT NULL,
  `district` TEXT NULL,
  `country` TEXT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Localizations_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_localization_history_localization_idx` (`id_localization`),
  KEY `fk_localization_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_localization_history_localization_idx` FOREIGN KEY (`id_localization`) REFERENCES `webapidatabase`.`Localizations` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_localization_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_localization
  AFTER INSERT
  ON Localizations FOR EACH ROW
  INSERT INTO Localizations_History
  SELECT NULL, 'insert', Localizations.* FROM Localizations WHERE Localizations.ID = NEW.ID;

CREATE
  TRIGGER update_localization
  AFTER UPDATE
  ON Localizations FOR EACH ROW
  INSERT INTO Localizations_History
  SELECT NULL, 'update', Localizations.* FROM Localizations WHERE Localizations.ID = NEW.ID;

CREATE
  TRIGGER delete_localization
  AFTER DELETE
  ON Localizations FOR EACH ROW
  INSERT INTO Localizations_History
  SELECT NULL, 'delete', Localizations.* FROM Localizations WHERE Localizations.ID = OLD.ID;

USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Organizations` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,  
  `logo` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `email` TEXT NOT NULL,
  `phone` TEXT NOT NULL,
  `legal_certificate` TEXT NULL,
  `type_organization` INT NOT NULL,
  `suborganization` INT(10) NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Organizations_Users_modified_by_idx` (`id_user_modified_by`),
 KEY `fk_Organizations_Users_idx` (`id_user`),
 CONSTRAINT `fk_Organizations_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Organizations_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `Programs_Organizations_id_x` ON `webapidatabase`.`Organizations` (`id_user` ASC);

-- -----------------------------------------------------
-- Table `webapidatabase`.`Organizations_history`
-- -----------------------------------------------------
 CREATE TABLE IF NOT EXISTS `webapidatabase`.`Organizations_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_organization` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `logo` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `email` TEXT NOT NULL,
  `phone` TEXT NOT NULL,  
  `type_organization` INT NOT NULL,
  `suborganization` INT(10) UNSIGNED NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,

  PRIMARY KEY (`ID_history`),
  KEY `Organizations_history_history_trigger_id_x` (`history_trigger`),
  KEY `fk_Organizations_history_Organizations_id_x` (`id_organization`),
  KEY `fk_Organizations_history_Users_modified_by_id_x` (`id_user_modified_by`),
  CONSTRAINT `fk_Organizations_history_Organizations_id_x` FOREIGN KEY (`id_organization`) REFERENCES `webapidatabase`.`Organizations` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organizations_history_Users_modified_by_id_x` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_organization
  AFTER INSERT
  ON Organizations FOR EACH ROW
  INSERT INTO Organizations_History
  SELECT NULL, 'insert', Organizations.* FROM Organizations WHERE Organizations.ID = NEW.ID;

CREATE
  TRIGGER update_organization
  AFTER UPDATE
  ON Organizations FOR EACH ROW
  INSERT INTO Organizations_History
  SELECT NULL, 'update', Organizations.* FROM Organizations WHERE Organizations.ID = NEW.ID;

CREATE
  TRIGGER delete_organization
  AFTER DELETE
  ON Organizations FOR EACH ROW
  INSERT INTO Organizations_History
  SELECT NULL, 'delete', Organizations.* FROM Organizations WHERE Organizations.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Departments` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_organization` INT(10) UNSIGNED NOT NULL,
 `id_attendant` INT(10) UNSIGNED NOT NULL,
 `department_name` TEXT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_department_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_department_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_department_organization` FOREIGN KEY (`id_organization`) REFERENCES `webapidatabase`.`Organizations` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `Organization_department_idx` ON `webapidatabase`.`Departments` (`id_organization` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Departments_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Departments_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_department` INT(10) UNSIGNED NOT NULL,
  `id_organization` INT(10) UNSIGNED NOT NULL,
  `id_attendant` INT(10) UNSIGNED NOT NULL,
  `department_name` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),
  KEY `Departments_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_department_history_department_idx` (`id_department`),
  KEY `fk_department_history_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_department_history_department_idx` FOREIGN KEY (`id_department`) REFERENCES `webapidatabase`.`Departments` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_department
  AFTER INSERT
  ON Departments FOR EACH ROW
  INSERT INTO Departments_History
  SELECT NULL, 'insert', Departments.* FROM Departments WHERE Departments.ID = NEW.ID;

CREATE
  TRIGGER update_department
  AFTER UPDATE
  ON Departments FOR EACH ROW
  INSERT INTO Departments_History
  SELECT NULL, 'update', Departments.* FROM Departments WHERE Departments.ID = NEW.ID;

CREATE
  TRIGGER delete_department
  AFTER DELETE
  ON Departments FOR EACH ROW
  INSERT INTO Departments_History
  SELECT NULL, 'delete', Departments.* FROM Departments WHERE Departments.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Teams`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `webapidatabase`.`Teams` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_attendant` INT(10) UNSIGNED NOT NULL,
  `id_organization` INT(10) UNSIGNED NOT NULL,

  `name` TEXT NOT NULL,
  `detail` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_team_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_team_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organization_Teams` FOREIGN KEY (`id_organization`) REFERENCES `webapidatabase`.`Organizations`(`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Teams_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Teams_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_team` INT(10) UNSIGNED NOT NULL,
  `id_attendant` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `detail` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),
  KEY `Teams_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_team_history_team_idx` (`id_team`),
  KEY `fk_team_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_team_history_team_idx` FOREIGN KEY (`id_team`) REFERENCES `webapidatabase`.`Teams` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_team
  AFTER INSERT
  ON Teams FOR EACH ROW
  INSERT INTO Teams_History
  SELECT NULL, 'insert', Teams.* FROM Teams WHERE Teams.ID = NEW.ID;

CREATE
  TRIGGER update_team
  AFTER UPDATE
  ON Teams FOR EACH ROW
  INSERT INTO Teams_History
  SELECT NULL, 'update', Teams.* FROM Teams WHERE Teams.ID = NEW.ID;

CREATE
  TRIGGER delete_team
  AFTER DELETE
  ON Teams FOR EACH ROW
  INSERT INTO Teams_History
  SELECT NULL, 'delete', Teams.* FROM Teams WHERE Teams.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Positions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Positions` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `id_organization` INT(10) UNSIGNED NOT NULL DEFAULT '1',
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Positions_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Positions_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Positions_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Positions_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_position` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `id_organization` INT(10) UNSIGNED NOT NULL DEFAULT '1',
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,

  PRIMARY KEY (`ID_history`),

  KEY `Positions_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Positions_history_Positions_idx` (`id_position`),
  KEY `fk_Positions_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_Positions_history_Positions_idx` FOREIGN KEY (`id_position`) REFERENCES `webapidatabase`.`Positions` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Positions_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_position
  AFTER INSERT
  ON Positions FOR EACH ROW
  INSERT INTO Positions_History
  SELECT NULL, 'insert', Positions.* FROM Positions WHERE Positions.ID = NEW.ID;

CREATE
  TRIGGER update_position
  AFTER UPDATE
  ON Positions FOR EACH ROW
  INSERT INTO Positions_History
  SELECT NULL, 'update', Positions.* FROM Positions WHERE Positions.ID = NEW.ID;

CREATE
  TRIGGER delete_position
  AFTER DELETE
  ON Positions FOR EACH ROW
  INSERT INTO Positions_History
  SELECT NULL, 'delete', Positions.* FROM Positions WHERE Positions.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Collaborators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Collaborators` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `id_team` INT(10) UNSIGNED NOT NULL,
  `id_department` int(10) UNSIGNED NOT NULL,
  `id_organization` int(10) UNSIGNED NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Collaborators_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Collaborators_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Collaborators_team` FOREIGN KEY (`id_team`) REFERENCES `webapidatabase`.`Teams` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Collaborators_Department` FOREIGN KEY (`id_department`) REFERENCES `webapidatabase`.`Departments`(`ID`)ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organization_Collaborators` FOREIGN KEY (`id_organization`) REFERENCES `webapidatabase`.`Organizations`(`ID`)ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `Collaborators_team_idx` ON `webapidatabase`.`Collaborators` (`id_team` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Collaborators_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Collaborators_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_collaborator` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `id_team` INT(10) UNSIGNED NOT NULL ,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),
  KEY `Collaborators_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Collaborators_history_Collaborators_idx` (`id_collaborator`),
  KEY `fk_Collaborators_history_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Collaborators_history_Collaborators_idx` FOREIGN KEY (`id_collaborator`) REFERENCES `webapidatabase`.`Collaborators` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Collaborators_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_collaborator
  AFTER INSERT
  ON Collaborators FOR EACH ROW
  INSERT INTO Collaborators_History
  SELECT NULL, 'insert', Collaborators.* FROM Collaborators WHERE Collaborators.ID = NEW.ID;

CREATE
  TRIGGER update_collaborator
  AFTER UPDATE
  ON Collaborators FOR EACH ROW
  INSERT INTO Collaborators_History
  SELECT NULL, 'update', Collaborators.* FROM Collaborators WHERE Collaborators.ID = NEW.ID;

CREATE
  TRIGGER delete_collaborator
  AFTER DELETE
  ON Collaborators FOR EACH ROW
  INSERT INTO Collaborators_History
  SELECT NULL, 'delete', Collaborators.* FROM Collaborators WHERE Collaborators.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Roles` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `name` TEXT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_role_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_role_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Roles_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Roles_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_role` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Roles_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_role_history_role_idx` (`id_role`),
  KEY `fk_role_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_role_history_role_idx` FOREIGN KEY (`id_role`) REFERENCES `webapidatabase`.`Roles` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_role
  AFTER INSERT
  ON Roles FOR EACH ROW
  INSERT INTO Roles_History
  SELECT NULL, 'insert', Roles.* FROM Roles WHERE Roles.ID = NEW.ID;

CREATE
  TRIGGER update_role
  AFTER UPDATE
  ON Roles FOR EACH ROW
  INSERT INTO Roles_History
  SELECT NULL, 'update', Roles.* FROM Roles WHERE Roles.ID = NEW.ID;

CREATE
  TRIGGER delete_role
  AFTER DELETE
  ON Roles FOR EACH ROW
  INSERT INTO Roles_History
  SELECT NULL, 'delete', Roles.* FROM Roles WHERE Roles.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Coaches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Coaches` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_coach_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_coach_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Coaches_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Coaches_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_coach` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Coaches_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_coach_history_coach_idx` (`id_coach`),
  KEY `fk_coach_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_coach_history_coach_idx` FOREIGN KEY (`id_coach`) REFERENCES `webapidatabase`.`Coaches` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_coach_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_coach
  AFTER INSERT
  ON Coaches FOR EACH ROW
  INSERT INTO Coaches_History
  SELECT NULL, 'insert', Coaches.* FROM Coaches WHERE Coaches.ID = NEW.ID;

CREATE
  TRIGGER update_coach
  AFTER UPDATE
  ON Coaches FOR EACH ROW
  INSERT INTO Coaches_History
  SELECT NULL, 'update', Coaches.* FROM Coaches WHERE Coaches.ID = NEW.ID;

CREATE
  TRIGGER delete_coach
  AFTER DELETE
  ON Coaches FOR EACH ROW
  INSERT INTO Coaches_History
  SELECT NULL, 'delete', Coaches.* FROM Coaches WHERE Coaches.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Authors` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `facebook_link` TEXT NOT NULL,
  `linkedin_link` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `studies` TEXT NOT NULL,
  `work` TEXT NOT NULL,
  `specialty` TEXT NOT NULL,
  `total_courses` INT NOT NULL DEFAULT '0',
  `total_videos` INT NOT NULL DEFAULT '0',
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Authors_Users_modified_by_idx` (`id_user_modified_by`),
  KEY `fk_Authors_Users_idx` (`id_user`),
  CONSTRAINT `fk_Authors_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authors_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Authors_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Authors_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_author` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `facebook_link` TEXT NOT NULL,
  `linkedin_link` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `studies` TEXT NOT NULL,
  `work` TEXT NOT NULL,
  `specialty` TEXT NOT NULL,
  `total_courses` INT NOT NULL,
  `total_videos` INT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Authors_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Authors_history_Authors_idx` (`id_author`),
  KEY `fk_Authors_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_Authors_history_Authors_idx` FOREIGN KEY (`id_author`) REFERENCES `webapidatabase`.`Authors` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authors_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_author
  AFTER INSERT
  ON Authors FOR EACH ROW
  INSERT INTO Authors_History
  SELECT NULL, 'insert', Authors.* FROM Authors WHERE Authors.ID = NEW.ID;

CREATE
  TRIGGER update_author
  AFTER UPDATE
  ON Authors FOR EACH ROW
  INSERT INTO Authors_History
  SELECT NULL, 'update', Authors.* FROM Authors WHERE Authors.ID = NEW.ID;

CREATE
  TRIGGER delete_author
  AFTER DELETE
  ON Authors FOR EACH ROW
  INSERT INTO Authors_History
  SELECT NULL, 'delete', Authors.* FROM Authors WHERE Authors.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Comments` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `comment` TEXT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_comment_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_comment_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_comment_user` FOREIGN KEY (`id_user`)  REFERENCES `webapidatabase`.`Users` (`ID`)  ON DELETE NO ACTION  ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `Comments_Users_idx` ON `webapidatabase`.`Comments` (`id_user` ASC);

-- -----------------------------------------------------
-- Table `webapidatabase`.`Comments_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Comments_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_comment` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `comment` TEXT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 
 PRIMARY KEY (`ID_history`),
 KEY `Comments_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_comment_history_comment_idx` (`id_comment`),
 KEY `fk_comment_history_Users_modified_by_idx` (`id_user_modified_by`),
 KEY `fk_Comment_Users_idx` (`id_user`),
 CONSTRAINT `fk_Comment_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_comment_history_comment_idx` FOREIGN KEY (`id_comment`) REFERENCES `webapidatabase`.`Comments` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_comment_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_comment
  AFTER INSERT
  ON Comments FOR EACH ROW
  INSERT INTO Comments_History
  SELECT NULL, 'insert', Comments.* FROM Comments WHERE Comments.ID = NEW.ID;

CREATE
  TRIGGER update_comment
  AFTER UPDATE
  ON Comments FOR EACH ROW
  INSERT INTO Comments_History
  SELECT NULL, 'update', Comments.* FROM Comments WHERE Comments.ID = NEW.ID;

CREATE
  TRIGGER delete_comment
  AFTER DELETE
  ON Comments FOR EACH ROW
  INSERT INTO Comments_History
  SELECT NULL, 'delete', Comments.* FROM Comments WHERE Comments.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Categories` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `name` TEXT NOT NULL,
 `parent` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_category_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_category_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Categories_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Categories_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_category` INT(10) UNSIGNED NOT NULL,
 `name` TEXT NOT NULL,
 `parent` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Categories_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_category_history_category_idx` (`id_category`),
 KEY `fk_category_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_category_history_category_idx` FOREIGN KEY (`id_category`) REFERENCES `webapidatabase`.`Categories` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_category_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_category
  AFTER INSERT
  ON Categories FOR EACH ROW
  INSERT INTO Categories_History
  SELECT NULL, 'insert', Categories.* FROM Categories WHERE Categories.ID = NEW.ID;

CREATE
  TRIGGER update_category
  AFTER UPDATE
  ON Categories FOR EACH ROW
  INSERT INTO Categories_History
  SELECT NULL, 'update', Categories.* FROM Categories WHERE Categories.ID = NEW.ID;

CREATE
  TRIGGER delete_category
  AFTER DELETE
  ON Categories FOR EACH ROW
  INSERT INTO Categories_History
  SELECT NULL, 'delete', Categories.* FROM Categories WHERE Categories.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `name` TEXT NOT NULL,
 `id_category` INT(10) UNSIGNED NOT NULL,
 `image` TEXT NOT NULL,
 `icon` TEXT NOT NULL,
 `description` TEXT NOT NULL,
 `short_description` TEXT NOT NULL,
 `level` INT NOT NULL,
 `id_author` INT(10) UNSIGNED NOT NULL,
 `slug` TEXT NOT NULL,
 `video_introduction` TEXT NOT NULL,
 `language` INT NOT NULL,
 `search_count` INT NOT NULL,
 `prerequisites` TEXT NOT NULL,
 `total_minutes` int NOT NULL,
 `total_seconds` int NOT NULL,
 `characteristics` TEXT NOT NULL,
 `certificate` TINYINT NOT NULL,
 `like_quantity` INT NOT NULL,
 `feature` TINYINT NOT NULL, 
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Courses_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Categories` FOREIGN KEY (`id_category`) REFERENCES `webapidatabase`.`Categories` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Authors` FOREIGN KEY (`id_author`) REFERENCES `webapidatabase`.`Authors` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `Courses_category_idx` ON `webapidatabase`.`Courses` (`id_category` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_course` INT(10) UNSIGNED NOT NULL,
 `name` TEXT NOT NULL,
 `id_category` INT(10) UNSIGNED NOT NULL,
 `image` TEXT NOT NULL,
 `icon` TEXT NOT NULL,
 `description` TEXT NOT NULL,
 `short_description` TEXT NOT NULL,
 `level` INT NOT NULL,
 `id_author`  INT(10) UNSIGNED NOT NULL,
 `slug` TEXT NOT NULL,
 `video_introduction` TEXT NOT NULL,
 `language` INT NOT NULL,
 `search_count` INT NOT NULL,
 `prerequisites` text NOT NULL,
 `total_minutes` int NOT NULL,
 `total_seconds` int NOT NULL,
 `characteristics` TEXT NOT NULL,
 `certificate` TINYINT NOT NULL,
 `like_quantity` INT NOT NULL,
 `feature` TINYINT NOT NULL, 
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Courses_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Courses_history_Courses_idx` (`id_course`),
 KEY `fk_Courses_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_history_Courses_idx` FOREIGN KEY (`id_course`) REFERENCES `webapidatabase`.`Courses` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_courses
  AFTER INSERT
  ON Courses FOR EACH ROW
  INSERT INTO Courses_History
  SELECT NULL, 'insert', Courses.* FROM Courses WHERE Courses.ID = NEW.ID;

CREATE
  TRIGGER update_courses
  AFTER UPDATE
  ON Courses FOR EACH ROW
  INSERT INTO Courses_History
  SELECT NULL, 'update', Courses.* FROM Courses WHERE Courses.ID = NEW.ID;

CREATE
  TRIGGER delete_courses
  AFTER DELETE
  ON Courses FOR EACH ROW
  INSERT INTO Courses_History
  SELECT NULL, 'delete', Courses.* FROM Courses WHERE Courses.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Videos` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `video_url` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `video_type` INT NOT NULL,
  `order` INT NOT NULL,
  `description` TEXT NOT NULL,
  `total_views` INT NOT NULL,
  `total_likes` INT NOT NULL,
  `id_author` INT(10) UNSIGNED NOT NULL,
  `total_minutes` int NOT NULL,
  `total_seconds` int NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 CONSTRAINT `fk_video_Users_Authors_idx` FOREIGN KEY (`id_author`) REFERENCES `webapidatabase`.`Authors` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_video_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 KEY `fk_video_Users_modified_by_idx` (`id_user_modified_by`),
 KEY `fk_video_Users_author_idx` (`id_author`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`video_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Videos_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_video` INT(10) UNSIGNED NOT NULL,
  `video_url` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `video_type` INT NOT NULL,
  `order` INT NOT NULL,
  `description` TEXT NOT NULL,
  `total_views` INT NOT NULL,
  `total_likes` INT NOT NULL,
  `id_author` INT(10) UNSIGNED NOT NULL,
  `total_minutes` int NOT NULL,
  `total_seconds` int NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `video_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_video_history_video_idx` (`id_video`),
  KEY `fk_video_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_video_history_video_idx` FOREIGN KEY (`id_video`) REFERENCES `webapidatabase`.`Videos` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_video
  AFTER INSERT
  ON Videos FOR EACH ROW
  INSERT INTO Videos_History
  SELECT NULL, 'insert', Videos.* FROM Videos WHERE Videos.ID = NEW.ID;

CREATE
  TRIGGER update_video
  AFTER UPDATE
  ON Videos FOR EACH ROW
  INSERT INTO Videos_History
  SELECT NULL, 'update', Videos.* FROM Videos WHERE Videos.ID = NEW.ID;

CREATE
  TRIGGER delete_video
  AFTER DELETE
  ON Videos FOR EACH ROW
  INSERT INTO Videos_History
  SELECT NULL, 'delete', Videos.* FROM Videos WHERE Videos.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Modules` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `name` TEXT NOT NULL,
 `icon` TEXT NOT NULL,
 `image` TEXT NOT NULL,
 `order` INT NOT NULL,
 `description` TEXT NOT NULL,
 `slug` TEXT NOT NULL,
 `total_minutes` int NOT NULL,
 `total_seconds` int NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Modules_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Modules_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Modules_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Modules_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_module` INT(10) UNSIGNED NOT NULL,
 `name` TEXT NOT NULL,
 `icon` TEXT NOT NULL,
 `image` TEXT NOT NULL,
 `order` INT NOT NULL,
 `description` TEXT NOT NULL,
 `slug` TEXT NOT NULL,
 `total_minutes` int NOT NULL,
 `total_seconds` int NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Modules_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Modules_history_Modules_idx` (`id_module`),
 KEY `fk_Modules_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Modules_history_Modules_idx` FOREIGN KEY (`id_module`) REFERENCES `webapidatabase`.`Modules` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Modules_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_module
  AFTER INSERT
  ON Modules FOR EACH ROW
  INSERT INTO Modules_History
  SELECT NULL, 'insert', Modules.* FROM Modules WHERE Modules.ID = NEW.ID;

CREATE
  TRIGGER update_module
  AFTER UPDATE
  ON Modules FOR EACH ROW
  INSERT INTO Modules_History
  SELECT NULL, 'update', Modules.* FROM Modules WHERE Modules.ID = NEW.ID;

CREATE
  TRIGGER delete_module
  AFTER DELETE
  ON Modules FOR EACH ROW
  INSERT INTO Modules_History
  SELECT NULL, 'delete', Modules.* FROM Modules WHERE Modules.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Coursess_module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Modules` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `id_module` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Courses_Modules_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Modules_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Modules_Course` FOREIGN KEY (`id_course`) REFERENCES `webapidatabase`.`Courses` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Modules_Module` FOREIGN KEY (`id_module`) REFERENCES `webapidatabase`.`Modules` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION

) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `Courses_Modules_Course_idx` ON `webapidatabase`.`Courses_Modules` (`id_course` ASC);
CREATE INDEX `Courses_Modules_Module_idx` ON `webapidatabase`.`Courses_Modules` (`id_module` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Modules_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Modules_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_courses_module` INT(10) UNSIGNED NOT NULL,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `id_module` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,

 PRIMARY KEY (`ID_history`),
 KEY `Courses_Modules_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Courses_Modules_history_Courses_Modules_idx` (`id_courses_module`),
 KEY `fk_Courses_Modules_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Modules_history_Courses_Modules_idx` FOREIGN KEY (`id_courses_module`) REFERENCES `webapidatabase`.`Courses_Modules` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Modules_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Courses_module
  AFTER INSERT
  ON Courses_Modules FOR EACH ROW
  INSERT INTO Courses_Modules_History
  SELECT NULL, 'insert', Courses_Modules.* FROM Courses_Modules WHERE Courses_Modules.ID = NEW.ID;

CREATE
  TRIGGER update_Courses_module
  AFTER UPDATE
  ON Courses_Modules FOR EACH ROW
  INSERT INTO Courses_Modules_History
  SELECT NULL, 'update', Courses_Modules.* FROM Courses_Modules WHERE Courses_Modules.ID = NEW.ID;

CREATE
  TRIGGER delete_Courses_module
  AFTER DELETE
  ON Courses_Modules FOR EACH ROW
  INSERT INTO Courses_Modules_History
  SELECT NULL, 'delete', Courses_Modules.* FROM Courses_Modules WHERE Courses_Modules.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Materials` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `name` TEXT NOT NULL,
 `url` TEXT NOT NULL,
 `type` INT NOT NULL,
 `extension` INT NOT NULL,
 `size` DECIMAL(10,2) NOT NULL,
 `download` INT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_material_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_material_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- -----------------------------------------------------
-- Table `webapidatabase`.`Materials_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Materials_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_material` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `url` TEXT NOT NULL,
  `type` INT NOT NULL,
  `extension` INT NOT NULL,
  `size` DECIMAL(10,2) NOT NULL,
  `download` INT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),
  KEY `Materials_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_material_history_material_idx` (`id_material`),
  KEY `fk_material_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_material_history_material_idx` FOREIGN KEY (`id_material`) REFERENCES `webapidatabase`.`Materials` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_material_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_material
  AFTER INSERT
  ON Materials FOR EACH ROW
  INSERT INTO Materials_History
  SELECT NULL, 'insert', Materials.* FROM Materials WHERE Materials.ID = NEW.ID;

CREATE
  TRIGGER update_material
  AFTER UPDATE
  ON Materials FOR EACH ROW
  INSERT INTO Materials_History
  SELECT NULL, 'update', Materials.* FROM Materials WHERE Materials.ID = NEW.ID;

CREATE
  TRIGGER delete_material
  AFTER DELETE
  ON Materials FOR EACH ROW
  INSERT INTO Materials_History
  SELECT NULL, 'delete', Materials.* FROM Materials WHERE Materials.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Users` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `percent_done` DECIMAL NOT NULL,
 `modules` INT(10) UNSIGNED NOT NULL,
 `videos` INT(10) UNSIGNED NOT NULL,
 `start_date` DATE NOT NULL DEFAULT '0001-01-01',
 `finish_date` DATE NOT NULL DEFAULT '0001-01-01',
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Courses_Users_user_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Users_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Users_user` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Users_courses` FOREIGN KEY (`id_course`) REFERENCES `webapidatabase`.`Courses` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `user_Courses_Users_idx` ON `webapidatabase`.`Courses_Users` (`id_user` ASC);
CREATE INDEX `Courses_Courses_Users_idx` ON `webapidatabase`.`Courses_Users` (`id_course` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Users_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Users_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_course_user` INT(10) UNSIGNED NOT NULL,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `percent_done` DECIMAL NOT NULL,
 `modules` INT(10) UNSIGNED NOT NULL,
 `videos` INT(10) UNSIGNED NOT NULL,
 `start_date` DATE NOT NULL DEFAULT '0001-01-01',
 `finish_date` DATE NOT NULL DEFAULT '0001-01-01',
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Courses_Users_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Courses_Users_history_Courses_Users_idx` (`id_course_user`),
 KEY `fk_Courses_Users_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Users_history_Courses_Users_idx` FOREIGN KEY (`id_course_user`) REFERENCES `webapidatabase`.`Courses_Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Users_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Courses_Users
  AFTER INSERT
  ON Courses_Users FOR EACH ROW
  INSERT INTO Courses_Users_History
  SELECT NULL, 'insert', Courses_Users.* FROM Courses_Users WHERE Courses_Users.ID = NEW.ID;

CREATE
  TRIGGER update_Courses_Users
  AFTER UPDATE
  ON Courses_Users FOR EACH ROW
  INSERT INTO Courses_Users_History
  SELECT NULL, 'update', Courses_Users.* FROM Courses_Users WHERE Courses_Users.ID = NEW.ID;

CREATE
  TRIGGER delete_Courses_Users
  AFTER DELETE
  ON Courses_Users FOR EACH ROW
  INSERT INTO Courses_Users_History
  SELECT NULL, 'delete', Courses_Users.* FROM Courses_Users WHERE Courses_Users.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Subscriptions` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `total_users` INT NOT NULL,
  `type` INT NOT NULL,
  `price` DECIMAL NOT NULL,
  `description` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Sucriptions_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Sucriptions_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Subscriptions_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Subscriptions_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_suscription` INT(10) UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `total_users` INT NOT NULL,
  `type` INT NOT NULL,
  `price` DECIMAL NOT NULL,
  `description` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),
  KEY `Subscriptions_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Subscriptions_history_Subscriptions_idx` (`id_suscription`),
  KEY `fk_Subscriptions_history_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Subscriptions_history_Subscriptions_idx` FOREIGN KEY (`id_suscription`) REFERENCES `webapidatabase`.`Subscriptions` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscriptions_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_suscription
  AFTER INSERT
  ON Subscriptions FOR EACH ROW
  INSERT INTO Subscriptions_History
  SELECT NULL, 'insert', Subscriptions.* FROM Subscriptions WHERE Subscriptions.ID = NEW.ID;

CREATE
  TRIGGER update_suscription
  AFTER UPDATE
  ON Subscriptions FOR EACH ROW
  INSERT INTO Subscriptions_History
  SELECT NULL, 'update', Subscriptions.* FROM Subscriptions WHERE Subscriptions.ID = NEW.ID;

CREATE
  TRIGGER delete_suscription
  AFTER DELETE
  ON Subscriptions FOR EACH ROW
  INSERT INTO Subscriptions_History
  SELECT NULL, 'delete', suscription.* FROM Subscriptions WHERE suscription.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Subscriptions_Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Subscriptions_Users` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_suscription` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `master` INT NULL,
 `start_date` DATE NOT NULL,
 `finish_date` DATE NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Sucriptions_Users_user_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Sucriptions_Users_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Subscriptions_Users_user`  FOREIGN KEY (`id_user`)  REFERENCES `webapidatabase`.`Users` (`ID`)ON DELETE NO ACTION   ON UPDATE NO ACTION,
 CONSTRAINT `fk_Subscriptions_Users_suscription` FOREIGN KEY (`id_suscription`)  REFERENCES `webapidatabase`.`Subscriptions` (`ID`)ON DELETE NO ACTION   ON UPDATE NO ACTION
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `user_Subscriptions_Users_idx` ON `webapidatabase`.`Subscriptions_Users` (`id_user` ASC);
CREATE INDEX `Subscriptions_Subscriptions_Users_idx` ON `webapidatabase`.`Subscriptions_Users` (`id_suscription` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Subscriptions_Users_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Subscriptions_Users_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_suscription_user` INT(10) UNSIGNED NOT NULL,
 `id_suscription` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `master` INT NULL,
 `start_date` DATE NOT NULL,
 `finish_date` DATE NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Subscriptions_Users_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Subscriptions_Users_history_Subscriptions_Users_idx` (`id_suscription_user`),
 KEY `fk_Subscriptions_Users_history_Users_modified_by_idx` (`id_user_modified_by`), 
 CONSTRAINT `fk_Subscriptions_Users_history_Subscriptions_Users_idx` FOREIGN KEY (`id_suscription_user`) REFERENCES `webapidatabase`.`Subscriptions_Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Subscriptions_Users_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Subscriptions_Users
  AFTER INSERT
  ON Subscriptions_Users FOR EACH ROW
  INSERT INTO suscription_Users_History
  SELECT NULL, 'insert', Subscriptions_Users.* FROM Subscriptions_Users WHERE Subscriptions_Users.ID = NEW.ID;

CREATE
  TRIGGER update_Subscriptions_Users
  AFTER UPDATE
  ON Subscriptions_Users FOR EACH ROW
  INSERT INTO suscription_Users_History
  SELECT NULL, 'update', Subscriptions_Users.* FROM Subscriptions_Users WHERE Subscriptions_Users.ID = NEW.ID;

CREATE
  TRIGGER delete_Subscriptions_Users
  AFTER DELETE
  ON Subscriptions_Users FOR EACH ROW
  INSERT INTO suscription_Users_History
  SELECT NULL, 'delete', Subscriptions_Users.* FROM Subscriptions_Users WHERE Subscriptions_Users.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Organizations` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_course` INT(10) UNSIGNED NOT NULL,
  `id_organization` INT(10) UNSIGNED NOT NULL,
  `type_course` INT NOT NULL,
  `schedule_course` SMALLINT NOT NULL,
  `schedule_date` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Courses_Organizations_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Courses_Organizations_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Organizations_courses`
  FOREIGN KEY (`id_course`)
  REFERENCES `webapidatabase`.`Courses` (`ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Organizations_organization`
  FOREIGN KEY (`id_organization`)
  REFERENCES `webapidatabase`.`Organizations` (`ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `Courses_Organizations_Courses_idx` ON `webapidatabase`.`Courses_Organizations` (`id_course` ASC);
CREATE INDEX `Courses_Organizations_Organizations_idx` ON `webapidatabase`.`Courses_Organizations` (`id_organization` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Organizations_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Organizations_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_course_organization` INT(10) UNSIGNED NOT NULL,
  `id_course` INT(10) UNSIGNED NOT NULL,
  `id_organization` INT(10) UNSIGNED NOT NULL,
  `type_course` INT NOT NULL,
  `schedule_course` SMALLINT NOT NULL,
  `schedule_date` TEXT NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),
  KEY `Courses_Organizations_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Courses_Organizations_history_Courses_Organizations_idx` (`id_course_organization`),
  KEY `fk_Courses_Organizations_history_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Courses_Organizations_history_Courses_Organizations_idx` FOREIGN KEY (`id_course_organization`) REFERENCES `webapidatabase`.`Courses_Organizations` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Courses_Organizations_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Courses_Organizations
  AFTER INSERT
  ON Courses_Organizations FOR EACH ROW
  INSERT INTO Courses_Organizations_History
  SELECT NULL, 'insert', Courses_Organizations.* FROM Courses_Organizations WHERE Courses_Organizations.ID = NEW.ID;

CREATE
  TRIGGER update_Courses_Organizations
  AFTER UPDATE
  ON Courses_Organizations FOR EACH ROW
  INSERT INTO Courses_Organizations_History
  SELECT NULL, 'update', Courses_Organizations.* FROM Courses_Organizations WHERE Courses_Organizations.ID = NEW.ID;

CREATE
  TRIGGER delete_Courses_Organizations
  AFTER DELETE
  ON Courses_Organizations FOR EACH ROW
  INSERT INTO Courses_Organizations_History
  SELECT NULL, 'delete', Courses_Organizations.* FROM Courses_Organizations WHERE Courses_Organizations.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Modules_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Modules_Videos` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_module` INT(10) UNSIGNED NOT NULL,
 `id_video` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Modules_video_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Modules_video_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Modules_video_module`
 FOREIGN KEY (`id_module`)
 REFERENCES `webapidatabase`.`Modules` (`ID`)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION,
 CONSTRAINT `fk_Modules_video_video`
 FOREIGN KEY (`id_video`)
 REFERENCES `webapidatabase`.`Videos` (`ID`)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `Modules_Videos_Modules_idx` ON `webapidatabase`.`Modules_Videos` (`id_module` ASC);
CREATE INDEX `Modules_Videos_video_idx` ON `webapidatabase`.`Modules_Videos` (`id_video` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Modules_Videos_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Modules_Videos_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_module_video` INT(10) UNSIGNED NOT NULL,
  `id_module` INT(10) UNSIGNED NOT NULL,
  `id_video` INT(10) UNSIGNED NOT NULL,
  `status` TINYINT(2) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Modules_Videos_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Modules_video_history_Modules_video_idx` (`id_module_video`),
  KEY `fk_Modules_video_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_Modules_video_history_Modules_video_idx` FOREIGN KEY (`id_module_video`) REFERENCES `webapidatabase`.`Modules_Videos` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Modules_video_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Modules_video
  AFTER INSERT
  ON Modules_Videos FOR EACH ROW
  INSERT INTO Modules_Videos_History
  SELECT NULL, 'insert', Modules_Videos.* FROM Modules_Videos WHERE Modules_Videos.ID = NEW.ID;

CREATE
  TRIGGER update_Modules_video
  AFTER UPDATE
  ON Modules_Videos FOR EACH ROW
  INSERT INTO Modules_Videos_History
  SELECT NULL, 'update', Modules_Videos.* FROM Modules_Videos WHERE Modules_Videos.ID = NEW.ID;

CREATE
  TRIGGER delete_Modules_video
  AFTER DELETE
  ON Modules_Videos FOR EACH ROW
  INSERT INTO Modules_Videos_History
  SELECT NULL, 'delete', Modules_Videos.* FROM Modules_Videos WHERE Modules_Videos.ID = OLD.ID;

USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Modules_Progress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Modules_Progress` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_module` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `percent_done` DECIMAL NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '0',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Modules_Progress_user_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Modules_Progress_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Modules_Progress_user` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Modules_Progress_modules` FOREIGN KEY (`id_module`) REFERENCES `webapidatabase`.`Modules` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `user_Modules_Progress_idx` ON `webapidatabase`.`Modules_Progress` (`id_user` ASC);
CREATE INDEX `Modules_Modules_Progress_idx` ON `webapidatabase`.`Modules_Progress` (`id_module` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Modules_Progress_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Modules_Progress_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_module_user` INT(10) UNSIGNED NOT NULL,
 `id_module` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `percent_done` DECIMAL NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '0',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Modules_Progress_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Modules_Progress_history_Modules_Progress_idx` (`id_module_user`),
 KEY `fk_Modules_Progress_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Modules_Progress_history_Modules_Progress_idx` FOREIGN KEY (`id_module_user`) REFERENCES `webapidatabase`.`Modules_Progress` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Modules_Progress_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Modules_user
  AFTER INSERT
  ON Modules_Progress FOR EACH ROW
  INSERT INTO Modules_Progress_History
  SELECT NULL, 'insert', Modules_Progress.* FROM Modules_Progress WHERE Modules_Progress.ID = NEW.ID;

CREATE
  TRIGGER update_Modules_user
  AFTER UPDATE
  ON Modules_Progress FOR EACH ROW
  INSERT INTO Modules_Progress_History
  SELECT NULL, 'update', Modules_Progress.* FROM Modules_Progress WHERE Modules_Progress.ID = NEW.ID;

CREATE
  TRIGGER delete_Modules_user
  AFTER DELETE
  ON Modules_Progress FOR EACH ROW
  INSERT INTO Modules_Progress_History
  SELECT NULL, 'delete', Modules_Progress.* FROM Modules_Progress WHERE Modules_Progress.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Videos_Progress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Videos_Progress` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_video` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `minutes` INT NOT NULL,
 `seconds` INT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '0',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Videos_Progress_user_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Videos_Progress_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Videos_Progress_user` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Videos_Progress_videos` FOREIGN KEY (`id_video`) REFERENCES `webapidatabase`.`Videos` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `user_Videos_Progress_idx` ON `webapidatabase`.`Videos_Progress` (`id_user` ASC);
CREATE INDEX `Videos_Videos_Progress_idx` ON `webapidatabase`.`Videos_Progress` (`id_video` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Videos_Progress_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Videos_Progress_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_video_user` INT(10) UNSIGNED NOT NULL,
 `id_video` INT(10) UNSIGNED NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `minutes` INT NOT NULL,
 `seconds` INT NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '0',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Videos_Progress_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Videos_Progress_history_Videos_Progress_idx` (`id_video_user`),
 KEY `fk_Videos_Progress_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Videos_Progress_history_Videos_Progress_idx` FOREIGN KEY (`id_video_user`) REFERENCES `webapidatabase`.`Videos_Progress` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Videos_Progress_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Videos_user
  AFTER INSERT
  ON Videos_Progress FOR EACH ROW
  INSERT INTO Videos_Progress_History
  SELECT NULL, 'insert', Videos_Progress.* FROM Videos_Progress WHERE Videos_Progress.ID = NEW.ID;

CREATE
  TRIGGER update_Videos_user
  AFTER UPDATE
  ON Videos_Progress FOR EACH ROW
  INSERT INTO Videos_Progress_History
  SELECT NULL, 'update', Videos_Progress.* FROM Videos_Progress WHERE Videos_Progress.ID = NEW.ID;

CREATE
  TRIGGER delete_Videos_user
  AFTER DELETE
  ON Videos_Progress FOR EACH ROW
  INSERT INTO Videos_Progress_History
  SELECT NULL, 'delete', Videos_Progress.* FROM Videos_Progress WHERE Videos_Progress.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Entities_Materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Entities_Materials` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_organization` INT(10) UNSIGNED NULL DEFAULT '0',
 `id_material` INT(10) UNSIGNED NOT NULL,
 `id_entity` INT NOT NULL,
 `entity_type` INT(1) NOT NULL,
 `start_date` DATE NULL DEFAULT '0001-01-01',
 `finish_date` DATE NULL DEFAULT '0001-01-01',
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Entities_Materials_material_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Entities_Materials_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Entities_Materials_material` FOREIGN KEY (`id_material`) REFERENCES `webapidatabase`.`Materials` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE INDEX `material_Entities_Materials_idx` ON `webapidatabase`.`Entities_Materials` (`id_material` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Entities_Materials_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Entities_Materials_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_entity_material` INT(10) UNSIGNED NOT NULL,
 `id_organization` INT(10) UNSIGNED NULL DEFAULT '0',
 `id_material` INT(10) UNSIGNED NOT NULL,
 `id_entity` INT NOT NULL,
 `entity_type` INT(1) NOT NULL,
 `start_date` DATE NULL,
 `finish_date` DATE NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Entities_Materials_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Entities_Materials_history_Entities_Materials_idx` (`id_entity_material`),
 KEY `fk_Entities_Materials_history_Materials_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Entities_Materials_history_Entities_Materials_idx` FOREIGN KEY (`id_entity_material`) REFERENCES `webapidatabase`.`Entities_Materials` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Entities_Materials_history_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Entities_material
  AFTER INSERT
  ON Entities_Materials FOR EACH ROW
  INSERT INTO Entities_Materials_History
  SELECT NULL, 'insert', Entities_Materials.* FROM Entities_Materials WHERE Entities_Materials.ID = NEW.ID;

CREATE
  TRIGGER update_Entities_material
  AFTER UPDATE
  ON Entities_Materials FOR EACH ROW
  INSERT INTO Entities_Materials_History
  SELECT NULL, 'update', Entities_Materials.* FROM Entities_Materials WHERE Entities_Materials.ID = NEW.ID;

CREATE
  TRIGGER delete_Entities_material
  AFTER DELETE
  ON Entities_Materials FOR EACH ROW
  INSERT INTO Entities_Materials_History
  SELECT NULL, 'delete', Entities_Materials.* FROM Entities_Materials WHERE Entities_Materials.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Persons` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Persons_Users_modified_by_idx` (`id_user_modified_by`),
  CONSTRAINT `fk_Persons_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persons_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Persons_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Persons_History` (
  `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
  `id_person` INT(10) UNSIGNED NOT NULL,
  `id_user` INT(10) UNSIGNED NOT NULL,
  `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_history`),

  KEY `Persons_history_history_trigger_idx` (`history_trigger`),
  KEY `fk_Persons_history_Persons_idx` (`id_person`),
  KEY `fk_Persons_history_Users_modified_by_idx` (`id_user_modified_by`),

  CONSTRAINT `fk_Persons_history_Persons_idx` FOREIGN KEY (`id_person`) REFERENCES `webapidatabase`.`Persons` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persons_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_person
  AFTER INSERT
  ON Persons FOR EACH ROW
  INSERT INTO Persons_History
  SELECT NULL, 'insert', Persons.* FROM Persons WHERE Persons.ID = NEW.ID;

CREATE
  TRIGGER update_person
  AFTER UPDATE
  ON Persons FOR EACH ROW
  INSERT INTO Persons_History
  SELECT NULL, 'update', Persons.* FROM Persons WHERE Persons.ID = NEW.ID;

CREATE
  TRIGGER delete_person
  AFTER DELETE
  ON Persons FOR EACH ROW
  INSERT INTO Persons_History
  SELECT NULL, 'delete', Persons.* FROM Persons WHERE Persons.ID = OLD.ID;

  USE webapidatabase;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Prices` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `price` DECIMAL NOT NULL,
 `currency` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `discount_amount` DECIMAL NOT NULL,
 `discount_percentage` INT(10) UNSIGNED NOT NULL,
 `discount_start_date` DATE NULL DEFAULT '0001-01-01',
 `discount_end_date` DATE NULL DEFAULT '0001-01-01',
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Courses_Prices_user_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Prices_user_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Prices_courses` FOREIGN KEY (`id_course`) REFERENCES `webapidatabase`.`Courses` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- -----------------------------------------------------
-- Table `webapidatabase`.`Courses_Prices_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Courses_Prices_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_course_price` INT(10) UNSIGNED NOT NULL,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `price` DECIMAL NOT NULL,
 `currency` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `discount_amount` DECIMAL NOT NULL,
 `discount_percentage` INT(10) UNSIGNED NOT NULL,
 `discount_start_date` DATE NULL DEFAULT '0001-01-01',
 `discount_end_date` DATE NULL DEFAULT '0001-01-01',
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Courses_Prices_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Courses_Prices_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Courses_Prices_history_Courses_Prices_idx` FOREIGN KEY (`id_course_price`) REFERENCES `webapidatabase`.`Courses_Prices` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Courses_Prices_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_courses_prices
  AFTER INSERT
  ON Courses_Prices FOR EACH ROW
  INSERT INTO Courses_Prices_History
  SELECT NULL, 'insert', Courses_Prices.* FROM Courses_Prices WHERE Courses_Prices.ID = NEW.ID;

CREATE
  TRIGGER update_courses_prices
  AFTER UPDATE
  ON Courses_Prices FOR EACH ROW
  INSERT INTO Courses_Prices_History
  SELECT NULL, 'update', Courses_Prices.* FROM Courses_Prices WHERE Courses_Prices.ID = NEW.ID;

CREATE
  TRIGGER delete_courses_prices
  AFTER DELETE
  ON Courses_Prices FOR EACH ROW
  INSERT INTO Courses_Prices_History
  SELECT NULL, 'delete', Courses_Prices.* FROM Courses_Prices WHERE Courses_Prices.ID = OLD.ID;

  -- -----------------------------------------------------
-- Table `webapidatabase`.`Reviews_Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Reviews_Course` (
 `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `rate_course` decimal NOT NULL,
 `rate_author` decimal NOT NULL,
 `rate_material` decimal NOT NULL, 
 `comment` TEXT NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID`),
 KEY `fk_Reviews_Course_Users_modified_by_idx` (`id_user_modified_by`),
 KEY `fk_Reviews_Course_Users_id_user_idx` (`id_user`),
 KEY `fk_Reviews_Course_Users_id_course_idx` (`id_course`),
 CONSTRAINT `fk_Reviews_Course_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Reviews_Course_Users` FOREIGN KEY (`id_user`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Reviews_Course_Courses` FOREIGN KEY (`id_course`) REFERENCES `webapidatabase`.`Courses` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE INDEX `Reviews_Course_course_idx` ON `webapidatabase`.`Reviews_Course` (`id_course` ASC);
CREATE INDEX `Reviews_Course_user_idx` ON `webapidatabase`.`Reviews_Course` (`id_user` ASC);
-- -----------------------------------------------------
-- Table `webapidatabase`.`Reviews_Course_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webapidatabase`.`Reviews_Course_Course_History` (
 `ID_history` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `history_trigger` ENUM('insert', 'update', 'delete', 'n/a'),
 `id_review` INT(10) UNSIGNED NOT NULL,
 `id_course` INT(10) UNSIGNED NOT NULL,
 `rate_course` decimal NOT NULL,
 `rate_author` decimal NOT NULL,
 `rate_material` decimal NOT NULL, 
 `comment` TEXT NOT NULL,
 `id_user` INT(10) UNSIGNED NOT NULL,
 `status` INT(1) UNSIGNED NOT NULL DEFAULT '1',
 `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `modified_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `id_user_modified_by` INT(10) UNSIGNED NOT NULL,
 PRIMARY KEY (`ID_history`),
 KEY `Reviews_Course_history_history_trigger_idx` (`history_trigger`),
 KEY `fk_Reviews_Course_history_Reviews_Course_idx` (`id_course`),
 KEY `fk_Reviews_Course_history_Users_modified_by_idx` (`id_user_modified_by`),
 CONSTRAINT `fk_Reviews_Course_history_Reviews_Course_idx` FOREIGN KEY (`id_course`) REFERENCES `webapidatabase`.`Reviews_Course` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_Reviews_Course_history_Users_modified_by_idx` FOREIGN KEY (`id_user_modified_by`) REFERENCES `webapidatabase`.`Users` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE
  TRIGGER insert_Reviews_Course
  AFTER INSERT
  ON Reviews_Course FOR EACH ROW
  INSERT INTO Reviews_Course_Course_History
  SELECT NULL, 'insert', Reviews_Course.* FROM Reviews_Course WHERE Reviews_Course.ID = NEW.ID;

CREATE
  TRIGGER update_Reviews_Course
  AFTER UPDATE
  ON Reviews_Course FOR EACH ROW
  INSERT INTO Reviews_Course_Course_History
  SELECT NULL, 'update', Reviews_Course.* FROM Reviews_Course WHERE Reviews_Course.ID = NEW.ID;

CREATE
  TRIGGER delete_Reviews_Course
  AFTER DELETE
  ON Reviews_Course FOR EACH ROW
  INSERT INTO Reviews_Course_Course_History
  SELECT NULL, 'delete', Reviews_Course.* FROM Reviews_Course WHERE Reviews_Course.ID = OLD.ID;

