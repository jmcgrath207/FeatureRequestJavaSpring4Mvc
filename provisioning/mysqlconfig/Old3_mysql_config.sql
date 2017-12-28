
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';
## GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE, REFERENCES ON *.* TO 'root'@'%';
## Create Tables #####


CREATE DATABASE web;


CREATE TABLE web.Role
(

  RoleId  INT UNSIGNED NOT NULL,
  Role VARCHAR(255) NOT NULL,
  RoleDescription TEXT NOT NULL,
  PRIMARY KEY (RoleId)


);


CREATE TABLE web.User
(
  UserId INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  UserName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  EmailAddress VARCHAR(255) NOT NULL,
  Password VARCHAR(255) NOT NULL,
  RoleId  INT UNSIGNED NOT NULL,
  PRIMARY KEY (UserId),
  FOREIGN KEY (RoleId) REFERENCES web.Role(RoleId)


);


CREATE TABLE web.TransactionCategory (

  CategoryId INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Category VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  PRIMARY KEY (CategoryId)

);



CREATE TABLE web.TransactionType (

  TypeId INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Transaction VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  CategoryId INT UNSIGNED NOT NULL,
  TransactionValueTable VARCHAR(64),
  FOREIGN KEY (CategoryId) REFERENCES web.TransactionCategory(CategoryId),
  PRIMARY KEY (TypeId)

);


CREATE TABLE web.TransactionTypeAttribute (

  AttributeId INT UNSIGNED NOT NULL AUTO_INCREMENT,
  AttributeValue VARCHAR(255),
  AttributeDescription TEXT,
  PRIMARY KEY (AttributeId,AttributeValue)

);



CREATE TABLE web.TransactionTypeMeta (

  TypeId INT UNSIGNED,
  AttributeId INT UNSIGNED,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (AttributeId) REFERENCES web.TransactionTypeAttribute(AttributeId)

);





CREATE TABLE web.Transactions (

  TransactionId BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  GroupTransactionId BIGINT UNSIGNED NOT NULL,
  ParentTransactionId BIGINT UNSIGNED NOT NULL,
  TypeId INT UNSIGNED NOT NULL,
  UserID INT UNSIGNED NOT NULL,
  TransactionDate DATETIME NOT NULL,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (UserID) REFERENCES web.User(UserId),
  FOREIGN KEY (GroupTransactionId) REFERENCES web.Transactions(TransactionId),
  FOREIGN KEY (ParentTransactionId) REFERENCES web.Transactions(TransactionId),
  PRIMARY KEY (TransactionId)


);






CREATE TABLE web.ActiveTransactions (


  TransactionId BIGINT UNSIGNED NOT NULL,
  ParentTransactionId BIGINT UNSIGNED NOT NULL,
  TypeId INT UNSIGNED NOT NULL,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId),
  FOREIGN KEY (ParentTransactionId) REFERENCES web.Transactions(ParentTransactionId),
  PRIMARY KEY (TransactionId)

);



CREATE TABLE web.TransactionsValueText (


  TransactionId BIGINT UNSIGNED NOT NULL,
  Value TEXT NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);

CREATE TABLE web.TransactionsValueVarChar (

  TransactionId BIGINT UNSIGNED NOT NULL,
  Value VARCHAR(255) NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);


CREATE TABLE web.TransactionsValueINT  (

  TransactionId BIGINT UNSIGNED NOT NULL,
  Value INT UNSIGNED NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);

CREATE TABLE web.TransactionsValueDateTime (

  TransactionId BIGINT UNSIGNED NOT NULL,
  Value DATETIME NOT NULL,
  FOREIGN KEY (TransactionId) REFERENCES web.Transactions(TransactionId)

);


## Table for find parent to child relationship between Transactions

