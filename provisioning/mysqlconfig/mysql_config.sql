
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


CREATE TABLE web.TransactionCategory (

  CategoryId INT NOT NULL AUTO_INCREMENT,
  Category VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (CategoryId)

);



CREATE TABLE web.TransactionType (

  TypeId INT NOT NULL AUTO_INCREMENT,
  Transaction VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  CategoryId INT NOT NULL,
  FOREIGN KEY (CategoryId) REFERENCES web.TransactionCategory(CategoryId),
  PRIMARY KEY (TypeId)

);


CREATE TABLE web.TransactionTypeAttribute (

  AttributeId INT NOT NULL AUTO_INCREMENT,
  AttributeValue VARCHAR(255),
  AttributeDescription TEXT,
  PRIMARY KEY (AttributeId,AttributeValue)

);



CREATE TABLE web.TransactionTypeMeta (

  TypeId INT,
  AttributeId INT,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (AttributeId) REFERENCES web.TransactionTypeAttribute(AttributeId)

);







CREATE TABLE web.Transactions (

  TransactionId INT NOT NULL AUTO_INCREMENT,
  GroupTransactionId INT NOT NULL,
  ParentTransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  UserID INT NOT NULL,
  TransactionDate DATETIME NOT NULL,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (UserID) REFERENCES web.User(UserId),
  FOREIGN KEY (GroupTransactionId) REFERENCES web.Transactions(TransactionId),
  FOREIGN KEY (ParentTransactionId) REFERENCES web.Transactions(TransactionId),
  PRIMARY KEY (TransactionId)


);




CREATE TABLE web.ActiveTransactions (


  TransactionId INT NOT NULL,
  ParentTransactionId INT NOT NULL,
  TypeId INT NOT NULL,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId),
  FOREIGN KEY (ParentTransactionId) REFERENCES web.Transactions(ParentTransactionId),
  PRIMARY KEY (TransactionId)

);



CREATE TABLE web.TransactionsValueText (


  TransactionId INT NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);

CREATE TABLE web.TransactionsValueVarChar (

  TransactionId INT NOT NULL,
  Value VARCHAR(255) NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);


CREATE TABLE web.TransactionsValueInt (

  TransactionId INT NOT NULL,
  Value INT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);

CREATE TABLE web.TransactionsValueDateTime (

  TransactionId INT NOT NULL,
  Value DATETIME NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);



### Defining Categories ####

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('InitialTickets','Category for Initial Tickets');
INSERT INTO web.TransactionCategory (Category, Description) VALUES ('AlteredTickets','Category for Altered Tickets');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('InitialComments','Category for Initial Comments');
INSERT INTO web.TransactionCategory (Category, Description) VALUES ('AlteredComments','Category for Altered Comments');





##### Defining Types #####

