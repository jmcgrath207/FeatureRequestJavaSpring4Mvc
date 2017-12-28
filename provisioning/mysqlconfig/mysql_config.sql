
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


CREATE TABLE web.TicketAttribute (

  AttributeId INT NOT NULL AUTO_INCREMENT,
  Attribute VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (AttributeId)

);


CREATE TABLE web.TicketTransactionCategory (

  CategoryId INT NOT NULL AUTO_INCREMENT,
  Category VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (CategoryId)

);



CREATE TABLE web.TicketTransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Transaction VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  CategoryId INT NOT NULL,
  FOREIGN KEY (CategoryId) REFERENCES web.TicketTransactionCategory(CategoryId),
  PRIMARY KEY (TypeId)

);


CREATE TABLE web.TicketTransaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  ParentTransactionID INT NOT NULL,
  TicketId INT NOT NULL,
  TypeId INT NOT NULL,
  UserID INT NOT NULL,
  TransactionDate DATETIME NOT NULL,
  FOREIGN KEY (TicketId) REFERENCES web.Ticket(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.TicketTransactionType(TypeId),
  FOREIGN KEY (UserID) REFERENCES web.User(UserId),
  FOREIGN KEY (ParentTransactionID) REFERENCES web.TicketTransaction(TransactionId),
  PRIMARY KEY (TransactionId)


);



CREATE TABLE web.TicketTransactionValueText (


  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId)

);

CREATE TABLE web.TicketTransactionValueVarChar (

  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId)

);


CREATE TABLE web.TicketTransactionValueInt (

  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId)

);

CREATE TABLE web.TicketTransactionValueDateTime (

  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.TicketTransaction(TransactionId)

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



CREATE TABLE web.CommentTransactionCategory (

  CategoryId INT NOT NULL AUTO_INCREMENT,
  Category VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (CategoryId)

);



CREATE TABLE web.CommentTransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Transaction VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  CategoryId INT NOT NULL,
  FOREIGN KEY (CategoryId) REFERENCES web.CommentTransactionCategory(CategoryId),
  PRIMARY KEY (TypeId)

);

CREATE TABLE web.CommentTransaction (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  ParentTransactionID INT NOT NULL,
  CommentId INT NOT NULL,
  TypeId INT NOT NULL,
  UserID INT NOT NULL,
  TransactionDate DATETIME NOT NULL,
  FOREIGN KEY (CommentId) REFERENCES web.Comment(TicketId),
  FOREIGN KEY (TypeId) REFERENCES web.CommentTransactionType(TypeId),
  FOREIGN KEY (UserID) REFERENCES web.User(UserId),
  FOREIGN KEY (ParentTransactionID) REFERENCES web.CommentTransaction(TransactionId),
  PRIMARY KEY (TransactionId)


);



CREATE TABLE web.CommentTransactionValueText (


  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId)

);

CREATE TABLE web.CommentTransactionValueVarChar (

  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId)

);


CREATE TABLE web.CommentTransactionValueInt (

  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId)

);

CREATE TABLE web.CommentTransactionValueDateTime (

  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.CommentTransaction(TransactionId)

);



### Defining Categories ####

INSERT INTO web.TicketTransactionCategory (Category, Description) VALUES ('InitialTickets','Category for Initial Tickets');
INSERT INTO web.TicketTransactionCategory (Category, Description) VALUES ('AlteredTickets','Category for Altered Tickets');

INSERT INTO web.CommentTransactionCategory (Category, Description) VALUES ('InitialComments','Category for Initial Comments');
INSERT INTO web.CommentTransactionCategory (Category, Description) VALUES ('AlteredComments','Category for Altered Comments');


##### Defining Types #####

#### TransactionType For Tickets ###

SELECT CategoryId INTO @ci FROM web.TicketTransactionCategory WHERE Category = 'InitialTickets';

INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialTicketOwnerId','Initial Owner ID of ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialTicketTitle','Initial Title of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialTicketDescription','Initial Description of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialCreationDate','Initial Creation date of ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialCreationUserId','Initial Creation User Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialUpdateDate','Initial Update Date of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialUpdateUserId','Initial Update User Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialTargetDate','Initial Target Date of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialDepartmentId','Initial Department Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialStatusId','Initial Status Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('InitialPriorityId','Initial Priority Id of the ticket', @ci);

SELECT CategoryId INTO @ci FROM web.TicketTransactionCategory WHERE Category = 'AlteredTickets';

INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredTicketOwnerId','Altered Owner ID of ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredTicketTitle','Altered Title of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredTicketDescription','Altered Description of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredCreationDate','Altered Creation date of ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredCreationUserId','Altered Creation User Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredUpdateDate','Altered Update Date of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredUpdateUserId','Altered Update User Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredTargetDate','Altered Target Date of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredDepartmentId','Altered Department Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredStatusId','Altered Status Id of the ticket', @ci);
INSERT INTO web.TicketTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredPriorityId','Altered Priority Id of the ticket', @ci);


#### TransactionType For Comment ###

SELECT CategoryId INTO @ci FROM web.CommentTransactionCategory WHERE Category = 'InitialComments';

INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('InitialCommentDescription','Initial Comment Description of a comment', @ci);
INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('InitialCreationDate','Initial Creation Date of a comment', @ci);
INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('InitialCreationUserId','Initial Creation User Id of a comment', @ci);
INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('InitialUpdateUserId','Initial Update User Id of a comment', @ci);

SELECT CategoryId INTO @ci FROM web.CommentTransactionCategory WHERE Category = 'AlteredComments';

INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredCommentDescription','Altered Comment Description of a comment', @ci);
INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredCreationDate','Altered Creation Date of a comment', @ci);
INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredCreationUserId','Altered Creation User Id of a comment', @ci);
INSERT INTO web.CommentTransactionType (Transaction, Description, CategoryId) VALUES ('AlteredUpdateUserId','Altered Update User Id of a comment', @ci);





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






#### Generic Standard Functions ######


DROP FUNCTION IF EXISTS web.FuncTicketTransaction;

CREATE FUNCTION web.FuncTicketTransaction (
  TI INT,                # Ticket Id
  TRANUSER INT,          # Transaction User
  TRANDATE DATETIME,     # Transaction Date
  TRANTYPE VARCHAR(255), # Transaction Type
  PTI INT                # Parent TicketTransactionID
)
  RETURNS INT

  BEGIN


    INSERT INTO web.TicketTransaction (TicketId, TypeId, UserID, TransactionDate,ParentTransactionID)

    VALUES(TI,
           ## Select Transction Type
           (SELECT TypeId FROM web.TicketTransactionType WHERE Transaction = TRANTYPE),
           TRANUSER,TRANDATE, PTI
    );



    ## Grab last inserted Id from
    RETURN LAST_INSERT_ID();

  END;







#### Generic Standard Procedures ######





#### Set Ticket Transaction Value Int ####

DROP PROCEDURE IF EXISTS web.StoreProdTicketTransactionValueInt;

CREATE PROCEDURE web.StoreProdTicketTransactionValueInt (TRANVALUE INT,         # Transaction Value
                                                         TI INT,                # Ticket Id
                                                         TRANUSER INT,          # Transaction User
                                                         TRANDATE DATETIME,     # Transaction Date
                                                         TRANTYPE VARCHAR(255), # Transaction Type
                                                         PTI INT                # Parent TicketTransactionID
)

  BEGIN


    INSERT INTO web.TicketTransactionValueInt (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTicketTransaction (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TicketTransactionID
      )),
      TRANVALUE);

  END;





#### Set Ticket Transaction Value VarChar ####

DROP PROCEDURE IF EXISTS web.StoreProdTicketTransactionValueVarChar;

CREATE PROCEDURE web.StoreProdTicketTransactionValueVarChar (TRANVALUE VARCHAR(255),        # Transaction Value
                                                             TI INT,                        # Ticket Id
                                                             TRANUSER INT,                  # Transaction User
                                                             TRANDATE DATETIME,             # Transaction Date
                                                             TRANTYPE VARCHAR(255),         # Transaction Type
                                                             PTI INT                        # Parent TicketTransactionID
)
  BEGIN

    INSERT INTO web.TicketTransactionValueVarChar (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTicketTransaction (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TicketTransactionID
      )),
      TRANVALUE);


  END;









