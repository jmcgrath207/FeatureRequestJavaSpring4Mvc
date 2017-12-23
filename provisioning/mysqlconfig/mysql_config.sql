
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';
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
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialTicketOwnerId','Initial Owner ID of ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialTicketTitle','Initial Title of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialTicketDescription','Initial Description of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialCreationDate','Initial Creation date of ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialCreationUserId','Initial Creation User Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialUpdateDate','Initial Update Date of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialUpdateUserId','Initial Update User Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialTargetDate','Initial Target Date of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialDepartmentId','Initial Department Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialStatusId','Initial Status Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('InitialPriorityId','Initial Priority Id of the ticket');

INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredTicketOwnerId','Altered Owner ID of ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredTicketTitle','Altered Title of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredTicketDescription','Altered Description of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredCreationDate','Altered Creation date of ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredCreationUserId','Altered Creation User Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredUpdateDate','Altered Update Date of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredUpdateUserId','Altered Update User Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredTargetDate','Altered Target Date of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredDepartmentId','Altered Department Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredStatusId','Altered Status Id of the ticket');
INSERT INTO web.TicketTransactionType (Transaction, Description) VALUES ('AlteredPriorityId','Altered Priority Id of the ticket');


## TransactionType For Comment
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('InitialCommentDescription','Initial Comment Description of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('InitialCreationDate','Initial Creation Date of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('InitialCreationUserId','Initial Creation User Id of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('InitialUpdateUserId','Initial Update User Id of a comment');

INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('AlteredCommentDescription','Altered Comment Description of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('AlteredCreationDate','Altered Creation Date of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('AlteredCreationUserId','Altered Creation User Id of a comment');
INSERT INTO web.CommentTransactionType (Transaction, Description) VALUES ('AlteredUpdateUserId','Altered Update User Id of a comment');





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


DROP PROCEDURE IF EXISTS web.create_new_Ticket;

CREATE PROCEDURE web.create_new_Ticket (TOS VARCHAR(255),      # TicketOwnerString
                                        TT VARCHAR(255),       # TicketTitle
                                        TDesc TEXT,            # TicketDescription
                                        CD DATETIME,           # CreationDate
                                        CUS VARCHAR(255),      # CreationUserString
                                        UD DATETIME,           # UpdateDate
                                        UUS VARCHAR(255),      # UpdateUserString
                                        TDate DATETIME,        # TargetDate
                                        DS VARCHAR(255),       # DepartmentString
                                        SS VARCHAR(255),       # StatusString
                                        PS VARCHAR(255))       # PriorityString
  BEGIN

    DECLARE TOI INT;        # TicketOwnerId
    DECLARE CUI INT;        # CreationUserId
    DECLARE UUI INT;        # UpdateUserId
    DECLARE DI INT;         # DepartmentId
    DECLARE SI INT;         # StatusId
    DECLARE PI INT;         # PriorityId

    SET TOI = (SELECT UserId FROM web.User WHERE UserName = TOS);
    SET CUI = (SELECT UserId FROM web.User WHERE UserName = CUS);
    SET UUI = (SELECT UserId FROM web.User WHERE UserName = UUS);
    SET DI = (SELECT DepartmentId FROM web.Department WHERE Department = DS);
    SET SI = (SELECT StatusId FROM web.TicketStatus WHERE Status = SS);
    SET PI = (SELECT PriorityId FROM web.Priority WHERE Priority = PS);

    SET autocommit=0;

    START TRANSACTION;


    INSERT INTO web.Ticket (TicketOwnerId,
                            TicketTitle, TicketDescription,
                            CreationDate, CreationUserId,
                            UpdateDate, UpdateUserId,
                            TargetDate, DepartmentId,
                            StatusId, PriorityId)

    VALUES (TOI,
      TT,TDesc,
      CD,CUI,
      UD,UUI,
      TDate,DI,
      SI,PI);

    ## Add TicketOwnerId to Ticket Transaction Table
    INSERT INTO web.TicketTransaction (TicketId, TypeId)

    VALUES(   ## Select Ticket ID just created
              (SELECT TicketId FROM web.Ticket
              WHERE TicketOwnerId = TOI
                    AND TicketTitle = TT AND TicketDescription = TDesc
                    AND CreationDate = CD AND CreationUserId = CUI
                    AND UpdateDate = UD AND UpdateUserId = UUI
                    AND TargetDate = TDate AND DepartmentId = DI
                    AND StatusId = SI AND PriorityId = PI),

              ## Select Transction Type
              (SELECT * FROM web.TicketTransactionType WHERE Transaction = 'InitialTicketOwnerId')
    );


    COMMIT;
  END;

call web.create_new_Ticket('jmcgrath',
                           'Fix Function Foo','Fix Function Foo issue',
                           '2017-11-07 12:00:12','jmcgrath',
                           '2017-11-08 13:00:12','jmcgrath',
                           '2017-11-09 14:00:12','Development',
                           'In Progress','Normal');