#### TransactionType For Tickets ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'InitialTickets';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('OwnerId','Initial Owner ID of ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('Title','Initial Title of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('Description','Initial Description of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationDate','Initial Creation date of ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationUserId','Initial Creation User Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('UpdateDate','Initial Update Date of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('UpdateUserId','Initial Update User Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('TargetDate','Initial Target Date of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('DepartmentId','Initial Department Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('StatusId','Initial Status Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('PriorityId','Initial Priority Id of the ticket', @ci);

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'AlteredTickets';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('OwnerId','Altered Owner ID of ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('Title','Altered Title of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('Description','Altered Description of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationDate','Altered Creation date of ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationUserId','Altered Creation User Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('UpdateDate','Altered Update Date of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('UpdateUserId','Altered Update User Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('TargetDate','Altered Target Date of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('DepartmentId','Altered Department Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('StatusId','Altered Status Id of the ticket', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('PriorityId','Altered Priority Id of the ticket', @ci);


#### TransactionType For Comment ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'InitialComments';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CommentDescription','Initial Comment Description of a comment', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationDate','Initial Creation Date of a comment', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationUserId','Initial Creation User Id of a comment', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('UpdateUserId','Initial Update User Id of a comment', @ci);

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'AlteredComments';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CommentDescription','Altered Comment Description of a comment', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationDate','Altered Creation Date of a comment', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('CreationUserId','Altered Creation User Id of a comment', @ci);
INSERT INTO web.TransactionType (Transaction, Description, CategoryId) VALUES ('UpdateUserId','Altered Update User Id of a comment', @ci);

#### Setting TransactionTypeAttribute ###

INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('Parent','Classify The Transaction Type As A Parent');
INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('Child','Classify The Transaction Type As A Child');
INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('IdentifyAsTranId','The Transaction Type is allowed to be Identify as be the Transaction ID upon creation');


### Setting TransactionTypeMeta ###

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Parent')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'InitialTickets';

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'IdentifyAsTranId')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'InitialTickets';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Parent')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'AlteredTickets';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'IdentifyAsTranId')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'AlteredTickets';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Child')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'InitialComments';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Child')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'AlteredComments';


## Role ID Type

INSERT INTO web.Role (RoleId, Role,RoleDescription) VALUES (
  1, 'User', 'Standard User Role'
);



#### Create User Info ####


INSERT INTO web.User (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jmcgrath','john','mcgrath','john.mcgrath207@gmail.com','test', 1
);

INSERT INTO web.User (UserName, FirstName, LastName, EmailAddress, Password, RoleId) VALUES (
  'jsmith','john','smith','john.smith@gmail.com','test', 1
);






#### Generic Standard Functions ######


DROP FUNCTION IF EXISTS web.FuncTransactions;

CREATE FUNCTION web.FuncTransactions (
  TI INT,                # Ticket Id
  TRANUSER INT,          # Transaction User
  TRANDATE DATETIME,     # Transaction Date
  TRANTYPE VARCHAR(255), # Transaction Type
  PTI INT                # Parent TransactionsID
)
  RETURNS INT

  BEGIN


    INSERT INTO web.Transactions (TicketId, TypeId, UserID, TransactionDate,ParentTransactionID)

    VALUES(TI,
           ## Select Transction Type
           (SELECT TypeId FROM web.TransactionType WHERE Transaction = TRANTYPE),
           TRANUSER,TRANDATE, PTI
    );



    ## Grab last inserted Id from
    RETURN LAST_INSERT_ID();

  END;







#### Generic Standard Procedures ######





#### Set Ticket Transaction Value Int ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueInt;

CREATE PROCEDURE web.StoreProdTransactionsValueInt (TRANVALUE INT,         # Transaction Value
                                                    TI INT,                # Ticket Id
                                                    TRANUSER INT,          # Transaction User
                                                    TRANDATE DATETIME,     # Transaction Date
                                                    TRANTYPE VARCHAR(255), # Transaction Type
                                                    PTI INT                # Parent TransactionsID
)

  BEGIN


    INSERT INTO web.TransactionsValueInt (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TransactionsID
      )),
      TRANVALUE);

  END;





#### Set Ticket Transaction Value VarChar ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueVarChar;

CREATE PROCEDURE web.StoreProdTransactionsValueVarChar (TRANVALUE VARCHAR(255),        # Transaction Value
                                                        TI INT,                        # Ticket Id
                                                        TRANUSER INT,                  # Transaction User
                                                        TRANDATE DATETIME,             # Transaction Date
                                                        TRANTYPE VARCHAR(255),         # Transaction Type
                                                        PTI INT                        # Parent TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueVarChar (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TransactionsID
      )),
      TRANVALUE);


  END;









#### Set Ticket Transaction Value Text ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueText;

CREATE PROCEDURE web.StoreProdTransactionsValueText (TRANVALUE TEXT,                # Transaction Value
                                                     TI INT,                        # Ticket Id
                                                     TRANUSER INT,                  # Transaction User
                                                     TRANDATE DATETIME,             # Transaction Date
                                                     TRANTYPE VARCHAR(255),         # Transaction Type
                                                     PTI INT                        # Parent TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueText (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TransactionsID
      )),
      TRANVALUE);


  END;






#### Set Ticket Transaction Value Date Time ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueDateTime;

