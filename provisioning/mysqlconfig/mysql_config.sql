
### Edit Root account for access from any IP address ###

#RENAME USER 'root'@'localhost' TO 'root'@'%';
## GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE, REFERENCES ON *.* TO 'root'@'%';
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
  TransactionValueTable VARCHAR(64),
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

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Tickets','Category for Tickets');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Comments','Category for  Comments');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Departments','Category for  Departments');

INSERT INTO web.TransactionCategory (Category, Description) VALUES ('Priorities','Category for Priorities');



##### Defining Types #####

#### TransactionType For Tickets ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Tickets';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Owner',' Owner ID of ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Title',' Title of the ticket', @ci, 'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Description',' Description of the ticket', @ci, 'TransactionsValueText');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CreationDate',' Creation date of ticket', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CreationUser',' Creation User Id of the ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('UpdateDate',' Update Date of the ticket', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('UpdateUser',' Update User Id of the ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('TargetDate',' Target Date of the ticket', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Department',' Department Id of the ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Status',' Status Id of the ticket', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('Priority',' Priority Id of the ticket', @ci, 'TransactionsValueVarChar');




#### TransactionType For Comment ###

SELECT CategoryId INTO @ci FROM web.TransactionCategory WHERE Category = 'Comments';

INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CommentDescription',' Comment Description of a comment', @ci, 'TransactionsValueText');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CreationDate',' Creation Date of a comment', @ci,'TransactionsValueDateTime');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('CreationUser',' Creation User Id of a comment', @ci,'TransactionsValueVarChar');
INSERT INTO web.TransactionType (Transaction, Description, CategoryId, TransactionValueTable) VALUES ('UpdateUser',' Update User Id of a comment', @ci,'TransactionsValueVarChar');



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





### Setting TransactionTypeMeta ###

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Parent')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'Tickets';

INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'IdentifyAsTranId')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'Tickets';


INSERT INTO web.TransactionTypeMeta (TypeId, AttributeId)
  SELECT TypeId, (SELECT AttributeId FROM web.TransactionTypeAttribute WHERE AttributeValue= 'Child')
  FROM web.TransactionType AS T
    JOIN web.TransactionCategory AS CT ON T.CategoryId = CT.CategoryId
  WHERE CT.Category = 'Comments';





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
  TRANUSER INT,          # Transaction User
  TRANDATE DATETIME,     # Transaction Date
  TRANTYPE VARCHAR(255), # Transaction Type
  PTI INT                # Parent TransactionsID
)
  RETURNS INT

  BEGIN


    INSERT INTO web.Transactions ( TypeId, UserID, TransactionDate,ParentTransactionID)

    VALUES(
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
                                                    TRANUSER INT,          # Transaction User
                                                    TRANDATE DATETIME,     # Transaction Date
                                                    TRANTYPE VARCHAR(255), # Transaction Type
                                                    PTI INT                # Parent TransactionsID
)

  BEGIN


    INSERT INTO web.TransactionsValueInt (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
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
                                                        TRANUSER INT,                  # Transaction User
                                                        TRANDATE DATETIME,             # Transaction Date
                                                        TRANTYPE VARCHAR(255),         # Transaction Type
                                                        PTI INT                        # Parent TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueVarChar (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
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
                                                     TRANUSER INT,                  # Transaction User
                                                     TRANDATE DATETIME,             # Transaction Date
                                                     TRANTYPE VARCHAR(255),         # Transaction Type
                                                     PTI INT                        # Parent TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueText (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
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
                                                         TRANUSER INT,                  # Transaction User
                                                         TRANDATE DATETIME,             # Transaction Date
                                                         TRANTYPE VARCHAR(255),         # Transaction Type
                                                         PTI INT                        # Parent TransactionsID
)
  BEGIN

    INSERT INTO web.TransactionsValueDateTime (TransactionId, Value)

      VALUE (
      (SELECT web.FuncTransactions (
          TRANUSER,     # Transaction User
          TRANDATE,     # Transaction Date
          TRANTYPE,     # Transaction Type
          PTI           # Parent TransactionsID
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

    DECLARE TypeCat VARCHAR(255);

    DECLARE s JSON;

    # CURSOR 1
    DECLARE T VARCHAR(255);   ## Transaction
    DECLARE TVT VARCHAR(255); ## TransactionValueTable
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

    ## Select First available Transactions Id that will become a Parent Transactions Id
    SET GTI = (SELECT AUTO_INCREMENT
               FROM  information_schema.TABLES
               WHERE TABLE_SCHEMA = 'web'
                     AND   TABLE_NAME   = 'Transactions');


    OPEN cur1;

    START TRANSACTION;
    -- Start our for loop
    forLoop: LOOP

      FETCH cur1 INTO T,TVT;
      IF done = TRUE THEN
        LEAVE forLoop;
      END IF;

      SET TypeCat = CONCAT(CONVERT('$.', CHAR(50)), T);


      IF (SELECT JSON_CONTAINS_PATH(DATA, 'one',  TypeCat) = 1)
      THEN SET s =JSON_EXTRACT(DATA, TypeCat);
      END IF;



      -- End our for loop
    END LOOP forLoop;


    COMMIT;

    SELECT s;
  END;

call web.newTransaction('{"Owner": "user","Title": "Fix Function Foo" }');


