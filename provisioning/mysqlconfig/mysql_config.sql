
### Edit Root account for access from any IP address ###
#USER 'root'@'localhost' TO 'root'@'%';
## GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON *.* TO 'root'@'%';
## Create Tables #####

CREATE DATABASE web;




CREATE TABLE web.Role
(

  RoleId  INT NOT NULL,
  Role VARCHAR(255) NOT NULL,
  RoleDescription TEXT NOT NULL,
  PRIMARY KEY (RoleId)


);


CREATE TABLE web.User
(
  UserId INT  NOT NULL AUTO_INCREMENT,
  UserName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  EmailAddress VARCHAR(255) NOT NULL,
  Password VARCHAR(255) NOT NULL,
  RoleId  INT NOT NULL,
  PRIMARY KEY (UserId),
  FOREIGN KEY (RoleId) REFERENCES web.Role(RoleId)


);





CREATE TABLE web.ApprovedIPAddress
(
  ApprovedIPAddress INT  NOT NULL AUTO_INCREMENT,
  UserId INT  NOT NULL NOT NULL,
  IPAddress VARCHAR(255) NOT NULL,
  Aproved CHAR NOT NULL,
  PRIMARY KEY (ApprovedIPAddress),
  FOREIGN KEY (UserId) REFERENCES web.User(UserId)


);



CREATE TABLE web.TicketStatus (

  StatusId  INT NOT NULL,
  Status VARCHAR(255) NOT NULL,
  StatusDescription TEXT NOT NULL,
  PRIMARY KEY (StatusId)
);

CREATE TABLE web.Department (

  DepartmentId  INT NOT NULL,
  Department VARCHAR(255) NOT NULL,
  DepartmentDescription TEXT NOT NULL,
  PRIMARY KEY (DepartmentId)
);

CREATE TABLE web.Priority (

  PriorityId  INT NOT NULL,
  Priority VARCHAR(255) NOT NULL,
  PriorityDescription TEXT NOT NULL,
  PRIMARY KEY (PriorityId)
);



CREATE TABLE web.Ticket
(
  TicketId INT NOT NULL AUTO_INCREMENT,
  TicketOwnerId INT NOT NULL,
  TicketTitle VARCHAR(255) NOT NULL,
  TicketDescription TEXT NOT NULL,
  CreationDate DATETIME NOT NULL,
  CreationUserId INT NOT NULL,
  UpdateDate DATETIME NOT NULL,
  UpdateUserId INT NOT NULL,
  TargetDate DATETIME NOT NULL,
  DepartmentId INT NOT NULL,
  StatusId  INT NOT NULL,
  PriorityId  INT NOT NULL,
  FOREIGN KEY (TicketOwnerId) REFERENCES web.User(UserId),
  FOREIGN KEY (CreationUserId) REFERENCES web.User(UserId),
  FOREIGN KEY (UpdateUserId) REFERENCES web.User(UserId),
  FOREIGN KEY (StatusId) REFERENCES web.TicketStatus(StatusId),
  FOREIGN KEY (DepartmentId) REFERENCES web.Department(DepartmentId),
  FOREIGN KEY (PriorityId) REFERENCES web.Priority(PriorityId),
  PRIMARY KEY (TicketId)
);



CREATE TABLE web.TicketTransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Transaction VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.TicketTransaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  TicketId INT NOT NULL,
  TypeId INT NOT NULL,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.TicketTransactionType(TypeId),
  PRIMARY KEY (TransactionId)


);



