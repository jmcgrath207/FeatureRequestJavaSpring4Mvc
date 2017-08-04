package com.johnmcgrath.controller;


import com.johnmcgrath.model.ClientViewObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.johnmcgrath.service.APIService;

import java.util.List;

@RequestMapping(value = "/api")
@RestController
public class APIcontroller {

    @Autowired
    private APIService apiService;

    @GetMapping(value="/client_view", produces = "application/json")
    public List<ClientViewObj> client_view(){
        List<ClientViewObj> a =  apiService.getAllClientView("test");
        return a;
    }

    @PostMapping(value="/client_view",produces = "application/json")
    public void client_view(String a){

    }



}
