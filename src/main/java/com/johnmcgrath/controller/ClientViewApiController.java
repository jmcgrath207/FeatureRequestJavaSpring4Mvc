package com.johnmcgrath.controller;


import com.johnmcgrath.model.TicketTableObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.johnmcgrath.service.APIService;

import java.util.List;

@RequestMapping(value = "/api")
@RestController
public class ClientViewApiController {

    @Autowired
    private APIService apiService;

    @CrossOrigin(origins = "http://localhost:4200")
    @GetMapping(value="/client_view")
    public @ResponseBody List<TicketTableObj> client_view(){
        // Returns Json List of Cases that are owned by the user

        return apiService.getAllClientView(1);
    }

    @PostMapping(value="/client_view",consumes="application/json")
    public String client_view(@RequestBody TicketTableObj ticketTableObj){
        apiService.setCliewView(ticketTableObj);
        return "success: Data has been successful POST";
    }



}
