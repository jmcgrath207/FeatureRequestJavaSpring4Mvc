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

    @GetMapping(value="/client_view",produces="application/json")
    public @ResponseBody List<ClientViewObj> client_view(){
        // Returns Json List of Cases that are owned by the user


        List<ClientViewObj> a =  apiService.getAllClientView("something");
        return a;
    }

    @PostMapping(value="/client_view",consumes="application/json")
    public void client_view(@RequestBody ClientViewObj cases){

        System.out.println("something");
        System.out.println(cases);





    }



}
