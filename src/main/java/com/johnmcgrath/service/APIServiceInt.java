package com.johnmcgrath.service;

import com.johnmcgrath.model.TicketTableObj;

import java.util.List;

public interface APIServiceInt {


    List<TicketTableObj> getAllClientView(String userName);

    void setCliewView(TicketTableObj ticketTableObj);
}
