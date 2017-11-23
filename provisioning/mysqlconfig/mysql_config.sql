
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
  TicketOrignalId INT,
  TickerOwnerId INT,
  Title VARCHAR(255),
  Description TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  TargetDate DATETIME,
  DepartmentId INT,
  StatusId  INT,
  PriorityId  INT,
  FOREIGN KEY (TicketOrignalId) REFERENCES web.TicketTable(TicketId),
  FOREIGN KEY (TickerOwnerId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (CreationUserId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (UpdateUserId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (StatusId) REFERENCES web.TicketStatusTable(StatusId),
  FOREIGN KEY (DepartmentId) REFERENCES web.DepartmentTable(DepartmentId),
  FOREIGN KEY (PriorityId) REFERENCES web.PriorityTable(PriorityId),
  PRIMARY KEY (TicketId)
);


### Create Index On Ticket Orignal ID
CREATE INDEX Index_TicketOrignalId
  ON web.TicketTable (TicketOrignalId);


CREATE TABLE web.CommentTable (

  CommentId INT NOT NULL AUTO_INCREMENT,
  TicketOrignalId INT,
  Description TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  FOREIGN KEY (TicketOrignalId) REFERENCES web.TicketTable(TicketOrignalId),
  PRIMARY KEY (CommentId)


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

### First Ticket ### Note: Orignal Value Will be Null
INSERT INTO web.TicketTable ( TickerOwnerId,
                              Title, Description,
                              CreationDate, CreationUserId,
                              UpdateDate, UpdateUserId,
                              TargetDate, DepartmentId,
                              StatusId, PriorityId)
VALUES (1,
  'Fix Function Foo','Fix Function Foo issue',
  '2017-11-07 12:00:12',1,
  '2017-11-07 12:00:12',1,
  '2017-11-07 12:00:12',1,
  1,1);





### Updated Ticket 1 ###

INSERT INTO web.TicketTable (TicketOrignalId, TickerOwnerId,
                             Title, Description,
                             CreationDate, CreationUserId,
                             UpdateDate, UpdateUserId,
                             TargetDate, DepartmentId,
                             StatusId, PriorityId)
VALUES (1,1,
          'Fix Function Foo','Fix Function Foo issue',
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',1,
          1,1);


### Updated Ticket 2 ###

INSERT INTO web.TicketTable (TicketOrignalId, TickerOwnerId,
                             Title, Description,
                             CreationDate, CreationUserId,
                             UpdateDate, UpdateUserId,
                             TargetDate, DepartmentId,
                             StatusId, PriorityId)
VALUES (1,1,
          'Fix Function Foo','Fix Function Foo issue',
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',1,
          1,1);




### Pull Last Ticket Info
SELECT * FROM web.TicketTable
WHERE TicketOrignalId = 1 ORDER BY TicketId DESC
LIMIT 1;




INSERT INTO web.CommentTable (TicketOrignalId, Description, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,'Something Happened','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1)




