package com.johnmcgrath.service;

import com.johnmcgrath.model.CommentTableObj;
import com.johnmcgrath.model.TicketTableObj;

import java.util.List;

public interface APIServiceInt {


    List<TicketTableObj> getLatestTicketsApiService();

    List<CommentTableObj> getCommentsByTicketOriginalIdApiService(int ticketOriginalId);

    void setCliewView(TicketTableObj ticketTableObj);
}