CREATE TABLE web.TransactionsRelations (

  SourceTransactionId BIGINT UNSIGNED NOT NULL,
  TypeId INT UNSIGNED NOT NULL,
  TargetTransactionId BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (TypeId) REFERENCES web.TransactionType(TypeId),
  FOREIGN KEY (SourceTransactionId) REFERENCES web.Transactions(TransactionId),
  FOREIGN KEY (TargetTransactionId) REFERENCES web.Transactions(TransactionId)

);






### Defining Categories ####

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Tickets','Category for Tickets');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Comments','Category for  Comments');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Departments','Category for  Departments');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Priorities','Category for Priorities');



##### Defining Types #####

#### TransactionType For Tickets ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Tickets';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketId',' TicketId of ticket', @ci,'TransactionsValueINT');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketOwner',' Owner of ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketTitle',' Title of the ticket', @ci, 'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketDescription',' Description of the ticket', @ci, 'TransactionsValueText');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketCreationDate',' Creation date of ticket', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketCreationUser',' Creation User of the ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketUpdateDate',' Update Date of the ticket', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketUpdateUser',' Update User  of the ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TicketTargetDate',' Target Date of the ticket', @ci,'TransactionsValueDateTime');






#### TransactionType For Comment ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Comments';


INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CommentId',' Comment Id of a comment', @ci, 'TransactionsValueINT');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CommentDescription',' Comment Description of a comment', @ci, 'TransactionsValueText');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CommentCreationDate',' Creation Date of a comment', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CommentCreationUser',' Creation User Id of a comment', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CommentUpdateUser',' Update User Id of a comment', @ci,'TransactionsValueVarChar');



### TransactionType for  Department ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Departments';


INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Development','Transaction Type for Development Department', @ci,'TransactionsValueVarChar');



### TransactionType for  Priority ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Priorities';


INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Normal','Transaction Type for Non Urgent Task', @ci,'TransactionsValueVarChar');


### TransactionType for  Priority ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Status';


INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('InProgress','Transaction Type for In Progress', @ci,'TransactionsValueVarChar');





#### Setting TransactionTypeAttribute ###

INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('Parent','Classify The Transaction Type As A Parent');
INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('Child','Classify The Transaction Type As A Child');
INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('IdentifyAsTranId','The Transaction Type used  Transaction ID for identification');
INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('Static','The Transactions that referecnes multiple transactions ex. Department');
INSERT INTO web.TransactionTypeAttribute (AttributeValue, AttributeDescription) VALUES ('NoEdit','Transactions that can not be edit. ex. Ticket ID');



### Setting TransactionTypeMeta ###

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'NoEdit')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'TicketId';

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'IdentifyAsTranId')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'TicketId';



INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'IdentifyAsTranId')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'CommentId';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'NoEdit')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'CommentId';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Static')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'Department';

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Static')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'TicketStatus';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Static')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE T.Transaction = 'TicketPriority';



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
  TRANUSERID INT,        # Transaction User
  TRANDATE DATETIME,     # Transaction Date
  TRANTYPE VARCHAR(255), # Transaction Type
  PTI INT,               # Parent TransactionsID
  GTI INT                # Group TransactionsID
)
  RETURNS INT

  BEGIN


    INSERT INTO web.Transactions ( TypeId, UserID,GroupTransactionId, ParentTransactionID,TransactionDate)

    VALUES(
      ## Select Transction Type
      (SELECT TypeId FROM web.TransactionType WHERE Transaction = TRANTYPE),
      TRANUSERID, GTI,PTI,TRANDATE
    );



    ## Grab last inserted Id from
    RETURN LAST_INSERT_ID();

  END;







#### Generic Standard Procedures ######





#### Set Ticket Transaction Value Int ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueInt;

CREATE PROCEDURE web.StoreProdTransactionsValueInt (TRANVALUE INT,           # Transaction Value
                                                    TRANUSERID INT,          # Transaction User
                                                    TRANDATE DATETIME,       # Transaction Date
                                                    TRANTYPE VARCHAR(255),   # Transaction Type
                                                    PTI INT,                 # Parent TransactionsID
                                                    GTI INT                  # Group TransactionsID
)

  BEGIN


    INSERT INTO web.TransactionsValueINT (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TRANUSERID,   # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI,          # Parent TransactionsID
          GTI           # Group TransactionsID
      )),
      TRANVALUE);

  END;





