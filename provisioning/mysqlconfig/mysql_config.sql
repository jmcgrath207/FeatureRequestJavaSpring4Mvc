
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';

## Create Tables #####

CREATE DATABASE web;




CREATE TABLE web.RoleTable
(

  RoleId  INT,
  Description TEXT,
  PRIMARY KEY (RoleId)


);


CREATE TABLE web.UserTable
(
  UserId INT  NOT NULL AUTO_INCREMENT,
  UserName VARCHAR(255),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  EmailAddress VARCHAR(255),
  Password VARCHAR(255),
  RoleId  INT,
  PRIMARY KEY (UserId),
  FOREIGN KEY (RoleId) REFERENCES web.RoleTable(RoleId)


);





CREATE TABLE web.ApprovedIPAddress
(
  ApprovedIPAddress INT  NOT NULL AUTO_INCREMENT,
  UserId INT  NOT NULL,
  IPAddress VARCHAR(255),
  Aproved CHAR,
  PRIMARY KEY (ApprovedIPAddress),
  FOREIGN KEY (UserId) REFERENCES web.UserTable(UserId)


);



CREATE TABLE web.TicketStatusTable (

  StatusId  INT,
  Description TEXT,
  PRIMARY KEY (StatusId)
);

CREATE TABLE web.DepartmentTable (

  DepartmentId  INT,
  Description TEXT,
  PRIMARY KEY (DepartmentId)
);

CREATE TABLE web.PriorityTable (

  PriorityId  INT,
  Description TEXT,
  PRIMARY KEY (PriorityId)
);



CREATE TABLE web.TicketTable
(
  TicketId INT NOT NULL AUTO_INCREMENT,
  Title VARCHAR(255),
  UserId INT,
  Description TEXT,
  CreationDate DATETIME,
  UpdateDate DATETIME,
  TargetDate DATETIME,
  DepartmentId Int,
  StatusId  INT,
  PriorityId  INT,
  FOREIGN KEY (UserId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (StatusId) REFERENCES web.TicketStatusTable(StatusId),
  FOREIGN KEY (DepartmentId) REFERENCES web.DepartmentTable(DepartmentId),
  FOREIGN KEY (PriorityId) REFERENCES web.PriorityTable(PriorityId),
  PRIMARY KEY (TicketId)

);


#### Create Info ####

INSERT INTO web.RoleTable (RoleId, Description) VALUES (
  1, 'User'
);

INSERT INTO web.UserTable (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jmcgrath','john','mcgrath','john.mcgrath207@gmail.com','test', 1
);



INSERT INTO web.TicketStatusTable (StatusId, Description) VALUES (
  1, 'In Progress'
);

INSERT INTO web.DepartmentTable (DepartmentId, Description) VALUES (
  1, 'Development'
);


INSERT INTO web.PriorityTable (PriorityId, Description) VALUES (
  1, 'Normal'
);


INSERT INTO web.TicketTable ( Title, UserId, Description, CreationDate, UpdateDate, TargetDate, DepartmentId,  StatusId, PriorityId) VALUES
  ('Fixed Print Statement',1,'Fix Print Statement on Function FOO','2017-11-07 12:00:12','2017-11-07 12:00:12', '2017-11-30 12:00:12',1,1,1)