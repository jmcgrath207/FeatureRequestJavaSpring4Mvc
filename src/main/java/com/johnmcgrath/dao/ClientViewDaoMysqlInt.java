package com.johnmcgrath.dao;


import com.johnmcgrath.model.ClientViewObj;

import java.util.List;

public interface ClientViewDaoMysqlInt {
    // create a abstraction for Mysql connections

    ClientViewObj getClientView(String userName);
}