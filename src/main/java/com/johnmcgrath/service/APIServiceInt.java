package com.johnmcgrath.service;

import com.johnmcgrath.model.TicketTableObj;

import java.util.List;

public interface APIServiceInt {


    List<TicketTableObj> getLatestTicketsApiService();

    void setCliewView(TicketTableObj ticketTableObj);
}
