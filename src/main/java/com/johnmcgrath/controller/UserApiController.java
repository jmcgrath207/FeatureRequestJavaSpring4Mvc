package com.johnmcgrath.controller;


import org.springframework.web.bind.annotation.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@RequestMapping(value = "/api")
@RestController
public class UserApiController {


    @GetMapping(value="/userlogon")
    public void UserLogOn(){
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    }

    @GetMapping(value="/userlogoff")
    public void UserLogOff(){

    }

}
