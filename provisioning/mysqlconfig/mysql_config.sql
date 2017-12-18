
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



CREATE TABLE web.TransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Tag VARCHAR(255),
  Description TEXT,
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.Transaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  TicketId INT,
  TypeId INT,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  PRIMARY KEY (TransactionId,TicketId,TypeId)


);



CREATE TABLE web.TransactionValueText (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value TEXT,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TransactionId) REFERENCES web.Transaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.TransactionValueVarChar (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value VARCHAR(255),
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TransactionId) REFERENCES web.Transaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);


CREATE TABLE web.TransactionValueInt (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value INT,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TransactionId) REFERENCES web.Transaction(TransactionId),
  PRIMARY KEY (TransactionValueId)

);

CREATE TABLE web.TransactionValueDateTime (

  TransactionValueId INT NOT NULL AUTO_INCREMENT,
  TransactionId INT,
  TypeId INT,
  Value DATETIME,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TransactionId) REFERENCES web.Transaction(TransactionId),
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

##### Defining Types #####

## TransactionType For Tickets
INSERT INTO web.TransactionType (Tag, Description) VALUES ('TicketOwnerId','Owner ID of ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('TicketTitle','Title of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('TicketDescription','Description of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('CreationDate','Creation date of ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('CreationUserId','Creation User Id of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('UpdateDate','Update Date of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('UpdateUserId','Update User Id of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('TargetDate','Target Date of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('DepartmentId','Department Id of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('StatusId','Status Id of the ticket');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('PriorityId','Priority Id of the ticket');


## TransactionType For Comment
INSERT INTO web.TransactionType (Tag, Description) VALUES ('CommentDescription','Comment Description of a comment');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('CreationDate','Creation Date of a comment');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('CreationUserId','Creation User Id of a comment');
INSERT INTO web.TransactionType (Tag, Description) VALUES ('UpdateUserId','Update User Id of a comment');





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







