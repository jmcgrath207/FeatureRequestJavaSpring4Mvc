
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
  CommentOriginalId INT,
  TicketOriginalId INT,
  CommentDescription TEXT,
  CreationDate DATETIME,
  CreationUserId INT,
  UpdateDate DATETIME,
  UpdateUserId INT,
  FOREIGN KEY (TicketOriginalId) REFERENCES web.TicketTable(TicketOriginalId),
  PRIMARY KEY (CommentId)


);

### Create Index On CommentOriginalId
CREATE INDEX Index_CommentOriginalId
  ON web.CommentTable (CommentOriginalId);

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

# Ticket One COMMENT ONE

SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'CommentTable';

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1, @ai ,'COMMENT 1 ENTRY 1','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1);


INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,@ai,'COMMENT 1 ENTRY 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,@ai,'COMMENT 1 ENTRY 3','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',2);



# Ticket One COMMENT TWO


SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'CommentTable';

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1, @ai ,'COMMENT 2 ENTRY 1','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1);


INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,@ai,'COMMENT 2 ENTRY 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,@ai,'COMMENT 2 ENTRY 3','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',2);



# Ticket One COMMENT Three


SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'CommentTable';

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1, @ai ,'COMMENT 3 ENTRY 1','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',1);


INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,@ai,'COMMENT 3 ENTRY 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (1,@ai,'COMMENT 3 ENTRY 3','2017-11-07 12:00:12',1,'2017-11-07 12:00:12',2);





# Ticket Three COMMENT ONE


SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'CommentTable';

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId,CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3, @ai, 'COMMENT 1 ENTRY 1','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3, @ai,'COMMENT 1 ENTRY 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3,@ai,'COMMENT 1 ENTRY 3','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',2);




# Ticket Three COMMENT TWO


SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'CommentTable';

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId,CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3, @ai, 'COMMENT 2 ENTRY 1','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3, @ai,'COMMENT 2 ENTRY 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3,@ai,'COMMENT 2 ENTRY 3','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',2);





# Ticket Three COMMENT THREE


SELECT `AUTO_INCREMENT` INTO @ai
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'web'
      AND   TABLE_NAME   = 'CommentTable';

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId,CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3, @ai, 'COMMENT 3 ENTRY 1','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3, @ai,'COMMENT 3 ENTRY 2','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',1);

INSERT INTO web.CommentTable (TicketOriginalId, CommentOriginalId, CommentDescription, CreationDate, CreationUserId, UpdateDate, UpdateUserId)
VALUES (3,@ai,'COMMENT 3 ENTRY 3','2017-11-07 12:00:12',2,'2017-11-07 12:00:12',2);





### Working Stored PROCEDURE For returning Latest Tickets

DROP PROCEDURE IF EXISTS web.return_latest_tickets;

CREATE PROCEDURE web.return_latest_tickets ()
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


Call web.return_latest_tickets();




## Working Return Commments based on ticketoriginalid

DROP PROCEDURE IF EXISTS web.return_comments_by_ticketoriginalid;

