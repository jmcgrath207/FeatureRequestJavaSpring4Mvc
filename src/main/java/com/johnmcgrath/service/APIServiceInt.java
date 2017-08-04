package com.johnmcgrath.service;

import com.johnmcgrath.model.ClientViewObj;

import java.util.List;

public interface APIServiceInt {


    List<ClientViewObj> getAllClientView(String userName);

    void setCliewView(ClientViewObj clientViewObj);
}
