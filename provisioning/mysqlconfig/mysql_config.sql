
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';
## GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON *.* TO 'root'@'%';
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
  TicketOriginalId INT,
  TicketOwnerId INT,
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
  FOREIGN KEY (TicketOriginalId) REFERENCES web.TicketTable(TicketId),
  FOREIGN KEY (TicketOwnerId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (CreationUserId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (UpdateUserId) REFERENCES web.UserTable(UserId),
  FOREIGN KEY (StatusId) REFERENCES web.TicketStatusTable(StatusId),
  FOREIGN KEY (DepartmentId) REFERENCES web.DepartmentTable(DepartmentId),
  FOREIGN KEY (PriorityId) REFERENCES web.PriorityTable(PriorityId),
  PRIMARY KEY (TicketId)
);


### Create Index On Ticket Orignal ID
CREATE INDEX Index_TicketOriginalId
  ON web.TicketTable (TicketOriginalId);


CREATE TABLE web.CommentTable (

  CommentId INT NOT NULL AUTO_INCREMENT,
  TicketOriginalId INT,
  Description TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  FOREIGN KEY (TicketOriginalId) REFERENCES web.TicketTable(TicketOriginalId),
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



### New Ticket 1 ###

SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'TicketTable';

INSERT INTO web.TicketTable (TicketOriginalId, TicketOwnerId,
                             Title, Description,
                             CreationDate, CreationUserId,
                             UpdateDate, UpdateUserId,
                             TargetDate, DepartmentId,
                             StatusId, PriorityId)
VALUES (@ai,1,
            'Fix Function Foo','Fix Function Foo issue',
            '2017-11-07 12:00:12',1,
            '2017-11-07 12:00:12',1,
            '2017-11-07 12:00:12',1,
            1,1);


### Updated Ticket 1 ###

INSERT INTO web.TicketTable (TicketOriginalId, TicketOwnerId,
                             Title, Description,
                             CreationDate, CreationUserId,
                             UpdateDate, UpdateUserId,
                             TargetDate, DepartmentId,
                             StatusId, PriorityId)
VALUES (1,1,
          'Fix Function Foo aaa','Fix Function Foo issue aaa',
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',1,
          1,1);




### New Ticket 2 ###

SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'TicketTable';

INSERT INTO web.TicketTable (TicketOriginalId, TicketOwnerId,
                             Title, Description,
                             CreationDate, CreationUserId,
                             UpdateDate, UpdateUserId,
                             TargetDate, DepartmentId,
                             StatusId, PriorityId)
VALUES (@ai,1,
            'Fix Function Foo','Fix Function Foo issue',
            '2017-11-07 12:00:12',1,
            '2017-11-07 12:00:12',1,
            '2017-11-07 12:00:12',1,
            1,1);




### Working Stored PROCEDURE For returning Latest Tickets

DROP PROCEDURE IF EXISTS return_latest_tickets;

CREATE PROCEDURE return_latest_tickets ()
  BEGIN
    DECLARE toi INT;
    DECLARE end_interate INT;
    DECLARE start_interate INT;

    DECLARE cur1 CURSOR FOR SELECT DISTINCT TicketOriginalId FROM  web.TicketTable;

    SET start_interate = 0;
    SET end_interate = (SELECT Count(DISTINCT TicketOriginalId) FROM  web.TicketTable);

    DROP TABLE IF EXISTS temp_ticket_table;
    CREATE TEMPORARY TABLE temp_ticket_table LIKE web.TicketTable;
    OPEN cur1;

    WHILE start_interate < end_interate DO
      FETCH cur1 INTO toi;
      INSERT INTO temp_ticket_table
        SELECT *  FROM web.TicketTable WHERE  TicketId = (SELECT MAX(TicketId) FROM web.TicketTable WHERE TicketOriginalID = toi);
      SET start_interate = start_interate + 1;
    END WHILE;

    select * from temp_ticket_table;
    CLOSE cur1;
  END;


Call return_latest_tickets();





SELECT * FROM web.TicketTable

### Add Comment Table


INSERT INTO web.CommentTable (TicketOriginalId, Description, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,'Something Happened','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1)




