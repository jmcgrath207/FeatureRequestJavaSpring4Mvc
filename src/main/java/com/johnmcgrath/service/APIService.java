package com.johnmcgrath.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.johnmcgrath.dao.ClientViewDaoMysqlInt;

import com.johnmcgrath.model.ClientViewObj;



@Service
public class APIService implements APIServiceInt {


    @Autowired
    private ClientViewDaoMysqlInt clientViewDaoMysqlInt;

    public ClientViewObj getAllClientView(String userName) {
        return clientViewDaoMysqlInt.getClientView(userName);


    }

}
