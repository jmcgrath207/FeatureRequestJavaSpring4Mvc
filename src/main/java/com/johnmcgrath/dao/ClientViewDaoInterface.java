package com.johnmcgrath.dao;


import com.johnmcgrath.model.TicketTableObj;

import java.util.List;

public interface ClientViewDaoInterface {
    // create a abstraction for Mysql connections

    List<TicketTableObj> getClientView(int userId);

    void setClientView(TicketTableObj ticketTableObj);
}