#### Set Ticket Transaction Value Text ####

DROP PROCEDURE IF EXISTS web.StoreProdTicketTransactionValueText;

CREATE PROCEDURE web.StoreProdTicketTransactionValueText (TRANVALUE TEXT,                # Transaction Value
                                                          TI INT,                        # Ticket Id
                                                          TRANUSER INT,                  # Transaction User
                                                          TRANDATE DATETIME,             # Transaction Date
                                                          TRANTYPE VARCHAR(255),         # Transaction Type
                                                          PTI INT                        # Parent TicketTransactionID
)
  BEGIN

    INSERT INTO web.TicketTransactionValueText (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTicketTransaction (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TicketTransactionID
      )),
      TRANVALUE);


  END;






#### Set Ticket Transaction Value Date Time ####

DROP PROCEDURE IF EXISTS web.StoreProdTicketTransactionValueDateTime;

CREATE PROCEDURE web.StoreProdTicketTransactionValueDateTime (TRANVALUE TEXT,                # Transaction Value
                                                              TI INT,                        # Ticket Id
                                                              TRANUSER INT,                  # Transaction User
                                                              TRANDATE DATETIME,             # Transaction Date
                                                              TRANTYPE VARCHAR(255),         # Transaction Type
                                                              PTI INT                        # Parent TicketTransactionID
)
  BEGIN

    INSERT INTO web.TicketTransactionValueDateTime (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTicketTransaction (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TicketTransactionID
      )),
      TRANVALUE);


  END;






