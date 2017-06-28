package com.johnmcgrath.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by root on 6/27/17.
 */

@RequestMapping(value = "/api")
@RestController
public class APIcontroller {

    @RequestMapping(value="/client_view", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
    public String client_view(){

    }



}