CREATE PROCEDURE web.StoreProdTransactionsValueDateTime (TRANVALUE TEXT,                # Transaction Value
                                                         TI INT,                        # Ticket Id
                                                         TRANUSER INT,                  # Transaction User
                                                         TRANDATE DATETIME,             # Transaction Date
                                                         TRANTYPE VARCHAR(255),         # Transaction Type
                                                         PTI INT                        # Parent TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueDateTime (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TI ,          # Ticket Id
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TransactionsID
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


    ## Select First available Transactions Id that will become a Parent Transactions Id
    SET PTI = (SELECT AUTO_INCREMENT
               FROM  information_schema.TABLES
               WHERE TABLE_SCHEMA = 'web'
                     AND   TABLE_NAME   = 'Transactions');
    ### Add TicketOwnerId to Ticket Transaction

    Call web.StoreProdTransactionsValueInt (TOI,                    # Transaction Value
                                            TI,                     # TicketId
                                            CUI,                    # Transaction User
                                            CD,                     # Transaction Date
                                            'InitialTicketOwnerId', # Transaction Type
                                            PTI                     # Parent TransactionsID
    );


    ### Add TicketTitle to Ticket Transaction

    Call web.StoreProdTransactionsValueVarChar (TT,                    # Transaction Value
                                                TI,                    # TicketId
                                                CUI,                   # Transaction User
                                                CD,                    # Transaction Date
                                                'InitialTicketTitle',  # Transaction Type
                                                PTI                    # Parent TransactionsID
    );

    ### Add TicketDescription to Ticket Transaction

    Call web.StoreProdTransactionsValueText (TDesc,                        # Transaction Value
                                             TI,                           # TicketId
                                             CUI,                          # Transaction User
                                             CD,                           # Transaction Date
                                             'InitialTicketDescription',   # Transaction Type
                                             PTI                           # Parent TransactionsID
    );

    ### Add CreationDate to Ticket Transaction

    Call web.StoreProdTransactionsValueDateTime (CD,                      # Transaction Value
                                                 TI,                      # TicketId
                                                 CUI,                     # Transaction User
                                                 CD,                      # Transaction Date
                                                 'InitialCreationDate',   # Transaction Type
                                                 PTI                      # Parent TransactionsID
    );


    ### Add CreationUserId to Ticket Transaction

    Call web.StoreProdTransactionsValueInt (CUI,                     # Transaction Value
                                            TI,                      # TicketId
                                            CUI,                     # Transaction User
                                            CD,                      # Transaction Date
                                            'InitialCreationUserId', # Transaction Type
                                            PTI                      # Parent TransactionsID
    );



    ### Add UpdateDate to Ticket Transaction

    Call web.StoreProdTransactionsValueDateTime (UD,                      # Transaction Value
                                                 TI,                      # TicketId
                                                 CUI,                     # Transaction User
                                                 CD,                      # Transaction Date
                                                 'InitialUpdateDate',     # Transaction Type
                                                 PTI                      # Parent TransactionsID
    );




    ### Add UpdateUserId to Ticket Transaction

    Call web.StoreProdTransactionsValueInt (UUI,                    # Transaction Value
                                            TI,                     # TicketId
                                            CUI,                    # Transaction User
                                            CD,                     # Transaction Date
                                            'InitialUpdateUserId',  # Transaction Type
                                            PTI                     # Parent TransactionsID
    );

    ### Add TargetDate to Ticket Transaction

    Call web.StoreProdTransactionsValueDateTime (TDate,                   # Transaction Value
                                                 TI,                      # TicketId
                                                 CUI,                     # Transaction User
                                                 CD,                      # Transaction Date
                                                 'InitialTargetDate',     # Transaction Type
                                                 PTI                      # Parent TransactionsID
    );




    ### Add DepartmentId to Ticket Transaction

    Call web.StoreProdTransactionsValueInt (DI,                     # Transaction Value
                                            TI,                     # TicketId
                                            CUI,                    # Transaction User
                                            CD,                     # Transaction Date
                                            'InitialDepartmentId',  # Transaction Type
                                            PTI                     # Parent TransactionsID
    );




    ### Add StatusId to Ticket Transaction

    Call web.StoreProdTransactionsValueInt (SI,                     # Transaction Value
                                            TI,                     # TicketId
                                            CUI,                    # Transaction User
                                            CD,                     # Transaction Date
                                            'InitialStatusId',      # Transaction Type
                                            PTI                     # Parent TransactionsID
    );



    ### Add PriorityId to Ticket Transaction

    Call web.StoreProdTransactionsValueInt (PI,                     # Transaction Value
                                            TI,                     # TicketId
                                            CUI,                    # Transaction User
                                            CD,                     # Transaction Date
                                            'InitialPriorityId',    # Transaction Type
                                            PTI                     # Parent TransactionsID
    );



    COMMIT;
  END;

call web.create_new_Ticket('jmcgrath',
                           'Fix Function Foo','Fix Function Foo issue',
                           '2017-11-07 12:00:12','jmcgrath',
                           '2017-11-08 13:00:12','jmcgrath',
                           '2017-11-09 14:00:12','Development',
                           'In Progress','Normal');


