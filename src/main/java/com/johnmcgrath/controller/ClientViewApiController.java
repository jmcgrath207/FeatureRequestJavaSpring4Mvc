package com.johnmcgrath.controller;


import com.johnmcgrath.model.ClientViewObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.johnmcgrath.service.APIService;

import java.util.List;

@RequestMapping(value = "/api")
@RestController
public class ClientViewApiController {

    @Autowired
    private APIService apiService;

    @GetMapping(value="/client_view")
    public @ResponseBody List<ClientViewObj> client_view(){
        // Returns Json List of Cases that are owned by the user

        return apiService.getAllClientView("test");
    }

    @PostMapping(value="/client_view",consumes="application/json")
    public String client_view(@RequestBody ClientViewObj cases){
        apiService.setCliewView(cases);
        return "success: Data has been successful POST";
    }



}
