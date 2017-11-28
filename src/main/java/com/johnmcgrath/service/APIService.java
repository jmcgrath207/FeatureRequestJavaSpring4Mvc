package com.johnmcgrath.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.johnmcgrath.dao.ClientViewDaoInterface;

import com.johnmcgrath.model.TicketTableObj;

import java.util.List;


@Service
public class APIService implements APIServiceInt {


    @Autowired
    private ClientViewDaoInterface clientViewDaoInterface;


    public void setCliewView(TicketTableObj ticketTableObj) {
        clientViewDaoInterface.setClientView(ticketTableObj);
    }


    public List<TicketTableObj> getLatestTicketsApiService() {
        return clientViewDaoInterface.getLatestTicketsDao();
    }



}