CREATE TABLE web.TicketTransactionValueText (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.TicketTransactionValueVarChar (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value VARCHAR(255) NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.TicketTransactionValueInt (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value INT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.TicketTransactionValueDateTime (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value DATETIME NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.Comment (

  CommentId INT NOT NULL AUTO_INCREMENT,
  TicketId INT NOT NULL,
  CommentDescription TEXT NOT NULL,
  CreationDate DATETIME NOT NULL,
  CreationUserId INT NOT NULL,
  UpdateDate DATETIME NOT NULL,
  UpdateUserId INT NOT NULL,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  PRIMARY KEY (CommentId)


);





CREATE TABLE web.CommentTransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Transaction VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.CommentTransaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  CommentId INT NOT NULL,
  TypeId INT NOT NULL,
  FOREIGN KEY (CommentId) REFERENCES web.Comment(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.CommentTransactionType(TypeId),
  PRIMARY KEY (TransactionId)


);



CREATE TABLE web.CommentTransactionValueText (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.CommentTransactionValueVarChar (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value VARCHAR(255) NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.CommentTransactionValueInt (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value INT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.CommentTransactionValueDateTime (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  Value DATETIME NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);




##### Defining Types #####

## TransactionType For Tickets
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('TicketOwnerId','Owner ID of ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('TicketTitle','Title of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('TicketDescription','Description of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('CreationDate','Creation date of ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('CreationUserId','Creation User Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('UpdateDate','Update Date of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('UpdateUserId','Update User Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('TargetDate','Target Date of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('DepartmentId','Department Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('StatusId','Status Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('PriorityId','Priority Id of the ticket');


## TransactionType For Comment
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('CommentDescription','Comment Description of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('CreationDate','Creation Date of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('CreationUserId','Creation User Id of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('UpdateUserId','Update User Id of a comment');





## Role ID Type

INSERT INTO web.Role (RoleId, Role,RoleDescription) VALUES (
  1, 'User', 'Standard User Role'
);



## Status Type

INSERT INTO web.TicketStatus (StatusId, Status,StatusDescription) VALUES (
  1, 'In Progress', 'Ticket is currently being worked'
);



## Department Type

INSERT INTO web.Department (DepartmentId, Department,DepartmentDescription) VALUES (
  1, 'Development', 'For the Development Department'
);


## Priority Type
INSERT INTO web.Priority (PriorityId, Priority,PriorityDescription) VALUES (
  1, 'Normal', 'Non Urgent Task'
);


#### Create User Info ####


INSERT INTO web.User (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jmcgrath','john','mcgrath','john.mcgrath207@gmail.com','test', 1
);

INSERT INTO web.User (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jsmith','john','smith','john.smith@gmail.com','test', 1
);



## New Ticket ###



CREATE TABLE web.Ticket
(
  TicketId          INT NOT NULL AUTO_INCREMENT,
  TicketOwnerId     INT,
  TicketTitle       VARCHAR(255),
  TicketDescription TEXT,
  CreationDate      DATETIME,
  CreationUserId    INT,
  UpdateDate        DATETIME,
  UpdateUserId      INT,
  TargetDate        DATETIME,
  DepartmentId      INT,
  StatusId          INT,
  PriorityId        INT
);

DROP PROCEDURE IF EXISTS web.create_new_Ticket;

CREATE PROCEDURE web.create_new_Ticket (TicketOwnerId VARCHAR(255),
                                        TicketTitle VARCHAR(255),
                                        TicketDescription TEXT,
                                        CreationDate DATETIME,
                                        CreationUserId VARCHAR(255),
                                        UpdateDate DATETIME,
                                        UpdateUserId VARCHAR(255),
                                        TargetDate DATETIME,
                                        DepartmentId VARCHAR(255),
                                        StatusId VARCHAR(255),
                                        PriorityId VARCHAR(255))
  BEGIN

    SET TicketOwnerId = (SELECT UserId FROM web.User WHERE UserName = TicketOwnerId);
    SET CreationUserId = (SELECT UserId FROM web.User WHERE UserName = CreationUserId);
    SET UpdateUserId = (SELECT UserId FROM web.User WHERE UserName = UpdateUserId);

    START TRANSACTION;


    INSERT INTO web.Ticket (TicketOwnerId,
                            TicketTitle, TicketDescription,
                            CreationDate, CreationUserId,
                            UpdateDate, UpdateUserId,
                            TargetDate, DepartmentId,
                            StatusId, PriorityId)
    VALUES (1,
      'Fix Function Foo','Fix Function Foo issue',
      '2017-11-07 12:00:12',1,
      '2017-11-08 13:00:12',1,
      '2017-11-09 14:00:12',1,
      1,1);


    COMMIT;
  END;

call web.create_new_Ticket('jmcgrath',
                           'Fix Function Foo','Fix Function Foo issue',
                           '2017-11-07 12:00:12',1,
                           '2017-11-08 13:00:12',1,
                           '2017-11-09 14:00:12',1,
                           1,1);


