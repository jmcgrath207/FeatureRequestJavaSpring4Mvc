package com.johnmcgrath.controller;


import com.johnmcgrath.model.ClientViewObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.johnmcgrath.service.APIService;

import java.util.List;

@RequestMapping(value = "/api")
@RestController
public class APIcontroller {

    @Autowired
    private APIService apiService;

    @RequestMapping(value="/client_view", method = RequestMethod.GET, produces = "application/json")
    public List<ClientViewObj> client_view(){
        List<ClientViewObj> a = apiService.getAllCase();
        return a;



    }

    @RequestMapping(value="/client_view", method = RequestMethod.POST, produces = "application/json")
    public String client_view(){

    }



}
