package com.johnmcgrath.dao;


import com.johnmcgrath.model.CommentTableObj;
import com.johnmcgrath.model.TicketTableObj;

import java.util.List;

public interface ClientViewDaoInterface {
    // create a abstraction for Mysql connections

    List<TicketTableObj> getLatestTicketsDao();

    List<CommentTableObj> getCommentsByTicketOriginalIdDao(int ticketOriginalId);

    void setClientView(TicketTableObj ticketTableObj);
}
