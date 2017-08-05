package com.johnmcgrath.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.johnmcgrath.dao.ClientViewDaoMysqlInt;

import com.johnmcgrath.model.ClientViewObj;

import java.util.List;


@Service
public class APIService implements APIServiceInt {


    @Autowired
    private ClientViewDaoMysqlInt clientViewDaoMysqlInt;


    public void setCliewView(ClientViewObj clientViewObj) {
        clientViewDaoMysqlInt.setClientView(clientViewObj);
    }


    public List<ClientViewObj> getAllClientView(String userName) {
        return clientViewDaoMysqlInt.getClientView(userName);
    }



}