#### Set Ticket Transaction Value VarChar ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueVarChar;

CREATE PROCEDURE web.StoreProdTransactionsValueVarChar (TRANVALUE VARCHAR(255),   # Transaction Value
                                                        TRANUSERID INT,           # Transaction User
                                                        TRANDATE DATETIME,        # Transaction Date
                                                        TRANTYPE VARCHAR(255),    # Transaction Type
                                                        PTI INT,                  # Parent TransactionsID
                                                        GTI INT                   # Group TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueVarChar (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TRANUSERID,   # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI,          # Parent TransactionsID
          GTI           # Group TransactionsID
      )),
      TRANVALUE);


  END;









#### Set Ticket Transaction Value Text ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueText;

CREATE PROCEDURE web.StoreProdTransactionsValueText (TRANVALUE TEXT,           # Transaction Value
                                                     TRANUSERID INT,           # Transaction User
                                                     TRANDATE DATETIME,        # Transaction Date
                                                     TRANTYPE VARCHAR(255),    # Transaction Type
                                                     PTI INT,                  # Parent TransactionsID
                                                     GTI INT                   # Group TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueText (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TRANUSERID,   # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI,          # Parent TransactionsID
          GTI           # Group TransactionsID
      )),
      TRANVALUE);


  END;






#### Set Ticket Transaction Value Date Time ####

DROP PROCEDURE IF EXISTS web.StoreProdTransactionsValueDateTime;

CREATE PROCEDURE web.StoreProdTransactionsValueDateTime (TRANVALUE TEXT,           # Transaction Value
                                                         TRANUSERID INT,           # Transaction User
                                                         TRANDATE DATETIME,        # Transaction Date
                                                         TRANTYPE VARCHAR(255),    # Transaction Type
                                                         PTI INT,                  # Parent TransactionsID
                                                         GTI INT                   # Group TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueDateTime (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TRANUSERID,   # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI,          # Parent TransactionsID
          GTI           # Group TransactionsID
      )),
      TRANVALUE);



  END;






##### new Transaction#########


DROP PROCEDURE IF EXISTS web.newTransaction;

