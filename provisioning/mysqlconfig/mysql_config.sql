
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';
## GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON *.* TO 'root'@'%';
## Create Tables #####

CREATE DATABASE web;




CREATE TABLE web.RoleTable
(

  RoleId  INT,
  RoleDescription TEXT,
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
  StatusDescription TEXT,
  PRIMARY KEY (StatusId)
);

CREATE TABLE web.DepartmentTable (

  DepartmentId  INT,
  DepartmentDescription TEXT,
  PRIMARY KEY (DepartmentId)
);

CREATE TABLE web.PriorityTable (

  PriorityId  INT,
  PriorityDescription TEXT,
  PRIMARY KEY (PriorityId)
);



CREATE TABLE web.TicketTable
(
  TicketId INT NOT NULL AUTO_INCREMENT,
  TicketOriginalId INT,
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
  CommentDescription TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  FOREIGN KEY (TicketOriginalId) REFERENCES web.TicketTable(TicketOriginalId),
  PRIMARY KEY (CommentId)


);

#### Create Info ####

INSERT INTO web.RoleTable (RoleId, RoleDescription) VALUES (
  1, 'User'
);

INSERT INTO web.UserTable (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jmcgrath','john','mcgrath','john.mcgrath207@gmail.com','test', 1
);

INSERT INTO web.UserTable (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jsmith','john','smith','john.smith@gmail.com','test', 1
);


INSERT INTO web.TicketStatusTable (StatusId, StatusDescription) VALUES (
  1, 'In Progress'
);

INSERT INTO web.DepartmentTable (DepartmentId, DepartmentDescription) VALUES (
  1, 'Development'
);


INSERT INTO web.PriorityTable (PriorityId, PriorityDescription) VALUES (
  1, 'Normal'
);



### New Ticket 1 ###

SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'TicketTable';

INSERT INTO web.TicketTable (TicketOriginalId, TicketOwnerId,
                             TicketTitle, TicketDescription,
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
                             TicketTitle, TicketDescription,
                             CreationDate, CreationUserId,
                             UpdateDate, UpdateUserId,
                             TargetDate, DepartmentId,
                             StatusId, PriorityId)
VALUES (1,1,
          'Fix Function Foo aaa','Fix Function Foo issue aaa',
          '2017-11-07 12:00:12',1,
          '2017-11-07 12:00:12',2,
          '2017-11-07 12:00:12',1,
          1,1);




### New Ticket 2 ###

SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'TicketTable';

