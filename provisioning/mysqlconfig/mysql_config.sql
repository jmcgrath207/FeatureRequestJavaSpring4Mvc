
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
  Description TEXT,
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.Transaction (

  TranId INT NOT NULL AUTO_INCREMENT,
  TicketId INT,
  TypeId INT,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  PRIMARY KEY (TranId,TicketId,TypeId)


);



CREATE TABLE web.TransactionValueText (

  TranValueId INT NOT NULL AUTO_INCREMENT,
  TranId INT,
  TypeId INT,
  Value TEXT,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TranId) REFERENCES web.Transaction(TranId),
  PRIMARY KEY (TranValueId)

);

CREATE TABLE web.TransactionValueVarChar (

  TranValueId INT NOT NULL AUTO_INCREMENT,
  TranId INT,
  TypeId INT,
  Value VARCHAR(255),
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TranId) REFERENCES web.Transaction(TranId),
  PRIMARY KEY (TranValueId)

);


CREATE TABLE web.TransactionValueInt (

  TranValueId INT NOT NULL AUTO_INCREMENT,
  TranId INT,
  TypeId INT,
  Value INT,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TranId) REFERENCES web.Transaction(TranId),
  PRIMARY KEY (TranValueId)

);

CREATE TABLE web.TransactionValueDateTime (

  TranValueId INT NOT NULL AUTO_INCREMENT,
  TranId INT,
  TypeId INT,
  Value DATETIME,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TranId) REFERENCES web.Transaction(TranId),
  PRIMARY KEY (TranValueId)

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