##### New Ticket #########


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
    DECLARE TI INT;         # TicketId
    DECLARE PTI INT;        # ParentTransactionId




    DECLARE exit handler for sqlexception
    BEGIN
      -- ERROR
      SHOW ERRORS;
      ROLLBACK;
    END;

    DECLARE exit handler for sqlwarning
    BEGIN
      -- WARNING
      SHOW WARNINGS;
      ROLLBACK;
    END;



    SET TOI = (SELECT UserId FROM web.User WHERE UserName = TOS);
    SET CUI = (SELECT UserId FROM web.User WHERE UserName = CUS);
    SET UUI = (SELECT UserId FROM web.User WHERE UserName = UUS);
    SET DI = (SELECT DepartmentId FROM web.Department WHERE Department = DS);
    SET SI = (SELECT StatusId FROM web.TicketStatus WHERE Status = SS);
    SET PI = (SELECT PriorityId FROM web.Priority WHERE Priority = PS);


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




    ## Select Ticket ID just created
    SET TI  = (SELECT TicketId FROM web.Ticket
    WHERE TicketOwnerId = TOI
          AND TicketTitle = TT AND TicketDescription = TDesc
          AND CreationDate = CD AND CreationUserId = CUI
          AND UpdateDate = UD AND UpdateUserId = UUI
          AND TargetDate = TDate AND DepartmentId = DI
          AND StatusId = SI AND PriorityId = PI);


    ## Select First available TicketTransaction Id that will become a Parent TicketTransaction Id
    SET PTI = (SELECT AUTO_INCREMENT
               FROM  information_schema.TABLES
               WHERE TABLE_SCHEMA = 'web'
                     AND   TABLE_NAME   = 'TicketTransaction');
    ### Add TicketOwnerId to Ticket Transaction

    Call web.StoreProdTicketTransactionValueInt (TOI,                    # Transaction Value
                                                 TI,                     # TicketId
                                                 CUI,                    # Transaction User
                                                 CD,                     # Transaction Date
                                                 'InitialTicketOwnerId', # Transaction Type
                                                 PTI                     # Parent TicketTransactionID
    );


    ### Add TicketTitle to Ticket Transaction

    Call web.StoreProdTicketTransactionValueVarChar (TT,                    # Transaction Value
                                                     TI,                    # TicketId
                                                     CUI,                   # Transaction User
                                                     CD,                    # Transaction Date
                                                     'InitialTicketTitle',  # Transaction Type
                                                     PTI                    # Parent TicketTransactionID
    );

    ### Add TicketDescription to Ticket Transaction

    Call web.StoreProdTicketTransactionValueText (TDesc,                        # Transaction Value
                                                  TI,                           # TicketId
                                                  CUI,                          # Transaction User
                                                  CD,                           # Transaction Date
                                                  'InitialTicketDescription',   # Transaction Type
                                                  PTI                           # Parent TicketTransactionID
    );

    ### Add CreationDate to Ticket Transaction

    Call web.StoreProdTicketTransactionValueDateTime (CD,                      # Transaction Value
                                                      TI,                      # TicketId
                                                      CUI,                     # Transaction User
                                                      CD,                      # Transaction Date
                                                      'InitialCreationDate',   # Transaction Type
                                                      PTI                      # Parent TicketTransactionID
    );


    ### Add CreationUserId to Ticket Transaction

    Call web.StoreProdTicketTransactionValueInt (CUI,                     # Transaction Value
                                                 TI,                      # TicketId
                                                 CUI,                     # Transaction User
                                                 CD,                      # Transaction Date
                                                 'InitialCreationUserId', # Transaction Type
                                                 PTI                      # Parent TicketTransactionID
    );



    ### Add UpdateDate to Ticket Transaction

    Call web.StoreProdTicketTransactionValueDateTime (UD,                      # Transaction Value
                                                      TI,                      # TicketId
                                                      CUI,                     # Transaction User
                                                      CD,                      # Transaction Date
                                                      'InitialUpdateDate',     # Transaction Type
                                                      PTI                      # Parent TicketTransactionID
    );




    ### Add UpdateUserId to Ticket Transaction

    Call web.StoreProdTicketTransactionValueInt (UUI,                    # Transaction Value
                                                 TI,                     # TicketId
                                                 CUI,                    # Transaction User
                                                 CD,                     # Transaction Date
                                                 'InitialUpdateUserId',  # Transaction Type
                                                 PTI                     # Parent TicketTransactionID
    );

    ### Add TargetDate to Ticket Transaction

    Call web.StoreProdTicketTransactionValueDateTime (TDate,                   # Transaction Value
                                                      TI,                      # TicketId
                                                      CUI,                     # Transaction User
                                                      CD,                      # Transaction Date
                                                      'InitialTargetDate',     # Transaction Type
                                                      PTI                      # Parent TicketTransactionID
    );




    ### Add DepartmentId to Ticket Transaction

    Call web.StoreProdTicketTransactionValueInt (DI,                     # Transaction Value
                                                 TI,                     # TicketId
                                                 CUI,                    # Transaction User
                                                 CD,                     # Transaction Date
                                                 'InitialDepartmentId',  # Transaction Type
                                                 PTI                     # Parent TicketTransactionID
    );




    ### Add StatusId to Ticket Transaction

    Call web.StoreProdTicketTransactionValueInt (SI,                     # Transaction Value
                                                 TI,                     # TicketId
                                                 CUI,                    # Transaction User
                                                 CD,                     # Transaction Date
                                                 'InitialStatusId',      # Transaction Type
                                                 PTI                     # Parent TicketTransactionID
    );



    ### Add PriorityId to Ticket Transaction

    Call web.StoreProdTicketTransactionValueInt (PI,                     # Transaction Value
                                                 TI,                     # TicketId
                                                 CUI,                    # Transaction User
                                                 CD,                     # Transaction Date
                                                 'InitialPriorityId',    # Transaction Type
                                                 PTI                     # Parent TicketTransactionID
    );



    COMMIT;
  END;

call web.create_new_Ticket('jmcgrath',
                           'Fix Function Foo','Fix Function Foo issue',
                           '2017-11-07 12:00:12','jmcgrath',
                           '2017-11-08 13:00:12','jmcgrath',
                           '2017-11-09 14:00:12','Development',
                           'In Progress','Normal');