CREATE PROCEDURE web.newTransaction (DATA JSON)
  BEGIN

    DECLARE done INT DEFAULT FALSE;
    ## Declare Vars ###

    DECLARE GTI INT;        # GroupTransactionId
    DECLARE PTI INT;        # ParentTransactionId
    DECLARE TRANDATETIME DATETIME;

    DECLARE TRANUSERID INT;

    DECLARE TRANTYPECAT VARCHAR(255); # converts symbol from double to Char to allow dynamic tag searching


    # CURSOR 1
    DECLARE TRANTYPE VARCHAR(255);   ## Transaction
    DECLARE TVT VARCHAR(255);        ## TransactionValueTable
    DECLARE cur1 CURSOR FOR SELECT  Transaction, TransactionValueTable FROM  web.TransactionType;




    ##### Error Handlers ####

    ### Error Handle for Loop ##

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

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

    ## Group TRANSACTION Number unique to each call
    SET GTI = (SELECT AUTO_INCREMENT
               FROM  information_schema.TABLES
               WHERE TABLE_SCHEMA = 'web'
                     AND   TABLE_NAME   = 'Transactions');


    ## Parent TRANSACTION Number unique to each call
    SET PTI = (SELECT AUTO_INCREMENT
               FROM  information_schema.TABLES
               WHERE TABLE_SCHEMA = 'web'
                     AND   TABLE_NAME   = 'Transactions');

    SET  TRANDATETIME = (SELECT NOW());

    SET TRANUSERID = (SELECT UserId FROM web.User WHERE UserName =(SELECT JSON_EXTRACT(DATA, '$.User' )));


    OPEN cur1;

    START TRANSACTION;
    -- Start our for loop
    forLoop: LOOP

      FETCH cur1 INTO TRANTYPE,TVT;
      IF done = TRUE THEN
        LEAVE forLoop;
      END IF;

      SET TRANTYPECAT = CONCAT(CONVERT('$.', CHAR(50)), TRANTYPE);


      IF (SELECT JSON_CONTAINS_PATH(DATA, 'one',  TRANTYPECAT) = 1) THEN
        IF ( TVT='TransactionsValueVarChar') THEN
          CALL web.StoreProdTransactionsValueVarChar ((SELECT JSON_UNQUOTE((SELECT JSON_EXTRACT(DATA, TRANTYPECAT)))),        # Transaction Value
                                                      TRANUSERID,           # Transaction User
                                                      TRANDATETIME,         # Transaction Date
                                                      TRANTYPE,             # Transaction Type
                                                      PTI,                  # Parent TransactionsID
                                                      GTI                   # Group TransactionsID
          );

        ELSEIF  ( TVT='TransactionsValueText') THEN
          CALL web.StoreProdTransactionsValueText ((SELECT JSON_UNQUOTE((SELECT JSON_EXTRACT(DATA, TRANTYPECAT)))),        # Transaction Value
                                                   TRANUSERID,           # Transaction User
                                                   TRANDATETIME,         # Transaction Date
                                                   TRANTYPE,             # Transaction Type
                                                   PTI,                  # Parent TransactionsID
                                                   GTI                   # Group TransactionsID
          );


        ELSEIF  ( TVT='TransactionsValueDateTime') THEN
          CALL web.StoreProdTransactionsValueDateTime ((SELECT JSON_UNQUOTE((SELECT JSON_EXTRACT(DATA, TRANTYPECAT)))),        # Transaction Value
                                                       TRANUSERID,           # Transaction User
                                                       TRANDATETIME,         # Transaction Date
                                                       TRANTYPE,             # Transaction Type
                                                       PTI,                  # Parent TransactionsID
                                                       GTI                   # Group TransactionsID
          );

        ELSEIF  ( TVT='TransactionsValueINT') THEN
          CALL web.StoreProdTransactionsValueInt ((SELECT JSON_UNQUOTE((SELECT JSON_EXTRACT(DATA, TRANTYPECAT)))),        # Transaction Value
                                                  TRANUSERID,           # Transaction User
                                                  TRANDATETIME,         # Transaction Date
                                                  TRANTYPE,             # Transaction Type
                                                  PTI,                  # Parent TransactionsID
                                                  GTI                   # Group TransactionsID
          );
        END IF;




      END IF;



      -- End our for loop
    END LOOP forLoop;


    COMMIT;


  END;


/* TODO: make stored producure match on Transcation Catorgoires, then Transcation Type ex. { "Tickets": {"TicketOwner": "jmcgrath"}} */
/* TODO: If data is static in the Catorgory attribute then reference exisiting Trans ID  */
/* TODO: look for existing parent trans ID*/
/* TODO: Create work for Identification by Trans ID */

call web.newTransaction('{"User": "jmcgrath",  "TicketOwner": "jmcgrath","TicketTitle": "Fix Function Foo",
  "TicketDescription": "Fix Function Foo issue", "TicketCreationDate": "2017-11-07 12:00:12", "TicketCreationUser": "jmcgrath",
  "TicketUpdateDate": "2017-11-08 13:00:12", "TicketUpdateUser": "jmcgrath", "TicketTargetDate": "2017-11-09 14:00:12",
  "Department": "Development",  "TicketStatus": "In Progress", "TicketPriority": "Normal"}');




/*call web.newTransaction('jmcgrath',
          'Fix Function Foo','Fix Function Foo issue',
          '2017-11-07 12:00:12','jmcgrath',
          '2017-11-08 13:00:12','jmcgrath',
          '2017-11-09 14:00:12','Development',
          'In Progress','Normal');*/














