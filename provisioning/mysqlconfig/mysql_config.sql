CREATE DATABASE web;


CREATE TABLE web.UserTable
(
  UserId       INT NOT NULL AUTO_INCREMENT,
  UserName     VARCHAR(255),
  FirstName    VARCHAR(255),
  LastName     VARCHAR(255),
  EmailAddress VARCHAR(255),
  Password     VARCHAR(255),
  PRIMARY KEY (UserId)


);


CREATE TABLE web.ApprovedIPAddress
(
  ApprovedIPAddress INT NOT NULL AUTO_INCREMENT,
  UserId            INT NOT NULL,
  IPAddress         VARCHAR(255),
  Aproved           CHAR,
  PRIMARY KEY (ApprovedIPAddress),
  FOREIGN KEY (UserId) REFERENCES web.UserTable (UserId)


);


CREATE TABLE web.TicketStatusTable (

  StatusId    INT,
  Description TEXT,
  PRIMARY KEY (StatusId)
);

CREATE TABLE web.DepartmentTable (

  DepartmentId INT,
  Description  TEXT,
  PRIMARY KEY (DepartmentId)
);

CREATE TABLE web.PriorityTable (

  PriorityId  INT,
  Description TEXT,
  PRIMARY KEY (PriorityId)
);


CREATE TABLE web.TicketTable
(
  TicketId     INT NOT NULL AUTO_INCREMENT,
  UserId       INT,
  Description  TEXT,
  CreationDate DATETIME,
  UpdateDate   DATETIME,
  TargetDate   DATETIME,
  DepartmentId INT,
  TicketStatus INT,
  StatusId     INT,
  PriorityId   INT,
  FOREIGN KEY (UserId) REFERENCES web.UserTable (UserId),
  FOREIGN KEY (StatusId) REFERENCES web.TicketStatusTable (StatusId),
  FOREIGN KEY (DepartmentId) REFERENCES web.DepartmentTable (DepartmentId),
  FOREIGN KEY (PriorityId) REFERENCES web.PriorityTable (PriorityId),
  PRIMARY KEY (TicketId)

);


RENAME USER '' root ''@''localhost'' TO ''root''@'' % '';