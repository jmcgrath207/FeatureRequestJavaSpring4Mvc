package com.johnmcgrath.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.johnmcgrath.dao.ClientViewDaoInterface;;

import com.johnmcgrath.model.ClientViewObj;

import java.util.List;


@Service
public class APIService implements APIServiceInt {


    @Autowired
    private ClientViewDaoInterface clientViewDaoInterface;


    public void setCliewView(ClientViewObj clientViewObj) {
        clientViewDaoInterface.setClientView(clientViewObj);
    }


    public List<ClientViewObj> getAllClientView(String userName) {
        return clientViewDaoInterface.getClientView(userName);
    }



}
