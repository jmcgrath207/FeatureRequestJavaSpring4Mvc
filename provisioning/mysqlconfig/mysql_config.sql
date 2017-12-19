
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';
## GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON *.* TO 'root'@'%';
## Create Tables #####

CREATE DATABASE web;




CREATE TABLE web.Role
(

  RoleId  INT,
  RoleDescription TEXT,
  PRIMARY KEY (RoleId)


);


CREATE TABLE web.User
(
  UserId INT  NOT NULL AUTO_INCREMENT,
  UserName VARCHAR(255),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  EmailAddress VARCHAR(255),
  Password VARCHAR(255),
  RoleId  INT,
  PRIMARY KEY (UserId),
  FOREIGN KEY (RoleId) REFERENCES web.Role(RoleId)


);





CREATE TABLE web.ApprovedIPAddress
(
  ApprovedIPAddress INT  NOT NULL AUTO_INCREMENT,
  UserId INT  NOT NULL,
  IPAddress VARCHAR(255),
  Aproved CHAR,
  PRIMARY KEY (ApprovedIPAddress),
  FOREIGN KEY (UserId) REFERENCES web.User(UserId)


);



CREATE TABLE web.TicketStatus (

  StatusId  INT,
  StatusDescription TEXT,
  PRIMARY KEY (StatusId)
);

CREATE TABLE web.Department (

  DepartmentId  INT,
  DepartmentDescription TEXT,
  PRIMARY KEY (DepartmentId)
);

CREATE TABLE web.Priority (

  PriorityId  INT,
  PriorityDescription TEXT,
  PRIMARY KEY (PriorityId)
);



CREATE TABLE web.Ticket
(
  TicketId INT NOT NULL AUTO_INCREMENT,
  TicketOwnerId INT,
  TicketTitle VARCHAR(255),
  TicketDescription TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  TargetDate DATETIME,
  DepartmentId INT,
  StatusId  INT,
  PriorityId  INT,
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
  Tag VARCHAR(255),
  Description TEXT,
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.TicketTransaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  TicketId INT,
  TypeId INT,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.TicketTransactionType(TypeId),
  PRIMARY KEY (TransactionId)


);



CREATE TABLE web.TicketTransactionValueText (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value TEXT,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.TicketTransactionValueVarChar (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value VARCHAR(255),
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.TicketTransactionValueInt (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value INT,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.TicketTransactionValueDateTime (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value DATETIME,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.Comment (

  CommentId INT NOT NULL AUTO_INCREMENT,
  TicketId INT,
  CommentDescription TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  PRIMARY KEY (CommentId)


);





CREATE TABLE web.CommentTransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Tag VARCHAR(255),
  Description TEXT,
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.CommentTransaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  CommentId INT,
  TypeId INT,
  FOREIGN KEY (CommentId) REFERENCES web.Comment(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.CommentTransactionType(TypeId),
  PRIMARY KEY (TransactionId)


);



CREATE TABLE web.CommentTransactionValueText (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value TEXT,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.CommentTransactionValueVarChar (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value VARCHAR(255),
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.CommentTransactionValueInt (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value INT,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.CommentTransactionValueDateTime (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value DATETIME,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);




##### Defining Types #####

## TransactionType For Tickets
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('TicketOwnerId','Owner ID of ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('TicketTitle','Title of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('TicketDescription','Description of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('CreationDate','Creation date of ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('CreationUserId','Creation User Id of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('UpdateDate','Update Date of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('UpdateUserId','Update User Id of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('TargetDate','Target Date of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('DepartmentId','Department Id of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('StatusId','Status Id of the ticket');
INSERT INTO web.TicketTransactionType (Tag, Description) VALUES ('PriorityId','Priority Id of the ticket');


## TransactionType For Comment
INSERT INTO web.CommentTransactionType (Tag, Description) VALUES ('CommentDescription','Comment Description of a comment');
INSERT INTO web.CommentTransactionType (Tag, Description) VALUES ('CreationDate','Creation Date of a comment');
INSERT INTO web.CommentTransactionType (Tag, Description) VALUES ('CreationUserId','Creation User Id of a comment');
INSERT INTO web.CommentTransactionType (Tag, Description) VALUES ('UpdateUserId','Update User Id of a comment');





## Role ID Type

INSERT INTO web.Role (RoleId, RoleDescription) VALUES (
  1, 'User'
);



## Status Type

INSERT INTO web.TicketStatus (StatusId, StatusDescription) VALUES (
  1, 'In Progress'
);



## Department Type

INSERT INTO web.Department (DepartmentId, DepartmentDescription) VALUES (
  1, 'Development'
);


## Priority Type
INSERT INTO web.Priority (PriorityId, PriorityDescription) VALUES (
  1, 'Normal'
);


#### Create User Info ####


INSERT INTO web.User (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jmcgrath','john','mcgrath','john.mcgrath207@gmail.com','test', 1
);

INSERT INTO web.User (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jsmith','john','smith','john.smith@gmail.com','test', 1
);







