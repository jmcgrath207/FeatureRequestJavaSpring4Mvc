package com.johnmcgrath.controller;


import com.johnmcgrath.model.CommentTableObj;
import com.johnmcgrath.model.TicketTableObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.johnmcgrath.service.APIService;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping(value = "/api")
@RestController
public class ClientViewApiController {

    @Autowired
    private APIService apiService;


    @GetMapping(value="/getlatesttickets")
    public @ResponseBody List<TicketTableObj> getLatestTicketsController() {
        return apiService.getLatestTicketsApiService();
    }


    @GetMapping(value="/getcommentsbyticketoriginalid/{ticketOriginalId}")
    public @ResponseBody List<CommentTableObj>
    getCommentsByTicketOriginalIdController(@PathVariable("ticketOriginalId") int ticketOriginalId) {
        return apiService.getCommentsByTicketOriginalIdApiService(ticketOriginalId);
    }


    @GetMapping(value="/getcommenthistorybycommentoriginalid/{commentOriginalId}")
    public @ResponseBody List<CommentTableObj>
    getCommentHistoryByCommentOriginalIdController(@PathVariable("commentOriginalId") int commentOriginalId) {
        return apiService.getCommentHistoryByCommentOriginalIdApiService(commentOriginalId);
    }


    @PostMapping(value="/client_view",consumes="application/json")
    public String client_view(@RequestBody TicketTableObj ticketTableObj){
        apiService.setCliewView(ticketTableObj);
        return "success: Data has been successful POST";
    }



}
