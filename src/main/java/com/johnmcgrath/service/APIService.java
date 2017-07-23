package com.johnmcgrath.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.johnmcgrath.daoInterface.ClientViewMySql;

import com.johnmcgrath.model.ClientViewObj;


import java.util.List;


@Service
public class APIService {


    @Autowired
    private ClientViewMySql clientViewMySql;

    public List<ClientViewObj> getAllCase() {
        List<ClientViewObj> orgList = clientViewMySql.getAllCase();
        return orgList;


    }
}