INSERT INTO web.TicketTable (TicketOriginalId, TicketOwnerId,
                             TicketTitle, TicketDescription,
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





### Insert into Comment Table

# Ticket One
INSERT INTO web.CommentTable (TicketOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,'Something Happened','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,'Something Happened 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,'Something Happened 3','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',2);


# Ticket Three
INSERT INTO web.CommentTable (TicketOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3,'Something Happened','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3,'Something Happened 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3,'Something Happened 3','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',2);



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
    CREATE TEMPORARY TABLE temp_ticket_table (
      TicketId INT,
      TicketOriginalId INT,
      TicketTitle VARCHAR(255),
      TicketDescription TEXT,
      StatusDescription TEXT,
      DepartmentDescription TEXT,
      PriorityDescription TEXT,
      CreationDate DATETIME,
      UpdateDate DATETIME,
      TargetDate DATETIME,
      TicketOwner VARCHAR(255),
      CreationUser VARCHAR(255),
      UpdateUser VARCHAR(255)
    );

    OPEN cur1;

    WHILE start_interate < end_interate DO
      FETCH cur1 INTO toi;
      INSERT INTO temp_ticket_table (TicketId, TicketOriginalId, TicketTitle, TicketDescription, StatusDescription,
                                     DepartmentDescription, PriorityDescription, CreationDate,
                                     UpdateDate, TargetDate, TicketOwner, CreationUser, UpdateUser)

        SELECT TT.TicketId,TT.TicketOriginalId, TT.TicketTitle, TT.TicketDescription, ST.StatusDescription,
          DT.DepartmentDescription, PT.PriorityDescription, TT.CreationDate, TT.UpdateDate, TT.TargetDate,

          ## SELECT USER FOR TicketOwnerId
          (SELECT UserName FROM web.UserTable AS UT JOIN web.TicketTable AS TT2 ON TT2.TicketOwnerId = UT.UserId
          WHERE  TicketId = (SELECT MAX(TicketId) FROM web.TicketTable WHERE TicketOriginalID = toi)),

          ## SELECT USER FOR CreationUserId
          (SELECT UserName FROM web.UserTable AS UT JOIN web.TicketTable AS TT2 ON TT2.CreationUserId = UT.UserId
          WHERE  TicketId = (SELECT MAX(TicketId) FROM web.TicketTable WHERE TicketOriginalID = toi)),

          ## SELECT USER FOR UpdateUserId
          (SELECT UserName FROM web.UserTable AS UT JOIN web.TicketTable AS TT2 ON TT2.UpdateUserId = UT.UserId
          WHERE  TicketId = (SELECT MAX(TicketId) FROM web.TicketTable WHERE TicketOriginalID = toi))

        FROM web.TicketTable AS TT
          JOIN web.DepartmentTable AS DT USING (DepartmentId)
          JOIN web.PriorityTable AS PT USING (PriorityId)
          JOIN web.TicketStatusTable AS ST USING (StatusId)
        WHERE  TicketId = (SELECT MAX(TicketId) FROM web.TicketTable WHERE TicketOriginalID = toi);
      SET start_interate = start_interate + 1;
    END WHILE;

    select * from temp_ticket_table;
    CLOSE cur1;
  END;


Call return_latest_tickets();




## Working Return Commments based on ticketoriginalid

DROP PROCEDURE IF EXISTS return_comments_by_ticketoriginalid;

CREATE PROCEDURE return_comments_by_ticketoriginalid (IN TOIVAR INT)
  BEGIN

    DECLARE end_interate INT;
    DECLARE start_interate INT;

    # CURSOR 1
    DECLARE TOI INT; ## TicketOriginalId
    DECLARE COMDESC TEXT; ## CommentDescription
    DECLARE CREDATE DATETIME; ## CreationDate
    DECLARE UD DATETIME; ## UpdateDate

    # CURSOR 2
    DECLARE CU VARCHAR(255); ## CreationUserId

    # CURSOR 3
    DECLARE UU VARCHAR(255); ## UpdateUserId


    DECLARE cur1 CURSOR FOR
      SELECT TicketOriginalId, CommentDescription, CreationDate, UpdateDate FROM web.CommentTable WHERE TicketOriginalId = TOIVAR;

    DECLARE cur2 CURSOR FOR
      # Creation User Name
      SELECT UT.UserName FROM web.CommentTable AS CT
        JOIN web.UserTable AS UT ON CT.CreationUserId = UT.UserId
      WHERE TicketOriginalId = TOIVAR;
    DECLARE cur3 CURSOR FOR
      # Update User Name
      SELECT UT.UserName FROM web.CommentTable AS CT
        JOIN web.UserTable AS UT ON CT.UpdateUserId = UT.UserId
      WHERE TicketOriginalId = TOIVAR;

    SET start_interate = 0;
    SET end_interate = (SELECT Count(TicketOriginalId) FROM  web.CommentTable WHERE TicketOriginalId = TOIVAR);


    DROP TABLE IF EXISTS temp_comment_table;
    CREATE TEMPORARY TABLE temp_comment_table (
      TicketOriginalId INT,
      CommentDescription TEXT,
      CreationDate DATETIME,
      UpdateDate DATETIME,
      CreationUser VARCHAR(255),
      UpdateUser VARCHAR(255)
    );

    OPEN cur1;
    OPEN cur2;
    OPEN cur3;

    WHILE start_interate < end_interate DO
      FETCH cur1 INTO TOI,COMDESC,CREDATE,UD;
      FETCH cur2 INTO CU;
      FETCH cur3 INTO UU;
      INSERT  INTO temp_comment_table (TicketOriginalId, CommentDescription, CreationDate, UpdateDate, CreationUser, UpdateUser)
      VALUES (TOI,COMDESC,CREDATE,UD,CU,UU);
      SET start_interate = start_interate + 1;
    END WHILE;

    select * from temp_comment_table;

    CLOSE cur1;
    CLOSE cur2;
    CLOSE cur3;

  END;


Call return_comments_by_ticketoriginalid(1);