CREATE PROCEDURE web.return_comments_by_ticketoriginalid (IN TOIVAR INT)
  BEGIN


    # Error Handler
    DECLARE done INT DEFAULT 0;

    # CURSOR 1
    DECLARE COMI INT; ## CommentOriginalId


    # CURSOR 1
    DECLARE cur1 CURSOR FOR SELECT DISTINCT CommentOriginalId FROM  web.CommentTable WHERE TicketOriginalId = TOIVAR;

    # Error Handler

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    DROP TABLE IF EXISTS temp_comment_table;
    CREATE TEMPORARY TABLE temp_comment_table (
      CommentId INT,
      CommentOriginalId INT,
      TicketOriginalId INT,
      CommentDescription TEXT,
      CreationDate DATETIME,
      UpdateDate DATETIME,
      CreationUser VARCHAR(255),
      UpdateUser VARCHAR(255)
    );

    OPEN cur1;

    -- Start our for loop
    forLoop: LOOP

      FETCH cur1 INTO COMI;
      IF done = 1 THEN
        LEAVE forLoop;
      END IF;
      INSERT  INTO temp_comment_table (CommentId,CommentOriginalId, TicketOriginalId, CommentDescription, CreationDate, UpdateDate, CreationUser, UpdateUser)

        SELECT CommentId,
          CommentOriginalId,
          TicketOriginalId,
          CommentDescription,
          CreationDate,
          UpdateDate,

          # Creation User Name
          (SELECT UT.UserName FROM web.CommentTable AS CT
            JOIN web.UserTable AS UT ON CT.CreationUserId = UT.UserId
          WHERE  CommentId = (SELECT MAX(CommentId) FROM web.CommentTable WHERE CommentOriginalId = COMI)),

          # Update User Name
          (SELECT UT.UserName FROM web.CommentTable AS CT
            JOIN web.UserTable AS UT ON CT.UpdateUserId = UT.UserId
          WHERE  CommentId = (SELECT MAX(CommentId) FROM web.CommentTable WHERE CommentOriginalId = COMI))
        FROM web.CommentTable WHERE  CommentId = (SELECT MAX(CommentId) FROM web.CommentTable WHERE CommentOriginalId = COMI);

      -- End our for loop
    END LOOP forLoop;



    select * from temp_comment_table  AS tt Order By tt.CommentId Desc;

    CLOSE cur1;

  END;


Call web.return_comments_by_ticketoriginalid(3);












## Working Return Commment History based on CommentOriginalId

DROP PROCEDURE IF EXISTS web.return_comment_history_by_commentoriginalid;

CREATE PROCEDURE web.return_comment_history_by_commentoriginalid (IN COMI INT)
  BEGIN


    # Error Handler
    DECLARE done INT DEFAULT 0;

    # CURSOR 1
    DECLARE CID INT; ## CommentOriginalId


    # CURSOR 1
    DECLARE cur1 CURSOR FOR SELECT CommentId FROM  web.CommentTable WHERE CommentOriginalId = COMI
                                                                          AND NOT CommentId = (SELECT MAX(CommentId) FROM web.CommentTable WHERE CommentOriginalId = COMI);

    # Error Handler

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


    DROP TABLE IF EXISTS temp_comment_table;
    CREATE TEMPORARY TABLE temp_comment_table (
      CommentId INT,
      CommentOriginalId INT,
      TicketOriginalId INT,
      CommentDescription TEXT,
      CreationDate DATETIME,
      UpdateDate DATETIME,
      CreationUser VARCHAR(255),
      UpdateUser VARCHAR(255)
    );

    OPEN cur1;

    -- Start our for loop
    forLoop: LOOP

      FETCH cur1 INTO CID;
      IF done = 1 THEN
        LEAVE forLoop;
      END IF;
      INSERT  INTO temp_comment_table (CommentId,CommentOriginalId, TicketOriginalId, CommentDescription, CreationDate, UpdateDate, CreationUser, UpdateUser)

        SELECT CommentId,
          CommentOriginalId,
          TicketOriginalId,
          CommentDescription,
          CreationDate,
          UpdateDate,

          # Creation User Name
          (SELECT UT.UserName FROM web.CommentTable AS CT
            JOIN web.UserTable AS UT ON CT.CreationUserId = UT.UserId
          WHERE  CommentId = CID),

          # Update User Name
          (SELECT UT.UserName FROM web.CommentTable AS CT
            JOIN web.UserTable AS UT ON CT.UpdateUserId = UT.UserId
          WHERE  CommentId = CID)
        FROM web.CommentTable WHERE  CommentId = CID;

      -- End our for loop
    END LOOP forLoop;



    select * from temp_comment_table  AS tt Order By tt.CommentId Desc;

    CLOSE cur1;

  END;


Call web.return_comment_history_by_commentoriginalid(1);



